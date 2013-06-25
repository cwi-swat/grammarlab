@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::run::RunMicro

import grammarlab::language::Grammar;
import grammarlab::language::Micro;
import grammarlab::io::Grammar;
import grammarlab::export::Grammar;
import grammarlab::analyse::Micro;
import grammarlab::lib::Sizes;
import IO;
import String;

//alias MicroGrammar = map[str,MicroClassify];
//alias MicroClassify = set[Micropattern];

public void main()
{
	int cx = 0;
	GGrammar g;
	//MicroPperN mp1;
	MicroNperP mp;
	//str buf = "";
	for (Micropattern m <- ALLMPatterns)
		writeFile(getFileName(m),"");
	for
	(
		loc zoo <- [|home:///projects/webslps/zoo|, |home:///projects/webslps/tank|],
		//loc zoo <- [|home:///projects/microzoo/|],
		str lang <- listEntries(zoo),
		!endsWith(lang,".html"),
		str s <- listEntries(zoo+"/<lang>"),
		endsWith(s,".bgf")
	)
	{
		str who = "<lang>::<s>";
		println(who);
		cx += 1;
		g = readBGF(zoo+"/<lang>/<s>");
		//mp1 = g2ppn(g);
		mp = g2npp(g);
		for (Micropattern m <- mp)
			if (!isEmpty(mp[m]))
			{
				appendToFile(getFileName(m),"--------------------<lang>::<s>--------------------\n");
				for (str s <- mp[m])
					if (s in g.prods)
						appendToFile(getFileName(m), ppx(g.prods[s]));
					else
						appendToFile(getFileName(m), "UNDEFINED <s>\n");
			}
		//for (str n <- mp)
		//	if (!isEmpty(mp[n]))
		//		println("<n> classified as: <mp[n]>");
	}
	println("Computed <len(ALLMPatterns)> micropatterns over <cx> grammars.");
}

loc getFileName(Micropattern mp) = |project://grammarlab/data/|+(substring("<mp>",0,findFirst("<mp>","("))+".txt");
