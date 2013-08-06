@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::Tree

import grammarlab::language::Grammar;

alias GRoot = tuple[GGrammar,GTree];

data GTree
	= epsilon()											// empty string language or trivial term language
//  | empty()											// not present in trees
	| anything(str x)									// universal symbol
	| val(GTValue v)										// built-in syntactic category
	| nonterminal(GProd p, GTree t)						// user-defined syntactic category
	| terminal(str x)									// static part of the structure
	| labelled(str lab, GTree expr)						// labelled part: e.g., a constructor, a line number
	| selectable(str sel, GTree expr)					// selectable subexpressions: e.g., a typed variable
//  | marked(GExpr expr)									// not present in trees
	| sequence(list[GTree] ts)							// sequential composition
	| choice(GExpr e, GTree t)							// disjunction
	| allof(list[tuple[GExpr e,GTree t]] xs)				// conjunction
	// TODO: check whether this is useful
	| not(GExpr e, GTree t)								// negation
	| optional1()										// optionality
	| optional2(GTree t)									// optionality
	| star(list[GTree] ts)								// zero-or-more (Kleene star)
	| plus(list[GTree] ts)								// one-or-more (plus)
	| sepliststar(GExpr ee, GTree et, GExpr se, GTree st)// zero-or-more separator list
	| seplistplus(GExpr ee, GTree et, GExpr se, GTree st)// one-or-more separator list
;

data GTValue
	= string(str x)
	| integer(int n)
	| boolean(bool b)
	;
