@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::extract::RelaxNG2BGF

import IO;
import lang::xml::DOM;
import grammarlab::language::Grammar;
import grammarlab::export::Grammar;
import grammarlab::lib::Squeeze;

GGrammar extractG(loc f)
{
	if (document(element(namespace(_,"http://relaxng.org/ns/structure/1.0"),"grammar",L)) := parseXMLDOMTrim(readFile(f)))
	{
		list[str] S
			= [s | element(_,"start",L2) <- L, element(_,"ref",[attribute(none(),"name",str s)]) <- L2]
			+ [s | element(_,"start",[element(_,"choice",L2)]) <- L, element(_,"ref",[attribute(none(),"name",str s)]) <- L2];
		println("Roots: <S>");
		ps = [mapprod(p) | p:element(namespace(_,"http://relaxng.org/ns/structure/1.0"),str t,_) <- L, t != "start"];
		return grammar(
			squeeze([p.lhs | p <- ps]),
			ps,
			S
		);
	}
	else
		throw "<f> is not a proper BGF file";
}

GProd mapprod(Node n)
{
	return production("a",empty());
}

void main()
{
	GGrammar g;
	
	g = extractG(|home:///projects/slps/topics/grammars/atom/dettrick/atom.rng.xml|);
	//println(ppx(g));
	println("ATOM Ok!");
	g = extractG(|home:///projects/slps/topics/grammars/svg/furubayashi/svg11/svg-basic-structure.rng|);
	//println(ppx(g));
	println("SVG Ok!");
}
