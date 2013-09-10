@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module tests::extract::RNG

import IO;
import List;
import String;
import lang::xml::DOM;
import grammarlab::lib::Sizes;
import grammarlab::Extractors;
import grammarlab::io::Grammar;
import grammarlab::compare::Differ;
import grammarlab::transform::Merge;
import grammarlab::language::Grammar;

// NB: careful — runs for a whole hour! 
void main()
{
	loc base = |home:///projects/slps/topics/grammars|;
	GGrammar g1, g2;
	for
	(
		str lang <- listEntries(base),
		isDirectory(base+"/<lang>"),
		str gram <- listEntries(base+"/<lang>"),
		exists(base+"/<lang>/<gram>/zoo.xml"),
		document(element(_,"grammar",L)) := parseXMLDOMTrim(readFile(base+"/<lang>/<gram>/zoo.xml")),
		/element(_,"tol1",[charData("rng2bgf")]) := L
	)
	{
		println("Checking <lang>::<gram>...");
		println("Reading...");
		g1 = bgf2bgf(base+"/<lang>/<gram>/grammar.bgf");
		gs2 = [];
		for (line <- tail(split("rng2bgf ",readFile(base+"/<lang>/<gram>/Makefile"))))
		{
			str src = split(" ",line)[0];
			println("Extracting from <src>...");
			gs2 += rng2bgf(base+"/<lang>/<gram>/<src>");
		}
		println("Merging...");
		if (isTrivial(gs2)) g2 = gs2[0]; else g2 = mergeGs(gs2);
		println("Writing...");
		writeBGF(g2,base+"/<lang>/<gram>/ext.grammarlab.bgf");
		println("Diffing...");
		r = gdtv(g1,g2);
		//if (!r) break;
	}
}
