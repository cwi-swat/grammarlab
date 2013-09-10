@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module tests::transform::Merge

import grammarlab::transform::Merge;
import grammarlab::language::Grammar;

test bool mt1() = 
	mergeGs(
		grammar(["foo"],[production("foo",nonterminal("bar"))],[]),
		grammar(["bar"],[production("bar",nonterminal("foo"))],[])
	) ==
	 grammar(["foo","bar"],[	production("foo",nonterminal("bar")),
							production("bar",nonterminal("foo"))],[]);
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
	 grammar(["foo"],[	production("foo",nonterminal("bar")),
						production("foo",nonterminal("wez"))],[]);
test bool mt4() = 
	mergeGs(
		grammar(["foo"],[production("foo",nonterminal("bar"))],["foo"]),
		grammar(["bar"],[production("bar",nonterminal("foo"))],["bar"])
	) ==
	 grammar(["foo","bar"],[	production("foo",nonterminal("bar")),
							production("bar",nonterminal("foo"))],["foo","bar"]);
test bool mt5() = 
	mergeGs(
		grammar(["foo"],[production("foo",nonterminal("bar"))],[]),
		grammar(["foo"],[production("foo",nonterminal("wez")),production("foo",nonterminal("bar"))],[])
	) ==
	 grammar(["foo"],[	production("foo",nonterminal("bar")),
						production("foo",nonterminal("wez"))],[]);
test bool mt6() = 
	mergeGs(
		grammar(["foo"],[production("foo",mark("one",nonterminal("bar")))],[]),
		grammar(["foo"],[production("foo",mark("one",nonterminal("foo")))],[])
	) ==
	 grammar(["foo"],[	production("foo",mark("one",nonterminal("bar"))),
						production("foo",mark("one",nonterminal("foo")))],[]);
test bool mt7() = 
	mergeGs(
		grammar(["foo"],[production("foo",mark("one",nonterminal("bar")))],[]),
		grammar(["bar"],[production("bar",mark("one",nonterminal("foo")))],[])
	) ==
	 grammar(["foo","bar"],[	production("foo",mark("one",nonterminal("bar"))),
							production("bar",mark("one",nonterminal("foo")))],[]);
