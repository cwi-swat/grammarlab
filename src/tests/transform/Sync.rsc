@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module tests::transform::Sync

import String;
import IO;
import grammarlab::io::Grammar;
import grammarlab::io::XBGF;

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
		'map[str,tuple[XSequence,GGrammar,GGrammar]] test_data = (
		'",
		buffer2 = "",
		buffer3 = "";
	for (f <- listEntries(base), endsWith(f,".xbgf"))
	{
		xbgf = readXBGF(base+f);
		bgf = readBGF(base+replaceLast(f,".xbgf",".bgf"));
		bl = readBGF(base+replaceLast(f,".xbgf",".baseline"));
		buffer += "\"<replaceLast(f,".xbgf","")>\": \<<xbgf>,<bgf>,<bl>\>,\n";
		buffer2 += "test bool test_<replaceLast(f,".xbgf","")>() { \<xbgf,bgf1,bgf2\> = test_data[\"<replaceLast(f,".xbgf","")>\"]; return gdts(transform(xbgf,bgf1),bgf2); }\n";
		buffer3 += "void show_<replaceLast(f,".xbgf","")>() { \<xbgf,bgf1,bgf2\> = test_data[\"<replaceLast(f,".xbgf","")>\"]; println(\"Input grammar: \<ppx(bgf1)\>\");println(\"Transformations: \<ppxs(xbgf)\>\");println(\"Expected output grammar: \<ppx(bgf2)\>\");bgf3=transform(xbgf,bgf1);println(\"Actual output grammar: \<ppx(bgf3)\>\"); gdtv(bgf3,bgf2); }\n";
	}
	writeFile(|project://grammarlab/src/tests/transform/Test.rsc|, "<replaceLast(buffer,",","")>);\n\n<buffer3>\n\n<buffer2>");
}

