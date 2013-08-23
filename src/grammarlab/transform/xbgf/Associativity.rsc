@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::xbgf::Associativity

import grammarlab::language::Grammar;
import grammarlab::language::X;
import grammarlab::language::XScope;
import grammarlab::language::XOutcome;
import grammarlab::transform::xbgf::Util;

bool admit(sequence([nonterminal(n),nonterminal(x),nonterminal(n)]),
		   sequence([nonterminal(n),star(sequence([nonterminal(x),nonterminal(n)]))])) = true;
bool admit(sequence([nonterminal(n),nonterminal(x),nonterminal(n)]),
		   sequence([star(sequence([nonterminal(n),nonterminal(x)])),nonterminal(n)])) = true;
bool admit(sequence([nonterminal(n),nonterminal(n)]),
		   plus(nonterminal(n))) = true;
default bool admit(GExpr e1, GExpr e2) = false;

// NB: rassoc and lassoc are the same when they work on the grammar level
// the differences can only be observed on the instance level
XResult runAssoc(GProd p, GGrammar g)
{
	str x = p.lhs;
	GProdList ps1,ps2,ps3;
	GExpr e1,e2;
	if (label(str l, GExpr e) := p.rhs)
	{
		<ps1,ps2,ps3> = splitPbyW(g.P,comboscope(inlabel(l),innt(x)));
		e1 = e;
	}
	else
	{
		<ps1,ps2,ps3> = splitPbyW(g.P,innt(x));
		e1 = p.rhs;
	}
	if ([production(x, GExpr e2a)] := ps2)
	{
		if (label(_, GExpr e2b) := e2a) e2 = e2b; else e2 = e2a;
		if (admit(e1, e2))
			return <ok(),grammar(g.N, ps1 + p + ps3, g.S)>;
		else
			return <problemExpr2("Production rule must admit associativity transformation",e1,e2),g>;
	}
	else
		return <problemPinProds("Cannot find the right production rule to match",p,ps2),g>;
}

XResult runIterate(GProd p, GGrammar g)
{
	str x = p.lhs;
	GProdList ps1,ps2,ps3;
	GExpr e1,e2;
	if (label(str l, GExpr e) := p.rhs)
	{
		<ps1,ps2,ps3> = splitPbyW(g.P,comboscope(inlabel(l),innt(x)));
		e1 = e;
	}
	else
	{
		<ps1,ps2,ps3> = splitPbyW(g.P,innt(x));
		e1 = p.rhs;
	}
	if ([production(x, GExpr e2a)] := ps2)
	{
		if (label(_, GExpr e2b) := e2a) e2 = e2b; else e2 = e2a;
		if (admit(e2, e1))
			return <ok(),grammar(g.N, ps1 + p + ps3, g.S)>;
		else
			return <problemExpr2("Production rule must admit associativity transformation",e1,e2),g>;
	}
	else
		return <problemPinProds("Cannot find the right production rule to match",p,ps2),g>;
}
