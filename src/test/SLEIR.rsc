@contributor{Super Awesome Automated SLEIR Test Suite Synchroniser}
@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
// This file contains 419 test cases from |project://grammarlab/src/test/set/sleir|
module \test::SLEIR

import IO;
import grammarlab::language::Grammar;
import grammarlab::export::Grammar;
import grammarlab::compare::Differ;
import grammarlab::language::GLUE;
import grammarlab::language::glue::Interpreter;
import grammarlab::io::GLUE;
import grammarlab::lib::ebnf::Glue;

bool run_case(str casen, bool debug)
{
	GGrammar uit = execute(EmptyGrammar,loadGlue(|project://grammarlab/src/test/set/sleir/<casen>|));
	bool res = false;
	if (debug) res = gdtv(uit,EmptyGrammar);
	else res = gdts(uit,EmptyGrammar);
	if (!res) println("[FAIL] |project://grammarlab/src/test/set/sleir/<casen>|");		
	if (!res && debug) println("Remaining grammar: <ppx(uit,GlueEBNF)>");
	return res;
}
// SLEIR:AbridgeAll: 20 tests
// AbridgeAll1_1.glue
test bool test_AbridgeAll1_1() = run_case("AbridgeAll1_1.glue",false);
void show_AbridgeAll1_1() {run_case("AbridgeAll1_1.glue",true);}
// AbridgeAll1_2.glue
test bool test_AbridgeAll1_2() = run_case("AbridgeAll1_2.glue",false);
void show_AbridgeAll1_2() {run_case("AbridgeAll1_2.glue",true);}
// AbridgeAll1_3.glue
test bool test_AbridgeAll1_3() = run_case("AbridgeAll1_3.glue",false);
void show_AbridgeAll1_3() {run_case("AbridgeAll1_3.glue",true);}
// AbridgeAll1_4.glue
test bool test_AbridgeAll1_4() = run_case("AbridgeAll1_4.glue",false);
void show_AbridgeAll1_4() {run_case("AbridgeAll1_4.glue",true);}
// AbridgeAll2_11.glue
test bool test_AbridgeAll2_11() = run_case("AbridgeAll2_11.glue",false);
void show_AbridgeAll2_11() {run_case("AbridgeAll2_11.glue",true);}
// AbridgeAll2_12.glue
test bool test_AbridgeAll2_12() = run_case("AbridgeAll2_12.glue",false);
void show_AbridgeAll2_12() {run_case("AbridgeAll2_12.glue",true);}
// AbridgeAll2_13.glue
test bool test_AbridgeAll2_13() = run_case("AbridgeAll2_13.glue",false);
void show_AbridgeAll2_13() {run_case("AbridgeAll2_13.glue",true);}
// AbridgeAll2_14.glue
test bool test_AbridgeAll2_14() = run_case("AbridgeAll2_14.glue",false);
void show_AbridgeAll2_14() {run_case("AbridgeAll2_14.glue",true);}
// AbridgeAll2_21.glue
test bool test_AbridgeAll2_21() = run_case("AbridgeAll2_21.glue",false);
void show_AbridgeAll2_21() {run_case("AbridgeAll2_21.glue",true);}
// AbridgeAll2_22.glue
test bool test_AbridgeAll2_22() = run_case("AbridgeAll2_22.glue",false);
void show_AbridgeAll2_22() {run_case("AbridgeAll2_22.glue",true);}
// AbridgeAll2_23.glue
test bool test_AbridgeAll2_23() = run_case("AbridgeAll2_23.glue",false);
void show_AbridgeAll2_23() {run_case("AbridgeAll2_23.glue",true);}
// AbridgeAll2_24.glue
test bool test_AbridgeAll2_24() = run_case("AbridgeAll2_24.glue",false);
void show_AbridgeAll2_24() {run_case("AbridgeAll2_24.glue",true);}
// AbridgeAll2_31.glue
test bool test_AbridgeAll2_31() = run_case("AbridgeAll2_31.glue",false);
void show_AbridgeAll2_31() {run_case("AbridgeAll2_31.glue",true);}
// AbridgeAll2_32.glue
test bool test_AbridgeAll2_32() = run_case("AbridgeAll2_32.glue",false);
void show_AbridgeAll2_32() {run_case("AbridgeAll2_32.glue",true);}
// AbridgeAll2_33.glue
test bool test_AbridgeAll2_33() = run_case("AbridgeAll2_33.glue",false);
void show_AbridgeAll2_33() {run_case("AbridgeAll2_33.glue",true);}
// AbridgeAll2_34.glue
test bool test_AbridgeAll2_34() = run_case("AbridgeAll2_34.glue",false);
void show_AbridgeAll2_34() {run_case("AbridgeAll2_34.glue",true);}
// AbridgeAll2_41.glue
test bool test_AbridgeAll2_41() = run_case("AbridgeAll2_41.glue",false);
void show_AbridgeAll2_41() {run_case("AbridgeAll2_41.glue",true);}
// AbridgeAll2_42.glue
test bool test_AbridgeAll2_42() = run_case("AbridgeAll2_42.glue",false);
void show_AbridgeAll2_42() {run_case("AbridgeAll2_42.glue",true);}
// AbridgeAll2_43.glue
test bool test_AbridgeAll2_43() = run_case("AbridgeAll2_43.glue",false);
void show_AbridgeAll2_43() {run_case("AbridgeAll2_43.glue",true);}
// AbridgeAll2_44.glue
test bool test_AbridgeAll2_44() = run_case("AbridgeAll2_44.glue",false);
void show_AbridgeAll2_44() {run_case("AbridgeAll2_44.glue",true);}
// SLEIR:ChainMixed: 5 tests
// ChainMixed1.glue
test bool test_ChainMixed1() = run_case("ChainMixed1.glue",false);
void show_ChainMixed1() {run_case("ChainMixed1.glue",true);}
// ChainMixed2.glue
test bool test_ChainMixed2() = run_case("ChainMixed2.glue",false);
void show_ChainMixed2() {run_case("ChainMixed2.glue",true);}
// ChainMixed3.glue
test bool test_ChainMixed3() = run_case("ChainMixed3.glue",false);
void show_ChainMixed3() {run_case("ChainMixed3.glue",true);}
// ChainMixed4.glue
test bool test_ChainMixed4() = run_case("ChainMixed4.glue",false);
void show_ChainMixed4() {run_case("ChainMixed4.glue",true);}
// ChainMixed5.glue
test bool test_ChainMixed5() = run_case("ChainMixed5.glue",false);
void show_ChainMixed5() {run_case("ChainMixed5.glue",true);}
// SLEIR:ConcatAllT: 7 tests
// ConcatAllT1.glue
test bool test_ConcatAllT1() = run_case("ConcatAllT1.glue",false);
void show_ConcatAllT1() {run_case("ConcatAllT1.glue",true);}
// ConcatAllT2.glue
test bool test_ConcatAllT2() = run_case("ConcatAllT2.glue",false);
void show_ConcatAllT2() {run_case("ConcatAllT2.glue",true);}
// ConcatAllT3.glue
test bool test_ConcatAllT3() = run_case("ConcatAllT3.glue",false);
void show_ConcatAllT3() {run_case("ConcatAllT3.glue",true);}
// ConcatAllT4.glue
test bool test_ConcatAllT4() = run_case("ConcatAllT4.glue",false);
void show_ConcatAllT4() {run_case("ConcatAllT4.glue",true);}
// ConcatAllT5.glue
test bool test_ConcatAllT5() = run_case("ConcatAllT5.glue",false);
void show_ConcatAllT5() {run_case("ConcatAllT5.glue",true);}
// ConcatAllT6.glue
test bool test_ConcatAllT6() = run_case("ConcatAllT6.glue",false);
void show_ConcatAllT6() {run_case("ConcatAllT6.glue",true);}
// ConcatAllT7.glue
test bool test_ConcatAllT7() = run_case("ConcatAllT7.glue",false);
void show_ConcatAllT7() {run_case("ConcatAllT7.glue",true);}
// SLEIR:DefineMin: 3 tests
// DefineMin1.glue
test bool test_DefineMin1() = run_case("DefineMin1.glue",false);
void show_DefineMin1() {run_case("DefineMin1.glue",true);}
// DefineMin2.glue
test bool test_DefineMin2() = run_case("DefineMin2.glue",false);
void show_DefineMin2() {run_case("DefineMin2.glue",true);}
// DefineMin3.glue
test bool test_DefineMin3() = run_case("DefineMin3.glue",false);
void show_DefineMin3() {run_case("DefineMin3.glue",true);}
// SLEIR:DeyaccifyAll: 132 tests
// DeyaccifyAll1H1.glue
test bool test_DeyaccifyAll1H1() = run_case("DeyaccifyAll1H1.glue",false);
void show_DeyaccifyAll1H1() {run_case("DeyaccifyAll1H1.glue",true);}
// DeyaccifyAll1H2.glue
test bool test_DeyaccifyAll1H2() = run_case("DeyaccifyAll1H2.glue",false);
void show_DeyaccifyAll1H2() {run_case("DeyaccifyAll1H2.glue",true);}
// DeyaccifyAll1H3.glue
test bool test_DeyaccifyAll1H3() = run_case("DeyaccifyAll1H3.glue",false);
void show_DeyaccifyAll1H3() {run_case("DeyaccifyAll1H3.glue",true);}
// DeyaccifyAll1H4.glue
test bool test_DeyaccifyAll1H4() = run_case("DeyaccifyAll1H4.glue",false);
void show_DeyaccifyAll1H4() {run_case("DeyaccifyAll1H4.glue",true);}
// DeyaccifyAll1H5.glue
test bool test_DeyaccifyAll1H5() = run_case("DeyaccifyAll1H5.glue",false);
void show_DeyaccifyAll1H5() {run_case("DeyaccifyAll1H5.glue",true);}
// DeyaccifyAll1H6.glue
test bool test_DeyaccifyAll1H6() = run_case("DeyaccifyAll1H6.glue",false);
void show_DeyaccifyAll1H6() {run_case("DeyaccifyAll1H6.glue",true);}
// DeyaccifyAll1V1.glue
test bool test_DeyaccifyAll1V1() = run_case("DeyaccifyAll1V1.glue",false);
void show_DeyaccifyAll1V1() {run_case("DeyaccifyAll1V1.glue",true);}
// DeyaccifyAll1V2.glue
test bool test_DeyaccifyAll1V2() = run_case("DeyaccifyAll1V2.glue",false);
void show_DeyaccifyAll1V2() {run_case("DeyaccifyAll1V2.glue",true);}
// DeyaccifyAll1V3.glue
test bool test_DeyaccifyAll1V3() = run_case("DeyaccifyAll1V3.glue",false);
void show_DeyaccifyAll1V3() {run_case("DeyaccifyAll1V3.glue",true);}
// DeyaccifyAll1V4.glue
test bool test_DeyaccifyAll1V4() = run_case("DeyaccifyAll1V4.glue",false);
void show_DeyaccifyAll1V4() {run_case("DeyaccifyAll1V4.glue",true);}
// DeyaccifyAll1V5.glue
test bool test_DeyaccifyAll1V5() = run_case("DeyaccifyAll1V5.glue",false);
void show_DeyaccifyAll1V5() {run_case("DeyaccifyAll1V5.glue",true);}
// DeyaccifyAll1V6.glue
test bool test_DeyaccifyAll1V6() = run_case("DeyaccifyAll1V6.glue",false);
void show_DeyaccifyAll1V6() {run_case("DeyaccifyAll1V6.glue",true);}
// DeyaccifyAll2HH11.glue
test bool test_DeyaccifyAll2HH11() = run_case("DeyaccifyAll2HH11.glue",false);
void show_DeyaccifyAll2HH11() {run_case("DeyaccifyAll2HH11.glue",true);}
// DeyaccifyAll2HH12.glue
test bool test_DeyaccifyAll2HH12() = run_case("DeyaccifyAll2HH12.glue",false);
void show_DeyaccifyAll2HH12() {run_case("DeyaccifyAll2HH12.glue",true);}
// DeyaccifyAll2HH13.glue
test bool test_DeyaccifyAll2HH13() = run_case("DeyaccifyAll2HH13.glue",false);
void show_DeyaccifyAll2HH13() {run_case("DeyaccifyAll2HH13.glue",true);}
// DeyaccifyAll2HH14.glue
test bool test_DeyaccifyAll2HH14() = run_case("DeyaccifyAll2HH14.glue",false);
void show_DeyaccifyAll2HH14() {run_case("DeyaccifyAll2HH14.glue",true);}
// DeyaccifyAll2HH15.glue
test bool test_DeyaccifyAll2HH15() = run_case("DeyaccifyAll2HH15.glue",false);
void show_DeyaccifyAll2HH15() {run_case("DeyaccifyAll2HH15.glue",true);}
// DeyaccifyAll2HH21.glue
test bool test_DeyaccifyAll2HH21() = run_case("DeyaccifyAll2HH21.glue",false);
void show_DeyaccifyAll2HH21() {run_case("DeyaccifyAll2HH21.glue",true);}
// DeyaccifyAll2HH22.glue
test bool test_DeyaccifyAll2HH22() = run_case("DeyaccifyAll2HH22.glue",false);
void show_DeyaccifyAll2HH22() {run_case("DeyaccifyAll2HH22.glue",true);}
// DeyaccifyAll2HH23.glue
test bool test_DeyaccifyAll2HH23() = run_case("DeyaccifyAll2HH23.glue",false);
void show_DeyaccifyAll2HH23() {run_case("DeyaccifyAll2HH23.glue",true);}
// DeyaccifyAll2HH24.glue
test bool test_DeyaccifyAll2HH24() = run_case("DeyaccifyAll2HH24.glue",false);
void show_DeyaccifyAll2HH24() {run_case("DeyaccifyAll2HH24.glue",true);}
// DeyaccifyAll2HH25.glue
test bool test_DeyaccifyAll2HH25() = run_case("DeyaccifyAll2HH25.glue",false);
void show_DeyaccifyAll2HH25() {run_case("DeyaccifyAll2HH25.glue",true);}
// DeyaccifyAll2HH31.glue
test bool test_DeyaccifyAll2HH31() = run_case("DeyaccifyAll2HH31.glue",false);
void show_DeyaccifyAll2HH31() {run_case("DeyaccifyAll2HH31.glue",true);}
// DeyaccifyAll2HH32.glue
test bool test_DeyaccifyAll2HH32() = run_case("DeyaccifyAll2HH32.glue",false);
void show_DeyaccifyAll2HH32() {run_case("DeyaccifyAll2HH32.glue",true);}
// DeyaccifyAll2HH33.glue
test bool test_DeyaccifyAll2HH33() = run_case("DeyaccifyAll2HH33.glue",false);
void show_DeyaccifyAll2HH33() {run_case("DeyaccifyAll2HH33.glue",true);}
// DeyaccifyAll2HH34.glue
test bool test_DeyaccifyAll2HH34() = run_case("DeyaccifyAll2HH34.glue",false);
void show_DeyaccifyAll2HH34() {run_case("DeyaccifyAll2HH34.glue",true);}
// DeyaccifyAll2HH35.glue
test bool test_DeyaccifyAll2HH35() = run_case("DeyaccifyAll2HH35.glue",false);
void show_DeyaccifyAll2HH35() {run_case("DeyaccifyAll2HH35.glue",true);}
// DeyaccifyAll2HH41.glue
test bool test_DeyaccifyAll2HH41() = run_case("DeyaccifyAll2HH41.glue",false);
void show_DeyaccifyAll2HH41() {run_case("DeyaccifyAll2HH41.glue",true);}
// DeyaccifyAll2HH42.glue
test bool test_DeyaccifyAll2HH42() = run_case("DeyaccifyAll2HH42.glue",false);
void show_DeyaccifyAll2HH42() {run_case("DeyaccifyAll2HH42.glue",true);}
// DeyaccifyAll2HH43.glue
test bool test_DeyaccifyAll2HH43() = run_case("DeyaccifyAll2HH43.glue",false);
void show_DeyaccifyAll2HH43() {run_case("DeyaccifyAll2HH43.glue",true);}
// DeyaccifyAll2HH44.glue
test bool test_DeyaccifyAll2HH44() = run_case("DeyaccifyAll2HH44.glue",false);
void show_DeyaccifyAll2HH44() {run_case("DeyaccifyAll2HH44.glue",true);}
// DeyaccifyAll2HH45.glue
test bool test_DeyaccifyAll2HH45() = run_case("DeyaccifyAll2HH45.glue",false);
void show_DeyaccifyAll2HH45() {run_case("DeyaccifyAll2HH45.glue",true);}
// DeyaccifyAll2HH51.glue
test bool test_DeyaccifyAll2HH51() = run_case("DeyaccifyAll2HH51.glue",false);
void show_DeyaccifyAll2HH51() {run_case("DeyaccifyAll2HH51.glue",true);}
// DeyaccifyAll2HH52.glue
test bool test_DeyaccifyAll2HH52() = run_case("DeyaccifyAll2HH52.glue",false);
void show_DeyaccifyAll2HH52() {run_case("DeyaccifyAll2HH52.glue",true);}
// DeyaccifyAll2HH53.glue
test bool test_DeyaccifyAll2HH53() = run_case("DeyaccifyAll2HH53.glue",false);
void show_DeyaccifyAll2HH53() {run_case("DeyaccifyAll2HH53.glue",true);}
// DeyaccifyAll2HH54.glue
test bool test_DeyaccifyAll2HH54() = run_case("DeyaccifyAll2HH54.glue",false);
void show_DeyaccifyAll2HH54() {run_case("DeyaccifyAll2HH54.glue",true);}
// DeyaccifyAll2HH55.glue
test bool test_DeyaccifyAll2HH55() = run_case("DeyaccifyAll2HH55.glue",false);
void show_DeyaccifyAll2HH55() {run_case("DeyaccifyAll2HH55.glue",true);}
// DeyaccifyAll2HH61.glue
test bool test_DeyaccifyAll2HH61() = run_case("DeyaccifyAll2HH61.glue",false);
void show_DeyaccifyAll2HH61() {run_case("DeyaccifyAll2HH61.glue",true);}
// DeyaccifyAll2HH62.glue
test bool test_DeyaccifyAll2HH62() = run_case("DeyaccifyAll2HH62.glue",false);
void show_DeyaccifyAll2HH62() {run_case("DeyaccifyAll2HH62.glue",true);}
// DeyaccifyAll2HH63.glue
test bool test_DeyaccifyAll2HH63() = run_case("DeyaccifyAll2HH63.glue",false);
void show_DeyaccifyAll2HH63() {run_case("DeyaccifyAll2HH63.glue",true);}
// DeyaccifyAll2HH64.glue
test bool test_DeyaccifyAll2HH64() = run_case("DeyaccifyAll2HH64.glue",false);
void show_DeyaccifyAll2HH64() {run_case("DeyaccifyAll2HH64.glue",true);}
// DeyaccifyAll2HH65.glue
test bool test_DeyaccifyAll2HH65() = run_case("DeyaccifyAll2HH65.glue",false);
void show_DeyaccifyAll2HH65() {run_case("DeyaccifyAll2HH65.glue",true);}
// DeyaccifyAll2HV11.glue
test bool test_DeyaccifyAll2HV11() = run_case("DeyaccifyAll2HV11.glue",false);
void show_DeyaccifyAll2HV11() {run_case("DeyaccifyAll2HV11.glue",true);}
// DeyaccifyAll2HV12.glue
test bool test_DeyaccifyAll2HV12() = run_case("DeyaccifyAll2HV12.glue",false);
void show_DeyaccifyAll2HV12() {run_case("DeyaccifyAll2HV12.glue",true);}
// DeyaccifyAll2HV13.glue
test bool test_DeyaccifyAll2HV13() = run_case("DeyaccifyAll2HV13.glue",false);
void show_DeyaccifyAll2HV13() {run_case("DeyaccifyAll2HV13.glue",true);}
// DeyaccifyAll2HV14.glue
test bool test_DeyaccifyAll2HV14() = run_case("DeyaccifyAll2HV14.glue",false);
void show_DeyaccifyAll2HV14() {run_case("DeyaccifyAll2HV14.glue",true);}
// DeyaccifyAll2HV15.glue
test bool test_DeyaccifyAll2HV15() = run_case("DeyaccifyAll2HV15.glue",false);
void show_DeyaccifyAll2HV15() {run_case("DeyaccifyAll2HV15.glue",true);}
// DeyaccifyAll2HV21.glue
test bool test_DeyaccifyAll2HV21() = run_case("DeyaccifyAll2HV21.glue",false);
void show_DeyaccifyAll2HV21() {run_case("DeyaccifyAll2HV21.glue",true);}
// DeyaccifyAll2HV22.glue
test bool test_DeyaccifyAll2HV22() = run_case("DeyaccifyAll2HV22.glue",false);
void show_DeyaccifyAll2HV22() {run_case("DeyaccifyAll2HV22.glue",true);}
// DeyaccifyAll2HV23.glue
test bool test_DeyaccifyAll2HV23() = run_case("DeyaccifyAll2HV23.glue",false);
void show_DeyaccifyAll2HV23() {run_case("DeyaccifyAll2HV23.glue",true);}
// DeyaccifyAll2HV24.glue
test bool test_DeyaccifyAll2HV24() = run_case("DeyaccifyAll2HV24.glue",false);
void show_DeyaccifyAll2HV24() {run_case("DeyaccifyAll2HV24.glue",true);}
// DeyaccifyAll2HV25.glue
test bool test_DeyaccifyAll2HV25() = run_case("DeyaccifyAll2HV25.glue",false);
void show_DeyaccifyAll2HV25() {run_case("DeyaccifyAll2HV25.glue",true);}
// DeyaccifyAll2HV31.glue
test bool test_DeyaccifyAll2HV31() = run_case("DeyaccifyAll2HV31.glue",false);
void show_DeyaccifyAll2HV31() {run_case("DeyaccifyAll2HV31.glue",true);}
// DeyaccifyAll2HV32.glue
test bool test_DeyaccifyAll2HV32() = run_case("DeyaccifyAll2HV32.glue",false);
void show_DeyaccifyAll2HV32() {run_case("DeyaccifyAll2HV32.glue",true);}
// DeyaccifyAll2HV33.glue
test bool test_DeyaccifyAll2HV33() = run_case("DeyaccifyAll2HV33.glue",false);
void show_DeyaccifyAll2HV33() {run_case("DeyaccifyAll2HV33.glue",true);}
// DeyaccifyAll2HV34.glue
test bool test_DeyaccifyAll2HV34() = run_case("DeyaccifyAll2HV34.glue",false);
void show_DeyaccifyAll2HV34() {run_case("DeyaccifyAll2HV34.glue",true);}
// DeyaccifyAll2HV35.glue
test bool test_DeyaccifyAll2HV35() = run_case("DeyaccifyAll2HV35.glue",false);
void show_DeyaccifyAll2HV35() {run_case("DeyaccifyAll2HV35.glue",true);}
// DeyaccifyAll2HV41.glue
test bool test_DeyaccifyAll2HV41() = run_case("DeyaccifyAll2HV41.glue",false);
void show_DeyaccifyAll2HV41() {run_case("DeyaccifyAll2HV41.glue",true);}
// DeyaccifyAll2HV42.glue
test bool test_DeyaccifyAll2HV42() = run_case("DeyaccifyAll2HV42.glue",false);
void show_DeyaccifyAll2HV42() {run_case("DeyaccifyAll2HV42.glue",true);}
// DeyaccifyAll2HV43.glue
test bool test_DeyaccifyAll2HV43() = run_case("DeyaccifyAll2HV43.glue",false);
void show_DeyaccifyAll2HV43() {run_case("DeyaccifyAll2HV43.glue",true);}
// DeyaccifyAll2HV44.glue
test bool test_DeyaccifyAll2HV44() = run_case("DeyaccifyAll2HV44.glue",false);
void show_DeyaccifyAll2HV44() {run_case("DeyaccifyAll2HV44.glue",true);}
// DeyaccifyAll2HV45.glue
test bool test_DeyaccifyAll2HV45() = run_case("DeyaccifyAll2HV45.glue",false);
void show_DeyaccifyAll2HV45() {run_case("DeyaccifyAll2HV45.glue",true);}
// DeyaccifyAll2HV51.glue
test bool test_DeyaccifyAll2HV51() = run_case("DeyaccifyAll2HV51.glue",false);
void show_DeyaccifyAll2HV51() {run_case("DeyaccifyAll2HV51.glue",true);}
// DeyaccifyAll2HV52.glue
test bool test_DeyaccifyAll2HV52() = run_case("DeyaccifyAll2HV52.glue",false);
void show_DeyaccifyAll2HV52() {run_case("DeyaccifyAll2HV52.glue",true);}
// DeyaccifyAll2HV53.glue
test bool test_DeyaccifyAll2HV53() = run_case("DeyaccifyAll2HV53.glue",false);
void show_DeyaccifyAll2HV53() {run_case("DeyaccifyAll2HV53.glue",true);}
// DeyaccifyAll2HV54.glue
test bool test_DeyaccifyAll2HV54() = run_case("DeyaccifyAll2HV54.glue",false);
void show_DeyaccifyAll2HV54() {run_case("DeyaccifyAll2HV54.glue",true);}
// DeyaccifyAll2HV55.glue
test bool test_DeyaccifyAll2HV55() = run_case("DeyaccifyAll2HV55.glue",false);
void show_DeyaccifyAll2HV55() {run_case("DeyaccifyAll2HV55.glue",true);}
// DeyaccifyAll2HV61.glue
test bool test_DeyaccifyAll2HV61() = run_case("DeyaccifyAll2HV61.glue",false);
void show_DeyaccifyAll2HV61() {run_case("DeyaccifyAll2HV61.glue",true);}
// DeyaccifyAll2HV62.glue
test bool test_DeyaccifyAll2HV62() = run_case("DeyaccifyAll2HV62.glue",false);
void show_DeyaccifyAll2HV62() {run_case("DeyaccifyAll2HV62.glue",true);}
// DeyaccifyAll2HV63.glue
test bool test_DeyaccifyAll2HV63() = run_case("DeyaccifyAll2HV63.glue",false);
void show_DeyaccifyAll2HV63() {run_case("DeyaccifyAll2HV63.glue",true);}
// DeyaccifyAll2HV64.glue
test bool test_DeyaccifyAll2HV64() = run_case("DeyaccifyAll2HV64.glue",false);
void show_DeyaccifyAll2HV64() {run_case("DeyaccifyAll2HV64.glue",true);}
// DeyaccifyAll2HV65.glue
test bool test_DeyaccifyAll2HV65() = run_case("DeyaccifyAll2HV65.glue",false);
void show_DeyaccifyAll2HV65() {run_case("DeyaccifyAll2HV65.glue",true);}
// DeyaccifyAll2VH11.glue
test bool test_DeyaccifyAll2VH11() = run_case("DeyaccifyAll2VH11.glue",false);
void show_DeyaccifyAll2VH11() {run_case("DeyaccifyAll2VH11.glue",true);}
// DeyaccifyAll2VH12.glue
test bool test_DeyaccifyAll2VH12() = run_case("DeyaccifyAll2VH12.glue",false);
void show_DeyaccifyAll2VH12() {run_case("DeyaccifyAll2VH12.glue",true);}
// DeyaccifyAll2VH13.glue
test bool test_DeyaccifyAll2VH13() = run_case("DeyaccifyAll2VH13.glue",false);
void show_DeyaccifyAll2VH13() {run_case("DeyaccifyAll2VH13.glue",true);}
// DeyaccifyAll2VH14.glue
test bool test_DeyaccifyAll2VH14() = run_case("DeyaccifyAll2VH14.glue",false);
void show_DeyaccifyAll2VH14() {run_case("DeyaccifyAll2VH14.glue",true);}
// DeyaccifyAll2VH15.glue
test bool test_DeyaccifyAll2VH15() = run_case("DeyaccifyAll2VH15.glue",false);
void show_DeyaccifyAll2VH15() {run_case("DeyaccifyAll2VH15.glue",true);}
// DeyaccifyAll2VH21.glue
test bool test_DeyaccifyAll2VH21() = run_case("DeyaccifyAll2VH21.glue",false);
void show_DeyaccifyAll2VH21() {run_case("DeyaccifyAll2VH21.glue",true);}
// DeyaccifyAll2VH22.glue
test bool test_DeyaccifyAll2VH22() = run_case("DeyaccifyAll2VH22.glue",false);
void show_DeyaccifyAll2VH22() {run_case("DeyaccifyAll2VH22.glue",true);}
// DeyaccifyAll2VH23.glue
test bool test_DeyaccifyAll2VH23() = run_case("DeyaccifyAll2VH23.glue",false);
void show_DeyaccifyAll2VH23() {run_case("DeyaccifyAll2VH23.glue",true);}
// DeyaccifyAll2VH24.glue
test bool test_DeyaccifyAll2VH24() = run_case("DeyaccifyAll2VH24.glue",false);
void show_DeyaccifyAll2VH24() {run_case("DeyaccifyAll2VH24.glue",true);}
// DeyaccifyAll2VH25.glue
test bool test_DeyaccifyAll2VH25() = run_case("DeyaccifyAll2VH25.glue",false);
void show_DeyaccifyAll2VH25() {run_case("DeyaccifyAll2VH25.glue",true);}
// DeyaccifyAll2VH31.glue
test bool test_DeyaccifyAll2VH31() = run_case("DeyaccifyAll2VH31.glue",false);
void show_DeyaccifyAll2VH31() {run_case("DeyaccifyAll2VH31.glue",true);}
// DeyaccifyAll2VH32.glue
test bool test_DeyaccifyAll2VH32() = run_case("DeyaccifyAll2VH32.glue",false);
void show_DeyaccifyAll2VH32() {run_case("DeyaccifyAll2VH32.glue",true);}
// DeyaccifyAll2VH33.glue
test bool test_DeyaccifyAll2VH33() = run_case("DeyaccifyAll2VH33.glue",false);
void show_DeyaccifyAll2VH33() {run_case("DeyaccifyAll2VH33.glue",true);}
// DeyaccifyAll2VH34.glue
test bool test_DeyaccifyAll2VH34() = run_case("DeyaccifyAll2VH34.glue",false);
void show_DeyaccifyAll2VH34() {run_case("DeyaccifyAll2VH34.glue",true);}
// DeyaccifyAll2VH35.glue
test bool test_DeyaccifyAll2VH35() = run_case("DeyaccifyAll2VH35.glue",false);
void show_DeyaccifyAll2VH35() {run_case("DeyaccifyAll2VH35.glue",true);}
// DeyaccifyAll2VH41.glue
test bool test_DeyaccifyAll2VH41() = run_case("DeyaccifyAll2VH41.glue",false);
void show_DeyaccifyAll2VH41() {run_case("DeyaccifyAll2VH41.glue",true);}
// DeyaccifyAll2VH42.glue
test bool test_DeyaccifyAll2VH42() = run_case("DeyaccifyAll2VH42.glue",false);
void show_DeyaccifyAll2VH42() {run_case("DeyaccifyAll2VH42.glue",true);}
// DeyaccifyAll2VH43.glue
test bool test_DeyaccifyAll2VH43() = run_case("DeyaccifyAll2VH43.glue",false);
void show_DeyaccifyAll2VH43() {run_case("DeyaccifyAll2VH43.glue",true);}
// DeyaccifyAll2VH44.glue
test bool test_DeyaccifyAll2VH44() = run_case("DeyaccifyAll2VH44.glue",false);
void show_DeyaccifyAll2VH44() {run_case("DeyaccifyAll2VH44.glue",true);}
// DeyaccifyAll2VH45.glue
test bool test_DeyaccifyAll2VH45() = run_case("DeyaccifyAll2VH45.glue",false);
void show_DeyaccifyAll2VH45() {run_case("DeyaccifyAll2VH45.glue",true);}
// DeyaccifyAll2VH51.glue
test bool test_DeyaccifyAll2VH51() = run_case("DeyaccifyAll2VH51.glue",false);
void show_DeyaccifyAll2VH51() {run_case("DeyaccifyAll2VH51.glue",true);}
// DeyaccifyAll2VH52.glue
test bool test_DeyaccifyAll2VH52() = run_case("DeyaccifyAll2VH52.glue",false);
void show_DeyaccifyAll2VH52() {run_case("DeyaccifyAll2VH52.glue",true);}
// DeyaccifyAll2VH53.glue
test bool test_DeyaccifyAll2VH53() = run_case("DeyaccifyAll2VH53.glue",false);
void show_DeyaccifyAll2VH53() {run_case("DeyaccifyAll2VH53.glue",true);}
// DeyaccifyAll2VH54.glue
test bool test_DeyaccifyAll2VH54() = run_case("DeyaccifyAll2VH54.glue",false);
void show_DeyaccifyAll2VH54() {run_case("DeyaccifyAll2VH54.glue",true);}
// DeyaccifyAll2VH55.glue
test bool test_DeyaccifyAll2VH55() = run_case("DeyaccifyAll2VH55.glue",false);
void show_DeyaccifyAll2VH55() {run_case("DeyaccifyAll2VH55.glue",true);}
// DeyaccifyAll2VH61.glue
test bool test_DeyaccifyAll2VH61() = run_case("DeyaccifyAll2VH61.glue",false);
void show_DeyaccifyAll2VH61() {run_case("DeyaccifyAll2VH61.glue",true);}
// DeyaccifyAll2VH62.glue
test bool test_DeyaccifyAll2VH62() = run_case("DeyaccifyAll2VH62.glue",false);
void show_DeyaccifyAll2VH62() {run_case("DeyaccifyAll2VH62.glue",true);}
// DeyaccifyAll2VH63.glue
test bool test_DeyaccifyAll2VH63() = run_case("DeyaccifyAll2VH63.glue",false);
void show_DeyaccifyAll2VH63() {run_case("DeyaccifyAll2VH63.glue",true);}
// DeyaccifyAll2VH64.glue
test bool test_DeyaccifyAll2VH64() = run_case("DeyaccifyAll2VH64.glue",false);
void show_DeyaccifyAll2VH64() {run_case("DeyaccifyAll2VH64.glue",true);}
// DeyaccifyAll2VH65.glue
test bool test_DeyaccifyAll2VH65() = run_case("DeyaccifyAll2VH65.glue",false);
void show_DeyaccifyAll2VH65() {run_case("DeyaccifyAll2VH65.glue",true);}
// DeyaccifyAll2VV11.glue
test bool test_DeyaccifyAll2VV11() = run_case("DeyaccifyAll2VV11.glue",false);
void show_DeyaccifyAll2VV11() {run_case("DeyaccifyAll2VV11.glue",true);}
// DeyaccifyAll2VV12.glue
test bool test_DeyaccifyAll2VV12() = run_case("DeyaccifyAll2VV12.glue",false);
void show_DeyaccifyAll2VV12() {run_case("DeyaccifyAll2VV12.glue",true);}
// DeyaccifyAll2VV13.glue
test bool test_DeyaccifyAll2VV13() = run_case("DeyaccifyAll2VV13.glue",false);
void show_DeyaccifyAll2VV13() {run_case("DeyaccifyAll2VV13.glue",true);}
// DeyaccifyAll2VV14.glue
test bool test_DeyaccifyAll2VV14() = run_case("DeyaccifyAll2VV14.glue",false);
void show_DeyaccifyAll2VV14() {run_case("DeyaccifyAll2VV14.glue",true);}
// DeyaccifyAll2VV15.glue
test bool test_DeyaccifyAll2VV15() = run_case("DeyaccifyAll2VV15.glue",false);
void show_DeyaccifyAll2VV15() {run_case("DeyaccifyAll2VV15.glue",true);}
// DeyaccifyAll2VV21.glue
test bool test_DeyaccifyAll2VV21() = run_case("DeyaccifyAll2VV21.glue",false);
void show_DeyaccifyAll2VV21() {run_case("DeyaccifyAll2VV21.glue",true);}
// DeyaccifyAll2VV22.glue
test bool test_DeyaccifyAll2VV22() = run_case("DeyaccifyAll2VV22.glue",false);
void show_DeyaccifyAll2VV22() {run_case("DeyaccifyAll2VV22.glue",true);}
// DeyaccifyAll2VV23.glue
test bool test_DeyaccifyAll2VV23() = run_case("DeyaccifyAll2VV23.glue",false);
void show_DeyaccifyAll2VV23() {run_case("DeyaccifyAll2VV23.glue",true);}
// DeyaccifyAll2VV24.glue
test bool test_DeyaccifyAll2VV24() = run_case("DeyaccifyAll2VV24.glue",false);
void show_DeyaccifyAll2VV24() {run_case("DeyaccifyAll2VV24.glue",true);}
// DeyaccifyAll2VV25.glue
test bool test_DeyaccifyAll2VV25() = run_case("DeyaccifyAll2VV25.glue",false);
void show_DeyaccifyAll2VV25() {run_case("DeyaccifyAll2VV25.glue",true);}
// DeyaccifyAll2VV31.glue
test bool test_DeyaccifyAll2VV31() = run_case("DeyaccifyAll2VV31.glue",false);
void show_DeyaccifyAll2VV31() {run_case("DeyaccifyAll2VV31.glue",true);}
// DeyaccifyAll2VV32.glue
test bool test_DeyaccifyAll2VV32() = run_case("DeyaccifyAll2VV32.glue",false);
void show_DeyaccifyAll2VV32() {run_case("DeyaccifyAll2VV32.glue",true);}
// DeyaccifyAll2VV33.glue
test bool test_DeyaccifyAll2VV33() = run_case("DeyaccifyAll2VV33.glue",false);
void show_DeyaccifyAll2VV33() {run_case("DeyaccifyAll2VV33.glue",true);}
// DeyaccifyAll2VV34.glue
test bool test_DeyaccifyAll2VV34() = run_case("DeyaccifyAll2VV34.glue",false);
void show_DeyaccifyAll2VV34() {run_case("DeyaccifyAll2VV34.glue",true);}
// DeyaccifyAll2VV35.glue
test bool test_DeyaccifyAll2VV35() = run_case("DeyaccifyAll2VV35.glue",false);
void show_DeyaccifyAll2VV35() {run_case("DeyaccifyAll2VV35.glue",true);}
// DeyaccifyAll2VV41.glue
test bool test_DeyaccifyAll2VV41() = run_case("DeyaccifyAll2VV41.glue",false);
void show_DeyaccifyAll2VV41() {run_case("DeyaccifyAll2VV41.glue",true);}
// DeyaccifyAll2VV42.glue
test bool test_DeyaccifyAll2VV42() = run_case("DeyaccifyAll2VV42.glue",false);
void show_DeyaccifyAll2VV42() {run_case("DeyaccifyAll2VV42.glue",true);}
// DeyaccifyAll2VV43.glue
test bool test_DeyaccifyAll2VV43() = run_case("DeyaccifyAll2VV43.glue",false);
void show_DeyaccifyAll2VV43() {run_case("DeyaccifyAll2VV43.glue",true);}
// DeyaccifyAll2VV44.glue
test bool test_DeyaccifyAll2VV44() = run_case("DeyaccifyAll2VV44.glue",false);
void show_DeyaccifyAll2VV44() {run_case("DeyaccifyAll2VV44.glue",true);}
// DeyaccifyAll2VV45.glue
test bool test_DeyaccifyAll2VV45() = run_case("DeyaccifyAll2VV45.glue",false);
void show_DeyaccifyAll2VV45() {run_case("DeyaccifyAll2VV45.glue",true);}
// DeyaccifyAll2VV51.glue
test bool test_DeyaccifyAll2VV51() = run_case("DeyaccifyAll2VV51.glue",false);
void show_DeyaccifyAll2VV51() {run_case("DeyaccifyAll2VV51.glue",true);}
// DeyaccifyAll2VV52.glue
test bool test_DeyaccifyAll2VV52() = run_case("DeyaccifyAll2VV52.glue",false);
void show_DeyaccifyAll2VV52() {run_case("DeyaccifyAll2VV52.glue",true);}
// DeyaccifyAll2VV53.glue
test bool test_DeyaccifyAll2VV53() = run_case("DeyaccifyAll2VV53.glue",false);
void show_DeyaccifyAll2VV53() {run_case("DeyaccifyAll2VV53.glue",true);}
// DeyaccifyAll2VV54.glue
test bool test_DeyaccifyAll2VV54() = run_case("DeyaccifyAll2VV54.glue",false);
void show_DeyaccifyAll2VV54() {run_case("DeyaccifyAll2VV54.glue",true);}
// DeyaccifyAll2VV55.glue
test bool test_DeyaccifyAll2VV55() = run_case("DeyaccifyAll2VV55.glue",false);
void show_DeyaccifyAll2VV55() {run_case("DeyaccifyAll2VV55.glue",true);}
// DeyaccifyAll2VV61.glue
test bool test_DeyaccifyAll2VV61() = run_case("DeyaccifyAll2VV61.glue",false);
void show_DeyaccifyAll2VV61() {run_case("DeyaccifyAll2VV61.glue",true);}
// DeyaccifyAll2VV62.glue
test bool test_DeyaccifyAll2VV62() = run_case("DeyaccifyAll2VV62.glue",false);
void show_DeyaccifyAll2VV62() {run_case("DeyaccifyAll2VV62.glue",true);}
// DeyaccifyAll2VV63.glue
test bool test_DeyaccifyAll2VV63() = run_case("DeyaccifyAll2VV63.glue",false);
void show_DeyaccifyAll2VV63() {run_case("DeyaccifyAll2VV63.glue",true);}
// DeyaccifyAll2VV64.glue
test bool test_DeyaccifyAll2VV64() = run_case("DeyaccifyAll2VV64.glue",false);
void show_DeyaccifyAll2VV64() {run_case("DeyaccifyAll2VV64.glue",true);}
// DeyaccifyAll2VV65.glue
test bool test_DeyaccifyAll2VV65() = run_case("DeyaccifyAll2VV65.glue",false);
void show_DeyaccifyAll2VV65() {run_case("DeyaccifyAll2VV65.glue",true);}
// SLEIR:DistributeAll: 3 tests
// DistributeAll1.glue
test bool test_DistributeAll1() = run_case("DistributeAll1.glue",false);
void show_DistributeAll1() {run_case("DistributeAll1.glue",true);}
// DistributeAll2.glue
test bool test_DistributeAll2() = run_case("DistributeAll2.glue",false);
void show_DistributeAll2() {run_case("DistributeAll2.glue",true);}
// DistributeAll3.glue
test bool test_DistributeAll3() = run_case("DistributeAll3.glue",false);
void show_DistributeAll3() {run_case("DistributeAll3.glue",true);}
// SLEIR:EliminateTop: 4 tests
// EliminateTop1.glue
test bool test_EliminateTop1() = run_case("EliminateTop1.glue",false);
void show_EliminateTop1() {run_case("EliminateTop1.glue",true);}
// EliminateTop2.glue
test bool test_EliminateTop2() = run_case("EliminateTop2.glue",false);
void show_EliminateTop2() {run_case("EliminateTop2.glue",true);}
// EliminateTop3.glue
test bool test_EliminateTop3() = run_case("EliminateTop3.glue",false);
void show_EliminateTop3() {run_case("EliminateTop3.glue",true);}
// EliminateTop4.glue
test bool test_EliminateTop4() = run_case("EliminateTop4.glue",false);
void show_EliminateTop4() {run_case("EliminateTop4.glue",true);}
// SLEIR:EquateAll: 4 tests
// EquateAll1.glue
test bool test_EquateAll1() = run_case("EquateAll1.glue",false);
void show_EquateAll1() {run_case("EquateAll1.glue",true);}
// EquateAll2.glue
test bool test_EquateAll2() = run_case("EquateAll2.glue",false);
void show_EquateAll2() {run_case("EquateAll2.glue",true);}
// EquateAll3.glue
test bool test_EquateAll3() = run_case("EquateAll3.glue",false);
void show_EquateAll3() {run_case("EquateAll3.glue",true);}
// EquateAll4.glue
test bool test_EquateAll4() = run_case("EquateAll4.glue",false);
void show_EquateAll4() {run_case("EquateAll4.glue",true);}
// SLEIR:FoldMax: 4 tests
// FoldMax1.glue
test bool test_FoldMax1() = run_case("FoldMax1.glue",false);
void show_FoldMax1() {run_case("FoldMax1.glue",true);}
// FoldMax2.glue
test bool test_FoldMax2() = run_case("FoldMax2.glue",false);
void show_FoldMax2() {run_case("FoldMax2.glue",true);}
// FoldMax3.glue
test bool test_FoldMax3() = run_case("FoldMax3.glue",false);
void show_FoldMax3() {run_case("FoldMax3.glue",true);}
// FoldMax4.glue
test bool test_FoldMax4() = run_case("FoldMax4.glue",false);
void show_FoldMax4() {run_case("FoldMax4.glue",true);}
// SLEIR:HorizontalAll: 5 tests
// HorizontalAll1.glue
test bool test_HorizontalAll1() = run_case("HorizontalAll1.glue",false);
void show_HorizontalAll1() {run_case("HorizontalAll1.glue",true);}
// HorizontalAll2.glue
test bool test_HorizontalAll2() = run_case("HorizontalAll2.glue",false);
void show_HorizontalAll2() {run_case("HorizontalAll2.glue",true);}
// HorizontalAll3.glue
test bool test_HorizontalAll3() = run_case("HorizontalAll3.glue",false);
void show_HorizontalAll3() {run_case("HorizontalAll3.glue",true);}
// HorizontalAll4.glue
test bool test_HorizontalAll4() = run_case("HorizontalAll4.glue",false);
void show_HorizontalAll4() {run_case("HorizontalAll4.glue",true);}
// HorizontalAll5.glue
test bool test_HorizontalAll5() = run_case("HorizontalAll5.glue",false);
void show_HorizontalAll5() {run_case("HorizontalAll5.glue",true);}
// SLEIR:InlineMax: 5 tests
// InlineMax1.glue
test bool test_InlineMax1() = run_case("InlineMax1.glue",false);
void show_InlineMax1() {run_case("InlineMax1.glue",true);}
// InlineMax2.glue
test bool test_InlineMax2() = run_case("InlineMax2.glue",false);
void show_InlineMax2() {run_case("InlineMax2.glue",true);}
// InlineMax3.glue
test bool test_InlineMax3() = run_case("InlineMax3.glue",false);
void show_InlineMax3() {run_case("InlineMax3.glue",true);}
// InlineMax4.glue
test bool test_InlineMax4() = run_case("InlineMax4.glue",false);
void show_InlineMax4() {run_case("InlineMax4.glue",true);}
// InlineMax5.glue
test bool test_InlineMax5() = run_case("InlineMax5.glue",false);
void show_InlineMax5() {run_case("InlineMax5.glue",true);}
// SLEIR:InlinePlus: 4 tests
// InlinePlus1.glue
test bool test_InlinePlus1() = run_case("InlinePlus1.glue",false);
void show_InlinePlus1() {run_case("InlinePlus1.glue",true);}
// InlinePlus2.glue
test bool test_InlinePlus2() = run_case("InlinePlus2.glue",false);
void show_InlinePlus2() {run_case("InlinePlus2.glue",true);}
// InlinePlus3.glue
test bool test_InlinePlus3() = run_case("InlinePlus3.glue",false);
void show_InlinePlus3() {run_case("InlinePlus3.glue",true);}
// InlinePlus4.glue
test bool test_InlinePlus4() = run_case("InlinePlus4.glue",false);
void show_InlinePlus4() {run_case("InlinePlus4.glue",true);}
// SLEIR:InsertLayout: 0 tests

// SLEIR:IterateXX: 3 tests
// IterateXX1.glue
test bool test_IterateXX1() = run_case("IterateXX1.glue",false);
void show_IterateXX1() {run_case("IterateXX1.glue",true);}
// IterateXX2.glue
test bool test_IterateXX2() = run_case("IterateXX2.glue",false);
void show_IterateXX2() {run_case("IterateXX2.glue",true);}
// IterateXX3.glue
test bool test_IterateXX3() = run_case("IterateXX3.glue",false);
void show_IterateXX3() {run_case("IterateXX3.glue",true);}
// SLEIR:IterateXYXLeft: 3 tests
// IterateXYXLeft1.glue
test bool test_IterateXYXLeft1() = run_case("IterateXYXLeft1.glue",false);
void show_IterateXYXLeft1() {run_case("IterateXYXLeft1.glue",true);}
// IterateXYXLeft2.glue
test bool test_IterateXYXLeft2() = run_case("IterateXYXLeft2.glue",false);
void show_IterateXYXLeft2() {run_case("IterateXYXLeft2.glue",true);}
// IterateXYXLeft3.glue
test bool test_IterateXYXLeft3() = run_case("IterateXYXLeft3.glue",false);
void show_IterateXYXLeft3() {run_case("IterateXYXLeft3.glue",true);}
// SLEIR:IterateXYXRight: 3 tests
// IterateXYXRight1.glue
test bool test_IterateXYXRight1() = run_case("IterateXYXRight1.glue",false);
void show_IterateXYXRight1() {run_case("IterateXYXRight1.glue",true);}
// IterateXYXRight2.glue
test bool test_IterateXYXRight2() = run_case("IterateXYXRight2.glue",false);
void show_IterateXYXRight2() {run_case("IterateXYXRight2.glue",true);}
// IterateXYXRight3.glue
test bool test_IterateXYXRight3() = run_case("IterateXYXRight3.glue",false);
void show_IterateXYXRight3() {run_case("IterateXYXRight3.glue",true);}
// SLEIR:LAssocAll: 7 tests
// LAssocAll1.glue
test bool test_LAssocAll1() = run_case("LAssocAll1.glue",false);
void show_LAssocAll1() {run_case("LAssocAll1.glue",true);}
// LAssocAll2.glue
test bool test_LAssocAll2() = run_case("LAssocAll2.glue",false);
void show_LAssocAll2() {run_case("LAssocAll2.glue",true);}
// LAssocAll3.glue
test bool test_LAssocAll3() = run_case("LAssocAll3.glue",false);
void show_LAssocAll3() {run_case("LAssocAll3.glue",true);}
// LAssocAll4.glue
test bool test_LAssocAll4() = run_case("LAssocAll4.glue",false);
void show_LAssocAll4() {run_case("LAssocAll4.glue",true);}
// LAssocAll5.glue
test bool test_LAssocAll5() = run_case("LAssocAll5.glue",false);
void show_LAssocAll5() {run_case("LAssocAll5.glue",true);}
// LAssocAll6.glue
test bool test_LAssocAll6() = run_case("LAssocAll6.glue",false);
void show_LAssocAll6() {run_case("LAssocAll6.glue",true);}
// LAssocAll7.glue
test bool test_LAssocAll7() = run_case("LAssocAll7.glue",false);
void show_LAssocAll7() {run_case("LAssocAll7.glue",true);}
// SLEIR:LiftTopLabels: 0 tests

// SLEIR:MassageAndNot2Except: 2 tests
// MassageAndNot2Except1.glue
test bool test_MassageAndNot2Except1() = run_case("MassageAndNot2Except1.glue",false);
void show_MassageAndNot2Except1() {run_case("MassageAndNot2Except1.glue",true);}
// MassageAndNot2Except2.glue
test bool test_MassageAndNot2Except2() = run_case("MassageAndNot2Except2.glue",false);
void show_MassageAndNot2Except2() {run_case("MassageAndNot2Except2.glue",true);}
// SLEIR:MassageAndNotXY2NotOrXY: 2 tests
// MassageAndNotXY2NotOrXY1.glue
test bool test_MassageAndNotXY2NotOrXY1() = run_case("MassageAndNotXY2NotOrXY1.glue",false);
void show_MassageAndNotXY2NotOrXY1() {run_case("MassageAndNotXY2NotOrXY1.glue",true);}
// MassageAndNotXY2NotOrXY2.glue
test bool test_MassageAndNotXY2NotOrXY2() = run_case("MassageAndNotXY2NotOrXY2.glue",false);
void show_MassageAndNotXY2NotOrXY2() {run_case("MassageAndNotXY2NotOrXY2.glue",true);}
// SLEIR:MassageAndXY2NotOrNotXY: 2 tests
// MassageAndXY2NotOrNotXY1.glue
test bool test_MassageAndXY2NotOrNotXY1() = run_case("MassageAndXY2NotOrNotXY1.glue",false);
void show_MassageAndXY2NotOrNotXY1() {run_case("MassageAndXY2NotOrNotXY1.glue",true);}
// MassageAndXY2NotOrNotXY2.glue
test bool test_MassageAndXY2NotOrNotXY2() = run_case("MassageAndXY2NotOrNotXY2.glue",false);
void show_MassageAndXY2NotOrNotXY2() {run_case("MassageAndXY2NotOrNotXY2.glue",true);}
// SLEIR:MassageExcept2AndNot: 2 tests
// MassageExcept2AndNot1.glue
test bool test_MassageExcept2AndNot1() = run_case("MassageExcept2AndNot1.glue",false);
void show_MassageExcept2AndNot1() {run_case("MassageExcept2AndNot1.glue",true);}
// MassageExcept2AndNot2.glue
test bool test_MassageExcept2AndNot2() = run_case("MassageExcept2AndNot2.glue",false);
void show_MassageExcept2AndNot2() {run_case("MassageExcept2AndNot2.glue",true);}
// SLEIR:MassageLabelNot2NotLabel: 2 tests
// MassageLabelNot2NotLabel1.glue
test bool test_MassageLabelNot2NotLabel1() = run_case("MassageLabelNot2NotLabel1.glue",false);
void show_MassageLabelNot2NotLabel1() {run_case("MassageLabelNot2NotLabel1.glue",true);}
// MassageLabelNot2NotLabel2.glue
test bool test_MassageLabelNot2NotLabel2() = run_case("MassageLabelNot2NotLabel2.glue",false);
void show_MassageLabelNot2NotLabel2() {run_case("MassageLabelNot2NotLabel2.glue",true);}
// SLEIR:MassageLabelOpt2OptLabel: 2 tests
// MassageLabelOpt2OptLabel1.glue
test bool test_MassageLabelOpt2OptLabel1() = run_case("MassageLabelOpt2OptLabel1.glue",false);
void show_MassageLabelOpt2OptLabel1() {run_case("MassageLabelOpt2OptLabel1.glue",true);}
// MassageLabelOpt2OptLabel2.glue
test bool test_MassageLabelOpt2OptLabel2() = run_case("MassageLabelOpt2OptLabel2.glue",false);
void show_MassageLabelOpt2OptLabel2() {run_case("MassageLabelOpt2OptLabel2.glue",true);}
// SLEIR:MassageLabelPlus2PlusLabel: 2 tests
// MassageLabelPlus2PlusLabel1.glue
test bool test_MassageLabelPlus2PlusLabel1() = run_case("MassageLabelPlus2PlusLabel1.glue",false);
void show_MassageLabelPlus2PlusLabel1() {run_case("MassageLabelPlus2PlusLabel1.glue",true);}
// MassageLabelPlus2PlusLabel2.glue
test bool test_MassageLabelPlus2PlusLabel2() = run_case("MassageLabelPlus2PlusLabel2.glue",false);
void show_MassageLabelPlus2PlusLabel2() {run_case("MassageLabelPlus2PlusLabel2.glue",true);}
// SLEIR:MassageLabelStar2StarLabel: 2 tests
// MassageLabelStar2StarLabel1.glue
test bool test_MassageLabelStar2StarLabel1() = run_case("MassageLabelStar2StarLabel1.glue",false);
void show_MassageLabelStar2StarLabel1() {run_case("MassageLabelStar2StarLabel1.glue",true);}
// MassageLabelStar2StarLabel2.glue
test bool test_MassageLabelStar2StarLabel2() = run_case("MassageLabelStar2StarLabel2.glue",false);
void show_MassageLabelStar2StarLabel2() {run_case("MassageLabelStar2StarLabel2.glue",true);}
// SLEIR:MassageMarkNot2NotMark: 2 tests
// MassageMarkNot2NotMark1.glue
test bool test_MassageMarkNot2NotMark1() = run_case("MassageMarkNot2NotMark1.glue",false);
void show_MassageMarkNot2NotMark1() {run_case("MassageMarkNot2NotMark1.glue",true);}
// MassageMarkNot2NotMark2.glue
test bool test_MassageMarkNot2NotMark2() = run_case("MassageMarkNot2NotMark2.glue",false);
void show_MassageMarkNot2NotMark2() {run_case("MassageMarkNot2NotMark2.glue",true);}
// SLEIR:MassageMarkOpt2OptMark: 2 tests
// MassageMarkOpt2OptMark1.glue
test bool test_MassageMarkOpt2OptMark1() = run_case("MassageMarkOpt2OptMark1.glue",false);
void show_MassageMarkOpt2OptMark1() {run_case("MassageMarkOpt2OptMark1.glue",true);}
// MassageMarkOpt2OptMark2.glue
test bool test_MassageMarkOpt2OptMark2() = run_case("MassageMarkOpt2OptMark2.glue",false);
void show_MassageMarkOpt2OptMark2() {run_case("MassageMarkOpt2OptMark2.glue",true);}
// SLEIR:MassageMarkPlus2PlusMark: 2 tests
// MassageMarkPlus2PlusMark1.glue
test bool test_MassageMarkPlus2PlusMark1() = run_case("MassageMarkPlus2PlusMark1.glue",false);
void show_MassageMarkPlus2PlusMark1() {run_case("MassageMarkPlus2PlusMark1.glue",true);}
// MassageMarkPlus2PlusMark2.glue
test bool test_MassageMarkPlus2PlusMark2() = run_case("MassageMarkPlus2PlusMark2.glue",false);
void show_MassageMarkPlus2PlusMark2() {run_case("MassageMarkPlus2PlusMark2.glue",true);}
// SLEIR:MassageMarkStar2StarMark: 2 tests
// MassageMarkStar2StarMark1.glue
test bool test_MassageMarkStar2StarMark1() = run_case("MassageMarkStar2StarMark1.glue",false);
void show_MassageMarkStar2StarMark1() {run_case("MassageMarkStar2StarMark1.glue",true);}
// MassageMarkStar2StarMark2.glue
test bool test_MassageMarkStar2StarMark2() = run_case("MassageMarkStar2StarMark2.glue",false);
void show_MassageMarkStar2StarMark2() {run_case("MassageMarkStar2StarMark2.glue",true);}
// SLEIR:MassageNotAndNotXY2OrXY: 2 tests
// MassageNotAndNotXY2OrXY1.glue
test bool test_MassageNotAndNotXY2OrXY1() = run_case("MassageNotAndNotXY2OrXY1.glue",false);
void show_MassageNotAndNotXY2OrXY1() {run_case("MassageNotAndNotXY2OrXY1.glue",true);}
// MassageNotAndNotXY2OrXY2.glue
test bool test_MassageNotAndNotXY2OrXY2() = run_case("MassageNotAndNotXY2OrXY2.glue",false);
void show_MassageNotAndNotXY2OrXY2() {run_case("MassageNotAndNotXY2OrXY2.glue",true);}
// SLEIR:MassageNotAndXY2OrNotXY: 2 tests
// MassageNotAndXY2OrNotXY1.glue
test bool test_MassageNotAndXY2OrNotXY1() = run_case("MassageNotAndXY2OrNotXY1.glue",false);
void show_MassageNotAndXY2OrNotXY1() {run_case("MassageNotAndXY2OrNotXY1.glue",true);}
// MassageNotAndXY2OrNotXY2.glue
test bool test_MassageNotAndXY2OrNotXY2() = run_case("MassageNotAndXY2OrNotXY2.glue",false);
void show_MassageNotAndXY2OrNotXY2() {run_case("MassageNotAndXY2OrNotXY2.glue",true);}
// SLEIR:MassageNotLabel2LabelNot: 2 tests
// MassageNotLabel2LabelNot1.glue
test bool test_MassageNotLabel2LabelNot1() = run_case("MassageNotLabel2LabelNot1.glue",false);
void show_MassageNotLabel2LabelNot1() {run_case("MassageNotLabel2LabelNot1.glue",true);}
// MassageNotLabel2LabelNot2.glue
test bool test_MassageNotLabel2LabelNot2() = run_case("MassageNotLabel2LabelNot2.glue",false);
void show_MassageNotLabel2LabelNot2() {run_case("MassageNotLabel2LabelNot2.glue",true);}
// SLEIR:MassageNotMark2MarkNot: 2 tests
// MassageNotMark2MarkNot1.glue
test bool test_MassageNotMark2MarkNot1() = run_case("MassageNotMark2MarkNot1.glue",false);
void show_MassageNotMark2MarkNot1() {run_case("MassageNotMark2MarkNot1.glue",true);}
// MassageNotMark2MarkNot2.glue
test bool test_MassageNotMark2MarkNot2() = run_case("MassageNotMark2MarkNot2.glue",false);
void show_MassageNotMark2MarkNot2() {run_case("MassageNotMark2MarkNot2.glue",true);}
// SLEIR:MassageNotNot: 2 tests
// MassageNotNot1.glue
test bool test_MassageNotNot1() = run_case("MassageNotNot1.glue",false);
void show_MassageNotNot1() {run_case("MassageNotNot1.glue",true);}
// MassageNotNot2.glue
test bool test_MassageNotNot2() = run_case("MassageNotNot2.glue",false);
void show_MassageNotNot2() {run_case("MassageNotNot2.glue",true);}
// SLEIR:MassageNotOrNotXY2AndXY: 2 tests
// MassageNotOrNotXY2AndXY1.glue
test bool test_MassageNotOrNotXY2AndXY1() = run_case("MassageNotOrNotXY2AndXY1.glue",false);
void show_MassageNotOrNotXY2AndXY1() {run_case("MassageNotOrNotXY2AndXY1.glue",true);}
// MassageNotOrNotXY2AndXY2.glue
test bool test_MassageNotOrNotXY2AndXY2() = run_case("MassageNotOrNotXY2AndXY2.glue",false);
void show_MassageNotOrNotXY2AndXY2() {run_case("MassageNotOrNotXY2AndXY2.glue",true);}
// SLEIR:MassageNotOrXY2AndNotXY: 2 tests
// MassageNotOrXY2AndNotXY1.glue
test bool test_MassageNotOrXY2AndNotXY1() = run_case("MassageNotOrXY2AndNotXY1.glue",false);
void show_MassageNotOrXY2AndNotXY1() {run_case("MassageNotOrXY2AndNotXY1.glue",true);}
// MassageNotOrXY2AndNotXY2.glue
test bool test_MassageNotOrXY2AndNotXY2() = run_case("MassageNotOrXY2AndNotXY2.glue",false);
void show_MassageNotOrXY2AndNotXY2() {run_case("MassageNotOrXY2AndNotXY2.glue",true);}
// SLEIR:MassageOpt2OrEpsX: 2 tests
// MassageOpt2OrEpsX1.glue
test bool test_MassageOpt2OrEpsX1() = run_case("MassageOpt2OrEpsX1.glue",false);
void show_MassageOpt2OrEpsX1() {run_case("MassageOpt2OrEpsX1.glue",true);}
// MassageOpt2OrEpsX2.glue
test bool test_MassageOpt2OrEpsX2() = run_case("MassageOpt2OrEpsX2.glue",false);
void show_MassageOpt2OrEpsX2() {run_case("MassageOpt2OrEpsX2.glue",true);}
// SLEIR:MassageOpt2OrXEps: 2 tests
// MassageOpt2OrXEps1.glue
test bool test_MassageOpt2OrXEps1() = run_case("MassageOpt2OrXEps1.glue",false);
void show_MassageOpt2OrXEps1() {run_case("MassageOpt2OrXEps1.glue",true);}
// MassageOpt2OrXEps2.glue
test bool test_MassageOpt2OrXEps2() = run_case("MassageOpt2OrXEps2.glue",false);
void show_MassageOpt2OrXEps2() {run_case("MassageOpt2OrXEps2.glue",true);}
// SLEIR:MassageOptLabel2LabelOpt: 2 tests
// MassageOptLabel2LabelOpt1.glue
test bool test_MassageOptLabel2LabelOpt1() = run_case("MassageOptLabel2LabelOpt1.glue",false);
void show_MassageOptLabel2LabelOpt1() {run_case("MassageOptLabel2LabelOpt1.glue",true);}
// MassageOptLabel2LabelOpt2.glue
test bool test_MassageOptLabel2LabelOpt2() = run_case("MassageOptLabel2LabelOpt2.glue",false);
void show_MassageOptLabel2LabelOpt2() {run_case("MassageOptLabel2LabelOpt2.glue",true);}
// SLEIR:MassageOptMark2MarkOpt: 2 tests
// MassageOptMark2MarkOpt1.glue
test bool test_MassageOptMark2MarkOpt1() = run_case("MassageOptMark2MarkOpt1.glue",false);
void show_MassageOptMark2MarkOpt1() {run_case("MassageOptMark2MarkOpt1.glue",true);}
// MassageOptMark2MarkOpt2.glue
test bool test_MassageOptMark2MarkOpt2() = run_case("MassageOptMark2MarkOpt2.glue",false);
void show_MassageOptMark2MarkOpt2() {run_case("MassageOptMark2MarkOpt2.glue",true);}
// SLEIR:MassageOptOpt: 2 tests
// MassageOptOpt1.glue
test bool test_MassageOptOpt1() = run_case("MassageOptOpt1.glue",false);
void show_MassageOptOpt1() {run_case("MassageOptOpt1.glue",true);}
// MassageOptOpt2.glue
test bool test_MassageOptOpt2() = run_case("MassageOptOpt2.glue",false);
void show_MassageOptOpt2() {run_case("MassageOptOpt2.glue",true);}
// SLEIR:MassageOptPlus2Star: 2 tests
// MassageOptPlus2Star1.glue
test bool test_MassageOptPlus2Star1() = run_case("MassageOptPlus2Star1.glue",false);
void show_MassageOptPlus2Star1() {run_case("MassageOptPlus2Star1.glue",true);}
// MassageOptPlus2Star2.glue
test bool test_MassageOptPlus2Star2() = run_case("MassageOptPlus2Star2.glue",false);
void show_MassageOptPlus2Star2() {run_case("MassageOptPlus2Star2.glue",true);}
// SLEIR:MassageOptSLPlus2SLStar: 2 tests
// MassageOptSLPlus2SLStar1.glue
test bool test_MassageOptSLPlus2SLStar1() = run_case("MassageOptSLPlus2SLStar1.glue",false);
void show_MassageOptSLPlus2SLStar1() {run_case("MassageOptSLPlus2SLStar1.glue",true);}
// MassageOptSLPlus2SLStar2.glue
test bool test_MassageOptSLPlus2SLStar2() = run_case("MassageOptSLPlus2SLStar2.glue",false);
void show_MassageOptSLPlus2SLStar2() {run_case("MassageOptSLPlus2SLStar2.glue",true);}
// SLEIR:MassageOptSeqStarX2SLStar: 2 tests
// MassageOptSeqStarX2SLStar1.glue
test bool test_MassageOptSeqStarX2SLStar1() = run_case("MassageOptSeqStarX2SLStar1.glue",false);
void show_MassageOptSeqStarX2SLStar1() {run_case("MassageOptSeqStarX2SLStar1.glue",true);}
// MassageOptSeqStarX2SLStar2.glue
test bool test_MassageOptSeqStarX2SLStar2() = run_case("MassageOptSeqStarX2SLStar2.glue",false);
void show_MassageOptSeqStarX2SLStar2() {run_case("MassageOptSeqStarX2SLStar2.glue",true);}
// SLEIR:MassageOptSeqXStar2SLStar: 2 tests
// MassageOptSeqXStar2SLStar1.glue
test bool test_MassageOptSeqXStar2SLStar1() = run_case("MassageOptSeqXStar2SLStar1.glue",false);
void show_MassageOptSeqXStar2SLStar1() {run_case("MassageOptSeqXStar2SLStar1.glue",true);}
// MassageOptSeqXStar2SLStar2.glue
test bool test_MassageOptSeqXStar2SLStar2() = run_case("MassageOptSeqXStar2SLStar2.glue",false);
void show_MassageOptSeqXStar2SLStar2() {run_case("MassageOptSeqXStar2SLStar2.glue",true);}
// SLEIR:MassageOptStar: 2 tests
// MassageOptStar1.glue
test bool test_MassageOptStar1() = run_case("MassageOptStar1.glue",false);
void show_MassageOptStar1() {run_case("MassageOptStar1.glue",true);}
// MassageOptStar2.glue
test bool test_MassageOptStar2() = run_case("MassageOptStar2.glue",false);
void show_MassageOptStar2() {run_case("MassageOptStar2.glue",true);}
// SLEIR:MassageOrEpsX2Opt: 2 tests
// MassageOrEpsX2Opt1.glue
test bool test_MassageOrEpsX2Opt1() = run_case("MassageOrEpsX2Opt1.glue",false);
void show_MassageOrEpsX2Opt1() {run_case("MassageOrEpsX2Opt1.glue",true);}
// MassageOrEpsX2Opt2.glue
test bool test_MassageOrEpsX2Opt2() = run_case("MassageOrEpsX2Opt2.glue",false);
void show_MassageOrEpsX2Opt2() {run_case("MassageOrEpsX2Opt2.glue",true);}
// SLEIR:MassageOrLabels2: 4 tests
// MassageOrLabels21.glue
test bool test_MassageOrLabels21() = run_case("MassageOrLabels21.glue",false);
void show_MassageOrLabels21() {run_case("MassageOrLabels21.glue",true);}
// MassageOrLabels22.glue
test bool test_MassageOrLabels22() = run_case("MassageOrLabels22.glue",false);
void show_MassageOrLabels22() {run_case("MassageOrLabels22.glue",true);}
// MassageOrLabels23.glue
test bool test_MassageOrLabels23() = run_case("MassageOrLabels23.glue",false);
void show_MassageOrLabels23() {run_case("MassageOrLabels23.glue",true);}
// MassageOrLabels24.glue
test bool test_MassageOrLabels24() = run_case("MassageOrLabels24.glue",false);
void show_MassageOrLabels24() {run_case("MassageOrLabels24.glue",true);}
// SLEIR:MassageOrLabels3: 4 tests
// MassageOrLabels31.glue
test bool test_MassageOrLabels31() = run_case("MassageOrLabels31.glue",false);
void show_MassageOrLabels31() {run_case("MassageOrLabels31.glue",true);}
// MassageOrLabels32.glue
test bool test_MassageOrLabels32() = run_case("MassageOrLabels32.glue",false);
void show_MassageOrLabels32() {run_case("MassageOrLabels32.glue",true);}
// MassageOrLabels33.glue
test bool test_MassageOrLabels33() = run_case("MassageOrLabels33.glue",false);
void show_MassageOrLabels33() {run_case("MassageOrLabels33.glue",true);}
// MassageOrLabels34.glue
test bool test_MassageOrLabels34() = run_case("MassageOrLabels34.glue",false);
void show_MassageOrLabels34() {run_case("MassageOrLabels34.glue",true);}
// SLEIR:MassageOrMarks2: 4 tests
// MassageOrMarks21.glue
test bool test_MassageOrMarks21() = run_case("MassageOrMarks21.glue",false);
void show_MassageOrMarks21() {run_case("MassageOrMarks21.glue",true);}
// MassageOrMarks22.glue
test bool test_MassageOrMarks22() = run_case("MassageOrMarks22.glue",false);
void show_MassageOrMarks22() {run_case("MassageOrMarks22.glue",true);}
// MassageOrMarks23.glue
test bool test_MassageOrMarks23() = run_case("MassageOrMarks23.glue",false);
void show_MassageOrMarks23() {run_case("MassageOrMarks23.glue",true);}
// MassageOrMarks24.glue
test bool test_MassageOrMarks24() = run_case("MassageOrMarks24.glue",false);
void show_MassageOrMarks24() {run_case("MassageOrMarks24.glue",true);}
// SLEIR:MassageOrMarks3: 4 tests
// MassageOrMarks31.glue
test bool test_MassageOrMarks31() = run_case("MassageOrMarks31.glue",false);
void show_MassageOrMarks31() {run_case("MassageOrMarks31.glue",true);}
// MassageOrMarks32.glue
test bool test_MassageOrMarks32() = run_case("MassageOrMarks32.glue",false);
void show_MassageOrMarks32() {run_case("MassageOrMarks32.glue",true);}
// MassageOrMarks33.glue
test bool test_MassageOrMarks33() = run_case("MassageOrMarks33.glue",false);
void show_MassageOrMarks33() {run_case("MassageOrMarks33.glue",true);}
// MassageOrMarks34.glue
test bool test_MassageOrMarks34() = run_case("MassageOrMarks34.glue",false);
void show_MassageOrMarks34() {run_case("MassageOrMarks34.glue",true);}
// SLEIR:MassageOrNotXY2NotAndXY: 2 tests
// MassageOrNotXY2NotAndXY1.glue
test bool test_MassageOrNotXY2NotAndXY1() = run_case("MassageOrNotXY2NotAndXY1.glue",false);
void show_MassageOrNotXY2NotAndXY1() {run_case("MassageOrNotXY2NotAndXY1.glue",true);}
// MassageOrNotXY2NotAndXY2.glue
test bool test_MassageOrNotXY2NotAndXY2() = run_case("MassageOrNotXY2NotAndXY2.glue",false);
void show_MassageOrNotXY2NotAndXY2() {run_case("MassageOrNotXY2NotAndXY2.glue",true);}
// SLEIR:MassageOrOptEps: 0 tests

// SLEIR:MassageOrOptX: 0 tests

// SLEIR:MassageOrPlusEps2Star: 3 tests
// MassageOrPlusEps2Star1.glue
test bool test_MassageOrPlusEps2Star1() = run_case("MassageOrPlusEps2Star1.glue",false);
void show_MassageOrPlusEps2Star1() {run_case("MassageOrPlusEps2Star1.glue",true);}
// MassageOrPlusEps2Star2.glue
test bool test_MassageOrPlusEps2Star2() = run_case("MassageOrPlusEps2Star2.glue",false);
void show_MassageOrPlusEps2Star2() {run_case("MassageOrPlusEps2Star2.glue",true);}
// MassageOrPlusEps2Star3.glue
test bool test_MassageOrPlusEps2Star3() = run_case("MassageOrPlusEps2Star3.glue",false);
void show_MassageOrPlusEps2Star3() {run_case("MassageOrPlusEps2Star3.glue",true);}
// SLEIR:MassageOrPlusOpt2Star: 3 tests
// MassageOrPlusOpt2Star1.glue
test bool test_MassageOrPlusOpt2Star1() = run_case("MassageOrPlusOpt2Star1.glue",false);
void show_MassageOrPlusOpt2Star1() {run_case("MassageOrPlusOpt2Star1.glue",true);}
// MassageOrPlusOpt2Star2.glue
test bool test_MassageOrPlusOpt2Star2() = run_case("MassageOrPlusOpt2Star2.glue",false);
void show_MassageOrPlusOpt2Star2() {run_case("MassageOrPlusOpt2Star2.glue",true);}
// MassageOrPlusOpt2Star3.glue
test bool test_MassageOrPlusOpt2Star3() = run_case("MassageOrPlusOpt2Star3.glue",false);
void show_MassageOrPlusOpt2Star3() {run_case("MassageOrPlusOpt2Star3.glue",true);}
// SLEIR:MassageOrPlusX: 0 tests

// SLEIR:MassageOrStar: 0 tests

// SLEIR:MassageOrStarEps: 0 tests

// SLEIR:MassageOrStarOpt: 0 tests

// SLEIR:MassageOrStarPlus: 0 tests

// SLEIR:MassageOrXEps2Opt: 2 tests
// MassageOrXEps2Opt1.glue
test bool test_MassageOrXEps2Opt1() = run_case("MassageOrXEps2Opt1.glue",false);
void show_MassageOrXEps2Opt1() {run_case("MassageOrXEps2Opt1.glue",true);}
// MassageOrXEps2Opt2.glue
test bool test_MassageOrXEps2Opt2() = run_case("MassageOrXEps2Opt2.glue",false);
void show_MassageOrXEps2Opt2() {run_case("MassageOrXEps2Opt2.glue",true);}
// SLEIR:MassageOrXPlus: 0 tests

// SLEIR:MassageOrXY2NotAndNotXY: 2 tests
// MassageOrXY2NotAndNotXY1.glue
test bool test_MassageOrXY2NotAndNotXY1() = run_case("MassageOrXY2NotAndNotXY1.glue",false);
void show_MassageOrXY2NotAndNotXY1() {run_case("MassageOrXY2NotAndNotXY1.glue",true);}
// MassageOrXY2NotAndNotXY2.glue
test bool test_MassageOrXY2NotAndNotXY2() = run_case("MassageOrXY2NotAndNotXY2.glue",false);
void show_MassageOrXY2NotAndNotXY2() {run_case("MassageOrXY2NotAndNotXY2.glue",true);}
// SLEIR:MassagePlus2SeqStarX: 0 tests

// SLEIR:MassagePlus2SeqXStar: 0 tests

// SLEIR:MassagePlusLabel2LabelPlus: 2 tests
// MassagePlusLabel2LabelPlus1.glue
test bool test_MassagePlusLabel2LabelPlus1() = run_case("MassagePlusLabel2LabelPlus1.glue",false);
void show_MassagePlusLabel2LabelPlus1() {run_case("MassagePlusLabel2LabelPlus1.glue",true);}
// MassagePlusLabel2LabelPlus2.glue
test bool test_MassagePlusLabel2LabelPlus2() = run_case("MassagePlusLabel2LabelPlus2.glue",false);
void show_MassagePlusLabel2LabelPlus2() {run_case("MassagePlusLabel2LabelPlus2.glue",true);}
// SLEIR:MassagePlusMark2MarkPlus: 2 tests
// MassagePlusMark2MarkPlus1.glue
test bool test_MassagePlusMark2MarkPlus1() = run_case("MassagePlusMark2MarkPlus1.glue",false);
void show_MassagePlusMark2MarkPlus1() {run_case("MassagePlusMark2MarkPlus1.glue",true);}
// MassagePlusMark2MarkPlus2.glue
test bool test_MassagePlusMark2MarkPlus2() = run_case("MassagePlusMark2MarkPlus2.glue",false);
void show_MassagePlusMark2MarkPlus2() {run_case("MassagePlusMark2MarkPlus2.glue",true);}
// SLEIR:MassagePlusOpt2Star: 2 tests
// MassagePlusOpt2Star1.glue
test bool test_MassagePlusOpt2Star1() = run_case("MassagePlusOpt2Star1.glue",false);
void show_MassagePlusOpt2Star1() {run_case("MassagePlusOpt2Star1.glue",true);}
// MassagePlusOpt2Star2.glue
test bool test_MassagePlusOpt2Star2() = run_case("MassagePlusOpt2Star2.glue",false);
void show_MassagePlusOpt2Star2() {run_case("MassagePlusOpt2Star2.glue",true);}
// SLEIR:MassagePlusPlus: 2 tests
// MassagePlusPlus1.glue
test bool test_MassagePlusPlus1() = run_case("MassagePlusPlus1.glue",false);
void show_MassagePlusPlus1() {run_case("MassagePlusPlus1.glue",true);}
// MassagePlusPlus2.glue
test bool test_MassagePlusPlus2() = run_case("MassagePlusPlus2.glue",false);
void show_MassagePlusPlus2() {run_case("MassagePlusPlus2.glue",true);}
// SLEIR:MassagePlusStar: 2 tests
// MassagePlusStar1.glue
test bool test_MassagePlusStar1() = run_case("MassagePlusStar1.glue",false);
void show_MassagePlusStar1() {run_case("MassagePlusStar1.glue",true);}
// MassagePlusStar2.glue
test bool test_MassagePlusStar2() = run_case("MassagePlusStar2.glue",false);
void show_MassagePlusStar2() {run_case("MassagePlusStar2.glue",true);}
// SLEIR:MassageSLPlus2SeqStarX: 0 tests

// SLEIR:MassageSLPlus2SeqXStar: 0 tests

// SLEIR:MassageSLStar2OptSLPlus: 2 tests
// MassageSLStar2OptSLPlus1.glue
test bool test_MassageSLStar2OptSLPlus1() = run_case("MassageSLStar2OptSLPlus1.glue",false);
void show_MassageSLStar2OptSLPlus1() {run_case("MassageSLStar2OptSLPlus1.glue",true);}
// MassageSLStar2OptSLPlus2.glue
test bool test_MassageSLStar2OptSLPlus2() = run_case("MassageSLStar2OptSLPlus2.glue",false);
void show_MassageSLStar2OptSLPlus2() {run_case("MassageSLStar2OptSLPlus2.glue",true);}
// SLEIR:MassageSLStar2OptSeqStarX: 2 tests
// MassageSLStar2OptSeqStarX1.glue
test bool test_MassageSLStar2OptSeqStarX1() = run_case("MassageSLStar2OptSeqStarX1.glue",false);
void show_MassageSLStar2OptSeqStarX1() {run_case("MassageSLStar2OptSeqStarX1.glue",true);}
// MassageSLStar2OptSeqStarX2.glue
test bool test_MassageSLStar2OptSeqStarX2() = run_case("MassageSLStar2OptSeqStarX2.glue",false);
void show_MassageSLStar2OptSeqStarX2() {run_case("MassageSLStar2OptSeqStarX2.glue",true);}
// SLEIR:MassageSLStar2OptSeqXStar: 2 tests
// MassageSLStar2OptSeqXStar1.glue
test bool test_MassageSLStar2OptSeqXStar1() = run_case("MassageSLStar2OptSeqXStar1.glue",false);
void show_MassageSLStar2OptSeqXStar1() {run_case("MassageSLStar2OptSeqXStar1.glue",true);}
// MassageSLStar2OptSeqXStar2.glue
test bool test_MassageSLStar2OptSeqXStar2() = run_case("MassageSLStar2OptSeqXStar2.glue",false);
void show_MassageSLStar2OptSeqXStar2() {run_case("MassageSLStar2OptSeqXStar2.glue",true);}
// SLEIR:MassageSeqOptPlus: 2 tests
// MassageSeqOptPlus1.glue
test bool test_MassageSeqOptPlus1() = run_case("MassageSeqOptPlus1.glue",false);
void show_MassageSeqOptPlus1() {run_case("MassageSeqOptPlus1.glue",true);}
// MassageSeqOptPlus2.glue
test bool test_MassageSeqOptPlus2() = run_case("MassageSeqOptPlus2.glue",false);
void show_MassageSeqOptPlus2() {run_case("MassageSeqOptPlus2.glue",true);}
// SLEIR:MassageSeqOptStar: 2 tests
// MassageSeqOptStar1.glue
test bool test_MassageSeqOptStar1() = run_case("MassageSeqOptStar1.glue",false);
void show_MassageSeqOptStar1() {run_case("MassageSeqOptStar1.glue",true);}
// MassageSeqOptStar2.glue
test bool test_MassageSeqOptStar2() = run_case("MassageSeqOptStar2.glue",false);
void show_MassageSeqOptStar2() {run_case("MassageSeqOptStar2.glue",true);}
// SLEIR:MassageSeqOptX2SeqXOpt: 0 tests

// SLEIR:MassageSeqPlusOpt: 2 tests
// MassageSeqPlusOpt1.glue
test bool test_MassageSeqPlusOpt1() = run_case("MassageSeqPlusOpt1.glue",false);
void show_MassageSeqPlusOpt1() {run_case("MassageSeqPlusOpt1.glue",true);}
// MassageSeqPlusOpt2.glue
test bool test_MassageSeqPlusOpt2() = run_case("MassageSeqPlusOpt2.glue",false);
void show_MassageSeqPlusOpt2() {run_case("MassageSeqPlusOpt2.glue",true);}
// SLEIR:MassageSeqPlusStar: 0 tests

// SLEIR:MassageSeqPlusX2SeqXPlus: 0 tests

// SLEIR:MassageSeqStarOpt: 0 tests

// SLEIR:MassageSeqStarPlus: 0 tests

// SLEIR:MassageSeqStarStar: 0 tests

// SLEIR:MassageSeqStarX2Plus: 0 tests

// SLEIR:MassageSeqStarX2SLPlus: 0 tests

// SLEIR:MassageSeqStarX2SeqXStar: 0 tests

// SLEIR:MassageSeqXOpt2SeqOptX: 0 tests

// SLEIR:MassageSeqXPlus2SeqPlusX: 0 tests

// SLEIR:MassageSeqXStar2Plus: 0 tests

// SLEIR:MassageSeqXStar2SLPlus: 0 tests

// SLEIR:MassageSeqXStar2SeqStarX: 0 tests

// SLEIR:MassageStar2OptPlus: 2 tests
// MassageStar2OptPlus1.glue
test bool test_MassageStar2OptPlus1() = run_case("MassageStar2OptPlus1.glue",false);
void show_MassageStar2OptPlus1() {run_case("MassageStar2OptPlus1.glue",true);}
// MassageStar2OptPlus2.glue
test bool test_MassageStar2OptPlus2() = run_case("MassageStar2OptPlus2.glue",false);
void show_MassageStar2OptPlus2() {run_case("MassageStar2OptPlus2.glue",true);}
// SLEIR:MassageStar2OrPlusEps: 2 tests
// MassageStar2OrPlusEps1.glue
test bool test_MassageStar2OrPlusEps1() = run_case("MassageStar2OrPlusEps1.glue",false);
void show_MassageStar2OrPlusEps1() {run_case("MassageStar2OrPlusEps1.glue",true);}
// MassageStar2OrPlusEps2.glue
test bool test_MassageStar2OrPlusEps2() = run_case("MassageStar2OrPlusEps2.glue",false);
void show_MassageStar2OrPlusEps2() {run_case("MassageStar2OrPlusEps2.glue",true);}
// SLEIR:MassageStar2OrPlusOpt: 2 tests
// MassageStar2OrPlusOpt1.glue
test bool test_MassageStar2OrPlusOpt1() = run_case("MassageStar2OrPlusOpt1.glue",false);
void show_MassageStar2OrPlusOpt1() {run_case("MassageStar2OrPlusOpt1.glue",true);}
// MassageStar2OrPlusOpt2.glue
test bool test_MassageStar2OrPlusOpt2() = run_case("MassageStar2OrPlusOpt2.glue",false);
void show_MassageStar2OrPlusOpt2() {run_case("MassageStar2OrPlusOpt2.glue",true);}
// SLEIR:MassageStar2PlusOpt: 2 tests
// MassageStar2PlusOpt1.glue
test bool test_MassageStar2PlusOpt1() = run_case("MassageStar2PlusOpt1.glue",false);
void show_MassageStar2PlusOpt1() {run_case("MassageStar2PlusOpt1.glue",true);}
// MassageStar2PlusOpt2.glue
test bool test_MassageStar2PlusOpt2() = run_case("MassageStar2PlusOpt2.glue",false);
void show_MassageStar2PlusOpt2() {run_case("MassageStar2PlusOpt2.glue",true);}
// SLEIR:MassageStarLabel2LabelStar: 2 tests
// MassageStarLabel2LabelStar1.glue
test bool test_MassageStarLabel2LabelStar1() = run_case("MassageStarLabel2LabelStar1.glue",false);
void show_MassageStarLabel2LabelStar1() {run_case("MassageStarLabel2LabelStar1.glue",true);}
// MassageStarLabel2LabelStar2.glue
test bool test_MassageStarLabel2LabelStar2() = run_case("MassageStarLabel2LabelStar2.glue",false);
void show_MassageStarLabel2LabelStar2() {run_case("MassageStarLabel2LabelStar2.glue",true);}
// SLEIR:MassageStarMark2MarkStar: 2 tests
// MassageStarMark2MarkStar1.glue
test bool test_MassageStarMark2MarkStar1() = run_case("MassageStarMark2MarkStar1.glue",false);
void show_MassageStarMark2MarkStar1() {run_case("MassageStarMark2MarkStar1.glue",true);}
// MassageStarMark2MarkStar2.glue
test bool test_MassageStarMark2MarkStar2() = run_case("MassageStarMark2MarkStar2.glue",false);
void show_MassageStarMark2MarkStar2() {run_case("MassageStarMark2MarkStar2.glue",true);}
// SLEIR:MassageStarOpt: 2 tests
// MassageStarOpt1.glue
test bool test_MassageStarOpt1() = run_case("MassageStarOpt1.glue",false);
void show_MassageStarOpt1() {run_case("MassageStarOpt1.glue",true);}
// MassageStarOpt2.glue
test bool test_MassageStarOpt2() = run_case("MassageStarOpt2.glue",false);
void show_MassageStarOpt2() {run_case("MassageStarOpt2.glue",true);}
// SLEIR:MassageStarPlus: 2 tests
// MassageStarPlus1.glue
test bool test_MassageStarPlus1() = run_case("MassageStarPlus1.glue",false);
void show_MassageStarPlus1() {run_case("MassageStarPlus1.glue",true);}
// MassageStarPlus2.glue
test bool test_MassageStarPlus2() = run_case("MassageStarPlus2.glue",false);
void show_MassageStarPlus2() {run_case("MassageStarPlus2.glue",true);}
// SLEIR:MassageStarStar: 2 tests
// MassageStarStar1.glue
test bool test_MassageStarStar1() = run_case("MassageStarStar1.glue",false);
void show_MassageStarStar1() {run_case("MassageStarStar1.glue",true);}
// MassageStarStar2.glue
test bool test_MassageStarStar2() = run_case("MassageStarStar2.glue",false);
void show_MassageStarStar2() {run_case("MassageStarStar2.glue",true);}
// SLEIR:NarrowOpt2X: 2 tests
// NarrowOpt2X1.glue
test bool test_NarrowOpt2X1() = run_case("NarrowOpt2X1.glue",false);
void show_NarrowOpt2X1() {run_case("NarrowOpt2X1.glue",true);}
// NarrowOpt2X2.glue
test bool test_NarrowOpt2X2() = run_case("NarrowOpt2X2.glue",false);
void show_NarrowOpt2X2() {run_case("NarrowOpt2X2.glue",true);}
// SLEIR:NarrowPlus2X: 2 tests
// NarrowPlus2X1.glue
test bool test_NarrowPlus2X1() = run_case("NarrowPlus2X1.glue",false);
void show_NarrowPlus2X1() {run_case("NarrowPlus2X1.glue",true);}
// NarrowPlus2X2.glue
test bool test_NarrowPlus2X2() = run_case("NarrowPlus2X2.glue",false);
void show_NarrowPlus2X2() {run_case("NarrowPlus2X2.glue",true);}
// SLEIR:NarrowStar2Opt: 2 tests
// NarrowStar2Opt1.glue
test bool test_NarrowStar2Opt1() = run_case("NarrowStar2Opt1.glue",false);
void show_NarrowStar2Opt1() {run_case("NarrowStar2Opt1.glue",true);}
// NarrowStar2Opt2.glue
test bool test_NarrowStar2Opt2() = run_case("NarrowStar2Opt2.glue",false);
void show_NarrowStar2Opt2() {run_case("NarrowStar2Opt2.glue",true);}
// SLEIR:NarrowStar2Plus: 2 tests
// NarrowStar2Plus1.glue
test bool test_NarrowStar2Plus1() = run_case("NarrowStar2Plus1.glue",false);
void show_NarrowStar2Plus1() {run_case("NarrowStar2Plus1.glue",true);}
// NarrowStar2Plus2.glue
test bool test_NarrowStar2Plus2() = run_case("NarrowStar2Plus2.glue",false);
void show_NarrowStar2Plus2() {run_case("NarrowStar2Plus2.glue",true);}
// SLEIR:NarrowStar2X: 2 tests
// NarrowStar2X1.glue
test bool test_NarrowStar2X1() = run_case("NarrowStar2X1.glue",false);
void show_NarrowStar2X1() {run_case("NarrowStar2X1.glue",true);}
// NarrowStar2X2.glue
test bool test_NarrowStar2X2() = run_case("NarrowStar2X2.glue",false);
void show_NarrowStar2X2() {run_case("NarrowStar2X2.glue",true);}
// SLEIR:ParenthesizeAll: 0 tests

// SLEIR:PermuteInfix2Postfix: 2 tests
// PermuteInfix2Postfix1.glue
test bool test_PermuteInfix2Postfix1() = run_case("PermuteInfix2Postfix1.glue",false);
void show_PermuteInfix2Postfix1() {run_case("PermuteInfix2Postfix1.glue",true);}
// PermuteInfix2Postfix2.glue
test bool test_PermuteInfix2Postfix2() = run_case("PermuteInfix2Postfix2.glue",false);
void show_PermuteInfix2Postfix2() {run_case("PermuteInfix2Postfix2.glue",true);}
// SLEIR:PermuteInfix2Prefix: 2 tests
// PermuteInfix2Prefix1.glue
test bool test_PermuteInfix2Prefix1() = run_case("PermuteInfix2Prefix1.glue",false);
void show_PermuteInfix2Prefix1() {run_case("PermuteInfix2Prefix1.glue",true);}
// PermuteInfix2Prefix2.glue
test bool test_PermuteInfix2Prefix2() = run_case("PermuteInfix2Prefix2.glue",false);
void show_PermuteInfix2Prefix2() {run_case("PermuteInfix2Prefix2.glue",true);}
// SLEIR:PermutePostfix2Infix: 2 tests
// PermutePostfix2Infix1.glue
test bool test_PermutePostfix2Infix1() = run_case("PermutePostfix2Infix1.glue",false);
void show_PermutePostfix2Infix1() {run_case("PermutePostfix2Infix1.glue",true);}
// PermutePostfix2Infix2.glue
test bool test_PermutePostfix2Infix2() = run_case("PermutePostfix2Infix2.glue",false);
void show_PermutePostfix2Infix2() {run_case("PermutePostfix2Infix2.glue",true);}
// SLEIR:PermutePostfix2Prefix: 2 tests
// PermutePostfix2Prefix1.glue
test bool test_PermutePostfix2Prefix1() = run_case("PermutePostfix2Prefix1.glue",false);
void show_PermutePostfix2Prefix1() {run_case("PermutePostfix2Prefix1.glue",true);}
// PermutePostfix2Prefix2.glue
test bool test_PermutePostfix2Prefix2() = run_case("PermutePostfix2Prefix2.glue",false);
void show_PermutePostfix2Prefix2() {run_case("PermutePostfix2Prefix2.glue",true);}
// SLEIR:PermutePrefix2Infix: 2 tests
// PermutePrefix2Infix1.glue
test bool test_PermutePrefix2Infix1() = run_case("PermutePrefix2Infix1.glue",false);
void show_PermutePrefix2Infix1() {run_case("PermutePrefix2Infix1.glue",true);}
// PermutePrefix2Infix2.glue
test bool test_PermutePrefix2Infix2() = run_case("PermutePrefix2Infix2.glue",false);
void show_PermutePrefix2Infix2() {run_case("PermutePrefix2Infix2.glue",true);}
// SLEIR:PermutePrefix2Postfix: 2 tests
// PermutePrefix2Postfix1.glue
test bool test_PermutePrefix2Postfix1() = run_case("PermutePrefix2Postfix1.glue",false);
void show_PermutePrefix2Postfix1() {run_case("PermutePrefix2Postfix1.glue",true);}
// PermutePrefix2Postfix2.glue
test bool test_PermutePrefix2Postfix2() = run_case("PermutePrefix2Postfix2.glue",false);
void show_PermutePrefix2Postfix2() {run_case("PermutePrefix2Postfix2.glue",true);}
// SLEIR:RAssocAll: 0 tests

// SLEIR:Reroot2top: 5 tests
// Reroot2top1.glue
test bool test_Reroot2top1() = run_case("Reroot2top1.glue",false);
void show_Reroot2top1() {run_case("Reroot2top1.glue",true);}
// Reroot2top2.glue
test bool test_Reroot2top2() = run_case("Reroot2top2.glue",false);
void show_Reroot2top2() {run_case("Reroot2top2.glue",true);}
// Reroot2top3.glue
test bool test_Reroot2top3() = run_case("Reroot2top3.glue",false);
void show_Reroot2top3() {run_case("Reroot2top3.glue",true);}
// Reroot2top4.glue
test bool test_Reroot2top4() = run_case("Reroot2top4.glue",false);
void show_Reroot2top4() {run_case("Reroot2top4.glue",true);}
// Reroot2top5.glue
test bool test_Reroot2top5() = run_case("Reroot2top5.glue",false);
void show_Reroot2top5() {run_case("Reroot2top5.glue",true);}
// SLEIR:RetireLs: 7 tests
// RetireLs1.glue
test bool test_RetireLs1() = run_case("RetireLs1.glue",false);
void show_RetireLs1() {run_case("RetireLs1.glue",true);}
// RetireLs2.glue
test bool test_RetireLs2() = run_case("RetireLs2.glue",false);
void show_RetireLs2() {run_case("RetireLs2.glue",true);}
// RetireLs3.glue
test bool test_RetireLs3() = run_case("RetireLs3.glue",false);
void show_RetireLs3() {run_case("RetireLs3.glue",true);}
// RetireLs4.glue
test bool test_RetireLs4() = run_case("RetireLs4.glue",false);
void show_RetireLs4() {run_case("RetireLs4.glue",true);}
// RetireLs5.glue
test bool test_RetireLs5() = run_case("RetireLs5.glue",false);
void show_RetireLs5() {run_case("RetireLs5.glue",true);}
// RetireLs6.glue
test bool test_RetireLs6() = run_case("RetireLs6.glue",false);
void show_RetireLs6() {run_case("RetireLs6.glue",true);}
// RetireLs7.glue
test bool test_RetireLs7() = run_case("RetireLs7.glue",false);
void show_RetireLs7() {run_case("RetireLs7.glue",true);}
// SLEIR:RetireMs: 8 tests
// RetireMs1.glue
test bool test_RetireMs1() = run_case("RetireMs1.glue",false);
void show_RetireMs1() {run_case("RetireMs1.glue",true);}
// RetireMs2.glue
test bool test_RetireMs2() = run_case("RetireMs2.glue",false);
void show_RetireMs2() {run_case("RetireMs2.glue",true);}
// RetireMs3.glue
test bool test_RetireMs3() = run_case("RetireMs3.glue",false);
void show_RetireMs3() {run_case("RetireMs3.glue",true);}
// RetireMs4.glue
test bool test_RetireMs4() = run_case("RetireMs4.glue",false);
void show_RetireMs4() {run_case("RetireMs4.glue",true);}
// RetireMs5.glue
test bool test_RetireMs5() = run_case("RetireMs5.glue",false);
void show_RetireMs5() {run_case("RetireMs5.glue",true);}
// RetireMs6.glue
test bool test_RetireMs6() = run_case("RetireMs6.glue",false);
void show_RetireMs6() {run_case("RetireMs6.glue",true);}
// RetireMs7.glue
test bool test_RetireMs7() = run_case("RetireMs7.glue",false);
void show_RetireMs7() {run_case("RetireMs7.glue",true);}
// RetireMs8.glue
test bool test_RetireMs8() = run_case("RetireMs8.glue",false);
void show_RetireMs8() {run_case("RetireMs8.glue",true);}
// SLEIR:RetireTs: 9 tests
// RetireTs1.glue
test bool test_RetireTs1() = run_case("RetireTs1.glue",false);
void show_RetireTs1() {run_case("RetireTs1.glue",true);}
// RetireTs2.glue
test bool test_RetireTs2() = run_case("RetireTs2.glue",false);
void show_RetireTs2() {run_case("RetireTs2.glue",true);}
// RetireTs3.glue
test bool test_RetireTs3() = run_case("RetireTs3.glue",false);
void show_RetireTs3() {run_case("RetireTs3.glue",true);}
// RetireTs4.glue
test bool test_RetireTs4() = run_case("RetireTs4.glue",false);
void show_RetireTs4() {run_case("RetireTs4.glue",true);}
// RetireTs5.glue
test bool test_RetireTs5() = run_case("RetireTs5.glue",false);
void show_RetireTs5() {run_case("RetireTs5.glue",true);}
// RetireTs6.glue
test bool test_RetireTs6() = run_case("RetireTs6.glue",false);
void show_RetireTs6() {run_case("RetireTs6.glue",true);}
// RetireTs7.glue
test bool test_RetireTs7() = run_case("RetireTs7.glue",false);
void show_RetireTs7() {run_case("RetireTs7.glue",true);}
// RetireTs8.glue
test bool test_RetireTs8() = run_case("RetireTs8.glue",false);
void show_RetireTs8() {run_case("RetireTs8.glue",true);}
// RetireTs9.glue
test bool test_RetireTs9() = run_case("RetireTs9.glue",false);
void show_RetireTs9() {run_case("RetireTs9.glue",true);}
// SLEIR:SplitAllT: 8 tests
// SplitAllT1.glue
test bool test_SplitAllT1() = run_case("SplitAllT1.glue",false);
void show_SplitAllT1() {run_case("SplitAllT1.glue",true);}
// SplitAllT2.glue
test bool test_SplitAllT2() = run_case("SplitAllT2.glue",false);
void show_SplitAllT2() {run_case("SplitAllT2.glue",true);}
// SplitAllT3.glue
test bool test_SplitAllT3() = run_case("SplitAllT3.glue",false);
void show_SplitAllT3() {run_case("SplitAllT3.glue",true);}
// SplitAllT4.glue
test bool test_SplitAllT4() = run_case("SplitAllT4.glue",false);
void show_SplitAllT4() {run_case("SplitAllT4.glue",true);}
// SplitAllT5.glue
test bool test_SplitAllT5() = run_case("SplitAllT5.glue",false);
void show_SplitAllT5() {run_case("SplitAllT5.glue",true);}
// SplitAllT6.glue
test bool test_SplitAllT6() = run_case("SplitAllT6.glue",false);
void show_SplitAllT6() {run_case("SplitAllT6.glue",true);}
// SplitAllT7.glue
test bool test_SplitAllT7() = run_case("SplitAllT7.glue",false);
void show_SplitAllT7() {run_case("SplitAllT7.glue",true);}
// SplitAllT8.glue
test bool test_SplitAllT8() = run_case("SplitAllT8.glue",false);
void show_SplitAllT8() {run_case("SplitAllT8.glue",true);}
// SLEIR:UnchainAll: 0 tests

// SLEIR:UndefineTrivial: 5 tests
// UndefineTrivial1.glue
test bool test_UndefineTrivial1() = run_case("UndefineTrivial1.glue",false);
void show_UndefineTrivial1() {run_case("UndefineTrivial1.glue",true);}
// UndefineTrivial2.glue
test bool test_UndefineTrivial2() = run_case("UndefineTrivial2.glue",false);
void show_UndefineTrivial2() {run_case("UndefineTrivial2.glue",true);}
// UndefineTrivial3.glue
test bool test_UndefineTrivial3() = run_case("UndefineTrivial3.glue",false);
void show_UndefineTrivial3() {run_case("UndefineTrivial3.glue",true);}
// UndefineTrivial4.glue
test bool test_UndefineTrivial4() = run_case("UndefineTrivial4.glue",false);
void show_UndefineTrivial4() {run_case("UndefineTrivial4.glue",true);}
// UndefineTrivial5.glue
test bool test_UndefineTrivial5() = run_case("UndefineTrivial5.glue",false);
void show_UndefineTrivial5() {run_case("UndefineTrivial5.glue",true);}
// SLEIR:UnfoldMax: 5 tests
// UnfoldMax1.glue
test bool test_UnfoldMax1() = run_case("UnfoldMax1.glue",false);
void show_UnfoldMax1() {run_case("UnfoldMax1.glue",true);}
// UnfoldMax2.glue
test bool test_UnfoldMax2() = run_case("UnfoldMax2.glue",false);
void show_UnfoldMax2() {run_case("UnfoldMax2.glue",true);}
// UnfoldMax3.glue
test bool test_UnfoldMax3() = run_case("UnfoldMax3.glue",false);
void show_UnfoldMax3() {run_case("UnfoldMax3.glue",true);}
// UnfoldMax4.glue
test bool test_UnfoldMax4() = run_case("UnfoldMax4.glue",false);
void show_UnfoldMax4() {run_case("UnfoldMax4.glue",true);}
// UnfoldMax5.glue
test bool test_UnfoldMax5() = run_case("UnfoldMax5.glue",false);
void show_UnfoldMax5() {run_case("UnfoldMax5.glue",true);}
// SLEIR:VerticalAll: 6 tests
// VerticalAll1.glue
test bool test_VerticalAll1() = run_case("VerticalAll1.glue",false);
void show_VerticalAll1() {run_case("VerticalAll1.glue",true);}
// VerticalAll2.glue
test bool test_VerticalAll2() = run_case("VerticalAll2.glue",false);
void show_VerticalAll2() {run_case("VerticalAll2.glue",true);}
// VerticalAll3.glue
test bool test_VerticalAll3() = run_case("VerticalAll3.glue",false);
void show_VerticalAll3() {run_case("VerticalAll3.glue",true);}
// VerticalAll4.glue
test bool test_VerticalAll4() = run_case("VerticalAll4.glue",false);
void show_VerticalAll4() {run_case("VerticalAll4.glue",true);}
// VerticalAll5.glue
test bool test_VerticalAll5() = run_case("VerticalAll5.glue",false);
void show_VerticalAll5() {run_case("VerticalAll5.glue",true);}
// VerticalAll6.glue
test bool test_VerticalAll6() = run_case("VerticalAll6.glue",false);
void show_VerticalAll6() {run_case("VerticalAll6.glue",true);}
// SLEIR:WidenOpt2Star: 2 tests
// WidenOpt2Star1.glue
test bool test_WidenOpt2Star1() = run_case("WidenOpt2Star1.glue",false);
void show_WidenOpt2Star1() {run_case("WidenOpt2Star1.glue",true);}
// WidenOpt2Star2.glue
test bool test_WidenOpt2Star2() = run_case("WidenOpt2Star2.glue",false);
void show_WidenOpt2Star2() {run_case("WidenOpt2Star2.glue",true);}
// SLEIR:WidenPlus2Star: 2 tests
// WidenPlus2Star1.glue
test bool test_WidenPlus2Star1() = run_case("WidenPlus2Star1.glue",false);
void show_WidenPlus2Star1() {run_case("WidenPlus2Star1.glue",true);}
// WidenPlus2Star2.glue
test bool test_WidenPlus2Star2() = run_case("WidenPlus2Star2.glue",false);
void show_WidenPlus2Star2() {run_case("WidenPlus2Star2.glue",true);}
// SLEIR:YaccifyAllL: 0 tests

// SLEIR:YaccifyAllR: 0 tests

