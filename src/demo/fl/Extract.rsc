@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module demo::fl::Extract

import grammarlab::language::Grammar;

import grammarlab::extract::RascalSyntax2BGF;
import grammarlab::extract::RascalADT2BGF;
import grammarlab::extract::SDF2BGF;

map[loc,GGrammar(loc)] LCI =
	(
		|home:///projects/slps/topics/fl/asfsdf| :
			grammarlab::extract::SDF2BGF::extractGs,
		|home:///projects/slps/topics/fl/rascal/Concrete.rsc| :
			grammarlab::extract::RascalSyntax2BGF::extractG,
		|home:///projects/slps/topics/fl/rascal/Abstract.rsc| :
			grammarlab::extract::RascalADT2BGF::extractG
	)
;

void main()
{
	for(loc k <- LCI)
		LCI[k](k);
}