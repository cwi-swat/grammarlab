@contributor{Super Awesome Automated SLEIR Test Suite Synchroniser}
@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
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
// SLEIR:ChainMixed: 0 tests

// SLEIR:ConcatAllT: 0 tests

// SLEIR:DefineMin: 0 tests

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
// SLEIR:DistributeAll: 0 tests

// SLEIR:EliminateTop: 0 tests

// SLEIR:EquateAll: 0 tests

// SLEIR:FoldMax: 0 tests

// SLEIR:HorizontalAll: 0 tests

// SLEIR:InlineMax: 0 tests

// SLEIR:InlinePlus: 0 tests

// SLEIR:InsertLayout: 0 tests

// SLEIR:IterateXX: 0 tests

// SLEIR:IterateXYXLeft: 0 tests

// SLEIR:IterateXYXRight: 0 tests

// SLEIR:LAssocAll: 0 tests

// SLEIR:LiftTopLabels: 0 tests

// SLEIR:MassageAndNot2Except: 0 tests

// SLEIR:MassageAndNotXY2NotOrXY: 0 tests

// SLEIR:MassageAndNotYX2NotOrXY: 0 tests

// SLEIR:MassageAndXY2NotOrNotXY: 0 tests

// SLEIR:MassageAndYX2NotOrNotXY: 0 tests

// SLEIR:MassageExcept2AndNot: 0 tests

// SLEIR:MassageLabelNot2NotLabel: 0 tests

// SLEIR:MassageLabelOpt2OptLabel: 0 tests

// SLEIR:MassageLabelPlus2PlusLabel: 0 tests

// SLEIR:MassageLabelStar2StarLabel: 0 tests

// SLEIR:MassageMarkNot2NotMark: 0 tests

// SLEIR:MassageMarkOpt2OptMark: 0 tests

// SLEIR:MassageMarkPlus2PlusMark: 0 tests

// SLEIR:MassageMarkStar2StarMark: 0 tests

// SLEIR:MassageNotAndNotXY2OrXY: 0 tests

// SLEIR:MassageNotAndNotXY2OrYX: 0 tests

// SLEIR:MassageNotAndXY2OrNotXY: 0 tests

// SLEIR:MassageNotAndXY2OrNotYX: 0 tests

// SLEIR:MassageNotLabel2LabelNot: 0 tests

// SLEIR:MassageNotMark2MarkNot: 0 tests

// SLEIR:MassageNotNot2X: 0 tests

// SLEIR:MassageNotOrNotXY2AndXY: 0 tests

// SLEIR:MassageNotOrNotXY2AndYX: 0 tests

// SLEIR:MassageNotOrXY2AndNotXY: 0 tests

// SLEIR:MassageNotOrXY2AndNotYX: 0 tests

// SLEIR:MassageOpt2OptOpt: 0 tests

// SLEIR:MassageOpt2OrEpsOpt: 0 tests

// SLEIR:MassageOpt2OrEpsX: 0 tests

// SLEIR:MassageOpt2OrOptEps: 0 tests

// SLEIR:MassageOpt2OrOptX: 0 tests

// SLEIR:MassageOpt2OrXEps: 0 tests

// SLEIR:MassageOpt2OrXOpt: 0 tests

// SLEIR:MassageOptLabel2LabelOpt: 0 tests

// SLEIR:MassageOptMark2MarkOpt: 0 tests

// SLEIR:MassageOptOpt2Opt: 0 tests

// SLEIR:MassageOptPlus2Star: 0 tests

// SLEIR:MassageOptSLPlus2SLStar: 0 tests

// SLEIR:MassageOptSeqStarX2SLStar: 0 tests

// SLEIR:MassageOptSeqXStar2SLStar: 0 tests

// SLEIR:MassageOptStar2Star: 0 tests

// SLEIR:MassageOr1Star2Star: 0 tests

// SLEIR:MassageOrEpsOpt2Opt: 0 tests

// SLEIR:MassageOrEpsPlus2Star: 0 tests

// SLEIR:MassageOrEpsStar2Star: 0 tests

// SLEIR:MassageOrEpsX2Opt: 0 tests

// SLEIR:MassageOrLabels2: 0 tests

// SLEIR:MassageOrLabels3: 0 tests

// SLEIR:MassageOrMarks2: 0 tests

// SLEIR:MassageOrMarks3: 0 tests

// SLEIR:MassageOrNotXY2NotAndXY: 0 tests

// SLEIR:MassageOrNotYX2NotAndXY: 0 tests

// SLEIR:MassageOrOptEps2Opt: 0 tests

// SLEIR:MassageOrOptPlus2Star: 0 tests

// SLEIR:MassageOrOptStar2Star: 0 tests

// SLEIR:MassageOrOptX2Opt: 0 tests

// SLEIR:MassageOrPlusEps2Star: 0 tests

// SLEIR:MassageOrPlusOpt2Star: 0 tests

// SLEIR:MassageOrPlusStar2Star: 0 tests

// SLEIR:MassageOrPlusX2Plus: 0 tests

// SLEIR:MassageOrStar12Star: 0 tests

// SLEIR:MassageOrStarEps2Star: 0 tests

// SLEIR:MassageOrStarOpt2Star: 0 tests

// SLEIR:MassageOrStarPlus2Star: 0 tests

// SLEIR:MassageOrXEps2Opt: 0 tests

// SLEIR:MassageOrXOpt2Opt: 0 tests

// SLEIR:MassageOrXPlus2Plus: 0 tests

// SLEIR:MassageOrXY2NotAndNotXY: 0 tests

// SLEIR:MassageOrYX2NotAndNotXY: 0 tests

// SLEIR:MassagePlus2OrPlusX: 0 tests

// SLEIR:MassagePlus2OrXPlus: 0 tests

// SLEIR:MassagePlus2PlusPlus: 0 tests

// SLEIR:MassagePlus2SeqOptPlus: 0 tests

// SLEIR:MassagePlus2SeqPlusOpt: 0 tests

// SLEIR:MassagePlus2SeqPlusStar: 0 tests

// SLEIR:MassagePlus2SeqStarPlus: 0 tests

// SLEIR:MassagePlus2SeqStarX: 0 tests

// SLEIR:MassagePlus2SeqXStar: 0 tests

// SLEIR:MassagePlusLabel2LabelPlus: 0 tests

// SLEIR:MassagePlusMark2MarkPlus: 0 tests

// SLEIR:MassagePlusOpt2Star: 0 tests

// SLEIR:MassagePlusPlus2Plus: 0 tests

// SLEIR:MassagePlusStar2Star: 0 tests

// SLEIR:MassageSLPlus2SeqStarX: 0 tests

// SLEIR:MassageSLPlus2SeqXStar: 0 tests

// SLEIR:MassageSLStar2OptSLPlus: 0 tests

// SLEIR:MassageSLStar2OptSeqStarX: 0 tests

// SLEIR:MassageSLStar2OptSeqXStar: 0 tests

// SLEIR:MassageSeqOptPlus2Plus: 0 tests

// SLEIR:MassageSeqOptStar2Star: 0 tests

// SLEIR:MassageSeqOptX2SeqXOpt: 0 tests

// SLEIR:MassageSeqPlusOpt2Plus: 0 tests

// SLEIR:MassageSeqPlusStar2Plus: 0 tests

// SLEIR:MassageSeqPlusX2SeqXPlus: 0 tests

// SLEIR:MassageSeqStarOpt2Star: 0 tests

// SLEIR:MassageSeqStarPlus2Plus: 0 tests

// SLEIR:MassageSeqStarStar2Star: 0 tests

// SLEIR:MassageSeqStarX2Plus: 0 tests

// SLEIR:MassageSeqStarX2SLPlus: 0 tests

// SLEIR:MassageSeqStarX2SeqXStar: 0 tests

// SLEIR:MassageSeqXOpt2SeqOptX: 0 tests

// SLEIR:MassageSeqXPlus2SeqPlusX: 0 tests

// SLEIR:MassageSeqXStar2Plus: 0 tests

// SLEIR:MassageSeqXStar2SLPlus: 0 tests

// SLEIR:MassageSeqXStar2SeqStarX: 0 tests

// SLEIR:MassageStar2OptPlus: 0 tests

// SLEIR:MassageStar2OptStar: 0 tests

// SLEIR:MassageStar2Or1Star: 0 tests

// SLEIR:MassageStar2OrEpsPlus: 0 tests

// SLEIR:MassageStar2OrEpsStar: 0 tests

// SLEIR:MassageStar2OrOptPlus: 0 tests

// SLEIR:MassageStar2OrOptStar: 0 tests

// SLEIR:MassageStar2OrPlusEps: 0 tests

// SLEIR:MassageStar2OrPlusOpt: 0 tests

// SLEIR:MassageStar2OrPlusStar: 0 tests

// SLEIR:MassageStar2OrStar1: 0 tests

// SLEIR:MassageStar2OrStarEps: 0 tests

// SLEIR:MassageStar2OrStarOpt: 0 tests

// SLEIR:MassageStar2OrStarPlus: 0 tests

// SLEIR:MassageStar2PlusOpt: 0 tests

// SLEIR:MassageStar2PlusStar: 0 tests

// SLEIR:MassageStar2SeqOptStar: 0 tests

// SLEIR:MassageStar2SeqStarOpt: 0 tests

// SLEIR:MassageStar2SeqStarStar: 0 tests

// SLEIR:MassageStar2StarOpt: 0 tests

// SLEIR:MassageStar2StarPlus: 0 tests

// SLEIR:MassageStar2StarStar: 0 tests

// SLEIR:MassageStarLabel2LabelStar: 0 tests

// SLEIR:MassageStarMark2MarkStar: 0 tests

// SLEIR:MassageStarOpt2Star: 0 tests

// SLEIR:MassageStarPlus2Star: 0 tests

// SLEIR:MassageStarStar2Star: 0 tests

// SLEIR:MassageX2NotNot: 0 tests

// SLEIR:NarrowOpt2X: 0 tests

// SLEIR:NarrowPlus2X: 0 tests

// SLEIR:NarrowStar2Opt: 0 tests

// SLEIR:NarrowStar2Plus: 0 tests

// SLEIR:NarrowStar2X: 0 tests

// SLEIR:ParenthesizeAll: 0 tests

// SLEIR:PermuteInfix2Postfix: 0 tests

// SLEIR:PermuteInfix2Prefix: 0 tests

// SLEIR:PermutePostfix2Infix: 0 tests

// SLEIR:PermutePostfix2Prefix: 0 tests

// SLEIR:PermutePrefix2Infix: 0 tests

// SLEIR:PermutePrefix2Postfix: 0 tests

// SLEIR:RAssocAll: 0 tests

// SLEIR:Reroot2top: 0 tests

// SLEIR:RetireLs: 0 tests

// SLEIR:RetireMs: 0 tests

// SLEIR:RetireTs: 0 tests

// SLEIR:SplitAllT: 0 tests

// SLEIR:UnchainAll: 0 tests

// SLEIR:UndefineTrivial: 0 tests

// SLEIR:UnfoldMax: 0 tests

// SLEIR:VerticalAll: 0 tests

// SLEIR:WidenOpt2Star: 0 tests

// SLEIR:WidenPlus2Star: 0 tests

// SLEIR:WidenX2Opt: 0 tests

// SLEIR:WidenX2Plus: 0 tests

// SLEIR:WidenX2Star: 0 tests

// SLEIR:YaccifyAllL: 0 tests

// SLEIR:YaccifyAllR: 0 tests

