@contributor{Super Awesome Automated SLEIR Test Suite Synchroniser}
@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module \test::SLEIR

import IO;
import grammarlab::language::Grammar;
import grammarlab::export::Grammar;
import grammarlab::compare::Differ;
import grammarlab::language::GlueScript;
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

// deyaccifyallHeps.glue
test bool test_deyaccifyallHeps() = run_case("deyaccifyallHeps.glue",false);
void show_deyaccifyallHeps() {run_case("deyaccifyallHeps.glue",true);}

// deyaccifyallHleft.glue
test bool test_deyaccifyallHleft() = run_case("deyaccifyallHleft.glue",false);
void show_deyaccifyallHleft() {run_case("deyaccifyallHleft.glue",true);}

// deyaccifyallHleft_plus.glue
test bool test_deyaccifyallHleft_plus() = run_case("deyaccifyallHleft_plus.glue",false);
void show_deyaccifyallHleft_plus() {run_case("deyaccifyallHleft_plus.glue",true);}

// deyaccifyallHright.glue
test bool test_deyaccifyallHright() = run_case("deyaccifyallHright.glue",false);
void show_deyaccifyallHright() {run_case("deyaccifyallHright.glue",true);}

// deyaccifyallHright_plus.glue
test bool test_deyaccifyallHright_plus() = run_case("deyaccifyallHright_plus.glue",false);
void show_deyaccifyallHright_plus() {run_case("deyaccifyallHright_plus.glue",true);}

// deyaccifyallVeps.glue
test bool test_deyaccifyallVeps() = run_case("deyaccifyallVeps.glue",false);
void show_deyaccifyallVeps() {run_case("deyaccifyallVeps.glue",true);}

// deyaccifyallVleft.glue
test bool test_deyaccifyallVleft() = run_case("deyaccifyallVleft.glue",false);
void show_deyaccifyallVleft() {run_case("deyaccifyallVleft.glue",true);}

// deyaccifyallVleft_plus.glue
test bool test_deyaccifyallVleft_plus() = run_case("deyaccifyallVleft_plus.glue",false);
void show_deyaccifyallVleft_plus() {run_case("deyaccifyallVleft_plus.glue",true);}

// deyaccifyallVright.glue
test bool test_deyaccifyallVright() = run_case("deyaccifyallVright.glue",false);
void show_deyaccifyallVright() {run_case("deyaccifyallVright.glue",true);}

// deyaccifyallVright_plus.glue
test bool test_deyaccifyallVright_plus() = run_case("deyaccifyallVright_plus.glue",false);
void show_deyaccifyallVright_plus() {run_case("deyaccifyallVright_plus.glue",true);}
