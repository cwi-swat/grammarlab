@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module meta::sync::SLEIRTests

import grammarlab::language::Grammar;
import grammarlab::Extractors;
import String;
import List;
import IO;

str whichOne(str tname, list[str] onames)
{
	for (str oname <- onames)
		if (startsWith(tname,oname))
			return oname;
	return "Unknown";
}

// meta::sync::SLEIRTests::main()
public void main()
{
	list[str] sleir = [n |
		GProd p <- rscd2bgf(|project://grammarlab/src/grammarlab/language/SLEIR.rsc|).P,
		choice(L) := p.rhs,
		e <- L,
		label(n,epsilon()) := e
	];
	map[str,list[str]] perop = (op:[] | op <- sleir);
	perop["Unknown"] = [];
	println(sleir);
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
		op = whichOne(name,sleir);
		println("Processing <name> as <op>...");
		perop[op] += ["// <f>
		'test bool test_<name>() = run_case(\"<f>\",false);
		'void show_<name>() {run_case(\"<f>\",true);}"];
	}
	for (str op <- sleir)
		buffer += "// SLEIR:<op>: <size(perop[op])> tests\n"+intercalate("\n",perop[op])+"\n";
	if (size(perop["Unknown"])>0)
		buffer += "//////////////////////////////////////////
		'// Unknown:
		'" + intercalate("\n",perop["Unknown"]);
	writeFile(|project://grammarlab/src/test/SLEIR.rsc|, buffer);
}
