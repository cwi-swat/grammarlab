@contributor{Super Awesome Automated GDT Test Suite Synchroniser}
@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module \test::Differ

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
	GGrammar uit = execute(EmptyGrammar,loadGlue(|project://grammarlab/src/test/set/diff/<casen>|));
	bool res = false;
	if (debug) res = gdtv(uit,EmptyGrammar);
	else res = gdts(uit,EmptyGrammar);
	if (!res) println("[FAIL] |project://grammarlab/src/test/set/diff/<casen>|");		
	if (!res && debug) println("Remaining grammar: <ppx(uit,GlueEBNF)>");
	return res;
}

// negN2.glue
test bool test_negN2() = !run_case("negN2.glue",false);
void show_negN2() {run_case("negN2.glue",true);}

// negO2.glue
test bool test_negO2() = !run_case("negO2.glue",false);
void show_negO2() {run_case("negO2.glue",true);}

// negR4.glue
test bool test_negR4() = !run_case("negR4.glue",false);
void show_negR4() {run_case("negR4.glue",true);}

// negR5.glue
test bool test_negR5() = !run_case("negR5.glue",false);
void show_negR5() {run_case("negR5.glue",true);}

// negR6.glue
test bool test_negR6() = !run_case("negR6.glue",false);
void show_negR6() {run_case("negR6.glue",true);}

// negR7.glue
test bool test_negR7() = !run_case("negR7.glue",false);
void show_negR7() {run_case("negR7.glue",true);}

// negS3.glue
test bool test_negS3() = !run_case("negS3.glue",false);
void show_negS3() {run_case("negS3.glue",true);}

// negS4.glue
test bool test_negS4() = !run_case("negS4.glue",false);
void show_negS4() {run_case("negS4.glue",true);}

// negS5.glue
test bool test_negS5() = !run_case("negS5.glue",false);
void show_negS5() {run_case("negS5.glue",true);}

// negS6.glue
test bool test_negS6() = !run_case("negS6.glue",false);
void show_negS6() {run_case("negS6.glue",true);}

// negS7.glue
test bool test_negS7() = !run_case("negS7.glue",false);
void show_negS7() {run_case("negS7.glue",true);}

// negS8.glue
test bool test_negS8() = !run_case("negS8.glue",false);
void show_negS8() {run_case("negS8.glue",true);}

// negS9.glue
test bool test_negS9() = !run_case("negS9.glue",false);
void show_negS9() {run_case("negS9.glue",true);}

// negSL3.glue
test bool test_negSL3() = !run_case("negSL3.glue",false);
void show_negSL3() {run_case("negSL3.glue",true);}

// negSL4.glue
test bool test_negSL4() = !run_case("negSL4.glue",false);
void show_negSL4() {run_case("negSL4.glue",true);}

// negSL5.glue
test bool test_negSL5() = !run_case("negSL5.glue",false);
void show_negSL5() {run_case("negSL5.glue",true);}

// negSL6.glue
test bool test_negSL6() = !run_case("negSL6.glue",false);
void show_negSL6() {run_case("negSL6.glue",true);}

// negSL7.glue
test bool test_negSL7() = !run_case("negSL7.glue",false);
void show_negSL7() {run_case("negSL7.glue",true);}

// negSL8.glue
test bool test_negSL8() = !run_case("negSL8.glue",false);
void show_negSL8() {run_case("negSL8.glue",true);}

// negSL9.glue
test bool test_negSL9() = !run_case("negSL9.glue",false);
void show_negSL9() {run_case("negSL9.glue",true);}

// negT2.glue
test bool test_negT2() = !run_case("negT2.glue",false);
void show_negT2() {run_case("negT2.glue",true);}

// negV2.glue
test bool test_negV2() = !run_case("negV2.glue",false);
void show_negV2() {run_case("negV2.glue",true);}

// negV3.glue
test bool test_negV3() = !run_case("negV3.glue",false);
void show_negV3() {run_case("negV3.glue",true);}

// negV4.glue
test bool test_negV4() = !run_case("negV4.glue",false);
void show_negV4() {run_case("negV4.glue",true);}

// negV6.glue
test bool test_negV6() = !run_case("negV6.glue",false);
void show_negV6() {run_case("negV6.glue",true);}

// negV7.glue
test bool test_negV7() = !run_case("negV7.glue",false);
void show_negV7() {run_case("negV7.glue",true);}

// negV8.glue
test bool test_negV8() = !run_case("negV8.glue",false);
void show_negV8() {run_case("negV8.glue",true);}

// posA1.glue
test bool test_posA1() = run_case("posA1.glue",false);
void show_posA1() {run_case("posA1.glue",true);}

// posC1.glue
test bool test_posC1() = run_case("posC1.glue",false);
void show_posC1() {run_case("posC1.glue",true);}

// posC2.glue
test bool test_posC2() = run_case("posC2.glue",false);
void show_posC2() {run_case("posC2.glue",true);}

// posE1.glue
test bool test_posE1() = run_case("posE1.glue",false);
void show_posE1() {run_case("posE1.glue",true);}

// posF1.glue
test bool test_posF1() = run_case("posF1.glue",false);
void show_posF1() {run_case("posF1.glue",true);}

// posMerge1.glue
test bool test_posMerge1() = run_case("posMerge1.glue",false);
void show_posMerge1() {run_case("posMerge1.glue",true);}

// posMerge2.glue
test bool test_posMerge2() = run_case("posMerge2.glue",false);
void show_posMerge2() {run_case("posMerge2.glue",true);}

// posMerge3.glue
test bool test_posMerge3() = run_case("posMerge3.glue",false);
void show_posMerge3() {run_case("posMerge3.glue",true);}

// posMerge4.glue
test bool test_posMerge4() = run_case("posMerge4.glue",false);
void show_posMerge4() {run_case("posMerge4.glue",true);}

// posMerge5.glue
test bool test_posMerge5() = run_case("posMerge5.glue",false);
void show_posMerge5() {run_case("posMerge5.glue",true);}

// posN1.glue
test bool test_posN1() = run_case("posN1.glue",false);
void show_posN1() {run_case("posN1.glue",true);}

// posO1.glue
test bool test_posO1() = run_case("posO1.glue",false);
void show_posO1() {run_case("posO1.glue",true);}

// posR1.glue
test bool test_posR1() = run_case("posR1.glue",false);
void show_posR1() {run_case("posR1.glue",true);}

// posR2.glue
test bool test_posR2() = run_case("posR2.glue",false);
void show_posR2() {run_case("posR2.glue",true);}

// posR3.glue
test bool test_posR3() = run_case("posR3.glue",false);
void show_posR3() {run_case("posR3.glue",true);}

// posS1.glue
test bool test_posS1() = run_case("posS1.glue",false);
void show_posS1() {run_case("posS1.glue",true);}

// posS2.glue
test bool test_posS2() = run_case("posS2.glue",false);
void show_posS2() {run_case("posS2.glue",true);}

// posSL1.glue
test bool test_posSL1() = run_case("posSL1.glue",false);
void show_posSL1() {run_case("posSL1.glue",true);}

// posSL2.glue
test bool test_posSL2() = run_case("posSL2.glue",false);
void show_posSL2() {run_case("posSL2.glue",true);}

// posT1.glue
test bool test_posT1() = run_case("posT1.glue",false);
void show_posT1() {run_case("posT1.glue",true);}

// posV1.glue
test bool test_posV1() = run_case("posV1.glue",false);
void show_posV1() {run_case("posV1.glue",true);}

// posV5.glue
test bool test_posV5() = run_case("posV5.glue",false);
void show_posV5() {run_case("posV5.glue",true);}

// posV9.glue
test bool test_posV9() = run_case("posV9.glue",false);
void show_posV9() {run_case("posV9.glue",true);}
