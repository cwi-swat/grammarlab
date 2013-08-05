@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module demo::fl::Extract

import grammarlab::language::Grammar;

import grammarlab::extract::RascalSyntax2BGF;
import grammarlab::extract::RascalADT2BGF;
import grammarlab::extract::SDF2BGF;
import grammarlab::transform::Merge;

import grammarlab::language::X;

//scenario: shortcut⋆ tools source+ target+ testset⋆
//shortcut: name::id expansion::xstring
data LCScenario = scenario(list[LCTool] tools, list[LCSource] sources, list[LCTarget] targets);
//tools: transformer::tool comparator::tool validator::tool? generator⋆
//tool:grammar::xstring tree::xstring?
data LCTool
	= transformer(str gTool, str tTool) // GGrammar(GGrammar, XSequence)
	| comparator(str gTool, str tTool)  // bool(GGrammar,GGrammar)
	| validator(str gTool, str tTool)   // bool(GGrammar)
	| generator(str gTool, str tTool)   // XSequence(GGrammar)
	// TODO: add mutations
	// TODO: duplicate with proper typing for trees
	// TODO: generalise and make truly pluggable
	;
//testset: name::id command::xstring
//source: name::id	derived?	source-grammar	source-tree?	test-set::refid ⋆
data LCSource
	= source(str name, LCGrammar source, LCTestSet tset)
	| derived(str name, str from, str using, LCGrammar source, LCTestSet tset)
	// TODO: tree-related parts
	;
//derived: from::refid using::string
//source-grammar: extraction::xstring parsing::xstring? evaluation::xstring?
//source-tree: extraction::xstring evaluation::xstring?
//target:name::id branch+
data LCTarget = target(str name, list[LCBranch] branches);
//branch: input::refid preparation::phase? nominal-matching::phase? structural-matching::phase?
//(extension::phase | correction::phase | relaxation::phase)⋆
data LCBranch = branch(str input, list[LCPhase] phases);
data LCPhase
	= preparation(list[LCStep] steps)
	| nominalMatching(list[LCStep] steps)
	| structuralMatching(list[LCStep] steps)
	| extension(list[LCStep] steps)
	| correction(list[LCStep] steps)
	| relaxation(list[LCStep] steps)
	// TODO? make conditions more strict
	;
//phase:step::(perform-transformation::string | automated-transformation)+
data LCStep
	= perform(XSequence xbgf)
	| automated(str method, str result)
	// TODO: add mutations
	;
//automated-transformation: method::id result::string


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