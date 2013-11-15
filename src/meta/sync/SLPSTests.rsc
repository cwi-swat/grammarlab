@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module meta::sync::SLPSTests

import String;
import List;
import IO;
import grammarlab::language::Grammar;
import grammarlab::language::X;
import grammarlab::language::EBNF;

import grammarlab::io::Grammar;
import grammarlab::io::XBGF;

import grammarlab::export::Grammar;
import grammarlab::export::XBNF;
import grammarlab::export::GrammarLab;
import meta::Glue;

// TODO properly
str pprintg(GGrammar g)
{
	myglue = GlueEBNF;
	myglue[terminator_symbol()] = " ;\n";
	return ppx(g,myglue);
}
str pprintx(XSequence xs)
{
	return replaceLast(replaceFirst(ppxs(xs),"(","\n\t"),")",".");
}

public void main()
{
	loc base = |home:///projects/slps/topics/transformation/xbgf/tests|;
	for (f <- listEntries(base), endsWith(f,".xbgf"))
	{
		xbgf = readXBGF(base+f);
		bgf = readBGF(base+replaceLast(f,".xbgf",".bgf"));
		bl = readBGF(base+replaceLast(f,".xbgf",".baseline"));
		name = replaceLast(f,".xbgf","");
		str buffer = "// <base+f>
		'importG
		'	<pprintg(bgf)>
		'.
		'<pprintx(xbgf)>
		'diff
		'	<pprintg(bl)>
		'.";
		writeFile(|project://grammarlab/src/tests/transform/set/<name>.glue|,
		intercalate("\n",[s | str s <- split("\n",buffer), trim(s)!=""]));
	}
}

