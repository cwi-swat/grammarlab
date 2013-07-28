@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::analyse::micro::Concrete

import grammarlab::language::Grammar;
import grammarlab::language::Micro;

set[str] check4mp(preterminal(), GGrammar g) = {n | str n <- g.nts, !isEmpty(g.prods[n]), allofterminals(g.prods[n])};
bool     check4mp(preterminal(), GGrammar g, str n) = n in g.nts && allofterminals(g.prods[n]);

bool allofterminals(GProdList ps) = ( true | it && allofterminals(p.rhs) | p <- ps );
bool allofterminals(GExprList xs) = ( true | it && allofterminals(e) | e <- xs );
bool allofterminals(terminal(_)) = true;
bool allofterminals(selectable(_,E)) = allofterminals(E); // arguable
bool allofterminals(labelled(_,E)) = allofterminals(E); // arguable
bool allofterminals(sequence(L)) = allofterminals(L);
bool allofterminals(choice(L)) = allofterminals(L);
bool allofterminals(allof(L)) = allofterminals(L); // hardly necessary
bool allofterminals(optional(E)) = allofterminals(E);
bool allofterminals(plus(E)) = allofterminals(E);
bool allofterminals(star(E)) = allofterminals(E);
bool allofterminals(seplistplus(E,S)) = allofterminals(E) && allofterminals(S);
bool allofterminals(sepliststar(E,S)) = allofterminals(E) && allofterminals(S);
default bool allofterminals(GExpr _) = false;

set[str] check4mp(\keyword(), GGrammar g) = {n | str n <- g.nts, [production(n,terminal(str x))] := g.prods[n],   isWord(x)};
bool     check4mp(\keyword(), GGrammar g, str n) = n in g.nts && [production(n,terminal(str x))] := g.prods[n] && isWord(x);

set[str] check4mp(keywords(), GGrammar g) = {n | str n <- g.nts, allConform2(normanon(g.prods[n]),isKeyword)};
bool     check4mp(keywords(), GGrammar g, str n) = n in g.nts && allConform2(normanon(g.prods[n]),isKeyword);

set[str] check4mp(operator(), GGrammar g) = {n | str n <- g.nts, [production(n,terminal(str x))] := g.prods[n],   isSpecial(x)};
bool     check4mp(operator(), GGrammar g, str n) = n in g.nts && [production(n,terminal(str x))] := g.prods[n] && isSpecial(x);

set[str] check4mp(operators(), GGrammar g) = {n | str n <- g.nts, allTconform2(normanon(g.prods[n]),isSpecial)};
bool     check4mp(operators(), GGrammar g, str n) = n in g.nts && allTconform2(normanon(g.prods[n]),isSpecial);

// TODO: originally it was much less permissive, like this:
// 			[*L1,*L2] := L,
// 			(allops(L1) && allkeywords(L2))
// 			||
// 			(allops(L2) && allkeywords(L1))
set[str] check4mp(operatorsMixed(), GGrammar g) = {n | str n <- g.nts, allTconform2(normanon(g.prods[n]),isSpecialOrWord)};
bool     check4mp(operatorsMixed(), GGrammar g, str n) = n in g.nts && allTconform2(normanon(g.prods[n]),isSpecialOrWord);

set[str] check4mp(words(), GGrammar g) = {n | str n <- g.nts, prods2words(normanon(g.prods[n]))};
bool     check4mp(words(), GGrammar g, str n) = n in g.nts && prods2words(normanon(g.prods[n]));

// simpleDerivationSet ::= ("#all" | ("list" | "union" | "restriction")*) ;
bool prods2words([production(n,plus(choice(L1)))]) = allConform2(L1,isKeyword);
bool prods2words([production(n,star(choice(L2)))]) = allConform2(L2,isKeyword);
bool prods2words([production(n,sequence(L3))]) = allConform2(L3,isKeyword);
bool prods2words([production(n,sequence([terminal(x),star(choice(L4))]))]) = isWord(x) && allConform2(L4,isKeyword);
default bool prods2words(GProdList ps) = false;

set[str] check4mp(tokens(), GGrammar g) = {n | str n <- g.nts, aretokens(normanon(g.prods[n]))};
bool     check4mp(tokens(), GGrammar g, str n) = n in g.nts && aretokens(normanon(g.prods[n]));

bool aretokens([production(_,choice(L))]) = ( !isEmpty(L) | it && terminal(x) := e && len(x)>1 | e <- L );
default bool aretokens(GProdList ps) = false;

set[str] check4mp(modifiers(), GGrammar g) = {n | str n <- g.nts, alllookslikemodifier(normanon(g.prods[n]))};
bool     check4mp(modifiers(), GGrammar g, str n) = n in g.nts && alllookslikemodifier(normanon(g.prods[n]));

// TODO: isn’t this perhaps dangerously specific?
bool alllookslikemodifier(GProdList ps)  = ( !isEmpty(ps) | it && lookslikemodifier(p.rhs) | p <- ps );
bool lookslikemodifier(choice([GExpr x, GExpr y, sequence([x,y])])) = true;
bool lookslikemodifier(choice([optional(GExpr x),sequence([x,GExpr y]),y])) = true;
bool lookslikemodifier(choice(
	[sequence([optional(GExpr x),GExpr y]),
	sequence([y,optional(x)])])) = true;
bool lookslikemodifier(choice(
	[sequence([optional(GExpr x),GExpr y]),
	sequence([y,x])])) = true;
bool lookslikemodifier(choice(
	[sequence([optional(GExpr x),optional(GExpr y),GExpr z]),
	sequence([optional(y),optional(x),z]),
	sequence([optional(x),z,optional(y)]),
	sequence([optional(y),z,optional(x)]),
	sequence([z,optional(x),optional(y)]),
	sequence([z,optional(y),optional(x)])])) = true;
default bool lookslikemodifier(GExpr p) = false;

set[str] check4mp(range(), GGrammar g) = {n | str n <- g.nts, allTconform2(normanon(g.prods[n]),isTrivial)};
bool     check4mp(range(), GGrammar g, str n) = n in g.nts && allTconform2(normanon(g.prods[n]),isTrivial);

set[str] check4mp(literalNumeric(), GGrammar g) = {n | str n <- g.nts, [p] := normanon(g.prods[n]),   lookslikeint(p.rhs)};
bool     check4mp(literalNumeric(), GGrammar g, str n) = n in g.nts && [p] := normanon(g.prods[n]) && lookslikeint(p.rhs);

bool lookslikeint(plus(choice(L2))) 
	= allTconform2(L2,isDigit);
bool lookslikeint(sequence([optional(choice(L3)),plus(choice(L4))]))
	=  allTconform2(L3,isSpecial)
	&& allTconform2(L4,isDigit);
bool lookslikeint(choice([terminal("0"),sequence([choice(L5),star(choice(L6))])]))
	=  allTconform2(L5,isDigit)
	&& allTconform2(L6,isDigit);
bool lookslikeint(choice(L1))
// OOPS: probably not safe for next versions of Rascal
	= allTconform2(L1,isDigit);
bool lookslikeint(sequence([optional(choice(L7)),choice([terminal("0"),sequence([choice(L8),star(choice(L9))])])]))
	=  allTconform2(L7,isSpecial)
	&& allTconform2(L8,isDigit)
	&& allTconform2(L9,isDigit);
default bool lookslikeint(GExpr _) = false;

set[str] check4mp(literalSimple(), GGrammar g) = {n | str n <- g.nts,
	[production(n,plus(choice(L)))] := normanon(g.prods[n]),
	areSimpleLiterals(L)};
bool     check4mp(literalSimple(), GGrammar g, str n) = n in g.nts
	&& [production(n,plus(choice(L)))] := normanon(g.prods[n])
	&& areSimpleLiterals(L);

bool areSimpleLiterals(GExprList L) = (!isEmpty(L) | it && terminal(x) := e && len(x)==1 | e <- L);

set[str] check4mp(literalFirstRest(), GGrammar g) = {n | str n <- g.nts,
	[production(n,sequence([choice(L1),star(choice(L2))]))] := normanon(g.prods[n]),
	areSimpleLiterals(L1),
	areSimpleLiterals(L2)};
bool     check4mp(literalFirstRest(), GGrammar g, str n) = n in g.nts
	&& [production(n,sequence([choice(L1),star(choice(L2))]))] := normanon(g.prods[n])
	&& areSimpleLiterals(L1)
	&& areSimpleLiterals(L2);

set[str] check4mp(simpleStatement(), GGrammar g) = {n | str n <- g.nts, isTStatement(normanon(g.prods[n]))};
bool     check4mp(simpleStatement(), GGrammar g, str n) = n in g.nts && isTStatement(normanon(g.prods[n]));
bool isTStatement([production(_,sequence([*L,terminal(";")]))]) = ( true | it && terminal(_) := e | e <- L );
default bool isTStatement(GProdList _) = false;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	

// bool isSpecial(str x) = /[\ \@\#\$\&\%\=\\\/\.\,\:\;\*\+\-\_\!\?\(\)\[\]\{\}\<\>\~\'\"\^\|������������]+/ := x; //'
// \���\���
bool isSpecial(str x) = /[a-zA-Z]/ !:= x; // NB: no start/end constraints!
bool isWord(str x) = /^[\w\.\-\#]+$/ := x;
bool isTrivial(str x) = len(x)==1;
// underscore for Eiffel’s sake
bool isDigit(str x) = /^[0-9A-Fa-f\_]$/ := x;

bool isKeyword(terminal(x)) = isWord(x);
bool isKeyword(sequence(L)) = ( !isEmpty(L) | it && isKeyword(e) | e <- L); // SIC!
default bool isKeyword(GExpr e) = false;

bool isSpecialOrWord(str x) = isWord(x) || isSpecial(x);

// universal higher-order function to check that all terminals within the list of production rules, conform to some given function
bool allConform2(GProdList ps, bool(GExpr) check) = ( !isEmpty(ps) | it &&
	(
		check(p.rhs)
	||
		(choice(L) := p.rhs && allConform2(L,check))
	) | p <- ps );
bool allConform2(GExprList es, bool(GExpr) check) = ( !isEmpty(es) | it && check(e) | e <- es );

bool allTconform2(GProdList ps, bool(str) check) = ( !isEmpty(ps) | it &&
	(
		(terminal(str x) := p.rhs && check(x))
	||
		(choice(L) := p.rhs && allTconform2(L,check))
	) | p <- ps );
bool allTconform2(GExprList es, bool(str) check) = ( !isEmpty(es) | it && terminal(str y) := e && check(y) | e <- es );