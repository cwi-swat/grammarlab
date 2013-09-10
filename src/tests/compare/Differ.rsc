@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module tests::compare::Differ

import grammarlab::compare::Differ;
import grammarlab::language::Grammar;

test bool dtE1() = gdts(
	grammar(["foo"],[production("foo",epsilon())],[]),
	grammar(["foo"],[production("foo",epsilon())],[])
);
test bool dtF1() = gdts(
	grammar(["foo"],[production("foo",empty())],[]),
	grammar(["foo"],[production("foo",empty())],[])
);
test bool dtA1() = gdts(
	grammar(["foo"],[production("foo",anything())],[]),
	grammar(["foo"],[production("foo",anything())],[])
);
test bool dtV1() = gdts(
	grammar(["foo"],[production("foo",val(integer()))],[]),
	grammar(["foo"],[production("foo",val(integer()))],[])
);
test bool dtV2() = !gdts(
	grammar(["foo"],[production("foo",val(integer()))],[]),
	grammar(["foo"],[production("foo",val(string()))],[])
);
test bool dtV3() = !gdts(
	grammar(["foo"],[production("foo",val(integer()))],[]),
	grammar(["foo"],[production("foo",val(boolean()))],[])
);
test bool dtV4() = !gdts(
	grammar(["foo"],[production("foo",val(string()))],[]),
	grammar(["foo"],[production("foo",val(integer()))],[])
);
test bool dtV5() = gdts(
	grammar(["foo"],[production("foo",val(string()))],[]),
	grammar(["foo"],[production("foo",val(string()))],[])
);
test bool dtV6() = !gdts(
	grammar(["foo"],[production("foo",val(string()))],[]),
	grammar(["foo"],[production("foo",val(boolean()))],[])
);
test bool dtV7() = !gdts(
	grammar(["foo"],[production("foo",val(boolean()))],[]),
	grammar(["foo"],[production("foo",val(integer()))],[])
);
test bool dtV8() = !gdts(
	grammar(["foo"],[production("foo",val(boolean()))],[]),
	grammar(["foo"],[production("foo",val(string()))],[])
);
test bool dtV9() = gdts(
	grammar(["foo"],[production("foo",val(boolean()))],[]),
	grammar(["foo"],[production("foo",val(boolean()))],[])
);
test bool dtT1() = gdts(
	grammar(["foo"],[production("foo",terminal("1"))],[]),
	grammar(["foo"],[production("foo",terminal("1"))],[])
);
test bool dtT2() = !gdts(
	grammar(["foo"],[production("foo",terminal("1"))],[]),
	grammar(["foo"],[production("foo",terminal("2"))],[])
);
test bool dtN1() = gdts(
	grammar(["foo"],[production("foo",nonterminal("bar"))],[]),
	grammar(["foo"],[production("foo",nonterminal("bar"))],[])
);
test bool dtN2() = !gdts(
	grammar(["foo"],[production("foo",nonterminal("bar"))],[]),
	grammar(["foo"],[production("foo",nonterminal("wez"))],[])
);
test bool dtS1() = gdts(
	grammar(["foo"],[production("foo",label("one",nonterminal("foo")))],[]),
	grammar(["foo"],[production("foo",label("one",nonterminal("foo")))],[])
);
test bool dtS2() = gdts(
	grammar(["foo"],[production("foo",mark("one",nonterminal("foo")))],[]),
	grammar(["foo"],[production("foo",mark("one",nonterminal("foo")))],[])
);
test bool dtS3() = !gdts(
	grammar(["foo"],[production("foo",label("one",nonterminal("foo")))],[]),
	grammar(["foo"],[production("foo",mark("one",nonterminal("foo")))],[])
);
test bool dtS4() = !gdts(
	grammar(["foo"],[production("foo",label("one",nonterminal("foo")))],[]),
	grammar(["foo"],[production("foo",label("two",nonterminal("foo")))],[])
);
test bool dtS5() = !gdts(
	grammar(["foo"],[production("foo",label("one",nonterminal("foo")))],[]),
	grammar(["foo"],[production("foo",label("one",nonterminal("bar")))],[])
);
test bool dtS6() = !gdts(
	grammar(["foo"],[production("foo",label("one",nonterminal("foo")))],[]),
	grammar(["foo"],[production("foo",label("two",nonterminal("bar")))],[])
);
test bool dtS7() = !gdts(
	grammar(["foo"],[production("foo",mark("one",nonterminal("foo")))],[]),
	grammar(["foo"],[production("foo",mark("two",nonterminal("foo")))],[])
);
test bool dtS8() = !gdts(
	grammar(["foo"],[production("foo",mark("one",nonterminal("foo")))],[]),
	grammar(["foo"],[production("foo",mark("one",nonterminal("bar")))],[])
);
test bool dtS9() = !gdts(
	grammar(["foo"],[production("foo",mark("one",nonterminal("foo")))],[]),
	grammar(["foo"],[production("foo",mark("two",nonterminal("bar")))],[])
);
test bool dtR1() = gdts(
	grammar(["foo"],[production("foo",star(terminal("1")))],[]),
	grammar(["foo"],[production("foo",star(terminal("1")))],[])
);
test bool dtR2() = gdts(
	grammar(["foo"],[production("foo",plus(terminal("1")))],[]),
	grammar(["foo"],[production("foo",plus(terminal("1")))],[])
);
test bool dtR3() = gdts(
	grammar(["foo"],[production("foo",optional(terminal("1")))],[]),
	grammar(["foo"],[production("foo",optional(terminal("1")))],[])
);
test bool dtR4() = !gdts(
	grammar(["foo"],[production("foo",star(terminal("1")))],[]),
	grammar(["foo"],[production("foo",star(terminal("2")))],[])
);
test bool dtR5() = !gdts(
	grammar(["foo"],[production("foo",plus(terminal("1")))],[]),
	grammar(["foo"],[production("foo",plus(terminal("2")))],[])
);
test bool dtR6() = !gdts(
	grammar(["foo"],[production("foo",optional(terminal("1")))],[]),
	grammar(["foo"],[production("foo",optional(terminal("2")))],[])
);
test bool dtC1() = gdts(
	grammar(["foo"],[production("foo",choice([terminal("1")]))],[]),
	grammar(["foo"],[production("foo",choice([terminal("1")]))],[])
);
test bool dtC2() = gdts(
	grammar(["foo"],[production("foo",choice([terminal("1"),terminal("2")]))],[]),
	grammar(["foo"],[production("foo",choice([terminal("2"),terminal("1")]))],[])
);
test bool dtO1() = gdts(
	grammar(["foo"],[production("foo",sequence([terminal("1"),epsilon()]))],[]),
	grammar(["foo"],[production("foo",terminal("1"))],[])
);
test bool dtO2() = !gdts(
	grammar(["foo"],[production("foo",sequence([terminal("1"),terminal("2")]))],[]),
	grammar(["foo"],[production("foo",sequence([terminal("2"),terminal("1")]))],[])
);
test bool dtSL1() = gdts(
	grammar(["foo"],[production("foo",sepliststar(nonterminal("foo"),terminal(",")))],[]),
	grammar(["foo"],[production("foo",sepliststar(nonterminal("foo"),terminal(",")))],[])
);
test bool dtSL2() = gdts(
	grammar(["foo"],[production("foo",seplistplus(nonterminal("foo"),terminal(",")))],[]),
	grammar(["foo"],[production("foo",seplistplus(nonterminal("foo"),terminal(",")))],[])
);
test bool dtSL3() = !gdts(
	grammar(["foo"],[production("foo",sepliststar(nonterminal("foo"),terminal(",")))],[]),
	grammar(["foo"],[production("foo",seplistplus(nonterminal("foo"),terminal(",")))],[])
);
test bool dtSL4() = !gdts(
	grammar(["foo"],[production("foo",sepliststar(nonterminal("foo"),terminal(",")))],[]),
	grammar(["foo"],[production("foo",sepliststar(nonterminal("bar"),terminal(",")))],[])
);
test bool dtSL5() = !gdts(
	grammar(["foo"],[production("foo",sepliststar(nonterminal("foo"),terminal(",")))],[]),
	grammar(["foo"],[production("foo",sepliststar(nonterminal("foo"),terminal(";")))],[])
);
test bool dtSL6() = !gdts(
	grammar(["foo"],[production("foo",sepliststar(nonterminal("foo"),terminal(",")))],[]),
	grammar(["foo"],[production("foo",sepliststar(nonterminal("bar"),terminal(";")))],[])
);
test bool dtSL7() = !gdts(
	grammar(["foo"],[production("foo",seplistplus(nonterminal("foo"),terminal(",")))],[]),
	grammar(["foo"],[production("foo",seplistplus(nonterminal("bar"),terminal(",")))],[])
);
test bool dtSL8() = !gdts(
	grammar(["foo"],[production("foo",seplistplus(nonterminal("foo"),terminal(",")))],[]),
	grammar(["foo"],[production("foo",seplistplus(nonterminal("foo"),terminal(";")))],[])
);
test bool dtSL9() = !gdts(
	grammar(["foo"],[production("foo",seplistplus(nonterminal("foo"),terminal(",")))],[]),
	grammar(["foo"],[production("foo",seplistplus(nonterminal("bar"),terminal(";")))],[])
);
