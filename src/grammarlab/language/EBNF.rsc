@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::EBNF

alias EBNF = set[Metasymbol];

data Metasymbol
	= grammarSymbol(str begin, str end)
	| lineContinuationSymbol(str symb)
	| labelSymbol(str begin, str end)
	| definingSymbol(str symb)
	| multiDefiningSymbol(str symb)
	| terminatorSymbol(str symb)
	| defSeparatorSymbol(str symb)
	| terminalSymbol(str begin, str end)
	| concatenationSymbol(str symb)
	| nonterminalSymbol(str begin, str end)
	| emptyLanguageSymbol(str symb)
	| epsilonSymbol(str symb)
	| universalSymbol(str symb)
	//| ...
;

public EBNF DefaultEBNF = {
	labelSymbol("[", "]"),
	definingSymbol("::="),
	terminatorSymbol(";\n"),
	concatenationSymbol(" "),
	defSeparatorSymbol("|"),
	terminalSymbol("\"","\""),
	emptyLanguageSymbol("φ"),
	epsilonSymbol("ε"),
	universalSymbol("α")
};

