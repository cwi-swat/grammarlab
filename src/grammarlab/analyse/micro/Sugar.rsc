@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::analyse::micro::Sugar

import grammarlab::language::Grammar;
import grammarlab::language::Micro;
import grammarlab::transform::Normal;

set[str] check4mp(fakeOptional(), GGrammar g) = {n | str n <- g.nts, isfakeopt(normanon(g.prods[n]))};
bool     check4mp(fakeOptional(), GGrammar g, str n) = n in g.nts && isfakeopt(normanon(g.prods[n]));

// N = … | ε, in all the variants
bool isfakeopt([production(_,choice([nonterminal(_),epsilon()]))]) = true;
bool isfakeopt([production(_,choice([epsilon(),nonterminal(_)]))]) = true;
bool isfakeopt([production(_,nonterminal(_)),production(_,epsilon())]) = true;
bool isfakeopt([production(_,epsilon()),production(_,nonterminal(_))]) = true;
bool isfakeopt(GProdList _) = false;

// TODO: does not work on vertically defined fake separator lists
set[str] check4mp(fakeSLPlus(), GGrammar g) = {n | str n <- g.nts, [p] := g.prods[n],   isfakeseplist(normanon(p).lhs, normanon(p).rhs)};
bool     check4mp(fakeSLPlus(), GGrammar g, str n) = n in g.nts && [p] := g.prods[n] && isfakeseplist(normanon(p).lhs, normanon(p).rhs);

// L = E (S E)*
bool isfakeseplist(_,     sequence([GExpr E,star(sequence([GExpr S, E]))]) ) = true;
// L = (E S)* E
bool isfakeseplist(_,     sequence([star(sequence([GExpr E, GExpr S])),E]) ) = true;
// L = E | L S E
bool isfakeseplist(str L, choice([GExpr E,sequence([nonterminal(L),GExpr S,E])]) ) = true;
// L = E | E S L
bool isfakeseplist(str L, choice([GExpr E,sequence([E,GExpr S,nonterminal(L)])]) ) = true;
// L = L S E | E
bool isfakeseplist(str L, choice([sequence([nonterminal(L),GExpr S,GExpr E]),E]) ) = true;
// L = E S L | E
bool isfakeseplist(str L, choice([sequence([GExpr E,GExpr S,nonterminal(L)]),E]) ) = true;
// otherwise, no
default bool isfakeseplist(str _, GExpr _) = false;

set[str] check4mp(fakeSLStar(), GGrammar g) = {n | str n <- g.nts, [production(str nt,optional(GExpr e))] := g.prods[n],   isfakeseplist(normanon(nt,e))};
bool     check4mp(fakeSLStar(), GGrammar g, str n) = n in g.nts && [production(str nt,optional(GExpr e))] := g.prods[n] && isfakeseplist(normanon(nt,e));

set[str] check4mp(fakeSL(), GGrammar g) = check4mp(fakeSLPlus(), g) + check4mp(fakeSLStar(), g);
bool     check4mp(fakeSL(), GGrammar g, str n) = check4mp(fakeSLPlus(), g, n) && check4mp(fakeSLStar(), g, n);

// possible TODO: all layer detection mechanisms now work only on vertical production rules

// ShiftExpression ::= AdditiveExpression
// ShiftExpression ::= ShiftExpression "<<" AdditiveExpression
// ShiftExpression ::= ShiftExpression ">>" AdditiveExpression
// ShiftExpression ::= ShiftExpression ">>>" AdditiveExpression
set[str] check4mp(exprInfixLayer(), GGrammar g) = {n | str n <- g.nts, [production(str n,nonterminal(str n2)),*L] := normanon(g.prods[n]),   allInfixLayers(n,n2,L)};
bool     check4mp(exprInfixLayer(), GGrammar g, str n) = n in g.nts && [production(str n,nonterminal(str n2)),*L] := normanon(g.prods[n]) && allInfixLayers(n,n2,L);

bool allInfixLayers(str n1, str n2, GExprList es) = ( true | it &&
	sequence([nonterminal(str x1),terminal(_),nonterminal(str x2)]) := e
	&& {x1,x2} == {n1,n2} | e <- es );

// UnaryExpression ::= PreIncrementExpression
// UnaryExpression ::= PreDecrementExpression
// UnaryExpression ::= "+" UnaryExpression
// UnaryExpression ::= "-" UnaryExpression
// UnaryExpression ::= UnaryExpressionNotPlusMinus
set[str] check4mp(exprPrefixLayer(), GGrammar g) = {n | str n <- g.nts, allPrefixLayers(normanon(g.prods[n]))};
bool     check4mp(exprPrefixLayer(), GGrammar g, str n) = n in g.nts && allPrefixLayers(normanon(g.prods[n]));

bool allPrefixLayers(GProdList ps) = ( true | it &&
	(
		nonterminal(_) := p.rhs
		|| sequence([terminal(_),nonterminal(_)]) := p.rhs
	) | p <- ps );

set[str] check4mp(exprPostfixLayer(), GGrammar g) = {n | str n <- g.nts, allPostfixLayers(normanon(g.prods[n]))};
bool     check4mp(exprPostfixLayer(), GGrammar g, str n) = n in g.nts && allPostfixLayers(normanon(g.prods[n]));

bool allPostfixLayers(GProdList ps) = ( true | it &&
	(
		nonterminal(_) := p.rhs
		|| sequence([nonterminal(_),terminal(_)]) := p.rhs
	) | p <- ps );

// PrimaryNoNewArray ::= Literal
// PrimaryNoNewArray ::= "this"
// PrimaryNoNewArray ::= "(" Expression ")"
// PrimaryNoNewArray ::= ClassInstanceCreationExpression
// PrimaryNoNewArray ::= FieldAccess
// PrimaryNoNewArray ::= MethodInvocation
// PrimaryNoNewArray ::= ArrayAccess
set[str] check4mp(exprLowestLayer(), GGrammar g) = {n | str n <- g.nts, allLowestLayers(normanon(g.prods[n]))};
bool     check4mp(exprLowestLayer(), GGrammar g, str n) = n in g.nts && allLowestLayers(normanon(g.prods[n]));

bool allLowestLayers(GProdList ps) = ( true | it &&
	(
		nonterminal(_) := p.rhs
		|| terminal(_) := p.rhs
		|| (sequence([terminal(str x1),nonterminal(_),terminal(str x2)]) := p.rhs && bracketpair(x1,x2))
	) | p <- ps );

// YACCification
set[str] check4mp(yaccPlusLeft(), GGrammar g) = {n | str n <- g.nts, yaccPL(normanon(g.prods[x]))};
bool     check4mp(yaccPlusLeft(), GGrammar g, str n) = n in g.nts && yaccPL(normanon(g.prods[n]));

bool yaccPL([production(x,sequence([nonterminal(x),nonterminal(_)])), production(x,nonterminal(_))]) = true;
bool yaccPL([production(x,nonterminal(_)), production(x,sequence([nonterminal(x),nonterminal(_)]))]) = true;
bool yaccPL([production(x,choice([sequence([nonterminal(x),nonterminal(_)]),nonterminal(_)]))]) = true;
bool yaccPL([production(x,choice([nonterminal(_),sequence([nonterminal(x),nonterminal(_)])]))]) = true;
default bool yaccPL(GProdList _) = false;

set[str] check4mp(yaccPlusRight(), GGrammar g) = {n | str n <- g.nts, yaccPR(normanon(g.prods[x]))};
bool     check4mp(yaccPlusRight(), GGrammar g, str n) = n in g.nts && yaccPR(normanon(g.prods[n]));

bool yaccPR([production(x,sequence([nonterminal(_),nonterminal(x)])), production(x,nonterminal(_))]) = true;
bool yaccPR([production(x,nonterminal(_)), production(x,sequence([nonterminal(_),nonterminal(x)]))]) = true;
bool yaccPR([production(x,choice([sequence([nonterminal(_),nonterminal(x)]),nonterminal(_)]))]) = true;
bool yaccPR([production(x,choice([nonterminal(_),sequence([nonterminal(_),nonterminal(x)])]))]) = true;
default bool yaccPR(GProdList _) = false;

set[str] check4mp(yaccStarLeft(), GGrammar g) = {n | str n <- g.nts, yaccSL(normanon(g.prods[x]))};
bool     check4mp(yaccStarLeft(), GGrammar g, str n) = n in g.nts && yaccSL(normanon(g.prods[n]));

bool yaccPR([production(x,sequence([nonterminal(x),nonterminal(_)])), production(x,epsilon())]) = true;
bool yaccPR([production(x,epsilon()), production(x,sequence([nonterminal(x),nonterminal(_)]))]) = true;
bool yaccPR([production(x,choice([sequence([nonterminal(x),nonterminal(_)]),epsilon()]))]) = true;
bool yaccPR([production(x,choice([epsilon(),sequence([nonterminal(x),nonterminal(_)])]))]) = true;
default bool yaccSL(GProdList _) = false;


set[str] check4mp(yaccStarRight(), GGrammar g) = {n | str n <- g.nts, yaccSR(normanon(g.prods[x]))};
bool     check4mp(yaccStarRight(), GGrammar g, str n) = n in g.nts && yaccSR(normanon(g.prods[n]));

bool yaccPR([production(x,sequence([nonterminal(_),nonterminal(x)])),production(x,epsilon())]) = true;
bool yaccPR([production(x,epsilon()),production(x,sequence([nonterminal(_),nonterminal(x)]))]) = true;
bool yaccPR([production(x,choice([sequence([nonterminal(_),nonterminal(x)]),epsilon()]))]) = true;
bool yaccPR([production(x,choice([epsilon(),sequence([nonterminal(_),nonterminal(x)])]))]) = true;
default bool yaccSL(GProdList _) = false;
