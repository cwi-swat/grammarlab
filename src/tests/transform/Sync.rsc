@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module tests::transform::Sync

import String;
import IO;
import grammarlab::io::Grammar;
import grammarlab::io::XBGF;

import grammarlab::export::Grammar;
import grammarlab::export::XBNF;
import grammarlab::export::GrammarLab;

public void main()
{
	loc base = |home:///projects/slps/topics/transformation/xbgf/tests|;
	str buffer = "@contributor{Super Awesome Automated XBGF Test Suite Synchroniser}
		'@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
		'module tests::transform::Test
		'
		'import IO;
		'import grammarlab::language::Grammar;
		'import grammarlab::language::X;
		'import grammarlab::language::XScope;
		'import grammarlab::transform::XBGF;
		'import grammarlab::compare::Differ;
		'import grammarlab::export::Grammar;
		'import grammarlab::export::XBNF;
		'
		'bool run_case(GGrammar bgf, XSequence xbgf, GGrammar bl, bool debug)
		'{
		'	if (debug) println(\"Input grammar: \<ppx(bgf)\>\");
		'	if (debug) println(\"Transformations: \<ppxs(xbgf)\>\");
		'	if (debug) println(\"Expected output grammar: \<ppx(bl)\>\");
		'	GGrammar res = transform(xbgf,bgf);
		'	if (debug) println(\"Actual output grammar: \<ppx(res)\>\");
		'	if (debug) return gdtv(res,bl);
		'	else return gdts(res,bl);
		'}
		'",
		buffer2 = "",
		buffer3 = "";
	for (f <- listEntries(base), endsWith(f,".xbgf"))
	{
		xbgf = readXBGF(base+f);
		bgf = readBGF(base+replaceLast(f,".xbgf",".bgf"));
		bl = readBGF(base+replaceLast(f,".xbgf",".baseline"));
		name = replaceLast(f,".xbgf","");
		// TODO: turn <bgf> to <ppx(bgf)>, <ppxs(xbgf)>, etc
		buffer += "\n// <base+f>\n"
		+"bool case_<name>(bool debug)\n{\n"
		+"	GGrammar bgf = <ppgl(0,1,bgf)>;\n"
		+"	XSequence xbgf =\n<ppgl(2,3,xbgf)>;\n"
		+"	GGrammar bl = <ppgl(0,1,bl)>;\n"
		+"	return run_case(bgf,xbgf,bl,debug);\n"
		+"}\ntest bool test_<name>() = case_<name>(false);\n"
		+"void show_<name>() {case_<name>(true);}\n";
	}
	writeFile(|project://grammarlab/src/tests/transform/XBGF.rsc|, buffer);
}

