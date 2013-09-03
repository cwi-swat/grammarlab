@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::xbgf::Factoring

import grammarlab::language::Grammar;
import grammarlab::language::XScope;
import grammarlab::language::XOutcome;
import grammarlab::transform::xbgf::Util;
import grammarlab::transform::xbgf::Brutal;
import grammarlab::transform::Normal;
import grammarlab::compare::Differ;

XResult runFactor(GExpr e1, GExpr e2, XScope w, GGrammar g)
{
	GExpr e3 = normalise(makeDistributed(e1));
	GExpr e4 = normalise(makeDistributed(e2));
	if (!eqE(e3, e4))
		return <problemExpr2("Expressions must be related by distribution.",e1,e2),g>;
	return grammarlab::transform::xbgf::Brutal::runReplace(e1,e2,w,g);
}

XResult runDistribute(XScope w, GGrammar g)
{
	<ps1,ps2,ps3> = splitPbyW(g.P,w);
	if (/choice(_) !:= ps2)
		return <problemScope("No choices found, nothing to distribute",w),g>;
	return <ok(),grammar(g.N, ps1 + normalise([makeDistributed(p) | p <- ps2]) + ps3, g.S)>;
}

GProd makeDistributed(GProd p) = production(p.lhs, makeDistributed(p.rhs));

// propagating distribution - could possibly be rewritten as a visitor, but more understandable this way
GExpr makeDistributed(label(str name, GExpr expr)) = label(name,makeDistributed(expr));
GExpr makeDistributed(mark(str name, GExpr expr)) = mark(name,makeDistributed(expr));
GExpr makeDistributed(not(GExpr expr)) = not(makeDistributed(expr));
GExpr makeDistributed(except(GExpr expr1, GExpr expr2)) = except(makeDistributed(expr1),makeDistributed(expr2));
GExpr makeDistributed(optional(GExpr expr)) = optional(makeDistributed(expr));
GExpr makeDistributed(star(GExpr expr)) = star(makeDistributed(expr));
GExpr makeDistributed(plus(GExpr expr)) = plus(makeDistributed(expr));
GExpr makeDistributed(sepliststar(GExpr expr, GExpr sep)) = sepliststar(makeDistributed(expr),makeDistributed(sep));
GExpr makeDistributed(seplistplus(GExpr expr, GExpr sep)) = seplistplus(makeDistributed(expr),makeDistributed(sep));
GExpr makeDistributed(choice(GExprList L1))
{
	GExprList Ln = [];
	for (e2 <- L1)
	{
		e3 = makeDistributed(e2);
		if (choice(L2) := e3)
			Ln += L2;
		else
			Ln += e2; // TODO or e3?
	}
	return choice(Ln);
}

// The real magic of distribution happens here
GExpr makeDistributed(sequence(L1))
{
	list[GExprList] Ln = [[]];
	for (e2 <- L1)
	{
		e3 = makeDistributed(e2);
		if (choice(L2) := e3)
			Ln = [Li + e4 | Li <- Ln, e4 <- L2];
		else
			Ln = [Li + e3 | Li <- Ln]; // TODO or e2?
	}
	return choice([sequence(Li) | Li <- Ln]);
}

default GExpr makeDistributed(GExpr e) = e;
