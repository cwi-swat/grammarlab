@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module tests::extract::XSD

import IO;
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

void main()
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
