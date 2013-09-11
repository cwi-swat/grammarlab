@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::extract::XMLSchemaDefinition2BGF

import IO;
import String;
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
			element(_,"complexType",_) := p ||
			element(_,"simpleType",_) := p];
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
GProd mapprod(e:element(_,"simpleType",_),_) = production(getName(e),mapSimpleType(e));

default GProd mapprod(Node n)
{
	println("Unmapped node:");
	iprintln(n);
}

GExpr mapSimpleType(Node n)
{
	ns = getPure(n);
	if ([element(_,"restriction",L)] := ns)
		return choice([mark(v,epsilon()) | element(_,"enumeration",[attribute(_,"value",str v)]) <- L]);
}

GExpr getContentType(Node n)
{
	if ( attribute(none(),"type",str name) <- n.children)
		return nonterminal(name);
	elseif ( e:element(_,"complexType",L) <- n.children)
		return mapComplexType(e,[]);
	else
	{
		println("Unknown element type:");
		iprintln(n);
		return empty();
	}
}

list[Node] getPure(Node n) = [e | e <- n.children, element(_,_,_) := e];

GExpr mapComplexType(Node n, list[Node] context)
{
	str mino = getMin(n), maxo = getMax(n);
	ns = getPure(n);
	if (isEmpty(ns) && isAbstract(n))
		return choice([type2nt(getName(t)) |
			/t:element(_,"complexType",L) := context,
			/x:element(_,"extension",L2) := L,
			getBase(x) == getName(n)
		]);
	if (isEmpty(ns)) return epsilon();
	if ([element(_,"complexContent",[element(_,"extension",L)])] := ns)
		ns = [e | e <- L, element(_,_,_) := e];

	if ([ge:element(_,"sequence",L)] := ns)
		return wrap(sequence([mapElement(e) | e <- getPure(ge)]),mino,maxo);
	elseif ([ge:element(_,"sequence",L),AS*] := ns, allattributes(AS))
		return wrap(sequence([mapElement(e) | e <- getPure(ge)]+[mapElement(e) | e <- AS]),mino,maxo);
		// TODO: double check what is minOccurs default for attributes
	elseif ([ge:element(_,"choice",L)] := ns)
		return wrap(choice([mapElement(e) | e <- getPure(ge)]),getMin(ge),getMax(ge));
	elseif ([ge:element(_,"group",L)] := ns)
		return wrap(type2nt(getRef(ge)),getMin(ge),getMax(ge));
	else
	{
		println("Do not know what to do in <n.name> with:");
		iprintln(ns);
		return empty();
	}
}

bool allattributes([]) = true;
bool allattributes([element(_,"attribute",_)]) = true;
bool allattributes([element(_,"attribute",_),L*]) = allattributes(L);
default bool allattributes(list[Node] nodes) = false;

GExpr mapElement(Node n)
{
	str name = getName(n), tip = getType(n), ref = getRef(n);
	str mino = getMin(n), maxo = getMax(n);
	// TODO: if tip is "", we need to go deeper
	// TODO: mark should be label after testing!
	if (!isEmpty(name))
	{
		if (!isEmpty(tip))
			return wrap(mark(name,type2nt(tip)), mino,maxo);
		elseif (isEmpty(tip) && isEmpty(n.children))
			return wrap(mark(name,epsilon()), mino,maxo);
		cts = [ct | ct:element(_,"complexType",_) <- n.children];
		if (isTrivial(cts))
			return wrap(mark(name,mapComplexType(cts[0],[])), mino,maxo);
		//elseif (getRef(n
		//else
		//	println("WTF multiple complex types??");
	}
	if (!isEmpty(ref))
		return wrap(type2nt(ref), mino,maxo);
	println("Name <name>, type <tip>, min <mino>, max <maxo>");
	return empty();
}

bool isAbstract(Node n) = [_*,attribute(none(),"abstract","true"),_*] := n.children;

str getName(Node n)
{
	//println("Getting the name of <n.name>...");
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
str getRef(Node n) = getAttr(n,"ref");

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

GExpr type2nt(str nsn) = type2nt2(dropNs(nsn));

str dropNs(str nsn)
{
	if (contains(nsn,":"))
		return split(":",nsn)[1];
	return nsn;
}

GExpr type2nt2("xs:int") = val(integer());
GExpr type2nt2("xsd:int") = val(integer());
GExpr type2nt2("xs:string") = val(string());
GExpr type2nt2("xsd:string") = val(string());
default GExpr type2nt2(str s) = nonterminal(s);

GExpr wrap(GExpr e, "1", "1") = e;
GExpr wrap(GExpr e, "0", "1") = optional(e);
GExpr wrap(GExpr e, "0", "unbounded") = star(e);
GExpr wrap(GExpr e, "1", "unbounded") = plus(e);
default GExpr wrap(GExpr e, str mino, str maxo)
{
	println("Warning: cannot properly model repetition of <mino>..<maxo>");
	return e;
}

void main()
{
	GGrammar g;
	g = extractG(|home:///projects/slps/shared/xsd/xbgf.xsd|);
	println(ppx(g));
	println("XSD Ok!");
}
