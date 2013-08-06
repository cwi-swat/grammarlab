@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module demo::fl::Extract

import grammarlab::language::Grammar;
import grammarlab::language::X;
//import grammarlab::language::M;
import grammarlab::language::LCI;

import grammarlab::extract::RascalSyntax2BGF;
import grammarlab::extract::RascalADT2BGF;
import grammarlab::extract::SDF2BGF;
import grammarlab::transform::Merge;

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
	//for(loc k <- LCI) LCI[k](k);
	//GGrammar G1 = mergeGs(
	//	grammarlab::extract::SDF2BGF::extractG(|home:///projects/slps/topics/fl/asfsdf/FL.sdf|),
	//	grammarlab::extract::SDF2BGF::extractG(|home:///projects/slps/topics/fl/asfsdf/Syntax.sdf|)
	//);
	GGrammar G2 = 
		grammarlab::extract::RascalSyntax2BGF::extractG(|home:///projects/slps/topics/fl/rascal/src/Concrete.rsc|)
	;
	GGrammar G3 = 
		grammarlab::extract::RascalADT2BGF::extractG(|home:///projects/slps/topics/fl/rascal/src/Abstract.rsc|)
	;
}