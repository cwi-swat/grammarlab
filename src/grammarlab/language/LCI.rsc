@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::LCI

import grammarlab::language::Grammar;
import grammarlab::language::Tree;
import grammarlab::language::X;
import grammarlab::language::XOutcome;
//import grammarlab::language::M;

//scenario: shortcut⋆ tools source+ target+ testset⋆
//shortcut: name::id expansion::xstring
data LCScenario
	= scenario(set[LCTool] tools, list[LCSource] sources, list[LCTarget] targets);
//tools: transformer::tool comparator::tool validator::tool? generator⋆
//tool:grammar::xstring tree::xstring?
data LCTool
	= transformer(XResult(XSequence, GGrammar) tool)
	| mutator(XResult(MSequence, GGrammar) tool)
	| comparator(bool(GGrammar,GGrammar) tool)
	| validator(bool(GGrammar) tool)
	| generator(XSequence(GGrammar) tool)
	| extractor(GGrammar(loc) tool)
	// TODO: duplicate with proper typing for trees
	;
//testset: name::id command::xstring
//source: name::id	derived?	source-grammar	source-tree?	test-set::refid ⋆
data LCSource
	= source(str name, LCGrammar source, LCTestSet tset)
	| source_d(str name, str from, str using, LCGrammar source, LCTestSet tset)
	// TODO: tree-related parts
	;

data LCTestSet
	= ts_no()
	| ts_generated(list[GTree]() get_ts)
	| ts_provided(list[GTree] ts)
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
//automated-transformation: method::id result::string
data LCStep
	= perform(XSequence xbgf)
	| automated(str method, str result)
	// TODO: add mutations
	;
