@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::Merge

import grammarlab::language::Grammar;
import grammarlab::transform::Normal;

public GGrammar mergeGs(GGrammar g1, GGrammar g2) = normalise(justMerge(g1,g2));

public GGrammar mergeGs(list[GGrammar] gs) = normalise( ( head(gs) | justMerge(it,g) | GGrammar g <- tail(gs) ) );

GGrammar justMerge(GGrammar g1, GGrammar g2)
{
	GGrammar g3 = g1;
	for (str r <- g2.roots)
		if (r notin g3.roots)
			g3.roots += r;
	for (str n <- g2.nts)
	{
		if (n notin g3.nts)
		{
			g3.nts += n;
			g3.prods[n] = [];
		}
		g3.prods[n] += g2.prods[n];
	}
	return g3;
}
