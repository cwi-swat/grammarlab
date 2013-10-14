@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module meta::UpdateXBGFTests

import String;
import IO;

public void main()
{
	loc base = |project://grammarlab/src/tests/transform/set|;
	str buffer = "@contributor{Super Awesome Automated XBGF Test Suite Synchroniser}
		'@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
		'module tests::transform::XBGF
		'
		'import IO;
		'import grammarlab::language::Grammar;
		'import grammarlab::export::Grammar;
		'import grammarlab::compare::Differ;
		'import grammarlab::language::GlueScript;
		'import meta::Glue;
		'
		'bool run_case(str casen, bool debug)
		'{
		'	GGrammar uit = execute(EmptyGrammar,loadGlue(|project://grammarlab/src/tests/transform/set/\<casen\>|));
		'	bool res = false;
		'	if (debug) res = gdtv(uit,EmptyGrammar);
		'	else res = gdts(uit,EmptyGrammar);
		'	if (!res) println(\"[FAIL] |project://grammarlab/src/tests/transform/set/\<casen\>|\");		
		'	if (!res && debug) println(\"Remaining grammar: \<ppx(uit,GlueEBNF)\>\");
		'	return res;
		'}
		'";
	for (f <- listEntries(base), endsWith(f,".glue"))
	{
		name = replaceLast(f,".glue","");
		buffer += "
		'// <f>
		'test bool test_<name>() = run_case(\"<f>\",false);
		'void show_<name>() {run_case(\"<f>\",true);}
		'";
	}
	writeFile(|project://grammarlab/src/tests/transform/XBGF.rsc|, buffer);
}

