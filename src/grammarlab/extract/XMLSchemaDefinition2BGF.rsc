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
		GProdList ps = [mapprod(p) | p <- L, element(_,"element",_) := p];
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

GProd mapprod(e:element(_,"element",_)) = production(getName(e),getType(e));

default GProd mapprod(Node n)
{
	println("Unmapped node:");
	iprintln(n);
}

GExpr getType(Node n) = empty();

str getName(Node n)
{
	if ( /attribute(none(),"name",str name) := n.children)
		return name;
	else
	{
		println("Cannot determine name of:");
		iprintln(n);
		return "?";
	}
}

void main()
{
	GGrammar g;
	g = extractG(|home:///projects/slps/topics/fl/xsd/fl.xsd|);
	println(ppx(g));
	println("XSD Ok!");
}
