@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::Micro

import List;

alias MicroNperP = map[Micropattern,set[str]];
alias MicroPperN = map[str,MicroClassify];
alias MicroClassify = set[Micropattern];
alias MicroClassifyS = list[Micropattern];
alias MicroClassifyG = list[MicroClassifyS];
data Micropattern
	// Metasyntax
	= containsStar()
	| containsPlus()
	| containsOptional()
	| containsEpsilon()
	| containsFailure()
	| containsUniversal()
	| containsInteger()
	| containsString()
	| containsBoolean()
	| containsSelector()
	| containsLabel()
	| containsMark()
	| containsSequence()
	| containsDisjunction()
	| containsConjunction()
	| containsNegation()
	| containsSLStar()
	| containsSLPlus()
	| containsTerminal() // not abstractSyntax
	| containsNonterminal() // not leaf
	| abstractSyntax()
	// Global
	| top()
	| bottom()
	| leaf()
	| root()
	| multiroot()
	// Structure
	| disallowed()
	| singleton()
	| horizontal()
	| vertical()
	| zigzag()
	// Sugar
	| fakeOptional()
	| fakeSL()
	| fakeSLStar()
	| fakeSLPlus()
	| exprInfixLayer()
	| exprPrefixLayer()
	| exprPostfixLayer()
	| exprLowestLayer()
	| yaccStarLeft()
	| yaccStarRight()
	| yaccPlusLeft()
	| yaccPlusRight()
	// Naming
	| camelCase()
	| mixedCase()
	| lowerCase()
	| upperCase()
	| miltiword()
	| camelCaseLax()
	| mixedCaseLax()
	| lowerCaseLax()
	| upperCaseLax()
	| miltiwordLax()
	// Concrete
	| preterminal()
	| \keyword()
	| keywords()
	| operator()
	| operators()
	| operatorsMixed()
	| words()
	| tokens()
	| modifiers()
	| range()
	| literalNumeric()
	| literalSimple()
	| literalFirstRest()
	| simpleStatement()
	// Normal
	| chomskyNormalForm()
	| greibachNormalForm()
	| abstractNormalForm()
	// Folding
	| justEmpty()
	| justFailure() // disallowed or bottom?
	| justOptional()
	| justStar()
	| justPlus()
	| justSLStar()
	| justSLPlus()
	| justChains()
	| justOneChain()
	| reflexiveChain()
	| chainOrTerminal()
	| chainsAndTerminals()
	// Template
	| constructors()
	| \bracket()
	| bracketSelf()
	| bracketFakeSLStar()
	| bracketFakeSLPlus()
	| bracketOptional()
	| bracketStar()
	| bracketPlus()
	| bracketSLStar()
	| bracketSLPlus()
	| delimited()
	| distinguished()
	| elementAccess()
	| pureSequence()
;

public MicroClassify ALLMPatterns_ =
	{singleton(), horizontal(), vertical(), zigzag()};

public MicroClassifyS ALLMPatterns1 =
	[containsEpsilon(), containsFailure(), containsUniversal(), containsString(), containsInteger(), containsBoolean(),
	containsOptional(), containsPlus(), containsStar(), containsSLPlus(), containsSLStar(),
	containsDisjunction(), //containsConjunction(), containsNegation(),
	containsSelector(), containsLabel(),
//containsMark(),
	containsSequence(), //containsTerminal(), containsNonterminal(),
	abstractSyntax()];

public MicroClassifyS ALLMPatterns2 =
	[root(), leaf(), top(), multiroot(), bottom()];

public MicroClassifyS ALLMPatterns3 =
	[disallowed(), singleton(), vertical(), horizontal(), zigzag()];

public MicroClassifyS ALLMPatterns4 =
	[fakeOptional(), fakeSL(), fakeSLStar(), fakeSLPlus(),
	exprInfixLayer(), exprPrefixLayer(), exprPostfixLayer(),
	exprLowestLayer(),
	yaccPlusLeft(), yaccPlusRight(), yaccStarLeft(), yaccStarRight()];

public MicroClassifyS ALLMPatterns5 =
	[camelCase(), lowerCase(), mixedCase(), miltiword(), upperCase()];

public MicroClassifyS ALLMPatterns6 =
	[camelCaseLax(), lowerCaseLax(), mixedCaseLax(), miltiwordLax(), upperCaseLax()];

public MicroClassifyS ALLMPatterns7 =
	[preterminal(), \keyword(), keywords(), operator(), operators(), operatorsMixed(),
	words(), tokens(), modifiers(), range(), literalNumeric(),
	literalSimple(), literalFirstRest(), simpleStatement()];

public MicroClassifyS ALLMPatterns8 =
	[chomskyNormalForm(), greibachNormalForm(), abstractNormalForm()];
	
public MicroClassifyS ALLMPatterns9 =
	[justEmpty(), justFailure(), justOptional(), justPlus(), justStar(), justSLPlus(),
	justSLStar(), justChains(), justOneChain(), reflexiveChain(), chainOrTerminal(), chainsAndTerminals()];

public MicroClassifyS ALLMPatterns10 =
	[constructors(), \bracket(), bracketSelf(), bracketFakeSLPlus(), bracketFakeSLStar(),
	bracketPlus(), bracketStar(), bracketOptional(),
	bracketSLPlus(), bracketSLStar(),
	delimited(), elementAccess(), pureSequence(), distinguished()];
	
public MicroClassify ALLMPatterns = toSet(ALLMPatterns1+ALLMPatterns2+ALLMPatterns3+ALLMPatterns4+ALLMPatterns5+ALLMPatterns6+ALLMPatterns7+ALLMPatterns8+ALLMPatterns9+ALLMPatterns10);

public MicroClassifyG ALLMPatternList =
	[ALLMPatterns1, ALLMPatterns2, ALLMPatterns3, ALLMPatterns4, ALLMPatterns5,
	ALLMPatterns6, ALLMPatterns7, ALLMPatterns8, ALLMPatterns9, ALLMPatterns10];
