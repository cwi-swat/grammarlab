@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::analyse::Metrics

import grammarlab::language::Grammar;
import grammarlab::lib::Sizes;
import grammarlab::lib::Haskell;

// PROD
public int PROD(GGrammar g) = summap(countProd, g.P);

int countProd(production (_, label(_,choice(GExprList exprs)))) = len(exprs);
int countProd(production (_,  mark(_,choice(GExprList exprs)))) = len(exprs);
int countProd(production (_,         choice(GExprList exprs)))  = len(exprs);
default int countProd(GProd p) = 1;

// VAR
public int VAR(GGrammar g) = ulen(g.nts, {name | /nonterminal(str name) := g.prods});

// TERM
public int TERM(GGrammar g) = ulen({name | /terminal(str name) := g.prods});

// MAR
public int MAR(GGrammar g) = ulen({name | /mark(str name, _) := g.prods});

// LAB
public int LAB(GGrammar g) = ulen({name | /label(str name, _) := g.prods});

// VOC
public int VOC(GGrammar g) = PROD(g) + VAR(g) + TERM(g) + MAR(g) + LAB(g);
