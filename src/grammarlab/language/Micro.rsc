@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::Micro

alias MicroGrammar = map[str,MicroClassify];
alias MicroClassify = set[Micropattern];
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
	| emptyStatement()
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

public MicroClassify ALLMPatterns1 =
	{singleton(), horizontal(), vertical(), zigzag()};
	
public MicroClassify ALLMPatterns =
	{containsStar(), containsPlus(), containsOptional(), containsEpsilon(), containsFailure(),
	containsUniversal(), containsInteger(), containsString(), containsBoolean(), containsSelector(),
	containsLabel(), containsMark(), containsSequence(), containsDisjunction(), containsConjunction(),
	containsNegation(), containsSLStar(), containsSLPlus(), containsTerminal(), containsNonterminal(),
	abstractSyntax(), top(), bottom(), leaf(), root(), multiroot(), disallowed(), singleton(), horizontal(),
	vertical(), zigzag(), fakeOptional(), fakeSL(), fakeSLStar(), fakeSLPlus(), exprInfixLayer(),
	exprPrefixLayer(), exprPostfixLayer(), exprLowestLayer(), yaccPlusLeft(), yaccPlusRight(), yaccStarLeft(),
	yaccStarRight(), camelCase(), mixedCase(), lowerCase(), upperCase(), miltiword(), camelCaseLax(),
	mixedCaseLax(), lowerCaseLax(), upperCaseLax(), miltiwordLax(), preterminal(), keyword(), keywords(),
	operator(), operators(), operatorsMixed(), words(), tokens(), modifiers(), range(), literalNumeric(),
	literalSimple(), literalFirstRest(), emptyStatement(), chomskyNormalForm(), greibachNormalForm(),
	abstractNormalForm(), justEmpty(), justFailure(), justOptional(), justPlus(), justStar(), justSLPlus(),
	justSLStar(), justChains(), justOneChain(), reflexiveChain(), chainOrTerminal(), chainsAndTerminals(),
	constructors(), \bracket(), bracketSelf(), bracketFakeSLStar(), bracketFakeSLPlus(), bracketOptional(),
	bracketPlus(), bracketStar(), bracketSLStar(), bracketSLPlus(), delimited(), distinguished(),
	elementAccess(), pureSequence()};
