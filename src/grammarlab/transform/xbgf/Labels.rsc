@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::xbgf::Labels

//import lib::Rascalware;
import grammarlab::language::Grammar;
import grammarlab::language::XScope;
import grammarlab::language::XOutcome;
import grammarlab::transform::xbgf::Util;

 // true labels
XResult runDesignate(production(str l,str n,GExpr e), GGrammar g)
{
	if (l == "")
		return <problemProd("Production rule must me labelled, use unlabel instead",production(l,n,e)),g>;
	if (production("",n,e) notin g.prods)
		// throw "Production rule defining <n> as <e> not found.";
		return <problemProd("Production rule not found, use renameL instead",production("",n,e)),g>;
	return <ok(),grammar(g.roots,replaceP(g.prods,production("",n,e),production(l,n,e)))>;
}

XResult runRenameL(str x, str y, GGrammar g)
{
	if (x == "")
		return <problem("Source label must not be empty for renaming, use designate"),g>;
	if (y == "")
		return <problem("Target label must not be empty for renaming, use unlabel"),g>;
	if (len([p | p <- g.prods, production(x, _, _) := p]) != 1)
		return <problemStr("Source name for renaming must be uniquely used",x),g>;
	if (len([p | p <- g.prods, production(y, _, _) := p]) != 0)
		return <problemStr("Target name for renaming must be fresh",y),g>;
	<ps1,ps2,ps3> = splitPbyW(g.prods, inlabel(x));
	if ([production(x, str n, GExpr e)] := ps2)
		return <ok(),grammar(g.roots, ps1 + production(y, n, e) + ps3)>;
	else
		return <problemStr("Label not found or not unique",x),g>; // the latter should never happen
}

XResult runUnlabel(str x, GGrammar g)
{
	if (x == "")
		return <problem("Please specify which label to unlabel"),g>;
	<ps1,ps2,ps3> = splitPbyW(g.prods, inlabel(x));
	if ([production(str x, GExpr e)] := ps2)
		return <ok(),grammar(g.roots, ps1 + production("", x, e) + ps3)>;
	else
		return <problemStr("Label not found or not unique",x),g>; // the latter should never happen
}

// selectors for subexpressions
XResult runAnonymize(GProd p1, GGrammar g)
{
	p2 = unmark(p1);
	p3 = demarkS(p1);
	if (!inProds(p2,g.prods))
		return <notFoundP(p1),g>;
	return <ok(),grammar(g.roots, replaceP(g.prods,p2,p3))>;
}

XResult runDeanonymize(GProd p1, GGrammar g)
{
	p2 = unmark(p1);
	p3 = demarkS(p1);
	if (!inProds(p3,g.prods))
		return <notFoundP(p1),g>;
	return <ok(),grammar(g.roots, replaceP(g.prods,p3,p2))>;
}

XResult runRenameS(str x, str y, XScope w, GGrammar g)
{
	<ps1,ps2,ps3> = splitPbyW(g.prods, w);
	if (/selectable(x,_) !:= ps2)
		return <freshName("Source name",x),g>;
	if (/selectable(y,_) := ps2)
		return <notFreshName("Target name",y),g>;
	ps4 = visit(ps2){case selectable(x,GExpr e) => selectable(y,e)}
	return <ok(),grammar(g.roots, ps1 + ps4 + ps3)>;
}
