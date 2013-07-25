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
public int VAR(GGrammar g) = len([n | str n <- g.nts, !isEmpty(g.prods[n])]);
