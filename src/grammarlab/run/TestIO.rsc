@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::run::TestIO

import grammarlab::language::Grammar;
import grammarlab::io::Grammar;
import grammarlab::export::Grammar;
import IO;

public void main()
{
	GGrammar g = readBGF(|home:///projects/webslps/zoo/ada/kempe.bgf|);
	iprintln(g);
	println(ppx(g));
}