@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::analyse::Metrics

import grammarlab::language::Grammar;
import grammarlab::lib::Sizes;

// PROD
public int PROD(GGrammar g)
	= ( 0 | it + countProd(p) | str n <- g.nts, GProd p <- g.prods[n] );

int countProd(production (_,   labelled(_,choice(GExprList exprs)))) = len(exprs);
int countProd(production (_, selectable(_,choice(GExprList exprs)))) = len(exprs);
int countProd(production (_,              choice(GExprList exprs)))  = len(exprs);
default int countProd(GProd p) = 1;

// VAR
public int VAR(GGrammar g) = ulen(g.nts, {name | /nonterminal(str name) := g.prods});

// TERM
public int TERM(GGrammar g) = ulen({name | /terminal(str name) := g.prods});

// SEL
public int SEL(GGrammar g) = ulen({name | /selectable(str name, _) := g.prods});

// LAB
public int LAB(GGrammar g) = ulen({name | /labelled(str name, _) := g.prods});

// VOC
public int VOC(GGrammar g) = PROD(g) + VAR(g) + TERM(g) + SEL(g) + LAB(g);
