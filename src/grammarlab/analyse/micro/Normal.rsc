@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::analyse::micro::Normal

import grammarlab::language::Grammar;
import grammarlab::language::Micro;

// Chomsky normal form
// see http://dx.doi.org/10.1016/S0019-9958(59)90362-6
set[str] check4mp(chomskyNormalForm(), GGrammar g) = {n | str n <- g.nts, ( !isEmpty(g.prods[n]) | it && isCNF(p.rhs) | p <- g.prods[n] )};
bool     check4mp(chomskyNormalForm(), GGrammar g, str n) = n in g.nts && ( !isEmpty(g.prods[n]) | it && isCNF(p.rhs) | p <- g.prods[n] );

bool isCNF(epsilon()) = true;
bool isCNF(terminal(_)) = true;
bool isCNF(sequence([nonterminal(_),nonterminal(_)])) = true;
default bool isCNF(GExpr e) = false;

// Greibach normal form
// see http://dx.doi.org/10.1145/321250.321254
set[str] check4mp(greibachNormalForm(), GGrammar g) = {n | str n <- g.nts, ( !isEmpty(g.prods[n]) | it && isGNF(p.rhs) | p <- g.prods[n] )};
bool     check4mp(greibachNormalForm(), GGrammar g, str n) = n in g.nts && ( !isEmpty(g.prods[n]) | it && isGNF(p.rhs) | p <- g.prods[n] );

bool isGNF(epsilon()) = true;
bool isGNF(selectable(_,epsilon())) = true;
bool isGNF(sequence([terminal(),*L])) = isEmpty(L) || allnonterminals(L);
default bool isGNF(GExpr e) = false;

// Abstract normal form
// see http://dx.doi.org/10.6084/m9.figshare.643391
set[str] check4mp(abstractNormalForm(), GGrammar g) = {n | str n <- g.nts, /terminal(_) !:= g.prods[n],   isANF(g.prods[n])};
bool     check4mp(abstractNormalForm(), GGrammar g, str n) = n in g.nts && /terminal(_) !:= g.prods[n] && isANF(g.prods[n]);

bool isANF([]) = true;
bool isANF([production(_,choice(L))]) = allnonterminals(L);
bool isANF([GProd p]) = choice(_) !:= p.rhs;
default bool isANF(GProdList ps) = len(ps)>1 && ( true | it && production(_,nonterminal(_)) := p  | p <- ps );
