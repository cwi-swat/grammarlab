@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::xbgf::Productions

//import lib::Rascalware;
import grammarlab::language::Grammar;
import grammarlab::language::XScope;
import grammarlab::language::XOutcome;
import grammarlab::transform::xbgf::Util;
import grammarlab::transform::xbgf::Brutal;
import grammarlab::compare::Differ;
import IO;

XResult runAddV(GProd p1, GGrammar g)
{
	GProdList ps1,ps2,ps3;
	iprintln(g.P);
	<ps1,ps2,ps3> = splitPbyW(g.P,innt(p1.lhs));
	if (isEmpty(ps2))
		return <problemStr("Nonterminal must be defined",p1.lhs),g>;
	if (inProds(p1,ps2))
		return <problemProd("Production rule is already present",p1),g>;
	if (label(str name, _) := p1.rhs)
		if (production(_,label(name,_)) <- ps1+ps3)
			return <problemStr("Another production rule with the same label is already present",name),g>;
	return <ok(), grammar(g.N, ps1 + ps2 + p1 + ps3, g.S)>;
}

XResult runDefine(GProdList ps, GGrammar g)
{
	if ({str n} := {p.lhs | GProd p <- ps})
	{
		if (/nonterminal(n) !:= g.P)
			return <problemStr("Nonterminal must not be fresh, use introduce instead",n),g>;
		return <ok(), grammar(g.N + n, g.P + ps, g.S)>;
	}
	else
		return <problem("Multiple defined nonterminals found"),g>;
}

XResult runEliminate(str x, GGrammar g)
{
	if (x in g.S)
		return <problemStr("Cannot eliminate root nonterminal",x),g>;
	if (x notin g.N)
		return <freshName(x),g>;
	GProdList ps = [p | GProd p <- g.P, p.lhs != x];
	if (/nonterminal(x) := ps)
		return <notFreshName(x),g>;
	return <ok(), grammar(g.N - x, ps, g.S)>;
}

XResult runImportG(GProdList ps, GGrammar g)
{
	set[str] defs1 = {p.lhs | GProd p <- ps};
	set[str] defs12 = defs1 & toSet(g.N);
	set[str] du12 = defs1 & {n | /nonterminal(str n) := g.P};
	if (!isEmpty(defs12))
		return <problemStrs("Import clashes with existing definitions", toList(defs12)),g>;
	if (!isEmpty(du12))
		return <problemStrs("Import clashes with existing definitions", toList(du12)),g>;
	if ("⟙" in g.N)
	{
		<ps1,ps2,ps3> = splitPbyW(g.P,innt("⟙"));
		if ([production("⟙",choice(RS))] := ps2)
			return <ok(), normalise(grammar(g.N, ps+ps1+ps3, g.S+[r | nonterminal(str r) <- RS]))>;
		if ([production("⟙",nonterminal(r))] := ps2)
			return <ok(), normalise(grammar(g.N, ps+ps1+ps3, g.S+[r]))>;
	}
	return <ok(), normalise(grammar(g.N, ps + g.P, g.S))>;
}

XResult runIntroduce(GProdList ps, GGrammar g)
{
	if ({str n} := {p.lhs | GProd p <- ps})
	{
		if (n in g.N)
			return <problemStr("Definition for nonterminal clashes with existing definition",n),g>;
		if (/nonterminal(n) := g.P)
			return <notFreshN(n),g>;
		return <ok(),grammar(g.N + n, g.P + ps, g.S)>;
	}
	else
		return <problem("Multiple defined nonterminals found"),g>;
}

XResult runRedefine(GProdList ps, GGrammar g)
{
	// inlined superposition of undefine and define, with two exceptional details:
	// (1) if ps1.n is a root, undefine would have stripped it from this status
	// (2) redefine preserves original order of production rules
	if ({str n} := {p.lhs | GProd p <- ps})
	{
		if (n notin g.N)
			return <freshName(n),g>;
		if (/nonterminal(n) !:= g.P)
			return <problemStr("Nonterminal must be used",n),g>;
		<ps1,_,ps2> = splitPbyW(g.P, innt(n));
		return <ok(),grammar(g.N, ps1 + ps + ps2, g.S)>; 
	}
	else
		return <problem("Please redefine one nonterminal at a time"),g>;
}

XResult runRemoveV(GProd p, GGrammar g)
{
	GProdList ps1,ps2,ps3,ps4;
	<ps1,ps2,ps3> = splitPbyW(g.P, innt(p.lhs));
	if (isEmpty(ps2))
		return <freshN(p.lhs),g>;
	ps4 = [q | GProd q <- ps2, !eqP(normalise(p),normalise(q))];
	if (ps2 == ps4)
		return <notFoundP(p),g>;
	if (isEmpty(ps4))
		return <problemStr("Cannot remove the last production rule with removeV, use undefine or eliminate",p.lhs),g>;
	return <ok(),grammar(g.N, ps1 + ps4 + ps3, g.S)>;
}

//TODO: undefine only one nonterminal per transformation
XResult runUndefine(list[str] xs, GGrammar g)
{
	XResult r = <ok(),g>;
	for (str x <- xs)
	{
		r = runUndefineTrue(x,r.g);
		if (ok() !:= r.r)
			return r;
	}
	return r;
}

XResult runUndefineTrue(str x, GGrammar g)
{
	if (x notin g.N)
		return <problemStr("Nonterminal must be defined.",x),g>;
	if (/nonterminal(x) !:= g.P)
		return <problemStr("Nonterminal must be used.",x),g>;
	return <ok(), grammar(g.N - x, [p | GProd p <- g.P, p.lhs != x], g.S - x)>;
}
