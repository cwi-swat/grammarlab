@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::Merge

import grammarlab::language::Grammar;
import grammarlab::transform::Normal;
import grammarlab::lib::Squeeze;
import List;

public GGrammar mergeGs(GGrammar g1, GGrammar g2) = normalise(justMerge(g1,g2));

public GGrammar mergeGs(list[GGrammar] gs) = normalise( ( gs[0] | justMerge(it,g) | GGrammar g <- tail(gs) ) );

GGrammar justMerge(GGrammar g1, GGrammar g2) =
	grammar(
		squeeze(g1.N + g2.N),
		squeeze(g1.P + g2.P),
		squeeze(g1.S + g2.S)
	);
