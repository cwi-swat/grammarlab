@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::xbgf::Nonterminals

//import lib::Rascalware;
import grammarlab::language::Grammar;
import grammarlab::language::XScope;
import grammarlab::language::XOutcome;
import grammarlab::lib::Scoping;
import grammarlab::transform::xbgf::Brutal;
import grammarlab::compare::Differ;

XResult runClone(str x, str y, XScope w, GGrammar g)
{
	// TODO
	return <ok(),g>;
}

XResult runEquate(str x, str y, GGrammar g)
{
	if (x == y)
		return <problemStr("Nonterminal is already equated with itself",x),g>;
	<ps1x,ps2x,ps3x> = splitPbyW(g.P,innt(x));
	<_,ps2y,_> = splitPbyW(g.P,innt(y));
	XResult rep = runRenameN(x,y,normalise(grammar([],ps2x,[])));
	if (ok() !:= rep.r) return rep;
	gxy = rep.g;
	gyy = normalise(grammar([],ps2y,[]));
	if (!gdts(gxy,gyy))
		return <problemStr2("Definitions of nonterminals must be equal",x,y),g>;
	if (x in usedNs(ps1x + ps3x))
		return grammarlab::transform::xbgf::Brutal::runReplace(nonterminal(x),nonterminal(y),globally(),grammar(g.N, ps1x + ps3x, g.S - x));
	else
		return <ok(),grammar(g.N, ps1x + ps3x, g.S - x)>;
}

XResult runRenameN(str x, str y, GGrammar g)
{
	ns = allNs(g.P);
	if (x notin ns)
		return <freshN(x),g>;
	if (y in ns)
		return <notFreshN(y),g>;
	return
		<ok(),performRenameN(x,y,g)>;
}

GGrammar performRenameN(str x, str y, GGrammar g)
{
	GProdList ps1,ps2,ps3,ps4;
	list[str] rs2;
	list[str] ns2 = [];
	if ([*L1, x, *L2] := g.S) rs2 = L1 + y + L2;
	else rs2 = g.S;
	for (n <- g.N)
		if (n == x)
			ns2 += y;
		else
			ns2 += n;
	if (x in g.N)
	{
		<ps1,ps2,ps3> = splitPbyW(g.P,innt(x));
		ps4 = ps1 + [production(y, p.rhs) | p <- ps2, p.lhs == x] + ps3;
	}
	else
		ps4 = g.P;
	if (x in usedNs(ps4))
		return grammar(ns2, grammarlab::transform::xbgf::Brutal::performReplace(nonterminal(x),nonterminal(y),ps4), rs2);
	else
		return grammar(ns2, ps4, rs2);
}

XResult runReroot(list[str] xs, GGrammar g)
{
	if (toSet(xs) == toSet(g.S))
		return <problemStrs("Vacuous reroot",xs),g>;
	// xbgf1.pro only asked for it to be a subset of allNs, not definedNs; we're more strict here
	for (str x <- xs, x notin g.N)
		return <problemStr("Cannot reroot to undefined nonterminal",x),g>;
	return <ok(), grammar(g.N, g.P, xs)>;
}

XResult runSplitN(str x, GProdList ps0, XScope w, GGrammar g)
{
	if ({str y} := definedNs(ps0))
	{
		if (x notin g.N)
			return <freshN(x),g>;
		if (y in allNs(g.P))
			return <notFreshN(y),g>;
		<ps2,ps3,ps4> = splitPbyW(g.P,innt(x));
		GProdList ps5 = [production(x,e) | production(y,GExpr e) <- ps0];
		if (x in g.S) rs2 = g.S + y; else rs2 = g.S;
		g = grammar(g.N, ps2 + (ps3 - ps5) + ps0 + ps4, rs2);
		if (nowhere() := w)
			return <ok(),g>;
		else
		{
			<pz1,pz2,pz3> = splitPbyW(g.P,w);
			return <ok(),grammar(g.N,pz1+grammarlab::transform::xbgf::Brutal::performReplaceRHS(nonterminal(x),nonterminal(y),pz2)+pz3,g.S)>;
		}
	}
	else
		return <problem("Splitting into more than two nonterminals not supported"),g>;
		// TODO OR NOT TODO
}

XResult runUnite(str x, str y, GGrammar g)
{
	if (x == y)
		return <problemStr("Nonterminal is already united with itself",x),g>;
	used = allNs(g.P);
	if (x notin used)
		return <freshN(x),g>;
	if (y notin used)
		return <freshN(y),g>;
	<ps1x,ps2x,ps3x> = splitPbyW(g.P, innt(x));
	GProdList ps4x = ps1x + [production(y, p.rhs) | p <- ps2x, p.lhs == x] + ps3x;
	if (x in usedNs(ps4x))
		return grammarlab::transform::xbgf::Brutal::runReplace(nonterminal(x),nonterminal(y),globally(),grammar(g.N,ps4x,g.S));
	else
		return <ok(),grammar(g.N,ps4x,g.S)>;
}

