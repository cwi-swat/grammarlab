@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module grammarlab::language::WGrammar

import grammarlab::language::Grammar;

syntax A = "s";
lexical B = "";

alias WProdList = list[WProd];
alias WProdSet  =  set[WProd];
alias WExprList = list[WExpr];
alias WExprSet  =  set[WExpr];

alias GNonTerm = str;
alias GTerm = str;
alias GLabel = str;
alias GMark = str;

data WGrammar
	= w_grammar(list[str] N, WProdList P, list[str] S)
;

data WProd
	= w_production (str lhs, WExpr rhs)
;

data WExpr
	= w_universal()
	| w_emptystring()
	| w_emptylanguage()
	| w_string()
	| w_number()
	| w_boolean()
	// unary metaconcepts
	| w_optionality(WExpr e)
	| w_star(WExpr e)
	| w_plus(WExpr e)
	| w_group(WExpr e)
	// binary metaconcepts
	| w_sep_star(WExpr e1, WExpr e2)
	| w_sep_plus(WExpr e1, WExpr e2)
	// multiary metaconcepts
	| w_disjunction(WExprList es)
	| w_conjunction(WExprList es)
	| w_concatenation(WExprList es)
	// the rest
	| w_nt(str s)
	| w_t(str s)
	| w_label(str s, WExpr e)
	| w_mark(str s, WExpr e)
;

public GGrammar wgrammar2ggrammar(WGrammar g) = grammar(g.N, [wprod2gprod(p) | p <- g.P], g.S);

GProd wprod2gprod(WProd p) = production(p.lhs, wexpr2gexpr(p.rhs));

GExpr wexpr2gexpr(WExpr::w_emptystring())   = epsilon();
GExpr wexpr2gexpr(WExpr::w_emptylanguage()) = empty();
GExpr wexpr2gexpr(WExpr::w_universal())     = anything();
GExpr wexpr2gexpr(WExpr::w_string())        = val(string());
GExpr wexpr2gexpr(WExpr::w_number())        = val(integer());
GExpr wexpr2gexpr(WExpr::w_boolean())       = val(boolean());
//
GExpr wexpr2gexpr(WExpr::w_optionality(e))  = optional(wexpr2gexpr(e));
GExpr wexpr2gexpr(WExpr::w_star(e))         = star(wexpr2gexpr(e));
GExpr wexpr2gexpr(WExpr::w_plus(e))         = plus(wexpr2gexpr(e));
//GExpr wexpr2gexpr(WExpr::w_group(w_concatenation(es)))        = sequence([wexpr2gexpr(e) | e<-es]);
GExpr wexpr2gexpr(WExpr::w_group(e))        = wexpr2gexpr(e); // ?
// binary
GExpr wexpr2gexpr(WExpr::w_sep_star(e1,e2)) = sepliststar(wexpr2gexpr(e1),wexpr2gexpr(e2));
GExpr wexpr2gexpr(WExpr::w_sep_plus(e1,e2)) = seplistplus(wexpr2gexpr(e1),wexpr2gexpr(e2));
// multiary
GExpr wexpr2gexpr(WExpr::w_disjunction(es)) = choice([wexpr2gexpr(e) | e<-es]);
GExpr wexpr2gexpr(WExpr::w_conjunction(es)) = allof([wexpr2gexpr(e) | e<-es]);
GExpr wexpr2gexpr(WExpr::w_concatenation(es)) = sequence([wexpr2gexpr(e) | e<-es]);
//
GExpr wexpr2gexpr(WExpr::w_nt(s)) = nonterminal(s);
GExpr wexpr2gexpr(WExpr::w_t(s)) = terminal(s);
GExpr wexpr2gexpr(WExpr::w_label(s, e)) = label(s, wexpr2gexpr(e));
GExpr wexpr2gexpr(WExpr::w_mark(s, e)) = mark(s, wexpr2gexpr(e));
default GExpr wexpr2gexpr(_) = nothing();

public WGrammar ggrammar2wgrammar(GGrammar g) = w_grammar(g.N, [gprod2wprod(p) | p <- g.P], g.S);

WProd gprod2wprod(GProd p) = w_production(p.lhs, gexpr2wexpr(p.rhs));

WExpr gexpr2wexpr(GExpr::epsilon())      = w_emptystring();
WExpr gexpr2wexpr(GExpr::empty())        = w_emptylanguage();
WExpr gexpr2wexpr(GExpr::anything())     = w_universal();
WExpr gexpr2wexpr(GExpr::val(string()))  = w_string();
WExpr gexpr2wexpr(GExpr::val(integer())) = w_number();
WExpr gexpr2wexpr(GExpr::val(boolean())) = w_boolean();
//
WExpr gexpr2wexpr(GExpr::optional(e)) = w_optionality(gexpr2wexprPG(e));
WExpr gexpr2wexpr(GExpr::star(e)) = w_star(gexpr2wexprPG(e));
WExpr gexpr2wexpr(GExpr::plus(e)) = w_plus(gexpr2wexprPG(e));
//
WExpr gexpr2wexpr(GExpr::sepliststar(e1,e2)) = w_sep_star(gexpr2wexprPG(e1),gexpr2wexprPG(e2));
WExpr gexpr2wexpr(GExpr::seplistplus(e1,e2)) = w_sep_plus(gexpr2wexprPG(e1),gexpr2wexprPG(e2));
// it's a question whether (a b) | c should be preferred to a b | c
WExpr gexpr2wexpr(GExpr::choice(es)) = w_disjunction([gexpr2wexpr(e) | e<-es]);
WExpr gexpr2wexpr(GExpr::allof(es)) = w_conjunction([gexpr2wexpr(e) | e<-es]);
WExpr gexpr2wexpr(GExpr::sequence(es)) = w_concatenation([gexpr2wexpr(e) | e<-es]);
//
WExpr gexpr2wexpr(GExpr::nonterminal(s)) = w_nt(s);
WExpr gexpr2wexpr(GExpr::terminal(s)) = w_t(s);
WExpr gexpr2wexpr(GExpr::label(s,e)) = w_label(s,gexpr2wexpr(e));
WExpr gexpr2wexpr(GExpr::mark(s,e)) = w_mark(s,gexpr2wexpr(e));

default WExpr gexpr2wexpr(_) = w_emptylanguage();

WExpr gexpr2wexprPG(GExpr e) = (sequence(_) := e) ? w_group(gexpr2wexpr(e)) : gexpr2wexpr(e);
