@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module meta::sync::SLEIRTests

import String;
import IO;

// meta::sync::SLEIRTests::main()
public void main()
{
	loc base = |project://grammarlab/src/test/set/sleir|;
	str buffer = "@contributor{Super Awesome Automated SLEIR Test Suite Synchroniser}
		'@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
		'module \\test::SLEIR
		'
		'import IO;
		'import grammarlab::language::Grammar;
		'import grammarlab::export::Grammar;
		'import grammarlab::compare::Differ;
		'import grammarlab::language::GLUE;
		'import grammarlab::language::glue::Interpreter;
		'import grammarlab::io::GLUE;
		'import grammarlab::lib::ebnf::Glue;
		'
		'bool run_case(str casen, bool debug)
		'{
		'	GGrammar uit = execute(EmptyGrammar,loadGlue(|project://grammarlab/src/test/set/sleir/\<casen\>|));
		'	bool res = false;
		'	if (debug) res = gdtv(uit,EmptyGrammar);
		'	else res = gdts(uit,EmptyGrammar);
		'	if (!res) println(\"[FAIL] |project://grammarlab/src/test/set/sleir/\<casen\>|\");		
		'	if (!res && debug) println(\"Remaining grammar: \<ppx(uit,GlueEBNF)\>\");
		'	return res;
		'}
		'";
	for (f <- listEntries(base), endsWith(f,".glue"))
	{
		name = replaceLast(f,".glue","");
		buffer += "// <f>
		'test bool test_<name>() = run_case(\"<f>\",false);
		'void show_<name>() {run_case(\"<f>\",true);}
		'";
	}
	writeFile(|project://grammarlab/src/test/SLEIR.rsc|, buffer);
}
