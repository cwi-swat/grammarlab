@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::analyse::Metrics

import Map;
import Set;
import grammarlab::language::Grammar;
import grammarlab::lib::Sizes;
import grammarlab::lib::Squeeze;
import grammarlab::lib::RascalPlus;

alias GMetrics = map[str,int];

// PROD
public int PROD(GGrammar g) = //summap(countProd, g.P);
	(0 | it + countProd(p) | p <- g.P);
// GMetrics ::= [PROD]::(<m>:GMetrics <g>:GGrammar);
public GMetrics PROD(GMetrics m, GGrammar g)
{
	if ("PROD" notin domain(m))
		m["PROD"] = PROD(g);
	return m;
}

int countProd(production (lhs, label(_,GExpr e))) = countProd(production(lhs,e));
int countProd(production (lhs,  mark(_,GExpr e))) = countProd(production(lhs,e));
int countProd(production (_, choice(GExprList exprs))) = len(exprs);
default int countProd(GProd p) = 1;

// VAR = number of nonterminals used or defined in the grammar
public list[str] listVAR(GGrammar g) = squeeze(g.S+g.N,{name | /nonterminal(str name) := g.P});
public int VAR(GGrammar g) = ulen(g.S+g.N, {name | /nonterminal(str name) := g.P});

// TERM = number of terminals
// probably Set::sort({name | /terminal(str name) := g.P}) is faster
public list[str] listTERM(GGrammar g) = squeeze([name | /terminal(str name) := g.P]);
public int TERM(GGrammar g) = len(listTERM(g));

// LET = letter terminal symbols (single-symbol alphabetic)
// TODO: include diacritics?
public list[str] listLET(GGrammar g) = squeeze([name | /terminal(str name) := g.P, /^[a-zA-Zα-ωΑ-Ω]$/ := name]);
public int LET(GGrammar g) = len(listLET(g));

// KWDS = keyword terminal symbols (alphabetic)
public list[str] listKWDS(GGrammar g) = squeeze([name | /terminal(str name) := g.P, /^[a-zA-Z_][a-zA-Z_]+$/ := name]);
public int KWDS(GGrammar g) = len(listKWDS(g));

// NUM = numeric terminal symbols (digits)
public list[str] listNUM(GGrammar g) = squeeze([name | /terminal(str name) := g.P, /^[1-90]+$/ := name]);
public int NUM(GGrammar g) = len(listNUM(g));

// SIGN = special terminal symbols (non-alphabetic)
public list[str] listSIGN(GGrammar g) = squeeze([name | /terminal(str name) := g.P, /[a-zA-Z1-90]/ !:= name]);
public int SIGN(GGrammar g) = len(listSIGN(g));

// MAR = number of different markers
public list[str] listMAR(GGrammar g) = squeeze([name | /mark(str name, _) := g.P]);
public int MAR(GGrammar g) = len(listMAR(g));

// LAB = number of unique labels
public list[str] listLAB(GGrammar g) = squeeze([name | /label(str name, _) := g.P]);
public int LAB(GGrammar g) = len(listLAB(g));

// VOC = vocabulary
public int VOC(GGrammar g) = /* PROD(g) + */ VAR(g) + TERM(g) + MAR(g) + LAB(g);

// TOP = top nonterminals (defined, not used)
public int TOP(GGrammar g) = len(listTOP(g));
public list[str] listTOP(GGrammar g) = [n | n <- g.N, n notin g.S, /nonterminal(n) !:= g.P];

// BOTTOM = bottom nonterminals (used, not defined)
list[str] usedNs(GGrammar g) = toList({n | /nonterminal(n) := g.P});
public int BOTTOM(GGrammar g) = len(listBOTTOM(g));
public list[str] listBOTTOM(GGrammar g) = usedNs(g) - g.N;

// ROOT = root nonterminals (official tops)
public int ROOT(GGrammar g) = len(listROOT(g));
public list[str] listROOT(GGrammar g) = g.S;

// SYMB = number of symbols in a production rule
public int SYMB(GGrammar g) = (0 | it + SYMB(p) | p <- g.P);
public int SYMB(GProd p) = 2 + SYMB(p.rhs); // +1 for lhs, +1 for ::=
public int SYMB(label(_, GExpr expr)) = 1 + SYMB(expr);
public int SYMB(mark(_, GExpr expr)) = 1 + SYMB(expr);
public int SYMB(sequence(GExprList exprs)) = (1 | it + SYMB(e) | e <- exprs);
public int SYMB(choice(GExprList exprs)) = (1 | it + SYMB(e) | e <- exprs);
public int SYMB(allof(GExprList exprs)) = (1 | it + SYMB(e) | e <- exprs);
public int SYMB(not(GExpr expr)) = 1 + SYMB(expr);
public int SYMB(except(GExpr expr1, GExpr expr2)) = SYMB(expr1) + 1 + SYMB(expr2);
public int SYMB(optional(GExpr expr)) = 1 + SYMB(expr);
public int SYMB(plus(GExpr expr)) = 1 + SYMB(expr);
public int SYMB(star(GExpr expr)) = 1 + SYMB(expr);
public int SYMB(sepliststar(GExpr expr, GExpr sep)) = SYMB(expr) + 1 + SYMB(sep);
public int SYMB(seplistplus(GExpr expr, GExpr sep)) = SYMB(expr) + 1 + SYMB(sep);
public int SYMB(nothing()) = 0; // soft error
public default int SYMB(GExpr e) = 1;

// Same with frequencies
public lrel[str,int] freqTerminals(list[str] ts, GGrammar g) = [<s,len([1|/terminal(s)<-g.P])> | s<-ts];
public lrel[str,int] freqNonterminals(list[str] ns, GGrammar g) = [<s,len([1|/nonterminal(s)<-g.P])> | s<-ns];
public lrel[str,int] freqMAR(GGrammar g) = [<s,len([1|/mark(s,_)<-g.P])> | s <- listMAR(g)];
public lrel[str,int] freqLAB(GGrammar g) = [<s,len([1|/label(s,_)<-g.P])> | s <- listLAB(g)];
