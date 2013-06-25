@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::run::TestMicro

import grammarlab::language::Grammar;
import grammarlab::io::Grammar;
import grammarlab::export::Grammar;
import grammarlab::analyse::Micro;
import grammarlab::lib::Sizes;
import IO;

public void main()
{
	//GGrammar g = readBGF(|home:///projects/webslps/tank/fl/rascal-c.bgf|);
	GGrammar g = readBGF(|home:///projects/webslps/zoo/odf/opendoc-1.1.bgf|);
	//iprintln(g);
	println(ppx(g));
	mp = g2ppn(g);
	for (str n <- mp)
		if (!isEmpty(mp[n]))
			println("<n> classified as: <mp[n]>");
}