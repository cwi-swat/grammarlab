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

// deyaccify_eps.glue
test bool test_deyaccify_eps() = run_case("deyaccify_eps.glue",false);
void show_deyaccify_eps() {run_case("deyaccify_eps.glue",true);}

// deyaccify_left.glue
test bool test_deyaccify_left() = run_case("deyaccify_left.glue",false);
void show_deyaccify_left() {run_case("deyaccify_left.glue",true);}

// deyaccify_left_plus.glue
test bool test_deyaccify_left_plus() = run_case("deyaccify_left_plus.glue",false);
void show_deyaccify_left_plus() {run_case("deyaccify_left_plus.glue",true);}

// deyaccify_right.glue
test bool test_deyaccify_right() = run_case("deyaccify_right.glue",false);
void show_deyaccify_right() {run_case("deyaccify_right.glue",true);}

// deyaccify_right_plus.glue
test bool test_deyaccify_right_plus() = run_case("deyaccify_right_plus.glue",false);
void show_deyaccify_right_plus() {run_case("deyaccify_right_plus.glue",true);}
