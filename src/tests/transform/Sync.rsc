@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module tests::transform::Sync

import String;
import IO;
import grammarlab::io::Grammar;
import grammarlab::io::XBGF;

import grammarlab::export::Grammar;
import grammarlab::export::XBNF;

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
		buffer += "
		'// <base+f>
		'bool case_<name>(bool debug)
		'{
		'	GGrammar bgf = <bgf>;
		'	XSequence xbgf = <xbgf>;
		'	GGrammar bl = <bl>;
		'	return run_case(bgf,xbgf,bl,debug);
		'}
		'test bool test_<name>() = case_<name>(false);
		'void show_<name>() {case_<name>(true);}
		'";
	}
	writeFile(|project://grammarlab/src/tests/transform/Test.rsc|, buffer);
}

