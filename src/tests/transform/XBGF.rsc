@contributor{Super Awesome Automated XBGF Test Suite Synchroniser}
@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module tests::transform::XBGF

import IO;
import grammarlab::language::Grammar;
import grammarlab::language::X;
import grammarlab::language::XScope;
import grammarlab::transform::XBGF;
import grammarlab::compare::Differ;
import grammarlab::export::Grammar;
import grammarlab::export::XBNF;

bool run_case(GGrammar bgf, XSequence xbgf, GGrammar bl, bool debug)
{
	if (debug) println("Input grammar: <ppx(bgf)>");
	if (debug) println("Transformations: <ppxs(xbgf)>");
	if (debug) println("Expected output grammar: <ppx(bl)>");
	if (debug) res = vtransform(xbgf,bgf); else res = transform(xbgf,bgf);
	if (debug) println("Actual output grammar: <ppx(res)>");
	if (debug) return gdtv(res,bl);
	else return gdts(res,bl);
}

// |home:///projects/slps/topics/transformation/xbgf/tests/abridge.xbgf|
bool case_abridge(bool debug)
{
	GGrammar bgf = grammar(["expr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("neg",
				nonterminal("expr"))),
		production("expr",
			label("bracket",
				nonterminal("expr")))],
		[]);
	XSequence xbgf =
		[abridge(production("expr",
				label("bracket",
					nonterminal("expr"))))];
	GGrammar bl = grammar(["expr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("neg",
				nonterminal("expr")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_abridge() = case_abridge(false);
void show_abridge() {case_abridge(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/abstractize.xbgf|
bool case_abstractize(bool debug)
{
	GGrammar bgf = grammar(["A"],
		[production("A",
			sequence([
				nonterminal("b"),
				terminal("x"),
				nonterminal("c"),
				terminal("y")]))],
		[]);
	XSequence xbgf =
		[abstractize(production("A",
				sequence([
					nonterminal("b"),
					mark("",terminal("x")),
					nonterminal("c"),
					terminal("y")])))];
	GGrammar bl = grammar(["A"],
		[production("A",
			sequence([
				nonterminal("b"),
				nonterminal("c"),
				terminal("y")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_abstractize() = case_abstractize(false);
void show_abstractize() {case_abstractize(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/add_horizontal.xbgf|
bool case_add_horizontal(bool debug)
{
	GGrammar bgf = grammar(["N"],
		[production("N",
			choice([
				nonterminal("a"),
				nonterminal("b")]))],
		[]);
	XSequence xbgf =
		[addH(production("N",
				choice([
					mark("",terminal("x")),
					nonterminal("a"),
					nonterminal("b")])))];
	GGrammar bl = grammar(["N"],
		[production("N",
			choice([
				terminal("x"),
				nonterminal("a"),
				nonterminal("b")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_add_horizontal() = case_add_horizontal(false);
void show_add_horizontal() {case_add_horizontal(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/add_inside.xbgf|
bool case_add_inside(bool debug)
{
	GGrammar bgf = grammar(["expr"],
		[production("expr",
			sequence([
				optional(terminal("-")),
				nonterminal("int")]))],
		[]);
	XSequence xbgf =
		[addH(production("expr",
				sequence([
					optional(choice([
						mark("",terminal("+")),
						terminal("-")])),
					nonterminal("int")])))];
	GGrammar bl = grammar(["expr"],
		[production("expr",
			sequence([
				optional(choice([
					terminal("+"),
					terminal("-")])),
				nonterminal("int")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_add_inside() = case_add_inside(false);
void show_add_inside() {case_add_inside(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/add_vertical.xbgf|
bool case_add_vertical(bool debug)
{
	GGrammar bgf = grammar(["expr"],
		[production("expr",
			nonterminal("int"))],
		[]);
	XSequence xbgf =
		[addV(production("expr",
				nonterminal("id")))];
	GGrammar bl = grammar(["expr"],
		[production("expr",
			nonterminal("int")),
		production("expr",
			nonterminal("id"))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_add_vertical() = case_add_vertical(false);
void show_add_vertical() {case_add_vertical(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/add_vertical_middle.xbgf|
bool case_add_vertical_middle(bool debug)
{
	GGrammar bgf = grammar(["foo","expr","bar"],
		[production("foo",
			nonterminal("bar")),
		production("expr",
			nonterminal("int")),
		production("bar",
			nonterminal("foo"))],
		[]);
	XSequence xbgf =
		[addV(production("expr",
				nonterminal("id")))];
	GGrammar bl = grammar(["foo","expr","bar"],
		[production("foo",
			nonterminal("bar")),
		production("expr",
			nonterminal("int")),
		production("expr",
			nonterminal("id")),
		production("bar",
			nonterminal("foo"))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_add_vertical_middle() = case_add_vertical_middle(false);
void show_add_vertical_middle() {case_add_vertical_middle(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/add_vertical_scattered.xbgf|
bool case_add_vertical_scattered(bool debug)
{
	GGrammar bgf = grammar(["foo","expr","bar","wez"],
		[production("foo",
			terminal("1")),
		production("expr",
			nonterminal("int")),
		production("bar",
			terminal("2")),
		production("expr",
			nonterminal("real")),
		production("wez",
			terminal("3"))],
		[]);
	XSequence xbgf =
		[addV(production("expr",
				nonterminal("id")))];
	GGrammar bl = grammar(["foo","expr","bar","wez"],
		[production("foo",
			terminal("1")),
		production("expr",
			nonterminal("int")),
		production("expr",
			nonterminal("real")),
		production("expr",
			nonterminal("id")),
		production("bar",
			terminal("2")),
		production("wez",
			terminal("3"))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_add_vertical_scattered() = case_add_vertical_scattered(false);
void show_add_vertical_scattered() {case_add_vertical_scattered(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/anonymize_multiple.xbgf|
bool case_anonymize_multiple(bool debug)
{
	GGrammar bgf = grammar(["A"],
		[production("A",
			sequence([
				mark("first",terminal("a")),
				mark("second",terminal("a")),
				mark("third",terminal("a"))]))],
		[]);
	XSequence xbgf =
		[anonymize(production("A",
				sequence([
					mark("first",terminal("a")),
					mark("",mark("second",terminal("a"))),
					mark("",mark("third",terminal("a")))])))];
	GGrammar bl = grammar(["A"],
		[production("A",
			sequence([
				mark("first",terminal("a")),
				terminal("a"),
				terminal("a")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_anonymize_multiple() = case_anonymize_multiple(false);
void show_anonymize_multiple() {case_anonymize_multiple(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/anonymize_single.xbgf|
bool case_anonymize_single(bool debug)
{
	GGrammar bgf = grammar(["expr"],
		[production("expr",
			label("binary",
				sequence([
					terminal("("),
					nonterminal("expr"),
					mark("op",nonterminal("binary_op")),
					nonterminal("expr"),
					terminal(")")]))),
		production("expr",
			label("unary",
				sequence([
					mark("op",nonterminal("unary_op")),
					nonterminal("expr")])))],
		[]);
	XSequence xbgf =
		[anonymize(production("expr",
				label("unary",
					sequence([
						mark("",mark("op",nonterminal("unary_op"))),
						nonterminal("expr")]))))];
	GGrammar bl = grammar(["expr"],
		[production("expr",
			label("binary",
				sequence([
					terminal("("),
					nonterminal("expr"),
					mark("op",nonterminal("binary_op")),
					nonterminal("expr"),
					terminal(")")]))),
		production("expr",
			label("unary",
				sequence([
					nonterminal("unary_op"),
					nonterminal("expr")])))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_anonymize_single() = case_anonymize_single(false);
void show_anonymize_single() {case_anonymize_single(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/appear_q.xbgf|
bool case_appear_q(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			nonterminal("bar"))],
		[]);
	XSequence xbgf =
		[appear(production("foo",
				sequence([
					nonterminal("bar"),
					mark("",optional(nonterminal("qux")))])))];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			sequence([
				nonterminal("bar"),
				optional(nonterminal("qux"))]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_appear_q() = case_appear_q(false);
void show_appear_q() {case_appear_q(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/appear_s.xbgf|
bool case_appear_s(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			nonterminal("bar"))],
		[]);
	XSequence xbgf =
		[appear(production("foo",
				sequence([
					nonterminal("bar"),
					mark("",star(nonterminal("qux")))])))];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			sequence([
				nonterminal("bar"),
				star(nonterminal("qux"))]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_appear_s() = case_appear_s(false);
void show_appear_s() {case_appear_s(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/bypass.xbgf|
bool case_bypass(bool debug)
{
	GGrammar bgf = grammar(["a"],
		[production("a",
			sequence([
				nonterminal("b"),
				star(nonterminal("d")),
				nonterminal("c")]))],
		[]);
	XSequence xbgf =
		[bypass()];
	GGrammar bl = grammar(["a"],
		[production("a",
			sequence([
				nonterminal("b"),
				star(nonterminal("d")),
				nonterminal("c")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_bypass() = case_bypass(false);
void show_bypass() {case_bypass(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/chain_l.xbgf|
bool case_chain_l(bool debug)
{
	GGrammar bgf = grammar(["expr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("binary",
				sequence([
					nonterminal("expr"),
					nonterminal("op"),
					nonterminal("expr")])))],
		[]);
	XSequence xbgf =
		[chain(production("expr",
				label("binary",
					nonterminal("binexpr"))))];
	GGrammar bl = grammar(["expr","binexpr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("binary",
				nonterminal("binexpr"))),
		production("binexpr",
			sequence([
				nonterminal("expr"),
				nonterminal("op"),
				nonterminal("expr")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_chain_l() = case_chain_l(false);
void show_chain_l() {case_chain_l(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/chain_n.xbgf|
bool case_chain_n(bool debug)
{
	GGrammar bgf = grammar(["ClassDeclaration","ClassBody"],
		[production("ClassDeclaration",
			sequence([
				terminal("class"),
				nonterminal("Identifier"),
				nonterminal("ClassBody")])),
		production("ClassBody",
			sequence([
				terminal("{"),
				optional(nonterminal("ClassBodyDeclarations")),
				terminal("}")]))],
		[]);
	XSequence xbgf =
		[chain(production("ClassDeclaration",
				nonterminal("NormalClassDeclaration")))];
	GGrammar bl = grammar(["ClassDeclaration","NormalClassDeclaration","ClassBody"],
		[production("ClassDeclaration",
			nonterminal("NormalClassDeclaration")),
		production("NormalClassDeclaration",
			sequence([
				terminal("class"),
				nonterminal("Identifier"),
				nonterminal("ClassBody")])),
		production("ClassBody",
			sequence([
				terminal("{"),
				optional(nonterminal("ClassBodyDeclarations")),
				terminal("}")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_chain_n() = case_chain_n(false);
void show_chain_n() {case_chain_n(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/concretize.xbgf|
bool case_concretize(bool debug)
{
	GGrammar bgf = grammar(["A"],
		[production("A",
			sequence([
				nonterminal("b"),
				nonterminal("c")]))],
		[]);
	XSequence xbgf =
		[concretize(production("A",
				sequence([
					nonterminal("b"),
					mark("",terminal("x")),
					nonterminal("c")])))];
	GGrammar bl = grammar(["A"],
		[production("A",
			sequence([
				nonterminal("b"),
				terminal("x"),
				nonterminal("c")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_concretize() = case_concretize(false);
void show_concretize() {case_concretize(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/deanonymize_multiple.xbgf|
bool case_deanonymize_multiple(bool debug)
{
	GGrammar bgf = grammar(["A"],
		[production("A",
			sequence([
				mark("first",terminal("a")),
				terminal("a"),
				terminal("a")]))],
		[]);
	XSequence xbgf =
		[deanonymize(production("A",
				sequence([
					mark("first",terminal("a")),
					mark("",mark("second",terminal("a"))),
					mark("",mark("third",terminal("a")))])))];
	GGrammar bl = grammar(["A"],
		[production("A",
			sequence([
				mark("first",terminal("a")),
				mark("second",terminal("a")),
				mark("third",terminal("a"))]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_deanonymize_multiple() = case_deanonymize_multiple(false);
void show_deanonymize_multiple() {case_deanonymize_multiple(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/deanonymize_single.xbgf|
bool case_deanonymize_single(bool debug)
{
	GGrammar bgf = grammar(["expr"],
		[production("expr",
			label("constant",
				mark("value",nonterminal("int")))),
		production("expr",
			label("binary",
				sequence([
					terminal("("),
					nonterminal("expr"),
					mark("op",nonterminal("binary_op")),
					nonterminal("expr"),
					terminal(")")]))),
		production("expr",
			label("unary",
				sequence([
					nonterminal("unary_op"),
					nonterminal("expr")])))],
		[]);
	XSequence xbgf =
		[deanonymize(production("expr",
				label("unary",
					sequence([
						mark("",mark("op",nonterminal("unary_op"))),
						nonterminal("expr")]))))];
	GGrammar bl = grammar(["expr"],
		[production("expr",
			label("constant",
				mark("value",nonterminal("int")))),
		production("expr",
			label("binary",
				sequence([
					terminal("("),
					nonterminal("expr"),
					mark("op",nonterminal("binary_op")),
					nonterminal("expr"),
					terminal(")")]))),
		production("expr",
			label("unary",
				sequence([
					mark("op",nonterminal("unary_op")),
					nonterminal("expr")])))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_deanonymize_single() = case_deanonymize_single(false);
void show_deanonymize_single() {case_deanonymize_single(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/define.xbgf|
bool case_define(bool debug)
{
	GGrammar bgf = grammar(["expr"],
		[production("expr",
			nonterminal("int")),
		production("expr",
			sequence([
				nonterminal("expr"),
				nonterminal("op"),
				nonterminal("expr")]))],
		[]);
	XSequence xbgf =
		[define([production("op",
					terminal("+")),
				production("op",
					terminal("-"))])];
	GGrammar bl = grammar(["expr","op"],
		[production("expr",
			nonterminal("int")),
		production("expr",
			sequence([
				nonterminal("expr"),
				nonterminal("op"),
				nonterminal("expr")])),
		production("op",
			terminal("+")),
		production("op",
			terminal("-"))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_define() = case_define(false);
void show_define() {case_define(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/designate.xbgf|
bool case_designate(bool debug)
{
	GGrammar bgf = grammar(["expr"],
		[production("expr",
			nonterminal("int"))],
		[]);
	XSequence xbgf =
		[designate(production("expr",
				label("intexpr",
					nonterminal("int"))))];
	GGrammar bl = grammar(["expr"],
		[production("expr",
			label("intexpr",
				nonterminal("int")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_designate() = case_designate(false);
void show_designate() {case_designate(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/detour.xbgf|
bool case_detour(bool debug)
{
	GGrammar bgf = grammar(["expr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("neg",
				nonterminal("expr")))],
		[]);
	XSequence xbgf =
		[detour(production("expr",
				label("bracket",
					nonterminal("expr"))))];
	GGrammar bl = grammar(["expr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("neg",
				nonterminal("expr"))),
		production("expr",
			label("bracket",
				nonterminal("expr")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_detour() = case_detour(false);
void show_detour() {case_detour(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/deyaccify_eps.xbgf|
bool case_deyaccify_eps(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			epsilon()),
		production("foo",
			sequence([
				nonterminal("bar"),
				nonterminal("foo")]))],
		[]);
	XSequence xbgf =
		[deyaccify("foo")];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			star(nonterminal("bar")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_deyaccify_eps() = case_deyaccify_eps(false);
void show_deyaccify_eps() {case_deyaccify_eps(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/deyaccify_left.xbgf|
bool case_deyaccify_left(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			nonterminal("bar")),
		production("foo",
			sequence([
				nonterminal("foo"),
				nonterminal("wez")]))],
		[]);
	XSequence xbgf =
		[deyaccify("foo")];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			sequence([
				nonterminal("bar"),
				star(nonterminal("wez"))]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_deyaccify_left() = case_deyaccify_left(false);
void show_deyaccify_left() {case_deyaccify_left(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/deyaccify_left_plus.xbgf|
bool case_deyaccify_left_plus(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			nonterminal("bar")),
		production("foo",
			sequence([
				nonterminal("foo"),
				nonterminal("bar")]))],
		[]);
	XSequence xbgf =
		[deyaccify("foo")];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			plus(nonterminal("bar")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_deyaccify_left_plus() = case_deyaccify_left_plus(false);
void show_deyaccify_left_plus() {case_deyaccify_left_plus(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/deyaccify_right.xbgf|
bool case_deyaccify_right(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			nonterminal("bar")),
		production("foo",
			sequence([
				nonterminal("wez"),
				nonterminal("foo")]))],
		[]);
	XSequence xbgf =
		[deyaccify("foo")];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			sequence([
				star(nonterminal("wez")),
				nonterminal("bar")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_deyaccify_right() = case_deyaccify_right(false);
void show_deyaccify_right() {case_deyaccify_right(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/deyaccify_right_plus.xbgf|
bool case_deyaccify_right_plus(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			nonterminal("bar")),
		production("foo",
			sequence([
				nonterminal("bar"),
				nonterminal("foo")]))],
		[]);
	XSequence xbgf =
		[deyaccify("foo")];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			plus(nonterminal("bar")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_deyaccify_right_plus() = case_deyaccify_right_plus(false);
void show_deyaccify_right_plus() {case_deyaccify_right_plus(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/disappear_q.xbgf|
bool case_disappear_q(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			sequence([
				nonterminal("bar"),
				optional(nonterminal("qux"))]))],
		[]);
	XSequence xbgf =
		[disappear(production("foo",
				sequence([
					nonterminal("bar"),
					mark("",optional(nonterminal("qux")))])))];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			nonterminal("bar"))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_disappear_q() = case_disappear_q(false);
void show_disappear_q() {case_disappear_q(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/disappear_s.xbgf|
bool case_disappear_s(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			sequence([
				nonterminal("bar"),
				star(nonterminal("wez")),
				nonterminal("qux")]))],
		[]);
	XSequence xbgf =
		[disappear(production("foo",
				sequence([
					nonterminal("bar"),
					mark("",star(nonterminal("wez"))),
					nonterminal("qux")])))];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			sequence([
				nonterminal("bar"),
				nonterminal("qux")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_disappear_s() = case_disappear_s(false);
void show_disappear_s() {case_disappear_s(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/distribute_l.xbgf|
bool case_distribute_l(bool debug)
{
	GGrammar bgf = grammar(["a"],
		[production("a",
			label("bcd",
				sequence([
					nonterminal("b"),
					choice([
						nonterminal("c"),
						nonterminal("d")])]))),
		production("a",
			label("efg",
				sequence([
					nonterminal("e"),
					choice([
						nonterminal("f"),
						nonterminal("g")])])))],
		[]);
	XSequence xbgf =
		[distribute(inlabel("bcd"))];
	GGrammar bl = grammar(["a"],
		[production("a",
			label("bcd",
				choice([
					sequence([
						nonterminal("b"),
						nonterminal("c")]),
					sequence([
						nonterminal("b"),
						nonterminal("d")])]))),
		production("a",
			label("efg",
				sequence([
					nonterminal("e"),
					choice([
						nonterminal("f"),
						nonterminal("g")])])))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_distribute_l() = case_distribute_l(false);
void show_distribute_l() {case_distribute_l(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/distribute_nt.xbgf|
bool case_distribute_nt(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			sequence([
				nonterminal("bar"),
				choice([
					nonterminal("qux"),
					nonterminal("wez")])]))],
		[]);
	XSequence xbgf =
		[distribute(innt("foo"))];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			choice([
				sequence([
					nonterminal("bar"),
					nonterminal("qux")]),
				sequence([
					nonterminal("bar"),
					nonterminal("wez")])]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_distribute_nt() = case_distribute_nt(false);
void show_distribute_nt() {case_distribute_nt(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/downgrade.xbgf|
bool case_downgrade(bool debug)
{
	GGrammar bgf = grammar(["a","b"],
		[production("a",
			sequence([
				nonterminal("b"),
				nonterminal("c")])),
		production("b",
			sequence([
				nonterminal("d"),
				nonterminal("e")])),
		production("b",
			sequence([
				nonterminal("f"),
				nonterminal("g")]))],
		[]);
	XSequence xbgf =
		[downgrade(
			production("a",
				sequence([
					mark("",nonterminal("b")),
					nonterminal("c")])),
			production("b",
				sequence([
					nonterminal("d"),
					nonterminal("e")])))];
	GGrammar bl = grammar(["a","b"],
		[production("a",
			sequence([
				nonterminal("d"),
				nonterminal("e"),
				nonterminal("c")])),
		production("b",
			sequence([
				nonterminal("d"),
				nonterminal("e")])),
		production("b",
			sequence([
				nonterminal("f"),
				nonterminal("g")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_downgrade() = case_downgrade(false);
void show_downgrade() {case_downgrade(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/eliminate.xbgf|
bool case_eliminate(bool debug)
{
	GGrammar bgf = grammar(["expr","intexpr"],
		[production("expr",
			nonterminal("int")),
		production("intexpr",
			nonterminal("int"))],
		[]);
	XSequence xbgf =
		[eliminate("intexpr")];
	GGrammar bl = grammar(["expr"],
		[production("expr",
			nonterminal("int"))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_eliminate() = case_eliminate(false);
void show_eliminate() {case_eliminate(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/equate1.xbgf|
bool case_equate1(bool debug)
{
	GGrammar bgf = grammar(["foo","bar"],
		[production("foo",
			nonterminal("wez")),
		production("bar",
			nonterminal("wez"))],
		[]);
	XSequence xbgf =
		[equate("foo","bar")];
	GGrammar bl = grammar(["bar"],
		[production("bar",
			nonterminal("wez"))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_equate1() = case_equate1(false);
void show_equate1() {case_equate1(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/equate2.xbgf|
bool case_equate2(bool debug)
{
	GGrammar bgf = grammar(["foo","bar"],
		[production("foo",
			choice([
				star(nonterminal("wez")),
				terminal("x")])),
		production("bar",
			choice([
				terminal("x"),
				star(nonterminal("wez"))]))],
		[]);
	XSequence xbgf =
		[equate("foo","bar")];
	GGrammar bl = grammar(["bar"],
		[production("bar",
			choice([
				terminal("x"),
				star(nonterminal("wez"))]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_equate2() = case_equate2(false);
void show_equate2() {case_equate2(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/equate3.xbgf|
bool case_equate3(bool debug)
{
	GGrammar bgf = grammar(["foo","bar"],
		[production("foo",
			star(nonterminal("wez"))),
		production("foo",
			terminal("x")),
		production("bar",
			terminal("x")),
		production("bar",
			star(nonterminal("wez")))],
		[]);
	XSequence xbgf =
		[equate("foo","bar")];
	GGrammar bl = grammar(["bar"],
		[production("bar",
			star(nonterminal("wez"))),
		production("bar",
			terminal("x"))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_equate3() = case_equate3(false);
void show_equate3() {case_equate3(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/equate4.xbgf|
bool case_equate4(bool debug)
{
	GGrammar bgf = grammar(["foo","bar","wez"],
		[production("foo",
			choice([
				star(nonterminal("wez")),
				terminal("x")])),
		production("bar",
			choice([
				terminal("x"),
				star(nonterminal("wez"))])),
		production("wez",
			label("go",
				sequence([
					nonterminal("foo"),
					terminal("!")]))),
		production("wez",
			label("stay",
				sequence([
					nonterminal("bar"),
					nonterminal("wez")])))],
		[]);
	XSequence xbgf =
		[equate("foo","bar")];
	GGrammar bl = grammar(["bar","wez"],
		[production("bar",
			choice([
				terminal("x"),
				star(nonterminal("wez"))])),
		production("wez",
			label("go",
				sequence([
					nonterminal("bar"),
					terminal("!")]))),
		production("wez",
			label("stay",
				sequence([
					nonterminal("bar"),
					nonterminal("wez")])))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_equate4() = case_equate4(false);
void show_equate4() {case_equate4(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/extract_l.xbgf|
bool case_extract_l(bool debug)
{
	GGrammar bgf = grammar(["a","b"],
		[production("a",
			label("l1",
				star(nonterminal("x")))),
		production("b",
			label("l2",
				star(nonterminal("x"))))],
		[]);
	XSequence xbgf =
		[extract(production("xs",
			star(nonterminal("x"))),
			inlabel("l2"))];
	GGrammar bl = grammar(["a","b","xs"],
		[production("a",
			label("l1",
				star(nonterminal("x")))),
		production("b",
			label("l2",
				nonterminal("xs"))),
		production("xs",
			star(nonterminal("x")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_extract_l() = case_extract_l(false);
void show_extract_l() {case_extract_l(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/extract_nt.xbgf|
bool case_extract_nt(bool debug)
{
	GGrammar bgf = grammar(["a","b"],
		[production("a",
			star(nonterminal("x"))),
		production("b",
			star(nonterminal("x")))],
		[]);
	XSequence xbgf =
		[extract(production("xs",
			star(nonterminal("x"))),
			innt("a"))];
	GGrammar bl = grammar(["a","xs","b"],
		[production("a",
			nonterminal("xs")),
		production("xs",
			star(nonterminal("x"))),
		production("b",
			star(nonterminal("x")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_extract_nt() = case_extract_nt(false);
void show_extract_nt() {case_extract_nt(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/extract_subch.xbgf|
bool case_extract_subch(bool debug)
{
	GGrammar bgf = grammar(["TypeDeclaration"],
		[production("TypeDeclaration",
			choice([
				nonterminal("ClassDeclaration"),
				nonterminal("InterfaceDeclaration"),
				terminal(";")]))],
		[]);
	XSequence xbgf =
		[extract(production("ClassOrInterfaceDeclaration",
			choice([
				nonterminal("ClassDeclaration"),
				nonterminal("InterfaceDeclaration")])),
			globally())];
	GGrammar bl = grammar(["TypeDeclaration","ClassOrInterfaceDeclaration"],
		[production("TypeDeclaration",
			choice([
				nonterminal("ClassOrInterfaceDeclaration"),
				terminal(";")])),
		production("ClassOrInterfaceDeclaration",
			choice([
				nonterminal("ClassDeclaration"),
				nonterminal("InterfaceDeclaration")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_extract_subch() = case_extract_subch(false);
void show_extract_subch() {case_extract_subch(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/extract_subseq_multiple.xbgf|
bool case_extract_subseq_multiple(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			sequence([
				star(sequence([
					nonterminal("bar"),
					nonterminal("wez")])),
				nonterminal("bar"),
				nonterminal("wez")]))],
		[]);
	XSequence xbgf =
		[extract(production("qux",
			sequence([
				nonterminal("bar"),
				nonterminal("wez")])),
			globally())];
	GGrammar bl = grammar(["foo","qux"],
		[production("foo",
			sequence([
				star(nonterminal("qux")),
				nonterminal("qux")])),
		production("qux",
			sequence([
				nonterminal("bar"),
				nonterminal("wez")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_extract_subseq_multiple() = case_extract_subseq_multiple(false);
void show_extract_subseq_multiple() {case_extract_subseq_multiple(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/extract_subseq_single.xbgf|
bool case_extract_subseq_single(bool debug)
{
	GGrammar bgf = grammar(["IfThenStatement"],
		[production("IfThenStatement",
			sequence([
				terminal("if"),
				terminal("("),
				nonterminal("Expression"),
				terminal(")"),
				nonterminal("Statement")]))],
		[]);
	XSequence xbgf =
		[extract(production("ParExpression",
			sequence([
				terminal("("),
				nonterminal("Expression"),
				terminal(")")])),
			globally())];
	GGrammar bl = grammar(["IfThenStatement","ParExpression"],
		[production("IfThenStatement",
			sequence([
				terminal("if"),
				nonterminal("ParExpression"),
				nonterminal("Statement")])),
		production("ParExpression",
			sequence([
				terminal("("),
				nonterminal("Expression"),
				terminal(")")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_extract_subseq_single() = case_extract_subseq_single(false);
void show_extract_subseq_single() {case_extract_subseq_single(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/factor_eps.xbgf|
bool case_factor_eps(bool debug)
{
	GGrammar bgf = grammar(["a"],
		[production("a",
			choice([
				nonterminal("b"),
				sequence([
					nonterminal("b"),
					nonterminal("c")])]))],
		[]);
	XSequence xbgf =
		[factor(
			choice([
				nonterminal("b"),
				sequence([
					nonterminal("b"),
					nonterminal("c")])]),
			sequence([
				nonterminal("b"),
				choice([
					epsilon(),
					nonterminal("c")])]),
			globally())];
	GGrammar bl = grammar(["a"],
		[production("a",
			sequence([
				nonterminal("b"),
				choice([
					epsilon(),
					nonterminal("c")])]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_factor_eps() = case_factor_eps(false);
void show_factor_eps() {case_factor_eps(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/factor_global.xbgf|
bool case_factor_global(bool debug)
{
	GGrammar bgf = grammar(["a"],
		[production("a",
			choice([
				sequence([
					nonterminal("b"),
					nonterminal("c")]),
				sequence([
					nonterminal("b"),
					nonterminal("d")])]))],
		[]);
	XSequence xbgf =
		[factor(
			choice([
				sequence([
					nonterminal("b"),
					nonterminal("c")]),
				sequence([
					nonterminal("b"),
					nonterminal("d")])]),
			sequence([
				nonterminal("b"),
				choice([
					nonterminal("d"),
					nonterminal("c")])]),
			globally())];
	GGrammar bl = grammar(["a"],
		[production("a",
			sequence([
				nonterminal("b"),
				choice([
					nonterminal("c"),
					nonterminal("d")])]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_factor_global() = case_factor_global(false);
void show_factor_global() {case_factor_global(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/factor_local.xbgf|
bool case_factor_local(bool debug)
{
	GGrammar bgf = grammar(["a"],
		[production("a",
			choice([
				nonterminal("a"),
				nonterminal("b"),
				sequence([
					nonterminal("c"),
					nonterminal("d"),
					nonterminal("e")]),
				sequence([
					nonterminal("c"),
					nonterminal("f"),
					nonterminal("g")]),
				nonterminal("h"),
				nonterminal("i")]))],
		[]);
	XSequence xbgf =
		[factor(
			choice([
				sequence([
					nonterminal("c"),
					nonterminal("d"),
					nonterminal("e")]),
				sequence([
					nonterminal("c"),
					nonterminal("f"),
					nonterminal("g")])]),
			sequence([
				nonterminal("c"),
				choice([
					sequence([
						nonterminal("d"),
						nonterminal("e")]),
					sequence([
						nonterminal("f"),
						nonterminal("g")])])]),
			globally())];
	GGrammar bl = grammar(["a"],
		[production("a",
			choice([
				nonterminal("a"),
				nonterminal("b"),
				sequence([
					nonterminal("c"),
					choice([
						sequence([
							nonterminal("d"),
							nonterminal("e")]),
						sequence([
							nonterminal("f"),
							nonterminal("g")])])]),
				nonterminal("h"),
				nonterminal("i")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_factor_local() = case_factor_local(false);
void show_factor_local() {case_factor_local(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/factor_nt.xbgf|
bool case_factor_nt(bool debug)
{
	GGrammar bgf = grammar(["a"],
		[production("a",
			choice([
				sequence([
					nonterminal("b"),
					nonterminal("c")]),
				sequence([
					nonterminal("b"),
					nonterminal("d")])]))],
		[]);
	XSequence xbgf =
		[factor(
			choice([
				sequence([
					nonterminal("b"),
					nonterminal("c")]),
				sequence([
					nonterminal("b"),
					nonterminal("d")])]),
			sequence([
				nonterminal("b"),
				choice([
					nonterminal("c"),
					nonterminal("d")])]),
			innt("a"))];
	GGrammar bl = grammar(["a"],
		[production("a",
			sequence([
				nonterminal("b"),
				choice([
					nonterminal("c"),
					nonterminal("d")])]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_factor_nt() = case_factor_nt(false);
void show_factor_nt() {case_factor_nt(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/fold.xbgf|
bool case_fold(bool debug)
{
	GGrammar bgf = grammar(["foo","qux","bar"],
		[production("foo",
			label("l1",
				star(nonterminal("wez")))),
		production("qux",
			label("l2",
				star(nonterminal("wez")))),
		production("bar",
			star(nonterminal("wez")))],
		[]);
	XSequence xbgf =
		[fold("bar",globally())];
	GGrammar bl = grammar(["foo","qux","bar"],
		[production("foo",
			label("l1",
				nonterminal("bar"))),
		production("qux",
			label("l2",
				nonterminal("bar"))),
		production("bar",
			star(nonterminal("wez")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_fold() = case_fold(false);
void show_fold() {case_fold(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/fold_l.xbgf|
bool case_fold_l(bool debug)
{
	GGrammar bgf = grammar(["foo","qux","bar"],
		[production("foo",
			label("l1",
				star(nonterminal("wez")))),
		production("qux",
			label("l2",
				star(nonterminal("wez")))),
		production("bar",
			star(nonterminal("wez")))],
		[]);
	XSequence xbgf =
		[fold("bar",inlabel("l1"))];
	GGrammar bl = grammar(["foo","qux","bar"],
		[production("foo",
			label("l1",
				nonterminal("bar"))),
		production("qux",
			label("l2",
				star(nonterminal("wez")))),
		production("bar",
			star(nonterminal("wez")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_fold_l() = case_fold_l(false);
void show_fold_l() {case_fold_l(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/fold_nt.xbgf|
bool case_fold_nt(bool debug)
{
	GGrammar bgf = grammar(["foo","qux","bar"],
		[production("foo",
			label("l1",
				star(nonterminal("wez")))),
		production("qux",
			label("l2",
				star(nonterminal("wez")))),
		production("bar",
			star(nonterminal("wez")))],
		[]);
	XSequence xbgf =
		[fold("bar",innt("foo"))];
	GGrammar bl = grammar(["foo","qux","bar"],
		[production("foo",
			label("l1",
				nonterminal("bar"))),
		production("qux",
			label("l2",
				star(nonterminal("wez")))),
		production("bar",
			star(nonterminal("wez")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_fold_nt() = case_fold_nt(false);
void show_fold_nt() {case_fold_nt(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/horizontal_l.xbgf|
bool case_horizontal_l(bool debug)
{
	GGrammar bgf = grammar(["decs"],
		[production("decs",
			label("onedec",
				nonterminal("dec"))),
		production("decs",
			label("moredecs",
				sequence([
					nonterminal("dec"),
					nonterminal("decs")])))],
		[]);
	XSequence xbgf =
		[horizontal(innt("decs"))];
	GGrammar bl = grammar(["decs"],
		[production("decs",
			choice([
				label("onedec",nonterminal("dec")),
				label("moredecs",sequence([
					nonterminal("dec"),
					nonterminal("decs")]))]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_horizontal_l() = case_horizontal_l(false);
void show_horizontal_l() {case_horizontal_l(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/horizontal_n.xbgf|
bool case_horizontal_n(bool debug)
{
	GGrammar bgf = grammar(["decs"],
		[production("decs",
			nonterminal("dec")),
		production("decs",
			sequence([
				nonterminal("dec"),
				nonterminal("decs")]))],
		[]);
	XSequence xbgf =
		[horizontal(innt("decs"))];
	GGrammar bl = grammar(["decs"],
		[production("decs",
			choice([
				nonterminal("dec"),
				sequence([
					nonterminal("dec"),
					nonterminal("decs")])]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_horizontal_n() = case_horizontal_n(false);
void show_horizontal_n() {case_horizontal_n(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/import.xbgf|
bool case_import(bool debug)
{
	GGrammar bgf = grammar(["X"],
		[production("X",
			sequence([
				terminal("a"),
				terminal("b")]))],
		[]);
	XSequence xbgf =
		[importG([production("A",
					sequence([
						nonterminal("B"),
						nonterminal("X")])),
				production("B",
					choice([
						nonterminal("A"),
						epsilon()]))])];
	GGrammar bl = grammar(["X","A","B"],
		[production("X",
			sequence([
				terminal("a"),
				terminal("b")])),
		production("A",
			sequence([
				nonterminal("B"),
				nonterminal("X")])),
		production("B",
			choice([
				nonterminal("A"),
				epsilon()]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_import() = case_import(false);
void show_import() {case_import(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/inject.xbgf|
bool case_inject(bool debug)
{
	GGrammar bgf = grammar(["a"],
		[production("a",
			sequence([
				nonterminal("b"),
				nonterminal("d")]))],
		[]);
	XSequence xbgf =
		[inject(production("a",
				sequence([
					nonterminal("b"),
					mark("",nonterminal("c")),
					nonterminal("d")])))];
	GGrammar bl = grammar(["a"],
		[production("a",
			sequence([
				nonterminal("b"),
				nonterminal("c"),
				nonterminal("d")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_inject() = case_inject(false);
void show_inject() {case_inject(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/inline.xbgf|
bool case_inline(bool debug)
{
	GGrammar bgf = grammar(["foo","bar","wez"],
		[production("foo",
			nonterminal("wez")),
		production("bar",
			sequence([
				nonterminal("wez"),
				terminal(".."),
				nonterminal("wez")])),
		production("wez",
			star(nonterminal("qux")))],
		[]);
	XSequence xbgf =
		[inline("wez")];
	GGrammar bl = grammar(["foo","bar"],
		[production("foo",
			star(nonterminal("qux"))),
		production("bar",
			sequence([
				star(nonterminal("qux")),
				terminal(".."),
				star(nonterminal("qux"))]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_inline() = case_inline(false);
void show_inline() {case_inline(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/introduce.xbgf|
bool case_introduce(bool debug)
{
	GGrammar bgf = grammar(["a","b"],
		[production("a",
			nonterminal("b")),
		production("b",
			epsilon())],
		[]);
	XSequence xbgf =
		[introduce([production("c",
					nonterminal("a")),
				production("c",
					nonterminal("b"))])];
	GGrammar bl = grammar(["a","b","c"],
		[production("a",
			nonterminal("b")),
		production("b",
			epsilon()),
		production("c",
			nonterminal("a")),
		production("c",
			nonterminal("b"))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_introduce() = case_introduce(false);
void show_introduce() {case_introduce(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/iterate_l.xbgf|
bool case_iterate_l(bool debug)
{
	GGrammar bgf = grammar(["expr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("binary",
				sequence([
					nonterminal("expr"),
					nonterminal("op"),
					nonterminal("expr")])))],
		[]);
	XSequence xbgf =
		[iterate(production("expr",
				label("binary",
					sequence([
						star(sequence([
							nonterminal("expr"),
							nonterminal("op")])),
						nonterminal("expr")]))))];
	GGrammar bl = grammar(["expr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("binary",
				sequence([
					star(sequence([
						nonterminal("expr"),
						nonterminal("op")])),
					nonterminal("expr")])))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_iterate_l() = case_iterate_l(false);
void show_iterate_l() {case_iterate_l(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/iterate_p.xbgf|
bool case_iterate_p(bool debug)
{
	GGrammar bgf = grammar(["expr"],
		[production("expr",
			label("terminal",
				val(string()))),
		production("expr",
			label("sequence",
				sequence([
					nonterminal("expr"),
					nonterminal("expr")])))],
		[]);
	XSequence xbgf =
		[iterate(production("expr",
				label("sequence",
					plus(nonterminal("expr")))))];
	GGrammar bl = grammar(["expr"],
		[production("expr",
			label("terminal",
				val(string()))),
		production("expr",
			label("sequence",
				plus(nonterminal("expr"))))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_iterate_p() = case_iterate_p(false);
void show_iterate_p() {case_iterate_p(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/iterate_r.xbgf|
bool case_iterate_r(bool debug)
{
	GGrammar bgf = grammar(["expr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("binary",
				sequence([
					nonterminal("expr"),
					nonterminal("op"),
					nonterminal("expr")])))],
		[]);
	XSequence xbgf =
		[iterate(production("expr",
				label("binary",
					sequence([
						nonterminal("expr"),
						star(sequence([
							nonterminal("op"),
							nonterminal("expr")]))]))))];
	GGrammar bl = grammar(["expr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("binary",
				sequence([
					nonterminal("expr"),
					star(sequence([
						nonterminal("op"),
						nonterminal("expr")]))])))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_iterate_r() = case_iterate_r(false);
void show_iterate_r() {case_iterate_r(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/lassoc_l.xbgf|
bool case_lassoc_l(bool debug)
{
	GGrammar bgf = grammar(["expr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("binary",
				sequence([
					star(sequence([
						nonterminal("expr"),
						nonterminal("op")])),
					nonterminal("expr")])))],
		[]);
	XSequence xbgf =
		[lassoc(production("expr",
				label("binary",
					sequence([
						nonterminal("expr"),
						nonterminal("op"),
						nonterminal("expr")]))))];
	GGrammar bl = grammar(["expr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("binary",
				sequence([
					nonterminal("expr"),
					nonterminal("op"),
					nonterminal("expr")])))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_lassoc_l() = case_lassoc_l(false);
void show_lassoc_l() {case_lassoc_l(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/lassoc_p.xbgf|
bool case_lassoc_p(bool debug)
{
	GGrammar bgf = grammar(["expr"],
		[production("expr",
			label("terminal",
				val(string()))),
		production("expr",
			label("sequence",
				plus(nonterminal("expr"))))],
		[]);
	XSequence xbgf =
		[lassoc(production("expr",
				label("sequence",
					sequence([
						nonterminal("expr"),
						nonterminal("expr")]))))];
	GGrammar bl = grammar(["expr"],
		[production("expr",
			label("terminal",
				val(string()))),
		production("expr",
			label("sequence",
				sequence([
					nonterminal("expr"),
					nonterminal("expr")])))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_lassoc_p() = case_lassoc_p(false);
void show_lassoc_p() {case_lassoc_p(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/lassoc_r.xbgf|
bool case_lassoc_r(bool debug)
{
	GGrammar bgf = grammar(["expr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("binary",
				sequence([
					nonterminal("expr"),
					star(sequence([
						nonterminal("op"),
						nonterminal("expr")]))])))],
		[]);
	XSequence xbgf =
		[lassoc(production("expr",
				label("binary",
					sequence([
						nonterminal("expr"),
						nonterminal("op"),
						nonterminal("expr")]))))];
	GGrammar bl = grammar(["expr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("binary",
				sequence([
					nonterminal("expr"),
					nonterminal("op"),
					nonterminal("expr")])))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_lassoc_r() = case_lassoc_r(false);
void show_lassoc_r() {case_lassoc_r(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_assoc_p.xbgf|
bool case_massage_assoc_p(bool debug)
{
	GGrammar bgf = grammar(["N"],
		[production("N",
			sequence([
				plus(sequence([
					nonterminal("a"),
					nonterminal("b")])),
				nonterminal("a")]))],
		[]);
	XSequence xbgf =
		[massage(
			sequence([
				plus(sequence([
					nonterminal("a"),
					nonterminal("b")])),
				nonterminal("a")]),
			sequence([
				nonterminal("a"),
				plus(sequence([
					nonterminal("b"),
					nonterminal("a")]))]),
			globally())];
	GGrammar bl = grammar(["N"],
		[production("N",
			sequence([
				nonterminal("a"),
				plus(sequence([
					nonterminal("b"),
					nonterminal("a")]))]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_assoc_p() = case_massage_assoc_p(false);
void show_massage_assoc_p() {case_massage_assoc_p(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_assoc_q.xbgf|
bool case_massage_assoc_q(bool debug)
{
	GGrammar bgf = grammar(["N"],
		[production("N",
			sequence([
				optional(sequence([
					nonterminal("a"),
					nonterminal("b")])),
				nonterminal("a")]))],
		[]);
	XSequence xbgf =
		[massage(
			sequence([
				optional(sequence([
					nonterminal("a"),
					nonterminal("b")])),
				nonterminal("a")]),
			sequence([
				nonterminal("a"),
				optional(sequence([
					nonterminal("b"),
					nonterminal("a")]))]),
			globally())];
	GGrammar bl = grammar(["N"],
		[production("N",
			sequence([
				nonterminal("a"),
				optional(sequence([
					nonterminal("b"),
					nonterminal("a")]))]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_assoc_q() = case_massage_assoc_q(false);
void show_massage_assoc_q() {case_massage_assoc_q(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_assoc_s.xbgf|
bool case_massage_assoc_s(bool debug)
{
	GGrammar bgf = grammar(["N"],
		[production("N",
			sequence([
				star(sequence([
					nonterminal("a"),
					nonterminal("b")])),
				nonterminal("a")]))],
		[]);
	XSequence xbgf =
		[massage(
			sequence([
				star(sequence([
					nonterminal("a"),
					nonterminal("b")])),
				nonterminal("a")]),
			sequence([
				nonterminal("a"),
				star(sequence([
					nonterminal("b"),
					nonterminal("a")]))]),
			globally())];
	GGrammar bl = grammar(["N"],
		[production("N",
			sequence([
				nonterminal("a"),
				star(sequence([
					nonterminal("b"),
					nonterminal("a")]))]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_assoc_s() = case_massage_assoc_s(false);
void show_massage_assoc_s() {case_massage_assoc_s(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_ch_ep.xbgf|
bool case_massage_ch_ep(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			choice([
				plus(nonterminal("bar")),
				epsilon()]))],
		[]);
	XSequence xbgf =
		[massage(
			choice([
				epsilon(),
				plus(nonterminal("bar"))]),
			star(nonterminal("bar")),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			star(nonterminal("bar")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_ch_ep() = case_massage_ch_ep(false);
void show_massage_ch_ep() {case_massage_ch_ep(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_ch_eq.xbgf|
bool case_massage_ch_eq(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			choice([
				optional(nonterminal("bar")),
				epsilon()]))],
		[]);
	XSequence xbgf =
		[massage(
			choice([
				epsilon(),
				optional(nonterminal("bar"))]),
			optional(nonterminal("bar")),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			optional(nonterminal("bar")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_ch_eq() = case_massage_ch_eq(false);
void show_massage_ch_eq() {case_massage_ch_eq(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_ch_es.xbgf|
bool case_massage_ch_es(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			choice([
				star(nonterminal("bar")),
				epsilon()]))],
		[]);
	XSequence xbgf =
		[massage(
			choice([
				epsilon(),
				star(nonterminal("bar"))]),
			star(nonterminal("bar")),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			star(nonterminal("bar")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_ch_es() = case_massage_ch_es(false);
void show_massage_ch_es() {case_massage_ch_es(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_ch_ex.xbgf|
bool case_massage_ch_ex(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			choice([
				nonterminal("bar"),
				epsilon()]))],
		[]);
	XSequence xbgf =
		[massage(
			choice([
				epsilon(),
				nonterminal("bar")]),
			optional(nonterminal("bar")),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			optional(nonterminal("bar")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_ch_ex() = case_massage_ch_ex(false);
void show_massage_ch_ex() {case_massage_ch_ex(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_ch_ps.xbgf|
bool case_massage_ch_ps(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			choice([
				star(nonterminal("bar")),
				plus(nonterminal("bar"))]))],
		[]);
	XSequence xbgf =
		[massage(
			choice([
				plus(nonterminal("bar")),
				star(nonterminal("bar"))]),
			star(nonterminal("bar")),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			star(nonterminal("bar")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_ch_ps() = case_massage_ch_ps(false);
void show_massage_ch_ps() {case_massage_ch_ps(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_ch_qp.xbgf|
bool case_massage_ch_qp(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			choice([
				plus(nonterminal("bar")),
				optional(nonterminal("bar"))]))],
		[]);
	XSequence xbgf =
		[massage(
			choice([
				optional(nonterminal("bar")),
				plus(nonterminal("bar"))]),
			star(nonterminal("bar")),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			star(nonterminal("bar")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_ch_qp() = case_massage_ch_qp(false);
void show_massage_ch_qp() {case_massage_ch_qp(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_ch_qs.xbgf|
bool case_massage_ch_qs(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			choice([
				star(nonterminal("bar")),
				optional(nonterminal("bar"))]))],
		[]);
	XSequence xbgf =
		[massage(
			choice([
				optional(nonterminal("bar")),
				star(nonterminal("bar"))]),
			star(nonterminal("bar")),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			star(nonterminal("bar")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_ch_qs() = case_massage_ch_qs(false);
void show_massage_ch_qs() {case_massage_ch_qs(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_ch_xp.xbgf|
bool case_massage_ch_xp(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			choice([
				plus(nonterminal("bar")),
				nonterminal("bar")]))],
		[]);
	XSequence xbgf =
		[massage(
			choice([
				nonterminal("bar"),
				plus(nonterminal("bar"))]),
			plus(nonterminal("bar")),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			plus(nonterminal("bar")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_ch_xp() = case_massage_ch_xp(false);
void show_massage_ch_xp() {case_massage_ch_xp(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_ch_xq.xbgf|
bool case_massage_ch_xq(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			choice([
				optional(nonterminal("bar")),
				nonterminal("bar")]))],
		[]);
	XSequence xbgf =
		[massage(
			choice([
				nonterminal("bar"),
				optional(nonterminal("bar"))]),
			optional(nonterminal("bar")),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			optional(nonterminal("bar")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_ch_xq() = case_massage_ch_xq(false);
void show_massage_ch_xq() {case_massage_ch_xq(true);}

// NEW
// |home:///projects/slps/topics/transformation/xbgf/tests/massage_2l.xbgf|
bool case_massage_2l(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			nonterminal("bar"))],
		[]);
	XSequence xbgf =
		[massage(
			nonterminal("bar"),
			choice([
				label("one",
					nonterminal("bar")),
				label("two",
					nonterminal("bar"))]),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			choice([
				label("one",
					nonterminal("bar")),
				label("two",
					nonterminal("bar"))]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_2l() = case_massage_2l(false);
void show_massage_2l() {case_massage_2l(true);}

// NEW
// |home:///projects/slps/topics/transformation/xbgf/tests/massage_2m.xbgf|
bool case_massage_2m(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			nonterminal("bar"))],
		[]);
	XSequence xbgf =
		[massage(
			nonterminal("bar"),
			choice([
				mark("one",nonterminal("bar")),
				mark("two",nonterminal("bar"))]),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			choice([
				mark("one",nonterminal("bar")),
				mark("two",nonterminal("bar"))]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_2m() = case_massage_2m(false);
void show_massage_2m() {case_massage_2m(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_ch_xs.xbgf|
bool case_massage_ch_xs(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			choice([
				star(nonterminal("bar")),
				nonterminal("bar")]))],
		[]);
	XSequence xbgf =
		[massage(
			choice([
				nonterminal("bar"),
				star(nonterminal("bar"))]),
			star(nonterminal("bar")),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			star(nonterminal("bar")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_ch_xs() = case_massage_ch_xs(false);
void show_massage_ch_xs() {case_massage_ch_xs(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_ch_xx1.xbgf|
bool case_massage_ch_xx1(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			choice([
				plus(nonterminal("bar")),
				optional(nonterminal("bar"))]))],
		[]);
	XSequence xbgf =
		[massage(
			optional(nonterminal("bar")),
			choice([
				mark("one",optional(nonterminal("bar"))),
				mark("two",optional(nonterminal("bar")))]),
			globally()),
		anonymize(production("foo",
				choice([
					plus(nonterminal("bar")),
					mark("",mark("one",optional(nonterminal("bar")))),
					mark("two",optional(nonterminal("bar")))]))),
		massage(
			choice([
				optional(nonterminal("bar")),
				plus(nonterminal("bar"))]),
			star(nonterminal("bar")),
			globally()),
		anonymize(production("foo",
				choice([
					star(nonterminal("bar")),
					mark("",mark("two",optional(nonterminal("bar"))))])))];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			choice([
				optional(nonterminal("bar")),
				star(nonterminal("bar"))]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_ch_xx1() = case_massage_ch_xx1(false);
void show_massage_ch_xx1() {case_massage_ch_xx1(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_ch_xx2.xbgf|
bool case_massage_ch_xx2(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			star(nonterminal("bar")))],
		[]);
	XSequence xbgf =
		[massage(
			star(nonterminal("bar")),
			choice([
				label("one",star(nonterminal("bar"))),
				label("two",star(nonterminal("bar")))]),
			globally()),
		vertical(innt("foo")),
		massage(
			star(nonterminal("bar")),
			choice([
				epsilon(),
				plus(nonterminal("bar"))]),
			inlabel("one")),
		massage(
			star(nonterminal("bar")),
			choice([
				optional(nonterminal("bar")),
				plus(nonterminal("bar"))]),
			inlabel("two")),
		extract(production("barplus",
			plus(nonterminal("bar"))),
			inlabel("one")),
		unlabel("one"),
		unlabel("two"),
		horizontal(innt("foo"))];
	GGrammar bl = grammar(["foo","barplus"],
		[production("foo",
			choice([
				epsilon(),
				optional(nonterminal("bar")),
				plus(nonterminal("bar")),
				nonterminal("barplus")])),
		production("barplus",
			plus(nonterminal("bar")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_ch_xx2() = case_massage_ch_xx2(false);
void show_massage_ch_xx2() {case_massage_ch_xx2(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_ch_xx3.xbgf|
bool case_massage_ch_xx3(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			nonterminal("bar"))],
		[]);
	XSequence xbgf =
		[massage(
			nonterminal("bar"),
			choice([
				mark("one",nonterminal("bar")),
				mark("two",nonterminal("bar")),
				mark("three",nonterminal("bar"))]),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			choice([
				mark("one",nonterminal("bar")),
				mark("two",nonterminal("bar")),
				mark("three",nonterminal("bar"))]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_ch_xx3() = case_massage_ch_xx3(false);
void show_massage_ch_xx3() {case_massage_ch_xx3(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_comp_pp.xbgf|
bool case_massage_comp_pp(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			plus(plus(nonterminal("bar"))))],
		[]);
	XSequence xbgf =
		[massage(
			plus(plus(nonterminal("bar"))),
			plus(nonterminal("bar")),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			plus(nonterminal("bar")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_comp_pp() = case_massage_comp_pp(false);
void show_massage_comp_pp() {case_massage_comp_pp(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_comp_pq.xbgf|
bool case_massage_comp_pq(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			optional(plus(nonterminal("bar"))))],
		[]);
	XSequence xbgf =
		[massage(
			optional(plus(nonterminal("bar"))),
			star(nonterminal("bar")),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			star(nonterminal("bar")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_comp_pq() = case_massage_comp_pq(false);
void show_massage_comp_pq() {case_massage_comp_pq(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_comp_ps.xbgf|
bool case_massage_comp_ps(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			star(plus(nonterminal("bar"))))],
		[]);
	XSequence xbgf =
		[massage(
			star(plus(nonterminal("bar"))),
			star(nonterminal("bar")),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			star(nonterminal("bar")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_comp_ps() = case_massage_comp_ps(false);
void show_massage_comp_ps() {case_massage_comp_ps(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_comp_qp.xbgf|
bool case_massage_comp_qp(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			plus(optional(nonterminal("bar"))))],
		[]);
	XSequence xbgf =
		[massage(
			plus(optional(nonterminal("bar"))),
			star(nonterminal("bar")),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			star(nonterminal("bar")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_comp_qp() = case_massage_comp_qp(false);
void show_massage_comp_qp() {case_massage_comp_qp(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_comp_qq.xbgf|
bool case_massage_comp_qq(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			optional(optional(nonterminal("bar"))))],
		[]);
	XSequence xbgf =
		[massage(
			optional(optional(nonterminal("bar"))),
			optional(nonterminal("bar")),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			optional(nonterminal("bar")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_comp_qq() = case_massage_comp_qq(false);
void show_massage_comp_qq() {case_massage_comp_qq(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_comp_qs.xbgf|
bool case_massage_comp_qs(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			star(optional(nonterminal("bar"))))],
		[]);
	XSequence xbgf =
		[massage(
			star(optional(nonterminal("bar"))),
			star(nonterminal("bar")),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			star(nonterminal("bar")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_comp_qs() = case_massage_comp_qs(false);
void show_massage_comp_qs() {case_massage_comp_qs(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_comp_sp.xbgf|
bool case_massage_comp_sp(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			plus(star(nonterminal("bar"))))],
		[]);
	XSequence xbgf =
		[massage(
			plus(star(nonterminal("bar"))),
			star(nonterminal("bar")),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			star(nonterminal("bar")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_comp_sp() = case_massage_comp_sp(false);
void show_massage_comp_sp() {case_massage_comp_sp(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_comp_sq.xbgf|
bool case_massage_comp_sq(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			optional(star(nonterminal("bar"))))],
		[]);
	XSequence xbgf =
		[massage(
			optional(star(nonterminal("bar"))),
			star(nonterminal("bar")),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			star(nonterminal("bar")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_comp_sq() = case_massage_comp_sq(false);
void show_massage_comp_sq() {case_massage_comp_sq(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_comp_ss.xbgf|
bool case_massage_comp_ss(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			star(star(nonterminal("bar"))))],
		[]);
	XSequence xbgf =
		[massage(
			star(star(nonterminal("bar"))),
			star(nonterminal("bar")),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			star(nonterminal("bar")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_comp_ss() = case_massage_comp_ss(false);
void show_massage_comp_ss() {case_massage_comp_ss(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_complex.xbgf|
bool case_massage_complex(bool debug)
{
	GGrammar bgf = grammar(["wez"],
		[production("wez",
			sequence([
				nonterminal("foo"),
				optional(sequence([
					star(nonterminal("foo")),
					optional(nonterminal("bar"))]))]))],
		[]);
	XSequence xbgf =
		[massage(
			optional(sequence([
				star(nonterminal("foo")),
				optional(nonterminal("bar"))])),
			choice([
				epsilon(),
				sequence([
					star(nonterminal("foo")),
					optional(nonterminal("bar"))])]),
			globally()),
		massage(
			optional(nonterminal("bar")),
			choice([
				nonterminal("bar"),
				epsilon()]),
			globally()),
		distribute(innt("wez")),
		massage(
			sequence([
				nonterminal("foo"),
				star(nonterminal("foo"))]),
			plus(nonterminal("foo")),
			globally()),
		massage(
			choice([
				nonterminal("foo"),
				plus(nonterminal("foo"))]),
			plus(nonterminal("foo")),
			globally()),
		factor(
			choice([
				plus(nonterminal("foo")),
				sequence([
					plus(nonterminal("foo")),
					nonterminal("bar")])]),
			sequence([
				plus(nonterminal("foo")),
				choice([
					nonterminal("bar"),
					epsilon()])]),
			globally()),
		massage(
			choice([
				nonterminal("bar"),
				epsilon()]),
			optional(nonterminal("bar")),
			globally())];
	GGrammar bl = grammar(["wez"],
		[production("wez",
			sequence([
				plus(nonterminal("foo")),
				optional(nonterminal("bar"))]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_complex() = case_massage_complex(false);
void show_massage_complex() {case_massage_complex(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_distr_ch.xbgf|
bool case_massage_distr_ch(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			optional(choice([
				nonterminal("bar"),
				nonterminal("qux")])))],
		[]);
	XSequence xbgf =
		[massage(
			optional(choice([
				nonterminal("bar"),
				nonterminal("qux")])),
			choice([
				choice([
					nonterminal("bar"),
					nonterminal("qux")]),
				epsilon()]),
			globally()),
		massage(
			epsilon(),
			choice([
				mark("bar",epsilon()),
				mark("qux",epsilon())]),
			globally()),
		factor(
			choice([
				choice([
					nonterminal("bar"),
					nonterminal("qux")]),
				choice([
					mark("bar",epsilon()),
					mark("qux",epsilon())])]),
			choice([
				choice([
					nonterminal("bar"),
					mark("bar",epsilon())]),
				choice([
					nonterminal("qux"),
					mark("qux",epsilon())])]),
			globally()),
		anonymize(production("foo",
				choice([
					choice([
						nonterminal("bar"),
						mark("",mark("bar",epsilon()))]),
					choice([
						nonterminal("qux"),
						mark("qux",epsilon())])]))),
		massage(
			choice([
				nonterminal("bar"),
				epsilon()]),
			optional(nonterminal("bar")),
			globally()),
		anonymize(production("foo",
				choice([
					optional(nonterminal("bar")),
					choice([
						nonterminal("qux"),
						mark("",mark("qux",epsilon()))])]))),
		massage(
			choice([
				nonterminal("qux"),
				epsilon()]),
			optional(nonterminal("qux")),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			choice([
				optional(nonterminal("bar")),
				optional(nonterminal("qux"))]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_distr_ch() = case_massage_distr_ch(false);
void show_massage_distr_ch() {case_massage_distr_ch(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_morgan1.xbgf|
bool case_massage_morgan1(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			not(allof([
				nonterminal("foo"),
				nonterminal("bar")])))],
		[]);
	XSequence xbgf =
		[massage(
			not(allof([
				nonterminal("foo"),
				nonterminal("bar")])),
			choice([
				not(nonterminal("bar")),
				not(nonterminal("foo"))]),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			choice([
				not(nonterminal("foo")),
				not(nonterminal("bar"))]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_morgan1() = case_massage_morgan1(false);
void show_massage_morgan1() {case_massage_morgan1(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_morgan2.xbgf|
bool case_massage_morgan2(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			not(allof([
				not(nonterminal("foo")),
				not(nonterminal("bar"))])))],
		[]);
	XSequence xbgf =
		[massage(
			not(allof([
				not(nonterminal("foo")),
				not(nonterminal("bar"))])),
			choice([
				nonterminal("foo"),
				nonterminal("bar")]),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			choice([
				nonterminal("bar"),
				nonterminal("foo")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_morgan2() = case_massage_morgan2(false);
void show_massage_morgan2() {case_massage_morgan2(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_morgan3.xbgf|
bool case_massage_morgan3(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			not(choice([
				nonterminal("foo"),
				nonterminal("bar")])))],
		[]);
	XSequence xbgf =
		[massage(
			not(choice([
				nonterminal("foo"),
				nonterminal("bar")])),
			allof([
				not(nonterminal("bar")),
				not(nonterminal("foo"))]),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			allof([
				not(nonterminal("foo")),
				not(nonterminal("bar"))]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_morgan3() = case_massage_morgan3(false);
void show_massage_morgan3() {case_massage_morgan3(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_morgan4.xbgf|
bool case_massage_morgan4(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			not(choice([
				not(nonterminal("foo")),
				not(nonterminal("bar"))])))],
		[]);
	XSequence xbgf =
		[massage(
			not(choice([
				not(nonterminal("foo")),
				not(nonterminal("bar"))])),
			allof([
				nonterminal("foo"),
				nonterminal("bar")]),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			allof([
				nonterminal("bar"),
				nonterminal("foo")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_morgan4() = case_massage_morgan4(false);
void show_massage_morgan4() {case_massage_morgan4(true);}

// NEW
// |home:///projects/slps/topics/transformation/xbgf/tests/massage_morgan5.xbgf|
bool case_massage_morgan5(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			allof([
				nonterminal("bar"),
				not(nonterminal("wez"))]))],
		[]);
	XSequence xbgf =
		[massage(
			allof([
				nonterminal("bar"),
				not(nonterminal("wez"))]),
			except(
				nonterminal("bar"),
				nonterminal("wez")),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			except(
				nonterminal("bar"),
				nonterminal("wez")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_morgan5() = case_massage_morgan5(false);
void show_massage_morgan5() {case_massage_morgan5(true);}

// REMOVED
// |home:///projects/slps/topics/transformation/xbgf/tests/massage_nn.xbgf|

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_sel_s.xbgf|
bool case_massage_sel_s(bool debug)
{
	GGrammar bgf = grammar(["program"],
		[production("program",
			star(mark("fun",nonterminal("function"))))],
		[]);
	XSequence xbgf =
		[massage(
			star(mark("fun",nonterminal("function"))),
			mark("fun",star(nonterminal("function"))),
			globally())];
	GGrammar bl = grammar(["program"],
		[production("program",
			mark("fun",star(nonterminal("function"))))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_sel_s() = case_massage_sel_s(false);
void show_massage_sel_s() {case_massage_sel_s(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_seq_pq.xbgf|
bool case_massage_seq_pq(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			sequence([
				plus(nonterminal("bar")),
				optional(nonterminal("bar"))]))],
		[]);
	XSequence xbgf =
		[massage(
			sequence([
				plus(nonterminal("bar")),
				optional(nonterminal("bar"))]),
			plus(nonterminal("bar")),
			globally()),
		massage(
			plus(nonterminal("bar")),
			sequence([
				optional(nonterminal("bar")),
				plus(nonterminal("bar"))]),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			sequence([
				optional(nonterminal("bar")),
				plus(nonterminal("bar"))]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_seq_pq() = case_massage_seq_pq(false);
void show_massage_seq_pq() {case_massage_seq_pq(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_seq_ps.xbgf|
bool case_massage_seq_ps(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			sequence([
				plus(nonterminal("bar")),
				star(nonterminal("bar"))]))],
		[]);
	XSequence xbgf =
		[massage(
			sequence([
				plus(nonterminal("bar")),
				star(nonterminal("bar"))]),
			plus(nonterminal("bar")),
			globally()),
		massage(
			plus(nonterminal("bar")),
			sequence([
				star(nonterminal("bar")),
				plus(nonterminal("bar"))]),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			sequence([
				star(nonterminal("bar")),
				plus(nonterminal("bar"))]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_seq_ps() = case_massage_seq_ps(false);
void show_massage_seq_ps() {case_massage_seq_ps(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_seq_sq.xbgf|
bool case_massage_seq_sq(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			sequence([
				star(nonterminal("bar")),
				optional(nonterminal("bar"))]))],
		[]);
	XSequence xbgf =
		[massage(
			sequence([
				star(nonterminal("bar")),
				optional(nonterminal("bar"))]),
			star(nonterminal("bar")),
			globally()),
		massage(
			star(nonterminal("bar")),
			sequence([
				optional(nonterminal("bar")),
				star(nonterminal("bar"))]),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			sequence([
				optional(nonterminal("bar")),
				star(nonterminal("bar"))]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_seq_sq() = case_massage_seq_sq(false);
void show_massage_seq_sq() {case_massage_seq_sq(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_seq_ss.xbgf|
bool case_massage_seq_ss(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			sequence([
				star(nonterminal("bar")),
				star(nonterminal("bar"))]))],
		[]);
	XSequence xbgf =
		[massage(
			sequence([
				star(nonterminal("bar")),
				star(nonterminal("bar"))]),
			star(nonterminal("bar")),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			star(nonterminal("bar")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_seq_ss() = case_massage_seq_ss(false);
void show_massage_seq_ss() {case_massage_seq_ss(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/massage_seq_xs.xbgf|
bool case_massage_seq_xs(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			sequence([
				nonterminal("bar"),
				star(nonterminal("bar"))]))],
		[]);
	XSequence xbgf =
		[massage(
			sequence([
				nonterminal("bar"),
				star(nonterminal("bar"))]),
			plus(nonterminal("bar")),
			globally()),
		massage(
			plus(nonterminal("bar")),
			sequence([
				star(nonterminal("bar")),
				nonterminal("bar")]),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			sequence([
				star(nonterminal("bar")),
				nonterminal("bar")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_massage_seq_xs() = case_massage_seq_xs(false);
void show_massage_seq_xs() {case_massage_seq_xs(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/narrow_global.xbgf|
bool case_narrow_global(bool debug)
{
	GGrammar bgf = grammar(["program"],
		[production("program",
			mark("fun",star(nonterminal("function"))))],
		[]);
	XSequence xbgf =
		[narrow(
			star(nonterminal("function")),
			plus(nonterminal("function")),
			globally())];
	GGrammar bl = grammar(["program"],
		[production("program",
			mark("fun",plus(nonterminal("function"))))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_narrow_global() = case_narrow_global(false);
void show_narrow_global() {case_narrow_global(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/narrow_l.xbgf|
bool case_narrow_l(bool debug)
{
	GGrammar bgf = grammar(["program"],
		[production("program",
			label("main",
				mark("fun",plus(nonterminal("function")))))],
		[]);
	XSequence xbgf =
		[narrow(
			plus(nonterminal("function")),
			nonterminal("function"),
			inlabel("main"))];
	GGrammar bl = grammar(["program"],
		[production("program",
			label("main",
				mark("fun",nonterminal("function"))))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_narrow_l() = case_narrow_l(false);
void show_narrow_l() {case_narrow_l(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/narrow_nt.xbgf|
bool case_narrow_nt(bool debug)
{
	GGrammar bgf = grammar(["program"],
		[production("program",
			mark("fun",plus(nonterminal("function"))))],
		[]);
	XSequence xbgf =
		[narrow(
			plus(nonterminal("function")),
			nonterminal("function"),
			innt("program"))];
	GGrammar bl = grammar(["program"],
		[production("program",
			mark("fun",nonterminal("function")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_narrow_nt() = case_narrow_nt(false);
void show_narrow_nt() {case_narrow_nt(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/permute.xbgf|
bool case_permute(bool debug)
{
	GGrammar bgf = grammar(["a"],
		[production("a",
			sequence([
				nonterminal("b"),
				star(nonterminal("d")),
				nonterminal("c")]))],
		[]);
	XSequence xbgf =
		[permute(production("a",
				sequence([
					nonterminal("b"),
					nonterminal("c"),
					star(nonterminal("d"))])))];
	GGrammar bl = grammar(["a"],
		[production("a",
			sequence([
				nonterminal("b"),
				nonterminal("c"),
				star(nonterminal("d"))]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_permute() = case_permute(false);
void show_permute() {case_permute(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/project.xbgf|
bool case_project(bool debug)
{
	GGrammar bgf = grammar(["a"],
		[production("a",
			sequence([
				nonterminal("b"),
				nonterminal("c"),
				nonterminal("d")]))],
		[]);
	XSequence xbgf =
		[project(production("a",
				sequence([
					nonterminal("b"),
					mark("",nonterminal("c")),
					nonterminal("d")])))];
	GGrammar bl = grammar(["a"],
		[production("a",
			sequence([
				nonterminal("b"),
				nonterminal("d")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_project() = case_project(false);
void show_project() {case_project(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/rassoc_p.xbgf|
bool case_rassoc_p(bool debug)
{
	GGrammar bgf = grammar(["expr"],
		[production("expr",
			label("terminal",
				val(string()))),
		production("expr",
			label("sequence",
				plus(nonterminal("expr"))))],
		[]);
	XSequence xbgf =
		[rassoc(production("expr",
				label("sequence",
					sequence([
						nonterminal("expr"),
						nonterminal("expr")]))))];
	GGrammar bl = grammar(["expr"],
		[production("expr",
			label("terminal",
				val(string()))),
		production("expr",
			label("sequence",
				sequence([
					nonterminal("expr"),
					nonterminal("expr")])))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_rassoc_p() = case_rassoc_p(false);
void show_rassoc_p() {case_rassoc_p(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/rassoc_s.xbgf|
bool case_rassoc_s(bool debug)
{
	GGrammar bgf = grammar(["expr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("binary",
				sequence([
					nonterminal("expr"),
					star(sequence([
						nonterminal("op"),
						nonterminal("expr")]))])))],
		[]);
	XSequence xbgf =
		[rassoc(production("expr",
				label("binary",
					sequence([
						nonterminal("expr"),
						nonterminal("op"),
						nonterminal("expr")]))))];
	GGrammar bl = grammar(["expr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("binary",
				sequence([
					nonterminal("expr"),
					nonterminal("op"),
					nonterminal("expr")])))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_rassoc_s() = case_rassoc_s(false);
void show_rassoc_s() {case_rassoc_s(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/redefine.xbgf|
bool case_redefine(bool debug)
{
	GGrammar bgf = grammar(["a","b"],
		[production("a",
			sequence([
				terminal("{"),
				nonterminal("b"),
				terminal("}")])),
		production("b",
			nonterminal("a"))],
		[]);
	XSequence xbgf =
		[redefine([production("a",
					star(nonterminal("b")))])];
	GGrammar bl = grammar(["a","b"],
		[production("a",
			star(nonterminal("b"))),
		production("b",
			nonterminal("a"))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_redefine() = case_redefine(false);
void show_redefine() {case_redefine(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/remove_horizontal.xbgf|
bool case_remove_horizontal(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			choice([
				terminal("x"),
				nonterminal("bar"),
				nonterminal("wez")]))],
		[]);
	XSequence xbgf =
		[removeH(production("foo",
				choice([
					mark("",terminal("x")),
					nonterminal("bar"),
					nonterminal("wez")])))];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			choice([
				nonterminal("bar"),
				nonterminal("wez")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_remove_horizontal() = case_remove_horizontal(false);
void show_remove_horizontal() {case_remove_horizontal(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/remove_inside.xbgf|
bool case_remove_inside(bool debug)
{
	GGrammar bgf = grammar(["expr"],
		[production("expr",
			sequence([
				optional(choice([
					terminal("+"),
					terminal("-")])),
				nonterminal("int")]))],
		[]);
	XSequence xbgf =
		[removeH(production("expr",
				sequence([
					optional(choice([
						mark("",terminal("+")),
						terminal("-")])),
					nonterminal("int")])))];
	GGrammar bl = grammar(["expr"],
		[production("expr",
			sequence([
				optional(terminal("-")),
				nonterminal("int")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_remove_inside() = case_remove_inside(false);
void show_remove_inside() {case_remove_inside(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/remove_vertical.xbgf|
bool case_remove_vertical(bool debug)
{
	GGrammar bgf = grammar(["expr"],
		[production("expr",
			nonterminal("int")),
		production("expr",
			nonterminal("id"))],
		[]);
	XSequence xbgf =
		[removeV(production("expr",
				nonterminal("id")))];
	GGrammar bl = grammar(["expr"],
		[production("expr",
			nonterminal("int"))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_remove_vertical() = case_remove_vertical(false);
void show_remove_vertical() {case_remove_vertical(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/rename4.xbgf|
bool case_rename4(bool debug)
{
	GGrammar bgf = grammar(["expr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("binary",
				sequence([
					nonterminal("expr"),
					mark("op",nonterminal("binary_op")),
					nonterminal("expr")]))),
		production("expr",
			label("unary",
				sequence([
					mark("op",nonterminal("unary_op")),
					nonterminal("expr")])))],
		[]);
	XSequence xbgf =
		[renameS("op","operator",inlabel("binary"))];
	GGrammar bl = grammar(["expr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("binary",
				sequence([
					nonterminal("expr"),
					mark("operator",nonterminal("binary_op")),
					nonterminal("expr")]))),
		production("expr",
			label("unary",
				sequence([
					mark("op",nonterminal("unary_op")),
					nonterminal("expr")])))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_rename4() = case_rename4(false);
void show_rename4() {case_rename4(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/renameL.xbgf|
bool case_renameL(bool debug)
{
	GGrammar bgf = grammar(["expr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("binary",
				sequence([
					nonterminal("expr"),
					mark("op",nonterminal("binary_op")),
					nonterminal("expr")]))),
		production("expr",
			label("unary",
				sequence([
					mark("op",nonterminal("unary_op")),
					nonterminal("expr")])))],
		[]);
	XSequence xbgf =
		[renameL("binary","binary_expr")];
	GGrammar bl = grammar(["expr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("binary_expr",
				sequence([
					nonterminal("expr"),
					mark("op",nonterminal("binary_op")),
					nonterminal("expr")]))),
		production("expr",
			label("unary",
				sequence([
					mark("op",nonterminal("unary_op")),
					nonterminal("expr")])))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_renameL() = case_renameL(false);
void show_renameL() {case_renameL(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/renameN.xbgf|
bool case_renameN(bool debug)
{
	GGrammar bgf = grammar(["expr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("binary",
				sequence([
					nonterminal("expr"),
					mark("op",nonterminal("binary_op")),
					nonterminal("expr")]))),
		production("expr",
			label("unary",
				sequence([
					mark("op",nonterminal("unary_op")),
					nonterminal("expr")])))],
		[]);
	XSequence xbgf =
		[renameN("expr","exp")];
	GGrammar bl = grammar(["exp"],
		[production("exp",
			label("constant",
				nonterminal("int"))),
		production("exp",
			label("binary",
				sequence([
					nonterminal("exp"),
					mark("op",nonterminal("binary_op")),
					nonterminal("exp")]))),
		production("exp",
			label("unary",
				sequence([
					mark("op",nonterminal("unary_op")),
					nonterminal("exp")])))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_renameN() = case_renameN(false);
void show_renameN() {case_renameN(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/renameS.xbgf|
bool case_renameS(bool debug)
{
	GGrammar bgf = grammar(["expr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("binary",
				sequence([
					nonterminal("expr"),
					mark("op",nonterminal("binary_op")),
					nonterminal("expr")]))),
		production("expr",
			label("unary",
				sequence([
					mark("op",nonterminal("unary_op")),
					nonterminal("expr")])))],
		[]);
	XSequence xbgf =
		[renameS("op","operator",globally())];
	GGrammar bl = grammar(["expr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("binary",
				sequence([
					nonterminal("expr"),
					mark("operator",nonterminal("binary_op")),
					nonterminal("expr")]))),
		production("expr",
			label("unary",
				sequence([
					mark("operator",nonterminal("unary_op")),
					nonterminal("expr")])))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_renameS() = case_renameS(false);
void show_renameS() {case_renameS(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/renameT.xbgf|
bool case_renameT(bool debug)
{
	GGrammar bgf = grammar(["x"],
		[production("x",
			terminal("x"))],
		[]);
	XSequence xbgf =
		[renameT("x","y")];
	GGrammar bl = grammar(["x"],
		[production("x",
			terminal("y"))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_renameT() = case_renameT(false);
void show_renameT() {case_renameT(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/replace_choice.xbgf|
bool case_replace_choice(bool debug)
{
	GGrammar bgf = grammar(["a"],
		[production("a",
			choice([
				nonterminal("b"),
				nonterminal("c")]))],
		[]);
	XSequence xbgf =
		[replace(
			choice([
				nonterminal("c"),
				nonterminal("b")]),
			nonterminal("d"),
			innt("a"))];
	GGrammar bl = grammar(["a"],
		[production("a",
			nonterminal("d"))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_replace_choice() = case_replace_choice(false);
void show_replace_choice() {case_replace_choice(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/replace_choice_part.xbgf|
bool case_replace_choice_part(bool debug)
{
	GGrammar bgf = grammar(["a"],
		[production("a",
			choice([
				sequence([
					nonterminal("b"),
					nonterminal("c")]),
				sequence([
					nonterminal("b"),
					nonterminal("d")]),
				sequence([
					nonterminal("b"),
					nonterminal("e")])]))],
		[]);
	XSequence xbgf =
		[replace(
			choice([
				sequence([
					nonterminal("b"),
					nonterminal("c")]),
				sequence([
					nonterminal("b"),
					nonterminal("e")])]),
			sequence([
				nonterminal("b"),
				choice([
					nonterminal("c"),
					nonterminal("e")])]),
			globally())];
	GGrammar bl = grammar(["a"],
		[production("a",
			choice([
				sequence([
					nonterminal("b"),
					choice([
						nonterminal("c"),
						nonterminal("e")])]),
				sequence([
					nonterminal("b"),
					nonterminal("d")])]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_replace_choice_part() = case_replace_choice_part(false);
void show_replace_choice_part() {case_replace_choice_part(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/replace_global.xbgf|
bool case_replace_global(bool debug)
{
	GGrammar bgf = grammar(["a","b","c"],
		[production("a",
			label("l1",
				nonterminal("x"))),
		production("b",
			label("l2",
				nonterminal("x"))),
		production("b",
			label("l3",
				star(nonterminal("x")))),
		production("c",
			label("l4",
				nonterminal("x")))],
		[]);
	XSequence xbgf =
		[replace(
			nonterminal("x"),
			nonterminal("y"),
			globally())];
	GGrammar bl = grammar(["a","b","c"],
		[production("a",
			label("l1",
				nonterminal("y"))),
		production("b",
			label("l2",
				nonterminal("y"))),
		production("b",
			label("l3",
				star(nonterminal("y")))),
		production("c",
			label("l4",
				nonterminal("y")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_replace_global() = case_replace_global(false);
void show_replace_global() {case_replace_global(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/replace_l.xbgf|
bool case_replace_l(bool debug)
{
	GGrammar bgf = grammar(["a","b","c"],
		[production("a",
			label("l1",
				nonterminal("x"))),
		production("b",
			label("l2",
				nonterminal("x"))),
		production("b",
			label("l3",
				star(nonterminal("x")))),
		production("c",
			label("l4",
				nonterminal("x")))],
		[]);
	XSequence xbgf =
		[replace(
			nonterminal("x"),
			nonterminal("y"),
			inlabel("l3"))];
	GGrammar bl = grammar(["a","b","c"],
		[production("a",
			label("l1",
				nonterminal("x"))),
		production("b",
			label("l2",
				nonterminal("x"))),
		production("b",
			label("l3",
				star(nonterminal("y")))),
		production("c",
			label("l4",
				nonterminal("x")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_replace_l() = case_replace_l(false);
void show_replace_l() {case_replace_l(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/replace_nt.xbgf|
bool case_replace_nt(bool debug)
{
	GGrammar bgf = grammar(["a","b","c"],
		[production("a",
			label("l1",
				nonterminal("x"))),
		production("b",
			label("l2",
				nonterminal("x"))),
		production("b",
			label("l3",
				star(nonterminal("x")))),
		production("c",
			label("l4",
				nonterminal("x")))],
		[]);
	XSequence xbgf =
		[replace(
			nonterminal("x"),
			nonterminal("y"),
			innt("b"))];
	GGrammar bl = grammar(["a","b","c"],
		[production("a",
			label("l1",
				nonterminal("x"))),
		production("b",
			label("l2",
				nonterminal("y"))),
		production("b",
			label("l3",
				star(nonterminal("y")))),
		production("c",
			label("l4",
				nonterminal("x")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_replace_nt() = case_replace_nt(false);
void show_replace_nt() {case_replace_nt(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/replace_seq.xbgf|
bool case_replace_seq(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			sequence([
				star(sequence([
					nonterminal("bar"),
					nonterminal("wez")])),
				nonterminal("bar"),
				nonterminal("wez")]))],
		[]);
	XSequence xbgf =
		[replace(
			sequence([
				nonterminal("bar"),
				nonterminal("wez")]),
			terminal("..."),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			sequence([
				star(terminal("...")),
				terminal("...")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_replace_seq() = case_replace_seq(false);
void show_replace_seq() {case_replace_seq(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/reroot.xbgf|
bool case_reroot(bool debug)
{
	GGrammar bgf = grammar(["expr","op"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("binary",
				sequence([
					nonterminal("expr"),
					nonterminal("op"),
					nonterminal("expr")]))),
		production("op",
			terminal("==")),
		production("op",
			terminal("+")),
		production("op",
			terminal("-"))],
		[]);
	XSequence xbgf =
		[reroot(["expr","op"])];
	GGrammar bl = grammar(["expr","op"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("binary",
				sequence([
					nonterminal("expr"),
					nonterminal("op"),
					nonterminal("expr")]))),
		production("op",
			terminal("==")),
		production("op",
			terminal("+")),
		production("op",
			terminal("-"))],
		["expr","op"]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_reroot() = case_reroot(false);
void show_reroot() {case_reroot(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/splitN1.xbgf|
bool case_splitN1(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			label("A",
				terminal("a"))),
		production("foo",
			label("B",
				terminal("b"))),
		production("foo",
			label("D",
				terminal("d")))],
		[]);
	XSequence xbgf =
		[splitN("foo",
			[production("bar",
					label("D",
						terminal("d")))],
			nowhere())];
	GGrammar bl = grammar(["foo","bar"],
		[production("foo",
			label("A",
				terminal("a"))),
		production("foo",
			label("B",
				terminal("b"))),
		production("bar",
			label("D",
				terminal("d")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_splitN1() = case_splitN1(false);
void show_splitN1() {case_splitN1(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/splitN2.xbgf|
bool case_splitN2(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			label("A",
				terminal("a"))),
		production("foo",
			label("B",
				terminal("b"))),
		production("foo",
			label("D",
				nonterminal("foo")))],
		[]);
	XSequence xbgf =
		[splitN("foo",
			[production("bar",
					label("D",
						nonterminal("foo")))],
			nowhere())];
	GGrammar bl = grammar(["foo","bar"],
		[production("foo",
			label("A",
				terminal("a"))),
		production("foo",
			label("B",
				terminal("b"))),
		production("bar",
			label("D",
				nonterminal("foo")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_splitN2() = case_splitN2(false);
void show_splitN2() {case_splitN2(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/splitN3.xbgf|
bool case_splitN3(bool debug)
{
	GGrammar bgf = grammar(["foo","wez"],
		[production("foo",
			label("A",
				terminal("a"))),
		production("wez",
			label("B",
				nonterminal("foo"))),
		production("foo",
			label("D",
				nonterminal("foo")))],
		[]);
	XSequence xbgf =
		[splitN("foo",
			[production("bar",
					label("D",
						nonterminal("foo")))],
			inlabel("B"))];
	GGrammar bl = grammar(["foo","wez","bar"],
		[production("foo",
			label("A",
				terminal("a"))),
		production("wez",
			label("B",
				nonterminal("bar"))),
		production("bar",
			label("D",
				nonterminal("foo")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_splitN3() = case_splitN3(false);
void show_splitN3() {case_splitN3(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/splitN4.xbgf|
bool case_splitN4(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			label("A",
				terminal("a"))),
		production("foo",
			label("B",
				nonterminal("foo"))),
		production("foo",
			label("D",
				nonterminal("foo")))],
		[]);
	XSequence xbgf =
		[splitN("foo",
			[production("bar",
					label("D",
						nonterminal("foo")))],
			inlabel("B"))];
	GGrammar bl = grammar(["foo","bar"],
		[production("foo",
			label("A",
				terminal("a"))),
		production("foo",
			label("B",
				nonterminal("bar"))),
		production("bar",
			label("D",
				nonterminal("foo")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_splitN4() = case_splitN4(false);
void show_splitN4() {case_splitN4(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/splitT1.xbgf|
bool case_splitT1(bool debug)
{
	GGrammar bgf = grammar(["foo","bar"],
		[production("foo",
			terminal("ab")),
		production("bar",
			terminal("ab"))],
		[]);
	XSequence xbgf =
		[splitT("ab",["a","b"],globally())];
	GGrammar bl = grammar(["foo","bar"],
		[production("foo",
			sequence([
				terminal("a"),
				terminal("b")])),
		production("bar",
			sequence([
				terminal("a"),
				terminal("b")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_splitT1() = case_splitT1(false);
void show_splitT1() {case_splitT1(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/splitT2.xbgf|
bool case_splitT2(bool debug)
{
	GGrammar bgf = grammar(["foo","bar"],
		[production("foo",
			terminal("ab")),
		production("bar",
			terminal("ab"))],
		[]);
	XSequence xbgf =
		[splitT("ab",["a","b"],innt("foo"))];
	GGrammar bl = grammar(["foo","bar"],
		[production("foo",
			sequence([
				terminal("a"),
				terminal("b")])),
		production("bar",
			terminal("ab"))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_splitT2() = case_splitT2(false);
void show_splitT2() {case_splitT2(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/splitT3.xbgf|
bool case_splitT3(bool debug)
{
	GGrammar bgf = grammar(["foo","bar"],
		[production("foo",
			terminal("abc")),
		production("bar",
			terminal("ab"))],
		[]);
	XSequence xbgf =
		[splitT("abc",["a","bc"],innt("foo"))];
	GGrammar bl = grammar(["foo","bar"],
		[production("foo",
			sequence([
				terminal("a"),
				terminal("bc")])),
		production("bar",
			terminal("ab"))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_splitT3() = case_splitT3(false);
void show_splitT3() {case_splitT3(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/splitT4.xbgf|
bool case_splitT4(bool debug)
{
	GGrammar bgf = grammar(["foo","bar"],
		[production("foo",
			sequence([
				terminal("a"),
				terminal("bc")])),
		production("bar",
			terminal("bc"))],
		[]);
	XSequence xbgf =
		[splitT("bc",["b","c"],innt("foo"))];
	GGrammar bl = grammar(["foo","bar"],
		[production("foo",
			sequence([
				terminal("a"),
				terminal("b"),
				terminal("c")])),
		production("bar",
			terminal("bc"))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_splitT4() = case_splitT4(false);
void show_splitT4() {case_splitT4(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/unchain_l.xbgf|
bool case_unchain_l(bool debug)
{
	GGrammar bgf = grammar(["expr","binexpr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("binary",
				nonterminal("binexpr"))),
		production("binexpr",
			sequence([
				nonterminal("expr"),
				nonterminal("op"),
				nonterminal("expr")]))],
		[]);
	XSequence xbgf =
		[unchain(production("expr",
				label("binary",
					nonterminal("binexpr"))))];
	GGrammar bl = grammar(["expr"],
		[production("expr",
			label("constant",
				nonterminal("int"))),
		production("expr",
			label("binary",
				sequence([
					nonterminal("expr"),
					nonterminal("op"),
					nonterminal("expr")])))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_unchain_l() = case_unchain_l(false);
void show_unchain_l() {case_unchain_l(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/unchain_n.xbgf|
bool case_unchain_n(bool debug)
{
	GGrammar bgf = grammar(["ClassDeclaration","NormalClassDeclaration","ClassBody"],
		[production("ClassDeclaration",
			nonterminal("NormalClassDeclaration")),
		production("NormalClassDeclaration",
			sequence([
				terminal("class"),
				nonterminal("Identifier"),
				nonterminal("ClassBody")])),
		production("ClassBody",
			sequence([
				terminal("{"),
				optional(nonterminal("ClassBodyDeclarations")),
				terminal("}")]))],
		[]);
	XSequence xbgf =
		[unchain(production("ClassDeclaration",
				nonterminal("NormalClassDeclaration")))];
	GGrammar bl = grammar(["ClassDeclaration","ClassBody"],
		[production("ClassDeclaration",
			label("NormalClassDeclaration",
				sequence([
					terminal("class"),
					nonterminal("Identifier"),
					nonterminal("ClassBody")]))),
		production("ClassBody",
			sequence([
				terminal("{"),
				optional(nonterminal("ClassBodyDeclarations")),
				terminal("}")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_unchain_n() = case_unchain_n(false);
void show_unchain_n() {case_unchain_n(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/undefine1.xbgf|
bool case_undefine1(bool debug)
{
	GGrammar bgf = grammar(["expr","op"],
		[production("expr",
			nonterminal("int")),
		production("expr",
			sequence([
				nonterminal("expr"),
				nonterminal("op"),
				nonterminal("expr")])),
		production("op",
			terminal("+")),
		production("op",
			terminal("-"))],
		[]);
	XSequence xbgf =
		[undefine(["op"])];
	GGrammar bl = grammar(["expr"],
		[production("expr",
			nonterminal("int")),
		production("expr",
			sequence([
				nonterminal("expr"),
				nonterminal("op"),
				nonterminal("expr")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_undefine1() = case_undefine1(false);
void show_undefine1() {case_undefine1(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/undefine2.xbgf|
bool case_undefine2(bool debug)
{
	GGrammar bgf = grammar(["foo","bar","wez","qux"],
		[production("foo",
			nonterminal("bar")),
		production("bar",
			nonterminal("wez")),
		production("wez",
			nonterminal("qux")),
		production("qux",
			nonterminal("foo"))],
		[]);
	XSequence xbgf =
		[undefine(["bar","qux"])];
	GGrammar bl = grammar(["foo","wez"],
		[production("foo",
			nonterminal("bar")),
		production("wez",
			nonterminal("qux"))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_undefine2() = case_undefine2(false);
void show_undefine2() {case_undefine2(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/unfold.xbgf|
bool case_unfold(bool debug)
{
	GGrammar bgf = grammar(["foo","qux","bar"],
		[production("foo",
			label("l1",
				nonterminal("bar"))),
		production("qux",
			label("l2",
				nonterminal("bar"))),
		production("bar",
			star(nonterminal("wez")))],
		[]);
	XSequence xbgf =
		[unfold("bar",globally())];
	GGrammar bl = grammar(["foo","qux","bar"],
		[production("foo",
			label("l1",
				star(nonterminal("wez")))),
		production("qux",
			label("l2",
				star(nonterminal("wez")))),
		production("bar",
			star(nonterminal("wez")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_unfold() = case_unfold(false);
void show_unfold() {case_unfold(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/unfold_l.xbgf|
bool case_unfold_l(bool debug)
{
	GGrammar bgf = grammar(["foo","qux","bar"],
		[production("foo",
			label("l1",
				nonterminal("bar"))),
		production("qux",
			label("l2",
				nonterminal("bar"))),
		production("bar",
			star(nonterminal("wez")))],
		[]);
	XSequence xbgf =
		[unfold("bar",inlabel("l1"))];
	GGrammar bl = grammar(["foo","qux","bar"],
		[production("foo",
			label("l1",
				star(nonterminal("wez")))),
		production("qux",
			label("l2",
				nonterminal("bar"))),
		production("bar",
			star(nonterminal("wez")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_unfold_l() = case_unfold_l(false);
void show_unfold_l() {case_unfold_l(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/unfold_normalize.xbgf|
bool case_unfold_normalize(bool debug)
{
	GGrammar bgf = grammar(["a","c"],
		[production("a",
			choice([
				nonterminal("b"),
				nonterminal("c")])),
		production("c",
			nonterminal("b"))],
		[]);
	XSequence xbgf =
		[unfold("c",globally())];
	GGrammar bl = grammar(["a","c"],
		[production("a",
			nonterminal("b")),
		production("c",
			nonterminal("b"))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_unfold_normalize() = case_unfold_normalize(false);
void show_unfold_normalize() {case_unfold_normalize(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/unfold_nt.xbgf|
bool case_unfold_nt(bool debug)
{
	GGrammar bgf = grammar(["foo","qux","bar"],
		[production("foo",
			label("l1",
				nonterminal("bar"))),
		production("qux",
			label("l2",
				nonterminal("bar"))),
		production("bar",
			star(nonterminal("wez")))],
		[]);
	XSequence xbgf =
		[unfold("bar",innt("foo"))];
	GGrammar bl = grammar(["foo","qux","bar"],
		[production("foo",
			label("l1",
				star(nonterminal("wez")))),
		production("qux",
			label("l2",
				nonterminal("bar"))),
		production("bar",
			star(nonterminal("wez")))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_unfold_nt() = case_unfold_nt(false);
void show_unfold_nt() {case_unfold_nt(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/unite_eq.xbgf|
bool case_unite_eq(bool debug)
{
	GGrammar bgf = grammar(["a","b"],
		[production("a",
			epsilon()),
		production("b",
			epsilon())],
		[]);
	XSequence xbgf =
		[unite("b","a")];
	GGrammar bl = grammar(["a"],
		[production("a",
			epsilon())],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_unite_eq() = case_unite_eq(false);
void show_unite_eq() {case_unite_eq(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/unite_normal.xbgf|
bool case_unite_normal(bool debug)
{
	GGrammar bgf = grammar(["foo","bar"],
		[production("foo",
			terminal("a")),
		production("foo",
			terminal("b")),
		production("bar",
			terminal("d"))],
		[]);
	XSequence xbgf =
		[unite("bar","foo")];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			terminal("a")),
		production("foo",
			terminal("b")),
		production("foo",
			terminal("d"))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_unite_normal() = case_unite_normal(false);
void show_unite_normal() {case_unite_normal(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/unlabel.xbgf|
bool case_unlabel(bool debug)
{
	GGrammar bgf = grammar(["expr"],
		[production("expr",
			label("intexpr",
				nonterminal("int")))],
		[]);
	XSequence xbgf =
		[unlabel("intexpr")];
	GGrammar bl = grammar(["expr"],
		[production("expr",
			nonterminal("int"))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_unlabel() = case_unlabel(false);
void show_unlabel() {case_unlabel(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/upgrade.xbgf|
bool case_upgrade(bool debug)
{
	GGrammar bgf = grammar(["a","b"],
		[production("a",
			sequence([
				nonterminal("d"),
				nonterminal("e"),
				nonterminal("c")])),
		production("b",
			sequence([
				nonterminal("d"),
				nonterminal("e")])),
		production("b",
			sequence([
				nonterminal("f"),
				nonterminal("g")]))],
		[]);
	XSequence xbgf =
		[upgrade(
			production("a",
				sequence([
					mark("",nonterminal("b")),
					nonterminal("c")])),
			production("b",
				sequence([
					nonterminal("d"),
					nonterminal("e")])))];
	GGrammar bl = grammar(["a","b"],
		[production("a",
			sequence([
				nonterminal("b"),
				nonterminal("c")])),
		production("b",
			sequence([
				nonterminal("d"),
				nonterminal("e")])),
		production("b",
			sequence([
				nonterminal("f"),
				nonterminal("g")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_upgrade() = case_upgrade(false);
void show_upgrade() {case_upgrade(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/vertical_l.xbgf|
bool case_vertical_l(bool debug)
{
	GGrammar bgf = grammar(["decs"],
		[production("decs",
			label("nodecs",
				epsilon())),
		production("decs",
			label("somedecs",
				choice([
					nonterminal("dec"),
					sequence([
						nonterminal("dec"),
						nonterminal("decs")])])))],
		[]);
	XSequence xbgf =
		[vertical(inlabel("somedecs"))];
	GGrammar bl = grammar(["decs"],
		[production("decs",
			label("nodecs",
				epsilon())),
		production("decs",
			nonterminal("dec")),
		production("decs",
			sequence([
				nonterminal("dec"),
				nonterminal("decs")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_vertical_l() = case_vertical_l(false);
void show_vertical_l() {case_vertical_l(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/vertical_s.xbgf|
bool case_vertical_s(bool debug)
{
	GGrammar bgf = grammar(["decs"],
		[production("decs",
			choice([
				label("onedec",
					nonterminal("dec")),
				label("moredecs",
					sequence([
						nonterminal("dec"),
						nonterminal("decs")]))]))],
		[]);
	XSequence xbgf =
		[vertical(innt("decs"))];
	GGrammar bl = grammar(["decs"],
		[production("decs",
			label("onedec",
				nonterminal("dec"))),
		production("decs",
			label("moredecs",
				sequence([
					nonterminal("dec"),
					nonterminal("decs")])))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_vertical_s() = case_vertical_s(false);
void show_vertical_s() {case_vertical_s(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/widen_global.xbgf|
bool case_widen_global(bool debug)
{
	GGrammar bgf = grammar(["program"],
		[production("program",
			mark("fun",plus(nonterminal("function"))))],
		[]);
	XSequence xbgf =
		[widen(
			plus(nonterminal("function")),
			star(nonterminal("function")),
			globally())];
	GGrammar bl = grammar(["program"],
		[production("program",
			mark("fun",star(nonterminal("function"))))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_widen_global() = case_widen_global(false);
void show_widen_global() {case_widen_global(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/widen_l.xbgf|
bool case_widen_l(bool debug)
{
	GGrammar bgf = grammar(["program"],
		[production("program",
			label("main",
				mark("fun",nonterminal("function"))))],
		[]);
	XSequence xbgf =
		[widen(
			nonterminal("function"),
			plus(nonterminal("function")),
			inlabel("main"))];
	GGrammar bl = grammar(["program"],
		[production("program",
			label("main",
				mark("fun",plus(nonterminal("function")))))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_widen_l() = case_widen_l(false);
void show_widen_l() {case_widen_l(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/widen_nt.xbgf|
bool case_widen_nt(bool debug)
{
	GGrammar bgf = grammar(["program"],
		[production("program",
			mark("fun",nonterminal("function")))],
		[]);
	XSequence xbgf =
		[widen(
			nonterminal("function"),
			plus(nonterminal("function")),
			innt("program"))];
	GGrammar bl = grammar(["program"],
		[production("program",
			mark("fun",plus(nonterminal("function"))))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_widen_nt() = case_widen_nt(false);
void show_widen_nt() {case_widen_nt(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/widen_sub.xbgf|
bool case_widen_sub(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			sequence([
				nonterminal("bar"),
				nonterminal("wez"),
				nonterminal("qux")]))],
		[]);
	XSequence xbgf =
		[widen(
			sequence([
				nonterminal("bar"),
				nonterminal("wez")]),
			star(sequence([
				nonterminal("bar"),
				nonterminal("wez")])),
			globally())];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			sequence([
				star(sequence([
					nonterminal("bar"),
					nonterminal("wez")])),
				nonterminal("qux")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_widen_sub() = case_widen_sub(false);
void show_widen_sub() {case_widen_sub(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/yaccify_eps.xbgf|
bool case_yaccify_eps(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			star(nonterminal("bar")))],
		[]);
	XSequence xbgf =
		[yaccify(
			[production("foo",
					epsilon()),
				production("foo",
					sequence([
						nonterminal("foo"),
						nonterminal("bar")]))])];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			epsilon()),
		production("foo",
			sequence([
				nonterminal("foo"),
				nonterminal("bar")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_yaccify_eps() = case_yaccify_eps(false);
void show_yaccify_eps() {case_yaccify_eps(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/yaccify_left.xbgf|
bool case_yaccify_left(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			sequence([
				nonterminal("bar"),
				star(nonterminal("wez"))]))],
		[]);
	XSequence xbgf =
		[yaccify(
			[production("foo",
					nonterminal("bar")),
				production("foo",
					sequence([
						nonterminal("foo"),
						nonterminal("wez")]))])];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			nonterminal("bar")),
		production("foo",
			sequence([
				nonterminal("foo"),
				nonterminal("wez")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_yaccify_left() = case_yaccify_left(false);
void show_yaccify_left() {case_yaccify_left(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/yaccify_left_plus.xbgf|
bool case_yaccify_left_plus(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			plus(nonterminal("bar")))],
		[]);
	XSequence xbgf =
		[yaccify(
			[production("foo",
					nonterminal("bar")),
				production("foo",
					sequence([
						nonterminal("foo"),
						nonterminal("bar")]))])];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			nonterminal("bar")),
		production("foo",
			sequence([
				nonterminal("foo"),
				nonterminal("bar")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_yaccify_left_plus() = case_yaccify_left_plus(false);
void show_yaccify_left_plus() {case_yaccify_left_plus(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/yaccify_right.xbgf|
bool case_yaccify_right(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			sequence([
				star(nonterminal("wez")),
				nonterminal("bar")]))],
		[]);
	XSequence xbgf =
		[yaccify(
			[production("foo",
					nonterminal("bar")),
				production("foo",
					sequence([
						nonterminal("wez"),
						nonterminal("foo")]))])];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			nonterminal("bar")),
		production("foo",
			sequence([
				nonterminal("wez"),
				nonterminal("foo")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_yaccify_right() = case_yaccify_right(false);
void show_yaccify_right() {case_yaccify_right(true);}

// |home:///projects/slps/topics/transformation/xbgf/tests/yaccify_right_plus.xbgf|
bool case_yaccify_right_plus(bool debug)
{
	GGrammar bgf = grammar(["foo"],
		[production("foo",
			plus(nonterminal("bar")))],
		[]);
	XSequence xbgf =
		[yaccify(
			[production("foo",
					nonterminal("bar")),
				production("foo",
					sequence([
						nonterminal("bar"),
						nonterminal("foo")]))])];
	GGrammar bl = grammar(["foo"],
		[production("foo",
			nonterminal("bar")),
		production("foo",
			sequence([
				nonterminal("bar"),
				nonterminal("foo")]))],
		[]);
	return run_case(bgf,xbgf,bl,debug);
}
test bool test_yaccify_right_plus() = case_yaccify_right_plus(false);
void show_yaccify_right_plus() {case_yaccify_right_plus(true);}
