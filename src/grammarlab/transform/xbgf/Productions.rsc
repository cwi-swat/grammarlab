@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::xbgf::Productions

//import lib::Rascalware;
import grammarlab::language::Grammar;
import grammarlab::language::XScope;
import grammarlab::language::XOutcome;
import grammarlab::transform::xbgf::Util;
import grammarlab::transform::xbgf::Brutal;
import grammarlab::compare::Differ;

XResult runAddV(GProd p1, GGrammar g)
{
	GProdList ps1,ps2,ps3;
	<ps1,ps2,ps3> = splitPbyW(g.P,innt(p1.lhs));
	if (isEmpty(ps2))
		return <problemStr("Nonterminal must be defined",p1.lhs),g>;
	for (GProd p <- ps2, eqP(p,p1))
		return <problemProd("Production rule is already present",p1),g>;
	if (label(str name, _) := p1.rhs)
		if (production(_,label(name,_)) <- ps1+ps3)
			return <problemStr("Another production rule with the same label is already present",name),g>;
	return <ok(), grammar(g.N, ps1 + ps2 + p1 + ps3, g.S)>;
}

XResult runDefine(GProdList ps1, GGrammar g)
{
	// TODO: reconsider relying on g.N
	if ({str n} := definedNs(ps1))
	{
		if (n notin usedNs(g.P))
			return <problemStr("Nonterminal must not be fresh, use introduce instead",n),g>;
		return <ok(), grammar(g.N + n, g.P + ps1, g.S)>;
	}
	else
		return <problem("Multiple defined nonterminals found"),g>;
}

XResult runEliminate(str x, GGrammar g)
{
	if (x in g.S)
		return <problemStr("Cannot eliminate root nonterminal",x),g>;
	if (x notin definedNs(g.P))
		return <freshName(x),g>;
	<ps1,_,ps3> = splitPbyW(g.P,innt(x));
	if (x in usedNs(ps1+ps3))
		return <notFreshName(x),g>;
	return <ok(), grammar(g.N - x, ps1 + ps3, g.S)>;
}

XResult runImportG(GProdList ps1, GGrammar g)
{
	defs1 = definedNs(ps1);
	defs12 = defs1 & definedNs(g.prods);
	du12 = defs1 & usedNs(g.prods);
	if (!isEmpty(defs12))
		return <problemStrs("Import clashes with existing definitions", toList(defs12)),g>;
	if (!isEmpty(du12))
		return <problemStrs("Import clashes with existing definitions", toList(du12)),g>;
	return <ok(),grammar(g.roots, ps1 + g.prods)>;
}

XResult runIntroduce(GProdList ps, GGrammar g)
{
	if ({str n} := definedNs(ps))
	{
		if (n in usedNs(g.prods))
			return <notFreshN(n),g>;
		if (n in definedNs(g.prods))
			return <problemStr("Definition for nonterminal clashes with existing definition",n),g>;
		return <ok(),grammar(g.roots, g.prods + ps)>;
	}
	else
		return <problem("Multiple defined nonterminals found"),g>;
}

XResult runRedefine(GProdList ps1, GGrammar g)
{
	// inlined superposition of undefine and define, with two exceptional details:
	// (1) if ps1.n is a root, undefine would have stripped it from this status
	// (2) redefine preserves original order of production rules
	if ({str x} := definedNs(ps1))
	{
		if (x notin definedNs(g.prods))
			return <freshName(x),g>;
		if (x notin usedNs(g.prods))
			return <problemStr("Nonterminal must be used",x),g>;
		<ps3,_,ps4> = splitPbyW(g.prods,innt(x));
		return <ok(),grammar(g.roots, ps3 + ps1 + ps4)>; 
	}
	else
		return <problem("Please redefine one nonterminal at a time"),g>;
}

XResult runRemoveV(GProd p, GGrammar g)
{
	<_,ps2,_> = splitPbyW(g.prods, innt(p.lhs));
	if (isEmpty(ps2))
		return <freshN(p.lhs),g>;
	if (!inProds(p,ps2))
		return <notFoundP(p),g>;
	if ([p] == ps2)
		return <problemStr("Cannot remove the last production rule with removeV, use undefine or eliminate",p.lhs),g>;
	return <ok(),grammar(g.roots, g.prods - p)>;
}

//TODO: undefine only one nonterminal per transformation
XResult runUndefine(list[str] xs, GGrammar g)
{
	GProdList myps = g.prods;
	list[str] rs = g.roots;
	for (str x <- xs)
	{
		if (x notin definedNs(g.prods))
			return <problemStr("Nonterminal must be defined.",x),g>;
		if (x notin usedNs(g.prods))
			return <problemStr("Nonterminal must be used.",x),g>;
		//throw "Cannot undefine root nonterminal <x>."; // check was not in xbgf1.pro
		rs -= x;
		<ps1,_,ps3> = splitPbyW(myps,innt(x));
		myps = ps1 + ps3;
	}
	return <ok(),grammar(g.roots,myps)>;
}
