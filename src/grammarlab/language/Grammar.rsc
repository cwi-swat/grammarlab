@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::Grammar

alias GProdList = list[GProd];
alias GProdSet  =  set[GProd];
alias GExprList = list[GExpr];
alias GExprSet  =  set[GExpr];

//deprecated
alias GProds = map[str,GProdList];

data GGrammar
	= grammar(list[str] N, GProdList P, list[str] S)
;

data GProd
	= production (str lhs, GExpr rhs)
;

data GExpr
	= epsilon()									// empty string language or trivial term language
	| empty()									// empty language
	| anything()									// universal symbol
	| val(GValue v)								// built-in syntactic category
	| nonterminal(str t)							// user-defined syntactic category
	| terminal(str t)							// static part of the structure
	| label(str name, GExpr expr)				// labelled part: e.g., a constructor, an element, a typed variable
	| mark(str name, GExpr expr)					// selectable subexpressions: e.g., a line number, a group
	| sequence(GExprList exprs)					// sequential composition
	| choice(GExprList exprs)					// disjunction (both inner choices and top-level alternatives)
	| allof(GExprList exprs)						// conjunction
	| not(GExpr expr)							// negation
	| except(GExpr expr1, GExpr expr2)			// and-not
	| optional(GExpr expr)						// optionality
	| star(GExpr expr)							// zero-or-more (Kleene star)
	| plus(GExpr expr)							// one-or-more (plus)
	| sepliststar(GExpr expr, GExpr sep)			// zero-or-more separator list
	| seplistplus(GExpr expr, GExpr sep)			// one-or-more separator list
;

data GValue = string() | integer() | boolean();
