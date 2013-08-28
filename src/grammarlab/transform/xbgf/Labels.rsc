@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::xbgf::Labels

//import lib::Rascalware;
import grammarlab::language::Grammar;
import grammarlab::language::XScope;
import grammarlab::language::XOutcome;
import grammarlab::transform::xbgf::Util;

 // true labels
XResult runDesignate(GProd p, GGrammar g)
{
	if (label(str name, GExpr expr) := p.rhs)
	{
		str plhs = p.lhs; // TODO: fix Rascal bug
		if (production(plhs, expr) <- g.P)
			return <ok(),grammar(g.N, replaceP(g.P, production(p.lhs, expr), p), g.S)>;
		else
			return <problemProd("Production rule not found, use renameL instead",p),g>;
	}
	else
		return <problemProd("Production rule must me labelled, use unlabel or renameL instead",p),g>;
}

XResult runRenameL(str x, str y, GGrammar g)
{
	if (x == "")
		return <problem("Source label must not be empty for renaming, use designate"),g>;
	if (y == "")
		return <problem("Target label must not be empty for renaming, use unlabel"),g>;
	if (len([e | /label(x,e) <- g.P]) != 1)
		return <problemStr("Source name for renaming must be uniquely used",x),g>;
	if (/label(y,_) !:= g.P)
		return <problemStr("Target name for renaming must be fresh",y),g>;
	<ps1,ps2,ps3> = splitPbyW(g.P, inlabel(x));
	if ([production(lhs, label(x, GExpr e))] := ps2)
		return <ok(), grammar(g.N, ps1 + production(lhs, label(y, e)) + ps3, g.S)>;
	else
		return <problemStr("Label not found or not unique",x),g>; // the latter should never happen
}

XResult runUnlabel(str x, GGrammar g)
{
	if (x == "")
		return <problem("Please specify which label to unlabel"),g>;
	<ps1,ps2,ps3> = splitPbyW(g.P, inlabel(x));
	if ([production(lhs, label(x, GExpr e))] := ps2)
		return <ok(),grammar(g.N, ps1 + production(lhs, e) + ps3, g.S)>;
	else
		return <problemStr("Label not found or not unique",x),g>; // the latter should never happen
}

// selectors for subexpressions
XResult runAnonymize(GProd p1, GGrammar g)
{
	p2 = unmark(p1);
	p3 = demarkS(p1);
	if (!inProds(p2,g.P))
		return <notFoundP(p1),g>;
	return <ok(),grammar(g.N, replaceP(g.P,p2,p3), g.S)>;
}

XResult runDeanonymize(GProd p1, GGrammar g)
{
	p2 = unmark(p1);
	p3 = demarkS(p1);
	if (!inProds(p3,g.P))
		return <notFoundP(p1),g>;
	return <ok(),grammar(g.N, replaceP(g.P,p3,p2), g.S)>;
}

XResult runRenameS(str x, str y, XScope w, GGrammar g)
{
	<ps1,ps2,ps3> = splitPbyW(g.P, w);
	if (/mark(x,_) !:= ps2)
		return <freshName("Source name",x),g>;
	if (/mark(y,_) := ps2)
		return <notFreshName("Target name",y),g>;
	ps4 = visit(ps2){case mark(x,GExpr e) => mark(y,e)}
	return <ok(),grammar(g.N, ps1 + ps4 + ps3, g.S)>;
}
