// TODO: generate automatically
// TOTHINK: now does not rely on GLUE
@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module \test::Extractors

import IO;
import String;
import grammarlab::Extractors;
import grammarlab::language::Grammar;
import grammarlab::export::Grammar;

bool run_all(loc base, GGrammar(loc) extractor, bool verbose)
{
	int cx = 0;
	int gx = 0;
	for (f <- listEntries(base), isFile(base+f))
	{
		cx += 1;
		try
		{
			g = extractor(base+f);
			gx += 1;
			if(verbose)
				println("[PASS] <base+f>");
		}
		catch:
		{
			if(verbose)
				println("[FAIL] <base+f>");
		}
	}
	println("<cx> tests tried, <gx> passed.");
	return true;
}

test bool test_bgf() = run_all(|project://grammarlab/src/test/set/extract/bgf|,bgf2bgf,false);
bool show_bgf() = run_all(|project://grammarlab/src/test/set/extract/bgf|,bgf2bgf,true);
