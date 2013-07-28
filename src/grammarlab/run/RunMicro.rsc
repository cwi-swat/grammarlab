@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::run::RunMicro

import grammarlab::analyse::Metrics;

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

public void main(list[str] a) = main();

public void main()
{
	loc zoo = |home:///projects/webslps/zoo|;
	int cx = 0;
	int total = 0;
	GGrammar g;
	MicroNperP allres = ();
	//MicroPperN mp1;
	MicroNperP mp;
	map[Micropattern,int] res = ();
	str buf = "";
	for (Micropattern m <- ALLMPatterns)
	{
		writeFile(getFileName(m),"");
		res[m] = 0;
		allres[m] = {};
	}
	for
	(
		str lang <- listEntries(zoo),
		!endsWith(lang,".html"),
		!endsWith(lang,".gz"),
		!endsWith(lang,".png"),
		str s <- listEntries(zoo+"/<lang>"),
		endsWith(s,".bgf")
	)
	{
		str who = "<lang>::<s>";
		println(who);
		cx += 1;
		g = readBGF(zoo+"/<lang>/<s>");
		total += VAR(g);
		//mp1 = g2ppn(g);
		mp = g2npp(g);
		for (Micropattern m <- mp)
		{
			res[m] += len(mp[m]);
			allres[m] += {"<lang>::<s>::<z>" | str z <- mp[m]};
			if (false)// (!isEmpty(mp[m]))
			{
				appendToFile(getFileName(m),"--------------------<lang>::<s>--------------------\n");
				for (str s <- mp[m])
					if (s in g.prods)
						appendToFile(getFileName(m), ppx(g.prods[s]));
					else
						appendToFile(getFileName(m), "UNDEFINED <s>\n");
			}
		}
		//for (str n <- mp)
		//	if (!isEmpty(mp[n]))
		//		println("<n> classified as: <mp[n]>");
	}
	println("Computed <len(ALLMPatterns)> micropatterns over <total> nonterminals from <cx> grammars.");
	for (MicroClassifyS ms <- ALLMPatternList)
	{
		set[str] coll = {};
		for (Micropattern m <- ms) coll += allres[m];
		int lencoll = len(coll);
		for (Micropattern m <- ms) buf += "<m>\t<res[m]>\t<lencoll>\n";
		}
	writeFile(|home://projects/lab/data/ALLmicropatterns.txt|,buf);
}

// loc getFileName(Micropattern mp) = |project://grammarlab/data/|+(substring("<mp>",0,findFirst("<mp>","("))+".txt");
loc getFileName(Micropattern mp) = |home://projects/lab/data/|+(substring("<mp>",0,findFirst("<mp>","("))+".txt");
