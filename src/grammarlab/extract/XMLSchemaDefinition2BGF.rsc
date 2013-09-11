@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::extract::XMLSchemaDefinition2BGF

import IO;
import lang::xml::DOM;
import grammarlab::language::Grammar;
import grammarlab::transform::Normal;
import grammarlab::export::Grammar;
import grammarlab::lib::Squeeze;
import grammarlab::lib::Sizes;

import grammarlab::transform::Merge;

GGrammar extractG(loc f)
{
	if (document(element(namespace(_,"http://www.w3.org/2001/XMLSchema"),"schema",L)) := parseXMLDOMTrim(readFile(f)))
	{
		list[str] S = [getName(e) | e:element(namespace(_,"http://www.w3.org/2001/XMLSchema"),"element",_) <- L];
		println("Roots: <S>");
		//list[Node] defines = [d | /d:element(namespace(_,"http://relaxng.org/ns/structure/1.0"),"define",_) := L];
		//list[Node] includes = [d | d:element(namespace(_,"http://relaxng.org/ns/structure/1.0"),"include",_) <- L];
		//list[Node] others = [e | e:element(namespace(_,"http://relaxng.org/ns/structure/1.0"),str t,_) <- L, t notin ["start", "define", "include"]];
		//// TODO: change the semantics of <include>!
		//for (inc <- includes)
		//	println("Warning: merge this grammar with the one extracted from <getAttr(inc.children,"href")>!");
		//if (!isEmpty(others))
		//	println("Warning: unexpected nodes in RNG: <[n | element(_,str n,_) <- others]>");
		GProdList ps = [mapprod(p,L) | p <- L,
			element(_,"element",_) := p ||
			element(_,"complexType",_) := p];
		//	= [mapprod(p)  |  p <- defines];
		//	//+ [mapprod(ip) | op <- defines, element(_,"element",list[Node] ec) <- op.children, element(_,"grammar",list[Node] gc) <- ec, ip:element(_,"define",_) <- gc];
		return normalise(grammar(
			squeeze([p.lhs | p <- ps]),
			ps,
			S
		));
	}
	else
		throw "<f> is not a proper XML Schema Definition file";
}

GProd mapprod(e:element(_,"element",_),_) = production(getName(e),getContentType(e));
GProd mapprod(e:element(_,"complexType",_),L) = production(getName(e),mapComplexType(e,L));

default GProd mapprod(Node n)
{
	println("Unmapped node:");
	iprintln(n);
}

GExpr getContentType(Node n)
{
	if ( attribute(none(),"type",str name) <- n.children)
		return nonterminal(name);
	elseif ( /e:element(_,"complexType",L) := n.children)
		return mapComplexType(e,[]);
	else
	{
		println("Unknown element type:");
		iprintln(n);
		return empty();
	}
}

GExpr mapComplexType(Node n, list[Node] context)
{
	ns = [e | e <- n.children, element(_,_,_) := e];
	if (isEmpty(ns) && isAbstract(n))
	{
		return choice([type2nt(getName(t)) |
			/t:element(_,"complexType",L) := context,
			/x:element(_,"extension",L2) := L,
			getBase(x) == getName(n)
		]);
	}
	elseif ([element(_,"sequence",L)] := ns)
		return sequence([mapElement(e) | e <- L]);
	else
	{
		println("Do not know what to do in <n.name> with:");
		iprintln(ns);
		return empty();
	}
}

GExpr mapElement(Node n)
{
	str name = getName(n), tip = getType(n), mino = getMin(n), maxo = getMax(n);
	// TODO: if tip is "", we need to go deeper
	if (mino == "1" && maxo == "1")
		return label(name,type2nt(tip));
	elseif (mino == "0" && maxo == "1")
		return optional(label(name,type2nt(tip)));
	elseif (mino == "0" && maxo == "unbounded")
		return star(label(name,type2nt(tip)));
	elseif (mino == "1" && maxo == "unbounded")
		return plus(label(name,type2nt(tip)));
	else
		println("Name <name>, type <tip>, min <mino>, max <maxo>");
	return empty();
}

bool isAbstract(Node n) = [_*,attribute(none(),"abstract","true"),_*] := n.children;

str getName(Node n)
{
	if ( attribute(none(),"name",str name) <- n.children)
		return name;
	else
	{
		println("Cannot determine name of:");
		iprintln(n);
		return "?";
	}
}

str getType(Node n) = getAttr(n,"type");
str getBase(Node n) = getAttr(n,"base");

str getAttr(Node n, str aname)
{
	if ( attribute(none(),aname,str name) <- n.children)
		return name;
	else
		return "";
}

str getMin(Node n)
{
	if ( attribute(none(),"minOccurs",str name) <- n.children)
		return name;
	else
		return "1";
}

str getMax(Node n)
{
	if ( attribute(none(),"maxOccurs",str name) <- n.children)
		return name;
	else
		return "1";
}

GExpr type2nt("xs:int") = val(integer());
GExpr type2nt("xsd:int") = val(integer());
GExpr type2nt("xs:string") = val(string());
GExpr type2nt("xsd:string") = val(string());
default GExpr type2nt(str s) = nonterminal(s);

void main()
{
	GGrammar g;
	g = extractG(|home:///projects/slps/topics/fl/xsd/fl.xsd|);
	println(ppx(g));
	println("XSD Ok!");
}
