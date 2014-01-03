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
// abridgeall1_1.glue
test bool test_abridgeall1_1() = run_case("abridgeall1_1.glue",false);
void show_abridgeall1_1() {run_case("abridgeall1_1.glue",true);}
// abridgeall1_2.glue
test bool test_abridgeall1_2() = run_case("abridgeall1_2.glue",false);
void show_abridgeall1_2() {run_case("abridgeall1_2.glue",true);}
// abridgeall1_3.glue
test bool test_abridgeall1_3() = run_case("abridgeall1_3.glue",false);
void show_abridgeall1_3() {run_case("abridgeall1_3.glue",true);}
// abridgeall1_4.glue
test bool test_abridgeall1_4() = run_case("abridgeall1_4.glue",false);
void show_abridgeall1_4() {run_case("abridgeall1_4.glue",true);}
// abridgeall2_11.glue
test bool test_abridgeall2_11() = run_case("abridgeall2_11.glue",false);
void show_abridgeall2_11() {run_case("abridgeall2_11.glue",true);}
// abridgeall2_12.glue
test bool test_abridgeall2_12() = run_case("abridgeall2_12.glue",false);
void show_abridgeall2_12() {run_case("abridgeall2_12.glue",true);}
// abridgeall2_13.glue
test bool test_abridgeall2_13() = run_case("abridgeall2_13.glue",false);
void show_abridgeall2_13() {run_case("abridgeall2_13.glue",true);}
// abridgeall2_14.glue
test bool test_abridgeall2_14() = run_case("abridgeall2_14.glue",false);
void show_abridgeall2_14() {run_case("abridgeall2_14.glue",true);}
// abridgeall2_21.glue
test bool test_abridgeall2_21() = run_case("abridgeall2_21.glue",false);
void show_abridgeall2_21() {run_case("abridgeall2_21.glue",true);}
// abridgeall2_22.glue
test bool test_abridgeall2_22() = run_case("abridgeall2_22.glue",false);
void show_abridgeall2_22() {run_case("abridgeall2_22.glue",true);}
// abridgeall2_23.glue
test bool test_abridgeall2_23() = run_case("abridgeall2_23.glue",false);
void show_abridgeall2_23() {run_case("abridgeall2_23.glue",true);}
// abridgeall2_24.glue
test bool test_abridgeall2_24() = run_case("abridgeall2_24.glue",false);
void show_abridgeall2_24() {run_case("abridgeall2_24.glue",true);}
// abridgeall2_31.glue
test bool test_abridgeall2_31() = run_case("abridgeall2_31.glue",false);
void show_abridgeall2_31() {run_case("abridgeall2_31.glue",true);}
// abridgeall2_32.glue
test bool test_abridgeall2_32() = run_case("abridgeall2_32.glue",false);
void show_abridgeall2_32() {run_case("abridgeall2_32.glue",true);}
// abridgeall2_33.glue
test bool test_abridgeall2_33() = run_case("abridgeall2_33.glue",false);
void show_abridgeall2_33() {run_case("abridgeall2_33.glue",true);}
// abridgeall2_34.glue
test bool test_abridgeall2_34() = run_case("abridgeall2_34.glue",false);
void show_abridgeall2_34() {run_case("abridgeall2_34.glue",true);}
// abridgeall2_41.glue
test bool test_abridgeall2_41() = run_case("abridgeall2_41.glue",false);
void show_abridgeall2_41() {run_case("abridgeall2_41.glue",true);}
// abridgeall2_42.glue
test bool test_abridgeall2_42() = run_case("abridgeall2_42.glue",false);
void show_abridgeall2_42() {run_case("abridgeall2_42.glue",true);}
// abridgeall2_43.glue
test bool test_abridgeall2_43() = run_case("abridgeall2_43.glue",false);
void show_abridgeall2_43() {run_case("abridgeall2_43.glue",true);}
// abridgeall2_44.glue
test bool test_abridgeall2_44() = run_case("abridgeall2_44.glue",false);
void show_abridgeall2_44() {run_case("abridgeall2_44.glue",true);}
// SLEIR:ChainMixed: 5 tests
// chainmixed1.glue
test bool test_chainmixed1() = run_case("chainmixed1.glue",false);
void show_chainmixed1() {run_case("chainmixed1.glue",true);}
// chainmixed2.glue
test bool test_chainmixed2() = run_case("chainmixed2.glue",false);
void show_chainmixed2() {run_case("chainmixed2.glue",true);}
// chainmixed3.glue
test bool test_chainmixed3() = run_case("chainmixed3.glue",false);
void show_chainmixed3() {run_case("chainmixed3.glue",true);}
// chainmixed4.glue
test bool test_chainmixed4() = run_case("chainmixed4.glue",false);
void show_chainmixed4() {run_case("chainmixed4.glue",true);}
// chainmixed5.glue
test bool test_chainmixed5() = run_case("chainmixed5.glue",false);
void show_chainmixed5() {run_case("chainmixed5.glue",true);}
// SLEIR:ConcatAllT: 7 tests
// concatallt1.glue
test bool test_concatallt1() = run_case("concatallt1.glue",false);
void show_concatallt1() {run_case("concatallt1.glue",true);}
// concatallt2.glue
test bool test_concatallt2() = run_case("concatallt2.glue",false);
void show_concatallt2() {run_case("concatallt2.glue",true);}
// concatallt3.glue
test bool test_concatallt3() = run_case("concatallt3.glue",false);
void show_concatallt3() {run_case("concatallt3.glue",true);}
// concatallt4.glue
test bool test_concatallt4() = run_case("concatallt4.glue",false);
void show_concatallt4() {run_case("concatallt4.glue",true);}
// concatallt5.glue
test bool test_concatallt5() = run_case("concatallt5.glue",false);
void show_concatallt5() {run_case("concatallt5.glue",true);}
// concatallt6.glue
test bool test_concatallt6() = run_case("concatallt6.glue",false);
void show_concatallt6() {run_case("concatallt6.glue",true);}
// concatallt7.glue
test bool test_concatallt7() = run_case("concatallt7.glue",false);
void show_concatallt7() {run_case("concatallt7.glue",true);}
// SLEIR:DefineMin: 3 tests
// definemin1.glue
test bool test_definemin1() = run_case("definemin1.glue",false);
void show_definemin1() {run_case("definemin1.glue",true);}
// definemin2.glue
test bool test_definemin2() = run_case("definemin2.glue",false);
void show_definemin2() {run_case("definemin2.glue",true);}
// definemin3.glue
test bool test_definemin3() = run_case("definemin3.glue",false);
void show_definemin3() {run_case("definemin3.glue",true);}
// SLEIR:DeyaccifyAll: 132 tests
// deyaccifyall1H1.glue
test bool test_deyaccifyall1H1() = run_case("deyaccifyall1H1.glue",false);
void show_deyaccifyall1H1() {run_case("deyaccifyall1H1.glue",true);}
// deyaccifyall1H2.glue
test bool test_deyaccifyall1H2() = run_case("deyaccifyall1H2.glue",false);
void show_deyaccifyall1H2() {run_case("deyaccifyall1H2.glue",true);}
// deyaccifyall1H3.glue
test bool test_deyaccifyall1H3() = run_case("deyaccifyall1H3.glue",false);
void show_deyaccifyall1H3() {run_case("deyaccifyall1H3.glue",true);}
// deyaccifyall1H4.glue
test bool test_deyaccifyall1H4() = run_case("deyaccifyall1H4.glue",false);
void show_deyaccifyall1H4() {run_case("deyaccifyall1H4.glue",true);}
// deyaccifyall1H5.glue
test bool test_deyaccifyall1H5() = run_case("deyaccifyall1H5.glue",false);
void show_deyaccifyall1H5() {run_case("deyaccifyall1H5.glue",true);}
// deyaccifyall1H6.glue
test bool test_deyaccifyall1H6() = run_case("deyaccifyall1H6.glue",false);
void show_deyaccifyall1H6() {run_case("deyaccifyall1H6.glue",true);}
// deyaccifyall1V1.glue
test bool test_deyaccifyall1V1() = run_case("deyaccifyall1V1.glue",false);
void show_deyaccifyall1V1() {run_case("deyaccifyall1V1.glue",true);}
// deyaccifyall1V2.glue
test bool test_deyaccifyall1V2() = run_case("deyaccifyall1V2.glue",false);
void show_deyaccifyall1V2() {run_case("deyaccifyall1V2.glue",true);}
// deyaccifyall1V3.glue
test bool test_deyaccifyall1V3() = run_case("deyaccifyall1V3.glue",false);
void show_deyaccifyall1V3() {run_case("deyaccifyall1V3.glue",true);}
// deyaccifyall1V4.glue
test bool test_deyaccifyall1V4() = run_case("deyaccifyall1V4.glue",false);
void show_deyaccifyall1V4() {run_case("deyaccifyall1V4.glue",true);}
// deyaccifyall1V5.glue
test bool test_deyaccifyall1V5() = run_case("deyaccifyall1V5.glue",false);
void show_deyaccifyall1V5() {run_case("deyaccifyall1V5.glue",true);}
// deyaccifyall1V6.glue
test bool test_deyaccifyall1V6() = run_case("deyaccifyall1V6.glue",false);
void show_deyaccifyall1V6() {run_case("deyaccifyall1V6.glue",true);}
// deyaccifyall2HH11.glue
test bool test_deyaccifyall2HH11() = run_case("deyaccifyall2HH11.glue",false);
void show_deyaccifyall2HH11() {run_case("deyaccifyall2HH11.glue",true);}
// deyaccifyall2HH12.glue
test bool test_deyaccifyall2HH12() = run_case("deyaccifyall2HH12.glue",false);
void show_deyaccifyall2HH12() {run_case("deyaccifyall2HH12.glue",true);}
// deyaccifyall2HH13.glue
test bool test_deyaccifyall2HH13() = run_case("deyaccifyall2HH13.glue",false);
void show_deyaccifyall2HH13() {run_case("deyaccifyall2HH13.glue",true);}
// deyaccifyall2HH14.glue
test bool test_deyaccifyall2HH14() = run_case("deyaccifyall2HH14.glue",false);
void show_deyaccifyall2HH14() {run_case("deyaccifyall2HH14.glue",true);}
// deyaccifyall2HH15.glue
test bool test_deyaccifyall2HH15() = run_case("deyaccifyall2HH15.glue",false);
void show_deyaccifyall2HH15() {run_case("deyaccifyall2HH15.glue",true);}
// deyaccifyall2HH21.glue
test bool test_deyaccifyall2HH21() = run_case("deyaccifyall2HH21.glue",false);
void show_deyaccifyall2HH21() {run_case("deyaccifyall2HH21.glue",true);}
// deyaccifyall2HH22.glue
test bool test_deyaccifyall2HH22() = run_case("deyaccifyall2HH22.glue",false);
void show_deyaccifyall2HH22() {run_case("deyaccifyall2HH22.glue",true);}
// deyaccifyall2HH23.glue
test bool test_deyaccifyall2HH23() = run_case("deyaccifyall2HH23.glue",false);
void show_deyaccifyall2HH23() {run_case("deyaccifyall2HH23.glue",true);}
// deyaccifyall2HH24.glue
test bool test_deyaccifyall2HH24() = run_case("deyaccifyall2HH24.glue",false);
void show_deyaccifyall2HH24() {run_case("deyaccifyall2HH24.glue",true);}
// deyaccifyall2HH25.glue
test bool test_deyaccifyall2HH25() = run_case("deyaccifyall2HH25.glue",false);
void show_deyaccifyall2HH25() {run_case("deyaccifyall2HH25.glue",true);}
// deyaccifyall2HH31.glue
test bool test_deyaccifyall2HH31() = run_case("deyaccifyall2HH31.glue",false);
void show_deyaccifyall2HH31() {run_case("deyaccifyall2HH31.glue",true);}
// deyaccifyall2HH32.glue
test bool test_deyaccifyall2HH32() = run_case("deyaccifyall2HH32.glue",false);
void show_deyaccifyall2HH32() {run_case("deyaccifyall2HH32.glue",true);}
// deyaccifyall2HH33.glue
test bool test_deyaccifyall2HH33() = run_case("deyaccifyall2HH33.glue",false);
void show_deyaccifyall2HH33() {run_case("deyaccifyall2HH33.glue",true);}
// deyaccifyall2HH34.glue
test bool test_deyaccifyall2HH34() = run_case("deyaccifyall2HH34.glue",false);
void show_deyaccifyall2HH34() {run_case("deyaccifyall2HH34.glue",true);}
// deyaccifyall2HH35.glue
test bool test_deyaccifyall2HH35() = run_case("deyaccifyall2HH35.glue",false);
void show_deyaccifyall2HH35() {run_case("deyaccifyall2HH35.glue",true);}
// deyaccifyall2HH41.glue
test bool test_deyaccifyall2HH41() = run_case("deyaccifyall2HH41.glue",false);
void show_deyaccifyall2HH41() {run_case("deyaccifyall2HH41.glue",true);}
// deyaccifyall2HH42.glue
test bool test_deyaccifyall2HH42() = run_case("deyaccifyall2HH42.glue",false);
void show_deyaccifyall2HH42() {run_case("deyaccifyall2HH42.glue",true);}
// deyaccifyall2HH43.glue
test bool test_deyaccifyall2HH43() = run_case("deyaccifyall2HH43.glue",false);
void show_deyaccifyall2HH43() {run_case("deyaccifyall2HH43.glue",true);}
// deyaccifyall2HH44.glue
test bool test_deyaccifyall2HH44() = run_case("deyaccifyall2HH44.glue",false);
void show_deyaccifyall2HH44() {run_case("deyaccifyall2HH44.glue",true);}
// deyaccifyall2HH45.glue
test bool test_deyaccifyall2HH45() = run_case("deyaccifyall2HH45.glue",false);
void show_deyaccifyall2HH45() {run_case("deyaccifyall2HH45.glue",true);}
// deyaccifyall2HH51.glue
test bool test_deyaccifyall2HH51() = run_case("deyaccifyall2HH51.glue",false);
void show_deyaccifyall2HH51() {run_case("deyaccifyall2HH51.glue",true);}
// deyaccifyall2HH52.glue
test bool test_deyaccifyall2HH52() = run_case("deyaccifyall2HH52.glue",false);
void show_deyaccifyall2HH52() {run_case("deyaccifyall2HH52.glue",true);}
// deyaccifyall2HH53.glue
test bool test_deyaccifyall2HH53() = run_case("deyaccifyall2HH53.glue",false);
void show_deyaccifyall2HH53() {run_case("deyaccifyall2HH53.glue",true);}
// deyaccifyall2HH54.glue
test bool test_deyaccifyall2HH54() = run_case("deyaccifyall2HH54.glue",false);
void show_deyaccifyall2HH54() {run_case("deyaccifyall2HH54.glue",true);}
// deyaccifyall2HH55.glue
test bool test_deyaccifyall2HH55() = run_case("deyaccifyall2HH55.glue",false);
void show_deyaccifyall2HH55() {run_case("deyaccifyall2HH55.glue",true);}
// deyaccifyall2HH61.glue
test bool test_deyaccifyall2HH61() = run_case("deyaccifyall2HH61.glue",false);
void show_deyaccifyall2HH61() {run_case("deyaccifyall2HH61.glue",true);}
// deyaccifyall2HH62.glue
test bool test_deyaccifyall2HH62() = run_case("deyaccifyall2HH62.glue",false);
void show_deyaccifyall2HH62() {run_case("deyaccifyall2HH62.glue",true);}
// deyaccifyall2HH63.glue
test bool test_deyaccifyall2HH63() = run_case("deyaccifyall2HH63.glue",false);
void show_deyaccifyall2HH63() {run_case("deyaccifyall2HH63.glue",true);}
// deyaccifyall2HH64.glue
test bool test_deyaccifyall2HH64() = run_case("deyaccifyall2HH64.glue",false);
void show_deyaccifyall2HH64() {run_case("deyaccifyall2HH64.glue",true);}
// deyaccifyall2HH65.glue
test bool test_deyaccifyall2HH65() = run_case("deyaccifyall2HH65.glue",false);
void show_deyaccifyall2HH65() {run_case("deyaccifyall2HH65.glue",true);}
// deyaccifyall2HV11.glue
test bool test_deyaccifyall2HV11() = run_case("deyaccifyall2HV11.glue",false);
void show_deyaccifyall2HV11() {run_case("deyaccifyall2HV11.glue",true);}
// deyaccifyall2HV12.glue
test bool test_deyaccifyall2HV12() = run_case("deyaccifyall2HV12.glue",false);
void show_deyaccifyall2HV12() {run_case("deyaccifyall2HV12.glue",true);}
// deyaccifyall2HV13.glue
test bool test_deyaccifyall2HV13() = run_case("deyaccifyall2HV13.glue",false);
void show_deyaccifyall2HV13() {run_case("deyaccifyall2HV13.glue",true);}
// deyaccifyall2HV14.glue
test bool test_deyaccifyall2HV14() = run_case("deyaccifyall2HV14.glue",false);
void show_deyaccifyall2HV14() {run_case("deyaccifyall2HV14.glue",true);}
// deyaccifyall2HV15.glue
test bool test_deyaccifyall2HV15() = run_case("deyaccifyall2HV15.glue",false);
void show_deyaccifyall2HV15() {run_case("deyaccifyall2HV15.glue",true);}
// deyaccifyall2HV21.glue
test bool test_deyaccifyall2HV21() = run_case("deyaccifyall2HV21.glue",false);
void show_deyaccifyall2HV21() {run_case("deyaccifyall2HV21.glue",true);}
// deyaccifyall2HV22.glue
test bool test_deyaccifyall2HV22() = run_case("deyaccifyall2HV22.glue",false);
void show_deyaccifyall2HV22() {run_case("deyaccifyall2HV22.glue",true);}
// deyaccifyall2HV23.glue
test bool test_deyaccifyall2HV23() = run_case("deyaccifyall2HV23.glue",false);
void show_deyaccifyall2HV23() {run_case("deyaccifyall2HV23.glue",true);}
// deyaccifyall2HV24.glue
test bool test_deyaccifyall2HV24() = run_case("deyaccifyall2HV24.glue",false);
void show_deyaccifyall2HV24() {run_case("deyaccifyall2HV24.glue",true);}
// deyaccifyall2HV25.glue
test bool test_deyaccifyall2HV25() = run_case("deyaccifyall2HV25.glue",false);
void show_deyaccifyall2HV25() {run_case("deyaccifyall2HV25.glue",true);}
// deyaccifyall2HV31.glue
test bool test_deyaccifyall2HV31() = run_case("deyaccifyall2HV31.glue",false);
void show_deyaccifyall2HV31() {run_case("deyaccifyall2HV31.glue",true);}
// deyaccifyall2HV32.glue
test bool test_deyaccifyall2HV32() = run_case("deyaccifyall2HV32.glue",false);
void show_deyaccifyall2HV32() {run_case("deyaccifyall2HV32.glue",true);}
// deyaccifyall2HV33.glue
test bool test_deyaccifyall2HV33() = run_case("deyaccifyall2HV33.glue",false);
void show_deyaccifyall2HV33() {run_case("deyaccifyall2HV33.glue",true);}
// deyaccifyall2HV34.glue
test bool test_deyaccifyall2HV34() = run_case("deyaccifyall2HV34.glue",false);
void show_deyaccifyall2HV34() {run_case("deyaccifyall2HV34.glue",true);}
// deyaccifyall2HV35.glue
test bool test_deyaccifyall2HV35() = run_case("deyaccifyall2HV35.glue",false);
void show_deyaccifyall2HV35() {run_case("deyaccifyall2HV35.glue",true);}
// deyaccifyall2HV41.glue
test bool test_deyaccifyall2HV41() = run_case("deyaccifyall2HV41.glue",false);
void show_deyaccifyall2HV41() {run_case("deyaccifyall2HV41.glue",true);}
// deyaccifyall2HV42.glue
test bool test_deyaccifyall2HV42() = run_case("deyaccifyall2HV42.glue",false);
void show_deyaccifyall2HV42() {run_case("deyaccifyall2HV42.glue",true);}
// deyaccifyall2HV43.glue
test bool test_deyaccifyall2HV43() = run_case("deyaccifyall2HV43.glue",false);
void show_deyaccifyall2HV43() {run_case("deyaccifyall2HV43.glue",true);}
// deyaccifyall2HV44.glue
test bool test_deyaccifyall2HV44() = run_case("deyaccifyall2HV44.glue",false);
void show_deyaccifyall2HV44() {run_case("deyaccifyall2HV44.glue",true);}
// deyaccifyall2HV45.glue
test bool test_deyaccifyall2HV45() = run_case("deyaccifyall2HV45.glue",false);
void show_deyaccifyall2HV45() {run_case("deyaccifyall2HV45.glue",true);}
// deyaccifyall2HV51.glue
test bool test_deyaccifyall2HV51() = run_case("deyaccifyall2HV51.glue",false);
void show_deyaccifyall2HV51() {run_case("deyaccifyall2HV51.glue",true);}
// deyaccifyall2HV52.glue
test bool test_deyaccifyall2HV52() = run_case("deyaccifyall2HV52.glue",false);
void show_deyaccifyall2HV52() {run_case("deyaccifyall2HV52.glue",true);}
// deyaccifyall2HV53.glue
test bool test_deyaccifyall2HV53() = run_case("deyaccifyall2HV53.glue",false);
void show_deyaccifyall2HV53() {run_case("deyaccifyall2HV53.glue",true);}
// deyaccifyall2HV54.glue
test bool test_deyaccifyall2HV54() = run_case("deyaccifyall2HV54.glue",false);
void show_deyaccifyall2HV54() {run_case("deyaccifyall2HV54.glue",true);}
// deyaccifyall2HV55.glue
test bool test_deyaccifyall2HV55() = run_case("deyaccifyall2HV55.glue",false);
void show_deyaccifyall2HV55() {run_case("deyaccifyall2HV55.glue",true);}
// deyaccifyall2HV61.glue
test bool test_deyaccifyall2HV61() = run_case("deyaccifyall2HV61.glue",false);
void show_deyaccifyall2HV61() {run_case("deyaccifyall2HV61.glue",true);}
// deyaccifyall2HV62.glue
test bool test_deyaccifyall2HV62() = run_case("deyaccifyall2HV62.glue",false);
void show_deyaccifyall2HV62() {run_case("deyaccifyall2HV62.glue",true);}
// deyaccifyall2HV63.glue
test bool test_deyaccifyall2HV63() = run_case("deyaccifyall2HV63.glue",false);
void show_deyaccifyall2HV63() {run_case("deyaccifyall2HV63.glue",true);}
// deyaccifyall2HV64.glue
test bool test_deyaccifyall2HV64() = run_case("deyaccifyall2HV64.glue",false);
void show_deyaccifyall2HV64() {run_case("deyaccifyall2HV64.glue",true);}
// deyaccifyall2HV65.glue
test bool test_deyaccifyall2HV65() = run_case("deyaccifyall2HV65.glue",false);
void show_deyaccifyall2HV65() {run_case("deyaccifyall2HV65.glue",true);}
// deyaccifyall2VH11.glue
test bool test_deyaccifyall2VH11() = run_case("deyaccifyall2VH11.glue",false);
void show_deyaccifyall2VH11() {run_case("deyaccifyall2VH11.glue",true);}
// deyaccifyall2VH12.glue
test bool test_deyaccifyall2VH12() = run_case("deyaccifyall2VH12.glue",false);
void show_deyaccifyall2VH12() {run_case("deyaccifyall2VH12.glue",true);}
// deyaccifyall2VH13.glue
test bool test_deyaccifyall2VH13() = run_case("deyaccifyall2VH13.glue",false);
void show_deyaccifyall2VH13() {run_case("deyaccifyall2VH13.glue",true);}
// deyaccifyall2VH14.glue
test bool test_deyaccifyall2VH14() = run_case("deyaccifyall2VH14.glue",false);
void show_deyaccifyall2VH14() {run_case("deyaccifyall2VH14.glue",true);}
// deyaccifyall2VH15.glue
test bool test_deyaccifyall2VH15() = run_case("deyaccifyall2VH15.glue",false);
void show_deyaccifyall2VH15() {run_case("deyaccifyall2VH15.glue",true);}
// deyaccifyall2VH21.glue
test bool test_deyaccifyall2VH21() = run_case("deyaccifyall2VH21.glue",false);
void show_deyaccifyall2VH21() {run_case("deyaccifyall2VH21.glue",true);}
// deyaccifyall2VH22.glue
test bool test_deyaccifyall2VH22() = run_case("deyaccifyall2VH22.glue",false);
void show_deyaccifyall2VH22() {run_case("deyaccifyall2VH22.glue",true);}
// deyaccifyall2VH23.glue
test bool test_deyaccifyall2VH23() = run_case("deyaccifyall2VH23.glue",false);
void show_deyaccifyall2VH23() {run_case("deyaccifyall2VH23.glue",true);}
// deyaccifyall2VH24.glue
test bool test_deyaccifyall2VH24() = run_case("deyaccifyall2VH24.glue",false);
void show_deyaccifyall2VH24() {run_case("deyaccifyall2VH24.glue",true);}
// deyaccifyall2VH25.glue
test bool test_deyaccifyall2VH25() = run_case("deyaccifyall2VH25.glue",false);
void show_deyaccifyall2VH25() {run_case("deyaccifyall2VH25.glue",true);}
// deyaccifyall2VH31.glue
test bool test_deyaccifyall2VH31() = run_case("deyaccifyall2VH31.glue",false);
void show_deyaccifyall2VH31() {run_case("deyaccifyall2VH31.glue",true);}
// deyaccifyall2VH32.glue
test bool test_deyaccifyall2VH32() = run_case("deyaccifyall2VH32.glue",false);
void show_deyaccifyall2VH32() {run_case("deyaccifyall2VH32.glue",true);}
// deyaccifyall2VH33.glue
test bool test_deyaccifyall2VH33() = run_case("deyaccifyall2VH33.glue",false);
void show_deyaccifyall2VH33() {run_case("deyaccifyall2VH33.glue",true);}
// deyaccifyall2VH34.glue
test bool test_deyaccifyall2VH34() = run_case("deyaccifyall2VH34.glue",false);
void show_deyaccifyall2VH34() {run_case("deyaccifyall2VH34.glue",true);}
// deyaccifyall2VH35.glue
test bool test_deyaccifyall2VH35() = run_case("deyaccifyall2VH35.glue",false);
void show_deyaccifyall2VH35() {run_case("deyaccifyall2VH35.glue",true);}
// deyaccifyall2VH41.glue
test bool test_deyaccifyall2VH41() = run_case("deyaccifyall2VH41.glue",false);
void show_deyaccifyall2VH41() {run_case("deyaccifyall2VH41.glue",true);}
// deyaccifyall2VH42.glue
test bool test_deyaccifyall2VH42() = run_case("deyaccifyall2VH42.glue",false);
void show_deyaccifyall2VH42() {run_case("deyaccifyall2VH42.glue",true);}
// deyaccifyall2VH43.glue
test bool test_deyaccifyall2VH43() = run_case("deyaccifyall2VH43.glue",false);
void show_deyaccifyall2VH43() {run_case("deyaccifyall2VH43.glue",true);}
// deyaccifyall2VH44.glue
test bool test_deyaccifyall2VH44() = run_case("deyaccifyall2VH44.glue",false);
void show_deyaccifyall2VH44() {run_case("deyaccifyall2VH44.glue",true);}
// deyaccifyall2VH45.glue
test bool test_deyaccifyall2VH45() = run_case("deyaccifyall2VH45.glue",false);
void show_deyaccifyall2VH45() {run_case("deyaccifyall2VH45.glue",true);}
// deyaccifyall2VH51.glue
test bool test_deyaccifyall2VH51() = run_case("deyaccifyall2VH51.glue",false);
void show_deyaccifyall2VH51() {run_case("deyaccifyall2VH51.glue",true);}
// deyaccifyall2VH52.glue
test bool test_deyaccifyall2VH52() = run_case("deyaccifyall2VH52.glue",false);
void show_deyaccifyall2VH52() {run_case("deyaccifyall2VH52.glue",true);}
// deyaccifyall2VH53.glue
test bool test_deyaccifyall2VH53() = run_case("deyaccifyall2VH53.glue",false);
void show_deyaccifyall2VH53() {run_case("deyaccifyall2VH53.glue",true);}
// deyaccifyall2VH54.glue
test bool test_deyaccifyall2VH54() = run_case("deyaccifyall2VH54.glue",false);
void show_deyaccifyall2VH54() {run_case("deyaccifyall2VH54.glue",true);}
// deyaccifyall2VH55.glue
test bool test_deyaccifyall2VH55() = run_case("deyaccifyall2VH55.glue",false);
void show_deyaccifyall2VH55() {run_case("deyaccifyall2VH55.glue",true);}
// deyaccifyall2VH61.glue
test bool test_deyaccifyall2VH61() = run_case("deyaccifyall2VH61.glue",false);
void show_deyaccifyall2VH61() {run_case("deyaccifyall2VH61.glue",true);}
// deyaccifyall2VH62.glue
test bool test_deyaccifyall2VH62() = run_case("deyaccifyall2VH62.glue",false);
void show_deyaccifyall2VH62() {run_case("deyaccifyall2VH62.glue",true);}
// deyaccifyall2VH63.glue
test bool test_deyaccifyall2VH63() = run_case("deyaccifyall2VH63.glue",false);
void show_deyaccifyall2VH63() {run_case("deyaccifyall2VH63.glue",true);}
// deyaccifyall2VH64.glue
test bool test_deyaccifyall2VH64() = run_case("deyaccifyall2VH64.glue",false);
void show_deyaccifyall2VH64() {run_case("deyaccifyall2VH64.glue",true);}
// deyaccifyall2VH65.glue
test bool test_deyaccifyall2VH65() = run_case("deyaccifyall2VH65.glue",false);
void show_deyaccifyall2VH65() {run_case("deyaccifyall2VH65.glue",true);}
// deyaccifyall2VV11.glue
test bool test_deyaccifyall2VV11() = run_case("deyaccifyall2VV11.glue",false);
void show_deyaccifyall2VV11() {run_case("deyaccifyall2VV11.glue",true);}
// deyaccifyall2VV12.glue
test bool test_deyaccifyall2VV12() = run_case("deyaccifyall2VV12.glue",false);
void show_deyaccifyall2VV12() {run_case("deyaccifyall2VV12.glue",true);}
// deyaccifyall2VV13.glue
test bool test_deyaccifyall2VV13() = run_case("deyaccifyall2VV13.glue",false);
void show_deyaccifyall2VV13() {run_case("deyaccifyall2VV13.glue",true);}
// deyaccifyall2VV14.glue
test bool test_deyaccifyall2VV14() = run_case("deyaccifyall2VV14.glue",false);
void show_deyaccifyall2VV14() {run_case("deyaccifyall2VV14.glue",true);}
// deyaccifyall2VV15.glue
test bool test_deyaccifyall2VV15() = run_case("deyaccifyall2VV15.glue",false);
void show_deyaccifyall2VV15() {run_case("deyaccifyall2VV15.glue",true);}
// deyaccifyall2VV21.glue
test bool test_deyaccifyall2VV21() = run_case("deyaccifyall2VV21.glue",false);
void show_deyaccifyall2VV21() {run_case("deyaccifyall2VV21.glue",true);}
// deyaccifyall2VV22.glue
test bool test_deyaccifyall2VV22() = run_case("deyaccifyall2VV22.glue",false);
void show_deyaccifyall2VV22() {run_case("deyaccifyall2VV22.glue",true);}
// deyaccifyall2VV23.glue
test bool test_deyaccifyall2VV23() = run_case("deyaccifyall2VV23.glue",false);
void show_deyaccifyall2VV23() {run_case("deyaccifyall2VV23.glue",true);}
// deyaccifyall2VV24.glue
test bool test_deyaccifyall2VV24() = run_case("deyaccifyall2VV24.glue",false);
void show_deyaccifyall2VV24() {run_case("deyaccifyall2VV24.glue",true);}
// deyaccifyall2VV25.glue
test bool test_deyaccifyall2VV25() = run_case("deyaccifyall2VV25.glue",false);
void show_deyaccifyall2VV25() {run_case("deyaccifyall2VV25.glue",true);}
// deyaccifyall2VV31.glue
test bool test_deyaccifyall2VV31() = run_case("deyaccifyall2VV31.glue",false);
void show_deyaccifyall2VV31() {run_case("deyaccifyall2VV31.glue",true);}
// deyaccifyall2VV32.glue
test bool test_deyaccifyall2VV32() = run_case("deyaccifyall2VV32.glue",false);
void show_deyaccifyall2VV32() {run_case("deyaccifyall2VV32.glue",true);}
// deyaccifyall2VV33.glue
test bool test_deyaccifyall2VV33() = run_case("deyaccifyall2VV33.glue",false);
void show_deyaccifyall2VV33() {run_case("deyaccifyall2VV33.glue",true);}
// deyaccifyall2VV34.glue
test bool test_deyaccifyall2VV34() = run_case("deyaccifyall2VV34.glue",false);
void show_deyaccifyall2VV34() {run_case("deyaccifyall2VV34.glue",true);}
// deyaccifyall2VV35.glue
test bool test_deyaccifyall2VV35() = run_case("deyaccifyall2VV35.glue",false);
void show_deyaccifyall2VV35() {run_case("deyaccifyall2VV35.glue",true);}
// deyaccifyall2VV41.glue
test bool test_deyaccifyall2VV41() = run_case("deyaccifyall2VV41.glue",false);
void show_deyaccifyall2VV41() {run_case("deyaccifyall2VV41.glue",true);}
// deyaccifyall2VV42.glue
test bool test_deyaccifyall2VV42() = run_case("deyaccifyall2VV42.glue",false);
void show_deyaccifyall2VV42() {run_case("deyaccifyall2VV42.glue",true);}
// deyaccifyall2VV43.glue
test bool test_deyaccifyall2VV43() = run_case("deyaccifyall2VV43.glue",false);
void show_deyaccifyall2VV43() {run_case("deyaccifyall2VV43.glue",true);}
// deyaccifyall2VV44.glue
test bool test_deyaccifyall2VV44() = run_case("deyaccifyall2VV44.glue",false);
void show_deyaccifyall2VV44() {run_case("deyaccifyall2VV44.glue",true);}
// deyaccifyall2VV45.glue
test bool test_deyaccifyall2VV45() = run_case("deyaccifyall2VV45.glue",false);
void show_deyaccifyall2VV45() {run_case("deyaccifyall2VV45.glue",true);}
// deyaccifyall2VV51.glue
test bool test_deyaccifyall2VV51() = run_case("deyaccifyall2VV51.glue",false);
void show_deyaccifyall2VV51() {run_case("deyaccifyall2VV51.glue",true);}
// deyaccifyall2VV52.glue
test bool test_deyaccifyall2VV52() = run_case("deyaccifyall2VV52.glue",false);
void show_deyaccifyall2VV52() {run_case("deyaccifyall2VV52.glue",true);}
// deyaccifyall2VV53.glue
test bool test_deyaccifyall2VV53() = run_case("deyaccifyall2VV53.glue",false);
void show_deyaccifyall2VV53() {run_case("deyaccifyall2VV53.glue",true);}
// deyaccifyall2VV54.glue
test bool test_deyaccifyall2VV54() = run_case("deyaccifyall2VV54.glue",false);
void show_deyaccifyall2VV54() {run_case("deyaccifyall2VV54.glue",true);}
// deyaccifyall2VV55.glue
test bool test_deyaccifyall2VV55() = run_case("deyaccifyall2VV55.glue",false);
void show_deyaccifyall2VV55() {run_case("deyaccifyall2VV55.glue",true);}
// deyaccifyall2VV61.glue
test bool test_deyaccifyall2VV61() = run_case("deyaccifyall2VV61.glue",false);
void show_deyaccifyall2VV61() {run_case("deyaccifyall2VV61.glue",true);}
// deyaccifyall2VV62.glue
test bool test_deyaccifyall2VV62() = run_case("deyaccifyall2VV62.glue",false);
void show_deyaccifyall2VV62() {run_case("deyaccifyall2VV62.glue",true);}
// deyaccifyall2VV63.glue
test bool test_deyaccifyall2VV63() = run_case("deyaccifyall2VV63.glue",false);
void show_deyaccifyall2VV63() {run_case("deyaccifyall2VV63.glue",true);}
// deyaccifyall2VV64.glue
test bool test_deyaccifyall2VV64() = run_case("deyaccifyall2VV64.glue",false);
void show_deyaccifyall2VV64() {run_case("deyaccifyall2VV64.glue",true);}
// deyaccifyall2VV65.glue
test bool test_deyaccifyall2VV65() = run_case("deyaccifyall2VV65.glue",false);
void show_deyaccifyall2VV65() {run_case("deyaccifyall2VV65.glue",true);}
// SLEIR:DistributeAll: 3 tests
// distributeall1.glue
test bool test_distributeall1() = run_case("distributeall1.glue",false);
void show_distributeall1() {run_case("distributeall1.glue",true);}
// distributeall2.glue
test bool test_distributeall2() = run_case("distributeall2.glue",false);
void show_distributeall2() {run_case("distributeall2.glue",true);}
// distributeall3.glue
test bool test_distributeall3() = run_case("distributeall3.glue",false);
void show_distributeall3() {run_case("distributeall3.glue",true);}
// SLEIR:EliminateTop: 4 tests
// eliminatetop1.glue
test bool test_eliminatetop1() = run_case("eliminatetop1.glue",false);
void show_eliminatetop1() {run_case("eliminatetop1.glue",true);}
// eliminatetop2.glue
test bool test_eliminatetop2() = run_case("eliminatetop2.glue",false);
void show_eliminatetop2() {run_case("eliminatetop2.glue",true);}
// eliminatetop3.glue
test bool test_eliminatetop3() = run_case("eliminatetop3.glue",false);
void show_eliminatetop3() {run_case("eliminatetop3.glue",true);}
// eliminatetop4.glue
test bool test_eliminatetop4() = run_case("eliminatetop4.glue",false);
void show_eliminatetop4() {run_case("eliminatetop4.glue",true);}
// SLEIR:EquateAll: 4 tests
// equateall1.glue
test bool test_equateall1() = run_case("equateall1.glue",false);
void show_equateall1() {run_case("equateall1.glue",true);}
// equateall2.glue
test bool test_equateall2() = run_case("equateall2.glue",false);
void show_equateall2() {run_case("equateall2.glue",true);}
// equateall3.glue
test bool test_equateall3() = run_case("equateall3.glue",false);
void show_equateall3() {run_case("equateall3.glue",true);}
// equateall4.glue
test bool test_equateall4() = run_case("equateall4.glue",false);
void show_equateall4() {run_case("equateall4.glue",true);}
// SLEIR:FoldMax: 4 tests
// foldmax1.glue
test bool test_foldmax1() = run_case("foldmax1.glue",false);
void show_foldmax1() {run_case("foldmax1.glue",true);}
// foldmax2.glue
test bool test_foldmax2() = run_case("foldmax2.glue",false);
void show_foldmax2() {run_case("foldmax2.glue",true);}
// foldmax3.glue
test bool test_foldmax3() = run_case("foldmax3.glue",false);
void show_foldmax3() {run_case("foldmax3.glue",true);}
// foldmax4.glue
test bool test_foldmax4() = run_case("foldmax4.glue",false);
void show_foldmax4() {run_case("foldmax4.glue",true);}
// SLEIR:HorizontalAll: 0 tests

// SLEIR:InlineMax: 5 tests
// inlinemax1.glue
test bool test_inlinemax1() = run_case("inlinemax1.glue",false);
void show_inlinemax1() {run_case("inlinemax1.glue",true);}
// inlinemax2.glue
test bool test_inlinemax2() = run_case("inlinemax2.glue",false);
void show_inlinemax2() {run_case("inlinemax2.glue",true);}
// inlinemax3.glue
test bool test_inlinemax3() = run_case("inlinemax3.glue",false);
void show_inlinemax3() {run_case("inlinemax3.glue",true);}
// inlinemax4.glue
test bool test_inlinemax4() = run_case("inlinemax4.glue",false);
void show_inlinemax4() {run_case("inlinemax4.glue",true);}
// inlinemax5.glue
test bool test_inlinemax5() = run_case("inlinemax5.glue",false);
void show_inlinemax5() {run_case("inlinemax5.glue",true);}
// SLEIR:InlinePlus: 4 tests
// inlineplus1.glue
test bool test_inlineplus1() = run_case("inlineplus1.glue",false);
void show_inlineplus1() {run_case("inlineplus1.glue",true);}
// inlineplus2.glue
test bool test_inlineplus2() = run_case("inlineplus2.glue",false);
void show_inlineplus2() {run_case("inlineplus2.glue",true);}
// inlineplus3.glue
test bool test_inlineplus3() = run_case("inlineplus3.glue",false);
void show_inlineplus3() {run_case("inlineplus3.glue",true);}
// inlineplus4.glue
test bool test_inlineplus4() = run_case("inlineplus4.glue",false);
void show_inlineplus4() {run_case("inlineplus4.glue",true);}
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

// SLEIR:Reroot2top: 5 tests
// reroot2top1.glue
test bool test_reroot2top1() = run_case("reroot2top1.glue",false);
void show_reroot2top1() {run_case("reroot2top1.glue",true);}
// reroot2top2.glue
test bool test_reroot2top2() = run_case("reroot2top2.glue",false);
void show_reroot2top2() {run_case("reroot2top2.glue",true);}
// reroot2top3.glue
test bool test_reroot2top3() = run_case("reroot2top3.glue",false);
void show_reroot2top3() {run_case("reroot2top3.glue",true);}
// reroot2top4.glue
test bool test_reroot2top4() = run_case("reroot2top4.glue",false);
void show_reroot2top4() {run_case("reroot2top4.glue",true);}
// reroot2top5.glue
test bool test_reroot2top5() = run_case("reroot2top5.glue",false);
void show_reroot2top5() {run_case("reroot2top5.glue",true);}
// SLEIR:RetireLs: 7 tests
// retirels1.glue
test bool test_retirels1() = run_case("retirels1.glue",false);
void show_retirels1() {run_case("retirels1.glue",true);}
// retirels2.glue
test bool test_retirels2() = run_case("retirels2.glue",false);
void show_retirels2() {run_case("retirels2.glue",true);}
// retirels3.glue
test bool test_retirels3() = run_case("retirels3.glue",false);
void show_retirels3() {run_case("retirels3.glue",true);}
// retirels4.glue
test bool test_retirels4() = run_case("retirels4.glue",false);
void show_retirels4() {run_case("retirels4.glue",true);}
// retirels5.glue
test bool test_retirels5() = run_case("retirels5.glue",false);
void show_retirels5() {run_case("retirels5.glue",true);}
// retirels6.glue
test bool test_retirels6() = run_case("retirels6.glue",false);
void show_retirels6() {run_case("retirels6.glue",true);}
// retirels7.glue
test bool test_retirels7() = run_case("retirels7.glue",false);
void show_retirels7() {run_case("retirels7.glue",true);}
// SLEIR:RetireMs: 8 tests
// retirems1.glue
test bool test_retirems1() = run_case("retirems1.glue",false);
void show_retirems1() {run_case("retirems1.glue",true);}
// retirems2.glue
test bool test_retirems2() = run_case("retirems2.glue",false);
void show_retirems2() {run_case("retirems2.glue",true);}
// retirems3.glue
test bool test_retirems3() = run_case("retirems3.glue",false);
void show_retirems3() {run_case("retirems3.glue",true);}
// retirems4.glue
test bool test_retirems4() = run_case("retirems4.glue",false);
void show_retirems4() {run_case("retirems4.glue",true);}
// retirems5.glue
test bool test_retirems5() = run_case("retirems5.glue",false);
void show_retirems5() {run_case("retirems5.glue",true);}
// retirems6.glue
test bool test_retirems6() = run_case("retirems6.glue",false);
void show_retirems6() {run_case("retirems6.glue",true);}
// retirems7.glue
test bool test_retirems7() = run_case("retirems7.glue",false);
void show_retirems7() {run_case("retirems7.glue",true);}
// retirems8.glue
test bool test_retirems8() = run_case("retirems8.glue",false);
void show_retirems8() {run_case("retirems8.glue",true);}
// SLEIR:RetireTs: 9 tests
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
// SLEIR:SplitAllT: 8 tests
// splitallt1.glue
test bool test_splitallt1() = run_case("splitallt1.glue",false);
void show_splitallt1() {run_case("splitallt1.glue",true);}
// splitallt2.glue
test bool test_splitallt2() = run_case("splitallt2.glue",false);
void show_splitallt2() {run_case("splitallt2.glue",true);}
// splitallt3.glue
test bool test_splitallt3() = run_case("splitallt3.glue",false);
void show_splitallt3() {run_case("splitallt3.glue",true);}
// splitallt4.glue
test bool test_splitallt4() = run_case("splitallt4.glue",false);
void show_splitallt4() {run_case("splitallt4.glue",true);}
// splitallt5.glue
test bool test_splitallt5() = run_case("splitallt5.glue",false);
void show_splitallt5() {run_case("splitallt5.glue",true);}
// splitallt6.glue
test bool test_splitallt6() = run_case("splitallt6.glue",false);
void show_splitallt6() {run_case("splitallt6.glue",true);}
// splitallt7.glue
test bool test_splitallt7() = run_case("splitallt7.glue",false);
void show_splitallt7() {run_case("splitallt7.glue",true);}
// splitallt8.glue
test bool test_splitallt8() = run_case("splitallt8.glue",false);
void show_splitallt8() {run_case("splitallt8.glue",true);}
// SLEIR:UnchainAll: 0 tests

// SLEIR:UndefineTrivial: 5 tests
// undefinetrivial1.glue
test bool test_undefinetrivial1() = run_case("undefinetrivial1.glue",false);
void show_undefinetrivial1() {run_case("undefinetrivial1.glue",true);}
// undefinetrivial2.glue
test bool test_undefinetrivial2() = run_case("undefinetrivial2.glue",false);
void show_undefinetrivial2() {run_case("undefinetrivial2.glue",true);}
// undefinetrivial3.glue
test bool test_undefinetrivial3() = run_case("undefinetrivial3.glue",false);
void show_undefinetrivial3() {run_case("undefinetrivial3.glue",true);}
// undefinetrivial4.glue
test bool test_undefinetrivial4() = run_case("undefinetrivial4.glue",false);
void show_undefinetrivial4() {run_case("undefinetrivial4.glue",true);}
// undefinetrivial5.glue
test bool test_undefinetrivial5() = run_case("undefinetrivial5.glue",false);
void show_undefinetrivial5() {run_case("undefinetrivial5.glue",true);}
// SLEIR:UnfoldMax: 5 tests
// unfoldmax1.glue
test bool test_unfoldmax1() = run_case("unfoldmax1.glue",false);
void show_unfoldmax1() {run_case("unfoldmax1.glue",true);}
// unfoldmax2.glue
test bool test_unfoldmax2() = run_case("unfoldmax2.glue",false);
void show_unfoldmax2() {run_case("unfoldmax2.glue",true);}
// unfoldmax3.glue
test bool test_unfoldmax3() = run_case("unfoldmax3.glue",false);
void show_unfoldmax3() {run_case("unfoldmax3.glue",true);}
// unfoldmax4.glue
test bool test_unfoldmax4() = run_case("unfoldmax4.glue",false);
void show_unfoldmax4() {run_case("unfoldmax4.glue",true);}
// unfoldmax5.glue
test bool test_unfoldmax5() = run_case("unfoldmax5.glue",false);
void show_unfoldmax5() {run_case("unfoldmax5.glue",true);}
// SLEIR:VerticalAll: 0 tests

// SLEIR:WidenOpt2Star: 0 tests

// SLEIR:WidenPlus2Star: 0 tests

// SLEIR:WidenX2Opt: 0 tests

// SLEIR:WidenX2Plus: 0 tests

// SLEIR:WidenX2Star: 0 tests

// SLEIR:YaccifyAllL: 0 tests

// SLEIR:YaccifyAllR: 0 tests

