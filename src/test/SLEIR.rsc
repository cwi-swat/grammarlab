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
// abridge1_1.glue
test bool test_abridge1_1() = run_case("abridge1_1.glue",false);
void show_abridge1_1() {run_case("abridge1_1.glue",true);}
// abridge1_2.glue
test bool test_abridge1_2() = run_case("abridge1_2.glue",false);
void show_abridge1_2() {run_case("abridge1_2.glue",true);}
// abridge1_3.glue
test bool test_abridge1_3() = run_case("abridge1_3.glue",false);
void show_abridge1_3() {run_case("abridge1_3.glue",true);}
// abridge1_4.glue
test bool test_abridge1_4() = run_case("abridge1_4.glue",false);
void show_abridge1_4() {run_case("abridge1_4.glue",true);}
// abridge2_11.glue
test bool test_abridge2_11() = run_case("abridge2_11.glue",false);
void show_abridge2_11() {run_case("abridge2_11.glue",true);}
// abridge2_12.glue
test bool test_abridge2_12() = run_case("abridge2_12.glue",false);
void show_abridge2_12() {run_case("abridge2_12.glue",true);}
// abridge2_13.glue
test bool test_abridge2_13() = run_case("abridge2_13.glue",false);
void show_abridge2_13() {run_case("abridge2_13.glue",true);}
// abridge2_14.glue
test bool test_abridge2_14() = run_case("abridge2_14.glue",false);
void show_abridge2_14() {run_case("abridge2_14.glue",true);}
// abridge2_21.glue
test bool test_abridge2_21() = run_case("abridge2_21.glue",false);
void show_abridge2_21() {run_case("abridge2_21.glue",true);}
// abridge2_22.glue
test bool test_abridge2_22() = run_case("abridge2_22.glue",false);
void show_abridge2_22() {run_case("abridge2_22.glue",true);}
// abridge2_23.glue
test bool test_abridge2_23() = run_case("abridge2_23.glue",false);
void show_abridge2_23() {run_case("abridge2_23.glue",true);}
// abridge2_24.glue
test bool test_abridge2_24() = run_case("abridge2_24.glue",false);
void show_abridge2_24() {run_case("abridge2_24.glue",true);}
// abridge2_31.glue
test bool test_abridge2_31() = run_case("abridge2_31.glue",false);
void show_abridge2_31() {run_case("abridge2_31.glue",true);}
// abridge2_32.glue
test bool test_abridge2_32() = run_case("abridge2_32.glue",false);
void show_abridge2_32() {run_case("abridge2_32.glue",true);}
// abridge2_33.glue
test bool test_abridge2_33() = run_case("abridge2_33.glue",false);
void show_abridge2_33() {run_case("abridge2_33.glue",true);}
// abridge2_34.glue
test bool test_abridge2_34() = run_case("abridge2_34.glue",false);
void show_abridge2_34() {run_case("abridge2_34.glue",true);}
// abridge2_41.glue
test bool test_abridge2_41() = run_case("abridge2_41.glue",false);
void show_abridge2_41() {run_case("abridge2_41.glue",true);}
// abridge2_42.glue
test bool test_abridge2_42() = run_case("abridge2_42.glue",false);
void show_abridge2_42() {run_case("abridge2_42.glue",true);}
// abridge2_43.glue
test bool test_abridge2_43() = run_case("abridge2_43.glue",false);
void show_abridge2_43() {run_case("abridge2_43.glue",true);}
// abridge2_44.glue
test bool test_abridge2_44() = run_case("abridge2_44.glue",false);
void show_abridge2_44() {run_case("abridge2_44.glue",true);}
// deyaccify1H1.glue
test bool test_deyaccify1H1() = run_case("deyaccify1H1.glue",false);
void show_deyaccify1H1() {run_case("deyaccify1H1.glue",true);}
// deyaccify1H2.glue
test bool test_deyaccify1H2() = run_case("deyaccify1H2.glue",false);
void show_deyaccify1H2() {run_case("deyaccify1H2.glue",true);}
// deyaccify1H3.glue
test bool test_deyaccify1H3() = run_case("deyaccify1H3.glue",false);
void show_deyaccify1H3() {run_case("deyaccify1H3.glue",true);}
// deyaccify1H4.glue
test bool test_deyaccify1H4() = run_case("deyaccify1H4.glue",false);
void show_deyaccify1H4() {run_case("deyaccify1H4.glue",true);}
// deyaccify1H5.glue
test bool test_deyaccify1H5() = run_case("deyaccify1H5.glue",false);
void show_deyaccify1H5() {run_case("deyaccify1H5.glue",true);}
// deyaccify1H6.glue
test bool test_deyaccify1H6() = run_case("deyaccify1H6.glue",false);
void show_deyaccify1H6() {run_case("deyaccify1H6.glue",true);}
// deyaccify1V1.glue
test bool test_deyaccify1V1() = run_case("deyaccify1V1.glue",false);
void show_deyaccify1V1() {run_case("deyaccify1V1.glue",true);}
// deyaccify1V2.glue
test bool test_deyaccify1V2() = run_case("deyaccify1V2.glue",false);
void show_deyaccify1V2() {run_case("deyaccify1V2.glue",true);}
// deyaccify1V3.glue
test bool test_deyaccify1V3() = run_case("deyaccify1V3.glue",false);
void show_deyaccify1V3() {run_case("deyaccify1V3.glue",true);}
// deyaccify1V4.glue
test bool test_deyaccify1V4() = run_case("deyaccify1V4.glue",false);
void show_deyaccify1V4() {run_case("deyaccify1V4.glue",true);}
// deyaccify1V5.glue
test bool test_deyaccify1V5() = run_case("deyaccify1V5.glue",false);
void show_deyaccify1V5() {run_case("deyaccify1V5.glue",true);}
// deyaccify1V6.glue
test bool test_deyaccify1V6() = run_case("deyaccify1V6.glue",false);
void show_deyaccify1V6() {run_case("deyaccify1V6.glue",true);}
// deyaccify2HH11.glue
test bool test_deyaccify2HH11() = run_case("deyaccify2HH11.glue",false);
void show_deyaccify2HH11() {run_case("deyaccify2HH11.glue",true);}
// deyaccify2HH12.glue
test bool test_deyaccify2HH12() = run_case("deyaccify2HH12.glue",false);
void show_deyaccify2HH12() {run_case("deyaccify2HH12.glue",true);}
// deyaccify2HH13.glue
test bool test_deyaccify2HH13() = run_case("deyaccify2HH13.glue",false);
void show_deyaccify2HH13() {run_case("deyaccify2HH13.glue",true);}
// deyaccify2HH14.glue
test bool test_deyaccify2HH14() = run_case("deyaccify2HH14.glue",false);
void show_deyaccify2HH14() {run_case("deyaccify2HH14.glue",true);}
// deyaccify2HH15.glue
test bool test_deyaccify2HH15() = run_case("deyaccify2HH15.glue",false);
void show_deyaccify2HH15() {run_case("deyaccify2HH15.glue",true);}
// deyaccify2HH21.glue
test bool test_deyaccify2HH21() = run_case("deyaccify2HH21.glue",false);
void show_deyaccify2HH21() {run_case("deyaccify2HH21.glue",true);}
// deyaccify2HH22.glue
test bool test_deyaccify2HH22() = run_case("deyaccify2HH22.glue",false);
void show_deyaccify2HH22() {run_case("deyaccify2HH22.glue",true);}
// deyaccify2HH23.glue
test bool test_deyaccify2HH23() = run_case("deyaccify2HH23.glue",false);
void show_deyaccify2HH23() {run_case("deyaccify2HH23.glue",true);}
// deyaccify2HH24.glue
test bool test_deyaccify2HH24() = run_case("deyaccify2HH24.glue",false);
void show_deyaccify2HH24() {run_case("deyaccify2HH24.glue",true);}
// deyaccify2HH25.glue
test bool test_deyaccify2HH25() = run_case("deyaccify2HH25.glue",false);
void show_deyaccify2HH25() {run_case("deyaccify2HH25.glue",true);}
// deyaccify2HH31.glue
test bool test_deyaccify2HH31() = run_case("deyaccify2HH31.glue",false);
void show_deyaccify2HH31() {run_case("deyaccify2HH31.glue",true);}
// deyaccify2HH32.glue
test bool test_deyaccify2HH32() = run_case("deyaccify2HH32.glue",false);
void show_deyaccify2HH32() {run_case("deyaccify2HH32.glue",true);}
// deyaccify2HH33.glue
test bool test_deyaccify2HH33() = run_case("deyaccify2HH33.glue",false);
void show_deyaccify2HH33() {run_case("deyaccify2HH33.glue",true);}
// deyaccify2HH34.glue
test bool test_deyaccify2HH34() = run_case("deyaccify2HH34.glue",false);
void show_deyaccify2HH34() {run_case("deyaccify2HH34.glue",true);}
// deyaccify2HH35.glue
test bool test_deyaccify2HH35() = run_case("deyaccify2HH35.glue",false);
void show_deyaccify2HH35() {run_case("deyaccify2HH35.glue",true);}
// deyaccify2HH41.glue
test bool test_deyaccify2HH41() = run_case("deyaccify2HH41.glue",false);
void show_deyaccify2HH41() {run_case("deyaccify2HH41.glue",true);}
// deyaccify2HH42.glue
test bool test_deyaccify2HH42() = run_case("deyaccify2HH42.glue",false);
void show_deyaccify2HH42() {run_case("deyaccify2HH42.glue",true);}
// deyaccify2HH43.glue
test bool test_deyaccify2HH43() = run_case("deyaccify2HH43.glue",false);
void show_deyaccify2HH43() {run_case("deyaccify2HH43.glue",true);}
// deyaccify2HH44.glue
test bool test_deyaccify2HH44() = run_case("deyaccify2HH44.glue",false);
void show_deyaccify2HH44() {run_case("deyaccify2HH44.glue",true);}
// deyaccify2HH45.glue
test bool test_deyaccify2HH45() = run_case("deyaccify2HH45.glue",false);
void show_deyaccify2HH45() {run_case("deyaccify2HH45.glue",true);}
// deyaccify2HH51.glue
test bool test_deyaccify2HH51() = run_case("deyaccify2HH51.glue",false);
void show_deyaccify2HH51() {run_case("deyaccify2HH51.glue",true);}
// deyaccify2HH52.glue
test bool test_deyaccify2HH52() = run_case("deyaccify2HH52.glue",false);
void show_deyaccify2HH52() {run_case("deyaccify2HH52.glue",true);}
// deyaccify2HH53.glue
test bool test_deyaccify2HH53() = run_case("deyaccify2HH53.glue",false);
void show_deyaccify2HH53() {run_case("deyaccify2HH53.glue",true);}
// deyaccify2HH54.glue
test bool test_deyaccify2HH54() = run_case("deyaccify2HH54.glue",false);
void show_deyaccify2HH54() {run_case("deyaccify2HH54.glue",true);}
// deyaccify2HH55.glue
test bool test_deyaccify2HH55() = run_case("deyaccify2HH55.glue",false);
void show_deyaccify2HH55() {run_case("deyaccify2HH55.glue",true);}
// deyaccify2HH61.glue
test bool test_deyaccify2HH61() = run_case("deyaccify2HH61.glue",false);
void show_deyaccify2HH61() {run_case("deyaccify2HH61.glue",true);}
// deyaccify2HH62.glue
test bool test_deyaccify2HH62() = run_case("deyaccify2HH62.glue",false);
void show_deyaccify2HH62() {run_case("deyaccify2HH62.glue",true);}
// deyaccify2HH63.glue
test bool test_deyaccify2HH63() = run_case("deyaccify2HH63.glue",false);
void show_deyaccify2HH63() {run_case("deyaccify2HH63.glue",true);}
// deyaccify2HH64.glue
test bool test_deyaccify2HH64() = run_case("deyaccify2HH64.glue",false);
void show_deyaccify2HH64() {run_case("deyaccify2HH64.glue",true);}
// deyaccify2HH65.glue
test bool test_deyaccify2HH65() = run_case("deyaccify2HH65.glue",false);
void show_deyaccify2HH65() {run_case("deyaccify2HH65.glue",true);}
// deyaccify2HV11.glue
test bool test_deyaccify2HV11() = run_case("deyaccify2HV11.glue",false);
void show_deyaccify2HV11() {run_case("deyaccify2HV11.glue",true);}
// deyaccify2HV12.glue
test bool test_deyaccify2HV12() = run_case("deyaccify2HV12.glue",false);
void show_deyaccify2HV12() {run_case("deyaccify2HV12.glue",true);}
// deyaccify2HV13.glue
test bool test_deyaccify2HV13() = run_case("deyaccify2HV13.glue",false);
void show_deyaccify2HV13() {run_case("deyaccify2HV13.glue",true);}
// deyaccify2HV14.glue
test bool test_deyaccify2HV14() = run_case("deyaccify2HV14.glue",false);
void show_deyaccify2HV14() {run_case("deyaccify2HV14.glue",true);}
// deyaccify2HV15.glue
test bool test_deyaccify2HV15() = run_case("deyaccify2HV15.glue",false);
void show_deyaccify2HV15() {run_case("deyaccify2HV15.glue",true);}
// deyaccify2HV21.glue
test bool test_deyaccify2HV21() = run_case("deyaccify2HV21.glue",false);
void show_deyaccify2HV21() {run_case("deyaccify2HV21.glue",true);}
// deyaccify2HV22.glue
test bool test_deyaccify2HV22() = run_case("deyaccify2HV22.glue",false);
void show_deyaccify2HV22() {run_case("deyaccify2HV22.glue",true);}
// deyaccify2HV23.glue
test bool test_deyaccify2HV23() = run_case("deyaccify2HV23.glue",false);
void show_deyaccify2HV23() {run_case("deyaccify2HV23.glue",true);}
// deyaccify2HV24.glue
test bool test_deyaccify2HV24() = run_case("deyaccify2HV24.glue",false);
void show_deyaccify2HV24() {run_case("deyaccify2HV24.glue",true);}
// deyaccify2HV25.glue
test bool test_deyaccify2HV25() = run_case("deyaccify2HV25.glue",false);
void show_deyaccify2HV25() {run_case("deyaccify2HV25.glue",true);}
// deyaccify2HV31.glue
test bool test_deyaccify2HV31() = run_case("deyaccify2HV31.glue",false);
void show_deyaccify2HV31() {run_case("deyaccify2HV31.glue",true);}
// deyaccify2HV32.glue
test bool test_deyaccify2HV32() = run_case("deyaccify2HV32.glue",false);
void show_deyaccify2HV32() {run_case("deyaccify2HV32.glue",true);}
// deyaccify2HV33.glue
test bool test_deyaccify2HV33() = run_case("deyaccify2HV33.glue",false);
void show_deyaccify2HV33() {run_case("deyaccify2HV33.glue",true);}
// deyaccify2HV34.glue
test bool test_deyaccify2HV34() = run_case("deyaccify2HV34.glue",false);
void show_deyaccify2HV34() {run_case("deyaccify2HV34.glue",true);}
// deyaccify2HV35.glue
test bool test_deyaccify2HV35() = run_case("deyaccify2HV35.glue",false);
void show_deyaccify2HV35() {run_case("deyaccify2HV35.glue",true);}
// deyaccify2HV41.glue
test bool test_deyaccify2HV41() = run_case("deyaccify2HV41.glue",false);
void show_deyaccify2HV41() {run_case("deyaccify2HV41.glue",true);}
// deyaccify2HV42.glue
test bool test_deyaccify2HV42() = run_case("deyaccify2HV42.glue",false);
void show_deyaccify2HV42() {run_case("deyaccify2HV42.glue",true);}
// deyaccify2HV43.glue
test bool test_deyaccify2HV43() = run_case("deyaccify2HV43.glue",false);
void show_deyaccify2HV43() {run_case("deyaccify2HV43.glue",true);}
// deyaccify2HV44.glue
test bool test_deyaccify2HV44() = run_case("deyaccify2HV44.glue",false);
void show_deyaccify2HV44() {run_case("deyaccify2HV44.glue",true);}
// deyaccify2HV45.glue
test bool test_deyaccify2HV45() = run_case("deyaccify2HV45.glue",false);
void show_deyaccify2HV45() {run_case("deyaccify2HV45.glue",true);}
// deyaccify2HV51.glue
test bool test_deyaccify2HV51() = run_case("deyaccify2HV51.glue",false);
void show_deyaccify2HV51() {run_case("deyaccify2HV51.glue",true);}
// deyaccify2HV52.glue
test bool test_deyaccify2HV52() = run_case("deyaccify2HV52.glue",false);
void show_deyaccify2HV52() {run_case("deyaccify2HV52.glue",true);}
// deyaccify2HV53.glue
test bool test_deyaccify2HV53() = run_case("deyaccify2HV53.glue",false);
void show_deyaccify2HV53() {run_case("deyaccify2HV53.glue",true);}
// deyaccify2HV54.glue
test bool test_deyaccify2HV54() = run_case("deyaccify2HV54.glue",false);
void show_deyaccify2HV54() {run_case("deyaccify2HV54.glue",true);}
// deyaccify2HV55.glue
test bool test_deyaccify2HV55() = run_case("deyaccify2HV55.glue",false);
void show_deyaccify2HV55() {run_case("deyaccify2HV55.glue",true);}
// deyaccify2HV61.glue
test bool test_deyaccify2HV61() = run_case("deyaccify2HV61.glue",false);
void show_deyaccify2HV61() {run_case("deyaccify2HV61.glue",true);}
// deyaccify2HV62.glue
test bool test_deyaccify2HV62() = run_case("deyaccify2HV62.glue",false);
void show_deyaccify2HV62() {run_case("deyaccify2HV62.glue",true);}
// deyaccify2HV63.glue
test bool test_deyaccify2HV63() = run_case("deyaccify2HV63.glue",false);
void show_deyaccify2HV63() {run_case("deyaccify2HV63.glue",true);}
// deyaccify2HV64.glue
test bool test_deyaccify2HV64() = run_case("deyaccify2HV64.glue",false);
void show_deyaccify2HV64() {run_case("deyaccify2HV64.glue",true);}
// deyaccify2HV65.glue
test bool test_deyaccify2HV65() = run_case("deyaccify2HV65.glue",false);
void show_deyaccify2HV65() {run_case("deyaccify2HV65.glue",true);}
// deyaccify2VH11.glue
test bool test_deyaccify2VH11() = run_case("deyaccify2VH11.glue",false);
void show_deyaccify2VH11() {run_case("deyaccify2VH11.glue",true);}
// deyaccify2VH12.glue
test bool test_deyaccify2VH12() = run_case("deyaccify2VH12.glue",false);
void show_deyaccify2VH12() {run_case("deyaccify2VH12.glue",true);}
// deyaccify2VH13.glue
test bool test_deyaccify2VH13() = run_case("deyaccify2VH13.glue",false);
void show_deyaccify2VH13() {run_case("deyaccify2VH13.glue",true);}
// deyaccify2VH14.glue
test bool test_deyaccify2VH14() = run_case("deyaccify2VH14.glue",false);
void show_deyaccify2VH14() {run_case("deyaccify2VH14.glue",true);}
// deyaccify2VH15.glue
test bool test_deyaccify2VH15() = run_case("deyaccify2VH15.glue",false);
void show_deyaccify2VH15() {run_case("deyaccify2VH15.glue",true);}
// deyaccify2VH21.glue
test bool test_deyaccify2VH21() = run_case("deyaccify2VH21.glue",false);
void show_deyaccify2VH21() {run_case("deyaccify2VH21.glue",true);}
// deyaccify2VH22.glue
test bool test_deyaccify2VH22() = run_case("deyaccify2VH22.glue",false);
void show_deyaccify2VH22() {run_case("deyaccify2VH22.glue",true);}
// deyaccify2VH23.glue
test bool test_deyaccify2VH23() = run_case("deyaccify2VH23.glue",false);
void show_deyaccify2VH23() {run_case("deyaccify2VH23.glue",true);}
// deyaccify2VH24.glue
test bool test_deyaccify2VH24() = run_case("deyaccify2VH24.glue",false);
void show_deyaccify2VH24() {run_case("deyaccify2VH24.glue",true);}
// deyaccify2VH25.glue
test bool test_deyaccify2VH25() = run_case("deyaccify2VH25.glue",false);
void show_deyaccify2VH25() {run_case("deyaccify2VH25.glue",true);}
// deyaccify2VH31.glue
test bool test_deyaccify2VH31() = run_case("deyaccify2VH31.glue",false);
void show_deyaccify2VH31() {run_case("deyaccify2VH31.glue",true);}
// deyaccify2VH32.glue
test bool test_deyaccify2VH32() = run_case("deyaccify2VH32.glue",false);
void show_deyaccify2VH32() {run_case("deyaccify2VH32.glue",true);}
// deyaccify2VH33.glue
test bool test_deyaccify2VH33() = run_case("deyaccify2VH33.glue",false);
void show_deyaccify2VH33() {run_case("deyaccify2VH33.glue",true);}
// deyaccify2VH34.glue
test bool test_deyaccify2VH34() = run_case("deyaccify2VH34.glue",false);
void show_deyaccify2VH34() {run_case("deyaccify2VH34.glue",true);}
// deyaccify2VH35.glue
test bool test_deyaccify2VH35() = run_case("deyaccify2VH35.glue",false);
void show_deyaccify2VH35() {run_case("deyaccify2VH35.glue",true);}
// deyaccify2VH41.glue
test bool test_deyaccify2VH41() = run_case("deyaccify2VH41.glue",false);
void show_deyaccify2VH41() {run_case("deyaccify2VH41.glue",true);}
// deyaccify2VH42.glue
test bool test_deyaccify2VH42() = run_case("deyaccify2VH42.glue",false);
void show_deyaccify2VH42() {run_case("deyaccify2VH42.glue",true);}
// deyaccify2VH43.glue
test bool test_deyaccify2VH43() = run_case("deyaccify2VH43.glue",false);
void show_deyaccify2VH43() {run_case("deyaccify2VH43.glue",true);}
// deyaccify2VH44.glue
test bool test_deyaccify2VH44() = run_case("deyaccify2VH44.glue",false);
void show_deyaccify2VH44() {run_case("deyaccify2VH44.glue",true);}
// deyaccify2VH45.glue
test bool test_deyaccify2VH45() = run_case("deyaccify2VH45.glue",false);
void show_deyaccify2VH45() {run_case("deyaccify2VH45.glue",true);}
// deyaccify2VH51.glue
test bool test_deyaccify2VH51() = run_case("deyaccify2VH51.glue",false);
void show_deyaccify2VH51() {run_case("deyaccify2VH51.glue",true);}
// deyaccify2VH52.glue
test bool test_deyaccify2VH52() = run_case("deyaccify2VH52.glue",false);
void show_deyaccify2VH52() {run_case("deyaccify2VH52.glue",true);}
// deyaccify2VH53.glue
test bool test_deyaccify2VH53() = run_case("deyaccify2VH53.glue",false);
void show_deyaccify2VH53() {run_case("deyaccify2VH53.glue",true);}
// deyaccify2VH54.glue
test bool test_deyaccify2VH54() = run_case("deyaccify2VH54.glue",false);
void show_deyaccify2VH54() {run_case("deyaccify2VH54.glue",true);}
// deyaccify2VH55.glue
test bool test_deyaccify2VH55() = run_case("deyaccify2VH55.glue",false);
void show_deyaccify2VH55() {run_case("deyaccify2VH55.glue",true);}
// deyaccify2VH61.glue
test bool test_deyaccify2VH61() = run_case("deyaccify2VH61.glue",false);
void show_deyaccify2VH61() {run_case("deyaccify2VH61.glue",true);}
// deyaccify2VH62.glue
test bool test_deyaccify2VH62() = run_case("deyaccify2VH62.glue",false);
void show_deyaccify2VH62() {run_case("deyaccify2VH62.glue",true);}
// deyaccify2VH63.glue
test bool test_deyaccify2VH63() = run_case("deyaccify2VH63.glue",false);
void show_deyaccify2VH63() {run_case("deyaccify2VH63.glue",true);}
// deyaccify2VH64.glue
test bool test_deyaccify2VH64() = run_case("deyaccify2VH64.glue",false);
void show_deyaccify2VH64() {run_case("deyaccify2VH64.glue",true);}
// deyaccify2VH65.glue
test bool test_deyaccify2VH65() = run_case("deyaccify2VH65.glue",false);
void show_deyaccify2VH65() {run_case("deyaccify2VH65.glue",true);}
// deyaccify2VV11.glue
test bool test_deyaccify2VV11() = run_case("deyaccify2VV11.glue",false);
void show_deyaccify2VV11() {run_case("deyaccify2VV11.glue",true);}
// deyaccify2VV12.glue
test bool test_deyaccify2VV12() = run_case("deyaccify2VV12.glue",false);
void show_deyaccify2VV12() {run_case("deyaccify2VV12.glue",true);}
// deyaccify2VV13.glue
test bool test_deyaccify2VV13() = run_case("deyaccify2VV13.glue",false);
void show_deyaccify2VV13() {run_case("deyaccify2VV13.glue",true);}
// deyaccify2VV14.glue
test bool test_deyaccify2VV14() = run_case("deyaccify2VV14.glue",false);
void show_deyaccify2VV14() {run_case("deyaccify2VV14.glue",true);}
// deyaccify2VV15.glue
test bool test_deyaccify2VV15() = run_case("deyaccify2VV15.glue",false);
void show_deyaccify2VV15() {run_case("deyaccify2VV15.glue",true);}
// deyaccify2VV21.glue
test bool test_deyaccify2VV21() = run_case("deyaccify2VV21.glue",false);
void show_deyaccify2VV21() {run_case("deyaccify2VV21.glue",true);}
// deyaccify2VV22.glue
test bool test_deyaccify2VV22() = run_case("deyaccify2VV22.glue",false);
void show_deyaccify2VV22() {run_case("deyaccify2VV22.glue",true);}
// deyaccify2VV23.glue
test bool test_deyaccify2VV23() = run_case("deyaccify2VV23.glue",false);
void show_deyaccify2VV23() {run_case("deyaccify2VV23.glue",true);}
// deyaccify2VV24.glue
test bool test_deyaccify2VV24() = run_case("deyaccify2VV24.glue",false);
void show_deyaccify2VV24() {run_case("deyaccify2VV24.glue",true);}
// deyaccify2VV25.glue
test bool test_deyaccify2VV25() = run_case("deyaccify2VV25.glue",false);
void show_deyaccify2VV25() {run_case("deyaccify2VV25.glue",true);}
// deyaccify2VV31.glue
test bool test_deyaccify2VV31() = run_case("deyaccify2VV31.glue",false);
void show_deyaccify2VV31() {run_case("deyaccify2VV31.glue",true);}
// deyaccify2VV32.glue
test bool test_deyaccify2VV32() = run_case("deyaccify2VV32.glue",false);
void show_deyaccify2VV32() {run_case("deyaccify2VV32.glue",true);}
// deyaccify2VV33.glue
test bool test_deyaccify2VV33() = run_case("deyaccify2VV33.glue",false);
void show_deyaccify2VV33() {run_case("deyaccify2VV33.glue",true);}
// deyaccify2VV34.glue
test bool test_deyaccify2VV34() = run_case("deyaccify2VV34.glue",false);
void show_deyaccify2VV34() {run_case("deyaccify2VV34.glue",true);}
// deyaccify2VV35.glue
test bool test_deyaccify2VV35() = run_case("deyaccify2VV35.glue",false);
void show_deyaccify2VV35() {run_case("deyaccify2VV35.glue",true);}
// deyaccify2VV41.glue
test bool test_deyaccify2VV41() = run_case("deyaccify2VV41.glue",false);
void show_deyaccify2VV41() {run_case("deyaccify2VV41.glue",true);}
// deyaccify2VV42.glue
test bool test_deyaccify2VV42() = run_case("deyaccify2VV42.glue",false);
void show_deyaccify2VV42() {run_case("deyaccify2VV42.glue",true);}
// deyaccify2VV43.glue
test bool test_deyaccify2VV43() = run_case("deyaccify2VV43.glue",false);
void show_deyaccify2VV43() {run_case("deyaccify2VV43.glue",true);}
// deyaccify2VV44.glue
test bool test_deyaccify2VV44() = run_case("deyaccify2VV44.glue",false);
void show_deyaccify2VV44() {run_case("deyaccify2VV44.glue",true);}
// deyaccify2VV45.glue
test bool test_deyaccify2VV45() = run_case("deyaccify2VV45.glue",false);
void show_deyaccify2VV45() {run_case("deyaccify2VV45.glue",true);}
// deyaccify2VV51.glue
test bool test_deyaccify2VV51() = run_case("deyaccify2VV51.glue",false);
void show_deyaccify2VV51() {run_case("deyaccify2VV51.glue",true);}
// deyaccify2VV52.glue
test bool test_deyaccify2VV52() = run_case("deyaccify2VV52.glue",false);
void show_deyaccify2VV52() {run_case("deyaccify2VV52.glue",true);}
// deyaccify2VV53.glue
test bool test_deyaccify2VV53() = run_case("deyaccify2VV53.glue",false);
void show_deyaccify2VV53() {run_case("deyaccify2VV53.glue",true);}
// deyaccify2VV54.glue
test bool test_deyaccify2VV54() = run_case("deyaccify2VV54.glue",false);
void show_deyaccify2VV54() {run_case("deyaccify2VV54.glue",true);}
// deyaccify2VV55.glue
test bool test_deyaccify2VV55() = run_case("deyaccify2VV55.glue",false);
void show_deyaccify2VV55() {run_case("deyaccify2VV55.glue",true);}
// deyaccify2VV61.glue
test bool test_deyaccify2VV61() = run_case("deyaccify2VV61.glue",false);
void show_deyaccify2VV61() {run_case("deyaccify2VV61.glue",true);}
// deyaccify2VV62.glue
test bool test_deyaccify2VV62() = run_case("deyaccify2VV62.glue",false);
void show_deyaccify2VV62() {run_case("deyaccify2VV62.glue",true);}
// deyaccify2VV63.glue
test bool test_deyaccify2VV63() = run_case("deyaccify2VV63.glue",false);
void show_deyaccify2VV63() {run_case("deyaccify2VV63.glue",true);}
// deyaccify2VV64.glue
test bool test_deyaccify2VV64() = run_case("deyaccify2VV64.glue",false);
void show_deyaccify2VV64() {run_case("deyaccify2VV64.glue",true);}
// deyaccify2VV65.glue
test bool test_deyaccify2VV65() = run_case("deyaccify2VV65.glue",false);
void show_deyaccify2VV65() {run_case("deyaccify2VV65.glue",true);}
// distribute1.glue
test bool test_distribute1() = run_case("distribute1.glue",false);
void show_distribute1() {run_case("distribute1.glue",true);}
// distribute2.glue
test bool test_distribute2() = run_case("distribute2.glue",false);
void show_distribute2() {run_case("distribute2.glue",true);}
// distribute3.glue
test bool test_distribute3() = run_case("distribute3.glue",false);
void show_distribute3() {run_case("distribute3.glue",true);}
// eliminate1.glue
test bool test_eliminate1() = run_case("eliminate1.glue",false);
void show_eliminate1() {run_case("eliminate1.glue",true);}
// eliminate2.glue
test bool test_eliminate2() = run_case("eliminate2.glue",false);
void show_eliminate2() {run_case("eliminate2.glue",true);}
// eliminate3.glue
test bool test_eliminate3() = run_case("eliminate3.glue",false);
void show_eliminate3() {run_case("eliminate3.glue",true);}
// eliminate4.glue
test bool test_eliminate4() = run_case("eliminate4.glue",false);
void show_eliminate4() {run_case("eliminate4.glue",true);}
// equate1.glue
test bool test_equate1() = run_case("equate1.glue",false);
void show_equate1() {run_case("equate1.glue",true);}
// equate2.glue
test bool test_equate2() = run_case("equate2.glue",false);
void show_equate2() {run_case("equate2.glue",true);}
// equate3.glue
test bool test_equate3() = run_case("equate3.glue",false);
void show_equate3() {run_case("equate3.glue",true);}
// equate4.glue
test bool test_equate4() = run_case("equate4.glue",false);
void show_equate4() {run_case("equate4.glue",true);}
// retirets01.glue
test bool test_retirets01() = run_case("retirets01.glue",false);
void show_retirets01() {run_case("retirets01.glue",true);}
// retirets02.glue
test bool test_retirets02() = run_case("retirets02.glue",false);
void show_retirets02() {run_case("retirets02.glue",true);}
// retirets03.glue
test bool test_retirets03() = run_case("retirets03.glue",false);
void show_retirets03() {run_case("retirets03.glue",true);}
// retirets04.glue
test bool test_retirets04() = run_case("retirets04.glue",false);
void show_retirets04() {run_case("retirets04.glue",true);}
// retirets05.glue
test bool test_retirets05() = run_case("retirets05.glue",false);
void show_retirets05() {run_case("retirets05.glue",true);}
// retirets06.glue
test bool test_retirets06() = run_case("retirets06.glue",false);
void show_retirets06() {run_case("retirets06.glue",true);}
// retirets07.glue
test bool test_retirets07() = run_case("retirets07.glue",false);
void show_retirets07() {run_case("retirets07.glue",true);}
// retirets08.glue
test bool test_retirets08() = run_case("retirets08.glue",false);
void show_retirets08() {run_case("retirets08.glue",true);}
// retirets09.glue
test bool test_retirets09() = run_case("retirets09.glue",false);
void show_retirets09() {run_case("retirets09.glue",true);}
