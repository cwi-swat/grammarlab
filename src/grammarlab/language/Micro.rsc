@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::Micro

alias MicroClassify = set[Micropattern];
data Micropattern
	// Metasyntax
	= contains-star()
	| contains-plus()
	| contains-optional()
	| contains-epsilon()
	| contains-failure()
	| contains-universal()
	| contains-integer()
	| contains-string()
	| contains-boolean()
	| contains-selector()
	| contains-label()
	| contains-mark()
	| contains-sequence()
	| contains-disjunction()
	| contains-conjunction()
	| contains-negation()
	| contains-sl-star()
	| contains-sl-plus()
	| contains-terminal() // not abstract-syntax
	| contains-nonterminal() // not leaf
	| abstract-syntax()
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
	| fake-sl()
	| fake-sl-star()
	| fake-sl-plus()
	| expr-mid-layer()
	| expr-low-layer()
	| yacc-plus-left()
	| yacc-plus-right()
	| yacc-star-left()
	| yacc-star-right()
	// Naming
	| camel-case()
	| mixed-case()
	| lower-case()
	| upper-case()
	| miltiword()
	| camel-case-lax()
	| mixed-case-lax()
	| lower-case-lax()
	| upper-case-lax()
	| miltiword-lax()
	// Concrete
	| preterminal()
	| keyword()
	| keywords()
	| operator()
	| operators()
	| operators-mixed()
	| words()
	| tokens()
	| modifiers()
	| range()
	| literal-numeric()
	| literal-simple()
	| literal-firstrest()
	| empty-statement()
	// Normal
	| chomsky-normal-form()
	| greibach-normal-form()
	| abstract-normal-form()
	// Folding
	| just-empty()
	| just-failure() // disallowed or bottom?
	| just-optional()
	| just-plus()
	| just-star()
	| just-sl-plus()
	| just-sl-star()
	| just-chains()
	| just-one-chain()
	| reflexive-chain()
	| chain-or-terminal()
	| chains-and-terminals()
	// Template
	| constructor()
	| bracket()
	| bracket-self()
	| bracket-fake-sl-star()
	| bracket-fake-sl-plus()
	| bracket-optional()
	| bracket-plus()
	| bracket-star()
	| bracket-sl-star()
	| bracket-sl-plus()
	| delimited()
	| distinguished()
	| element-access()
	| pure-sequence()
;
