@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::xbgf::Terminals

import grammarlab::language::Grammar;
import grammarlab::language::XScope;
import grammarlab::language::XOutcome;
import grammarlab::transform::xbgf::Util;
import grammarlab::transform::xbgf::Brutal;
import grammarlab::transform::xbgf::Sequential;
import grammarlab::transform::Normal;
import grammarlab::compare::Differ;

XBGFResult runAbstractize(BGFProduction p1, BGFGrammar g)
{
	p2 = unmark(p1);
	if (!inProds(p2,g.prods))
		return <notFoundP(p2),g>;
	for (/marked(e) := p1)
		if (terminal(_) !:= e)
			return <problem("Abstractize only works with marked terminals, use project instead."),g>;
	return transform::library::Sequential::runProject(p1,grammar(g.roots, g.prods));
}

XBGFResult runConcatT(list[str] xs, str y, XBGFScope w, BGFGrammar g)
{
	// TODO
	return <ok(),g>;
}

XBGFResult runConcretize(BGFProduction p1, BGFGrammar g)
{
	p2 = demark(p1);
	if (!inProds(p2,g.prods))
		return <notFoundP(p2),g>;
	for (/marked(e) := p1)
		if (terminal(_) !:= e)
			return <problem("Concretize only works with marked terminals, use inject instead."),g>;
	return transform::library::Sequential::runInject(p1,g);
}

XBGFResult runRenameT(str x, str y, BGFGrammar g)
{
	ts = allTs(g.prods);
	if (x notin ts)
		return <freshName("Source name",x),g>;
	if (y in ts)
		return <notFreshName("Target name",y),g>;
	return transform::library::Brutal::runReplace(terminal(x),terminal(y),globally(),g);
}

XBGFResult runSplitT(str x, list[str] ys, XBGFScope w, BGFGrammar g)
{
	// TODO: insert proper preconditions
	//<ps1,ps2,ps3> = splitPbyW(g.prods, w);
	//BGFGrammar g2 	= transform::library::Brutal::runReplace(terminal(x),sequence([terminal(y) | y <- ys]),w,grammar([],ps2));
	return transform::library::Brutal::runReplace(terminal(x),sequence([terminal(y) | y <- ys]),w,g);
}
