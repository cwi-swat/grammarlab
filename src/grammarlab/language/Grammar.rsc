@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::Grammar

alias GProdList = list[GProd];
alias GProdSet  =  set[GProd];
alias GExprList = list[GExpr];
alias GExprSet  =  set[GExpr];

alias GProds = map[str,GProdList];

data GGrammar
	= grammar(list[str] nts, list[str] roots, GProds prods)
;

data GProd
	= production (str lhs, GExpr rhs)
;

data GExpr
	= epsilon()									// empty string language or trivial term language
	| empty()									// empty language
	| anything()								// universal symbol
	| val(BGFValue v)							// built-in syntactic category
	| nonterminal(str t)						// user-defined syntactic category
	| terminal(str t)							// static part of the structure
	| labelled(str lab, GExpr expr)				// labelled part: e.g., a constructor, a line number
	| selectable(str sel, GExpr expr)			// selectable subexpressions: e.g., a typed variable
	| marked(GExpr expr)						// non-labelled marked subexpression
	| sequence(GExprList exprs)					// sequential composition
	| choice(GExprList exprs)					// disjunction
	| allof(GExprList exprs)					// conjunction
	| not(GExpr expr)							// negation
	| optional(GExpr expr)						// optionality
	| star(GExpr expr)							// zero-or-more (Kleene star)
	| plus(GExpr expr)							// one-or-more (plus)
	| sepliststar(GExpr expr, GExpr sep)		// zero-or-more separator list
	| seplistplus(GExpr expr, GExpr sep)		// one-or-more separator list
;

data GValue = string() | integer() | boolean();
