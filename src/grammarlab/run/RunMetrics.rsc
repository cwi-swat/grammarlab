@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::run::RunMetrics

import grammarlab::language::Grammar;
import grammarlab::analyse::Metrics;
import grammarlab::io::Grammar;
import grammarlab::lib::Sizes;
import IO;
import String;

public void main(list[str] args)
{
	int cx = 0;
	GGrammar g;
	loc log = |home:///projects/lab/data/zoo.txt|;
	writeFile(log,"");
	for
	(
		loc zoo <- [|home:///projects/webslps/zoo|, |home:///projects/webslps/tank|],
		//loc zoo <- [|home:///projects/microzoo/|],
		str lang <- listEntries(zoo),
		!endsWith(lang,".png"),
		!endsWith(lang,".html"),
		str s <- listEntries(zoo+"/<lang>"),
		endsWith(s,".bgf")
	)
	{
		str who = "<lang>::<s>";
		println(who);
		cx += 1;
		g = readBGF(zoo+"/<lang>/<s>");
		appendToFile(log,"<who>\t<PROD(g)>\t<VAR(g)>\t<TERM(g)>\t<SEL(g)>\t<LAB(g)>\t<VOC(g)>\n");
	}
	println("Computed metrics over <cx> grammars.");
}
