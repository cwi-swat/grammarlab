@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::xbgf::Conjunction

import grammarlab::language::Grammar;
import grammarlab::language::XScope;
import grammarlab::language::XOutcome;
import grammarlab::transform::xbgf::Util;

XResult runAddC(GProd p, GGrammar g)
{
	<ps1,ps2,ps3> = splitPbyW(g.prods,innt(p.lhs));
	if ([GProd q] := ps2)
	{
		if (p.lhs != q.lhs)
			return <problemStr("Incorrect splitting by nonterminal scope",p.lhs),g>;
		// Checking the label for emptyness is unnecessary, normalisations will follow anyway
		pq = production(p.lhs,allof([p.rhs,q.rhs]));
		return <ok(),grammar(g.roots, ps1 + [pq] + ps3)>;
	}
	else
		return <problemStr("Nonterminal must be defined horizontally",p.lhs),g>;
}
