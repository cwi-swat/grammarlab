@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module tests::extract::XSD

import IO;
import List;
import String;	
import grammarlab::Extractors;
import grammarlab::io::Grammar;
import grammarlab::compare::Differ;
import grammarlab::language::Grammar;
//import grammarlab::extract::XMLSchemaDefinition2BGF;

bool compare(loc bgf, loc xsd, loc res)
{
	println("Reading...");
	GGrammar g1 = bgf2bgf(bgf);
	println("Extracting...");
	GGrammar g2 = xsd2bgf(xsd);
	println("Writing...");
	writeBGF(g2,res);
	println("Diffing...");
	return gdtv(g1,g2);
}

void main2()
{
	compare(
		|home:///projects/slps/topics/grammars/fl/xsd/grammar.bgf|,
		|home:///projects/slps/topics/fl/xsd/fl.xsd|,
		|home:///projects/slps/topics/grammars/fl/xsd/ext.grammarlab.bgf|
	);
	compare(
		|home:///projects/slps/topics/grammars/slps/xbgf-xsd/grammar.bgf|,
		|home:///projects/slps/shared/xsd/xbgf.xsd|,
		|home:///projects/slps/topics/grammars/slps/xbgf-xsd/ext.grammarlab.bgf|
	);
}

void main()
{
	int cx = 0;
	loc base = |home:///projects/slps/topics/grammars/|;
	list[str] slps = ["bgf","xedd","xldf","ldf"];
	GGrammar g1, g2;
	for
	(
		str lang <- slps,
		str gram <- listEntries(base+"/<lang>"),
		isDirectory(base+"/<lang>/<gram>"),
		endsWith(gram,"xsd")
	)
	{
		println("Checking <lang>::<gram>...");
		println("Reading...");
		g1 = bgf2bgf(base+"/<lang>/<gram>/grammar.bgf");
		str src = split(" ",split("xsd2bgf ",readFile(base+"/<lang>/<gram>/Makefile"))[1])[0];
		println("Extracting from <src>...");
		g2 = xsd2bgf(base+"/<lang>/<gram>/<src>");
		println("Writing...");
		writeBGF(g2,base+"/<lang>/<gram>/ext.grammarlab.bgf");
		println("Diffing...");
		r = gdtv(g1,g2);
		r2 = gdts(g1,grammar(g2.N,g2.P,g1.S));
		if (!r2 && lang != "ldf") break;
		cx += 1;
	}
	println("Checked for <cx> grammars.");
}
