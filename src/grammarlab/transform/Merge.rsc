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

test bool mt1() = 
	mergeGs(
		grammar(["foo"],[production("foo",nonterminal("bar"))],[]),
		grammar(["bar"],[production("bar",nonterminal("foo"))],[])
	) ==
	 grammar(["foo","bar"],[production("foo",nonterminal("bar")), production("bar",nonterminal("foo"))],[]);
test bool mt2() = 
	mergeGs(
		grammar(["foo"],[production("foo",nonterminal("bar"))],[]),
		grammar(["foo"],[production("foo",nonterminal("bar"))],[])
	) ==
	 grammar(["foo"],[production("foo",nonterminal("bar"))],[]);
test bool mt3() = 
	mergeGs(
		grammar(["foo"],[production("foo",nonterminal("bar"))],[]),
		grammar(["foo"],[production("foo",nonterminal("wez"))],[])
	) ==
	 grammar(["foo"],[production("foo",nonterminal("bar")), production("foo",nonterminal("wez"))],[]);
test bool mt4() = 
	mergeGs(
		grammar(["foo"],[production("foo",nonterminal("bar"))],["foo"]),
		grammar(["bar"],[production("bar",nonterminal("foo"))],["bar"])
	) ==
	 grammar(["foo","bar"],[production("foo",nonterminal("bar")), production("bar",nonterminal("foo"))],["foo","bar"]);
