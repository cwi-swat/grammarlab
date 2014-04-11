@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::io::read::BGF

import IO;
import lang::xml::DOM;
import grammarlab::language::Grammar;
import grammarlab::lib::Squeeze;
import grammarlab::lib::Sizes;

public GGrammar readBGF(loc f)
{
	if (document(element(namespace(_,"http://planet-sl.org/bgf"),"grammar",L)) := parseXMLDOMTrim(readFile(f)))
	{
		ps = [mapprod(p) | p:element(namespace(_,"http://planet-sl.org/bgf"),_,_) <- L];
		return grammar(
			squeeze([p.lhs | p <- ps]),
			ps,
			[s | element(none(),"root",[charData(str s)]) <- L]
		);
	}
	else
		throw "<f> is not a proper BGF file";
}

// TODO: figure out if this dead code is needed at all
GProds prodsByNT(GProdList ps)
{
	GProds res = ();
	for (GProd p <- ps)
	{
		if (p.lhs notin res)
			res[p.lhs] = [p];
		else
			res[p.lhs] += [p];
	}
	return res;
}

GProd mapprod(Node n)
{
	str lname = "";
	str lhs = "";
	GExpr rhs;
	if (element(namespace(_,"http://planet-sl.org/bgf"),"production",kids) := n)
	{
		for (k <- kids)
			switch (k)
			{
				case element(none(),"label",[charData(str s)]) : lname = s;
				case element(none(),"nonterminal",[charData(str s)]) : lhs = s;
				case element(namespace(_,"http://planet-sl.org/bgf"),"expression",[expr]): rhs = mapexpr(expr);
			}
		if (isEmpty(lname))
			return production (lhs, rhs);
		else
			return production (lhs, label(lname,rhs));
	}
	else
		throw "ERROR in mapprod:\n<n>";
}

GExpr mapexpr(Node n)
{
	switch(n)
	{
		// just in case
		case element(namespace(_,"http://planet-sl.org/bgf"),"expression",[e]): return mapexpr(e);
		// regular alternatives
		case element(none(),"epsilon",[]): return epsilon();
		case element(none(),"empty",[]): return empty();
		case element(none(),"value",[charData("boolean")]): return val(boolean());
		case element(none(),"value",[charData("string")]): return val(string());
		case element(none(),"value",[charData("int")]): return val(integer());
		case element(none(),"any",[]): return anything();
		case element(none(),"terminal",[]): return terminal(" ");// lang::xml::DOM does not preserve whitespace, so this can mean something like a newline
		case element(none(),"terminal",[charData(str s)]): return terminal(s);
		case element(none(),"nonterminal",[charData(str s)]): return nonterminal(s);
		//case element(none(),"labelled",[element(none(),"label",[charData(str s)]),expr]): return label(s,mapexpr(expr));
		case element(none(),"selectable",[element(none(),"selector",[charData(str s)]),expr]): return label(s,mapexpr(expr));
		case element(none(),"sequence",kids): return sequence([mapexpr(k) | k <- kids]);
		case element(none(),"choice",kids): return choice([mapexpr(k) | k <- kids]);
		case element(none(),"allof",kids): return allof([mapexpr(k) | k <- kids]);
		case element(none(),"marked",[expr]): return mark("",mapexpr(expr));
		case element(none(),"marked",[element(none(),"mark",[charData(str s)]),expr]): return mark(s,mapexpr(expr));
		case element(none(),"except",[e1,e2]): return except(mapexpr(e1),mapexpr(e2));
		case element(none(),"optional",[expr]): return optional(mapexpr(expr));
		case element(none(),"not",[expr]): return not(mapexpr(expr));
		case element(none(),"plus",[expr]): return plus(mapexpr(expr));
		case element(none(),"star",[expr]): return star(mapexpr(expr));
		case element(none(),"seplistplus",[e1,e2]): return seplistplus(mapexpr(e1),mapexpr(e2));
		case element(none(),"sepliststar",[e1,e2]): return sepliststar(mapexpr(e1),mapexpr(e2));
		case element(none(),"nonterminal",[]): throw "ERROR: empty nonterminal!";
		//case comment(_): return nothing();
		default: throw "ERROR in mapexpr:\n<n>";
	}
}
