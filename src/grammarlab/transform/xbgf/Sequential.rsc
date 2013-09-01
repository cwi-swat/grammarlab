@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::xbgf::Sequential

//import lib::Rascalware;
import grammarlab::language::Grammar;
import grammarlab::language::XScope;
import grammarlab::language::XOutcome;
import grammarlab::transform::xbgf::Util;
import grammarlab::transform::xbgf::Brutal;
import grammarlab::compare::Differ;

// TODO: reimplement for arbitrary markers
XResult runAppear(GProd p1, GGrammar g)
{
	p2 = demark(p1);
	if (!inProds(p2,g.P))
		return <notFoundP(p2),g>;
	for (/mark("",e) := p1)
		if (optional(_) !:= e && star(_) !:= e)
			return <problemProd("Production rule does not have an optional part marked",p1),g>;
	return <ok(),grammar(g.N, replaceP(g.P,p2,unmark(p1)), g.S)>;
}

XResult runDisappear(GProd p1, GGrammar g)
{
	p2 = unmark(p1);
	if (!inProds(p2,g.P))
		return <notFoundP(p2),g>;
	for (/mark("",e) := p1)
		if (optional(_) !:= e && star(_) !:= e)
			return <problemProd("Production rule does not have an optional part marked",p2),g>;
	return <ok(),grammar(g.N, replaceP(g.P,p2,demark(p1)), g.S)>;
}

XResult runInject(GProd p1, GGrammar g)
{
	p2 = demark(p1);
	if (!inProds(p2,g.P))
		return <notFoundP(p2),g>;
	return <ok(),grammar(g.N, replaceP(g.P,p2,unmark(p1)), g.S)>;
}

XResult runPermute(GProd p, GGrammar g)
{
	if (production(str n, sequence(L1)) := p)
	{
		<ps1,ps2,ps3> = splitPbyW(g.P,innt(n));
		if ([production(n, sequence(L2))] := ps2)
		{
			if (seteq(L1,L2))
				return <ok(),grammar(g.N, ps1 + p + ps3, g.S)>;
			else
				return <problemExpr2("Phrases must be permutations of each other",sequence(L1),sequence(L2)),g>;
		}
		else
			return <problemProds("Permutation requires a single sequence instead of",ps2),g>;
	}
	else
		return <problemProd("Permutation parameter requires a sequence instead of",p),g>;
	// TODO check if really dead code
	return <ok(),g>;
}

XResult runProject(GProd p1, GGrammar g)
{
	p2 = unmark(p1);
	if (!inProds(p2,g.P))
		return <notFoundP(p2),g>;
	return <ok(), grammar(g.N, replaceP(g.P, p2, demark(p1)), g.S)>;
}

