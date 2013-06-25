@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::analyse::micro::Templates

import grammarlab::language::Grammar;
import grammarlab::language::Micro;
import List; // head, tail
import grammarlab::lib::Sizes;

bool     check4mp(constructors(), GGrammar g, str n) = n in g.nts &&
	( [production(n,choice(L))] := g.prods[n]
	  && arecons(L)
	) || arecons(g.prods[n]);

bool arecons(GProdList L) = ( !isEmpty(L) | it && labelled(str x, _) := p.rhs && !isEmpty(x) | p <- L );
bool arecons(GExprList L) = ( !isEmpty(L) | it && labelled(str x, _) := e     && !isEmpty(x) | e <- L );

bool     check4mp(\bracket(), GGrammar g, str n) = n in g.nts && oneisbracket(normanon(g.prods[n]));

bool oneisbracket([]) = false;
default bool oneisbracket(GProdList ps)
	= (production(_,sequence([terminal(str x),nonterminal(_),terminal(str y)])) := head(ps) && bracketpair(x,y))
	|| oneisbracket(tail(ps));

bool     check4mp(bracketSelf(), GGrammar g, str n) = n in g.nts &&	oneisbracketself(normanon(g.prods[n]));

bool oneisbracketself([]) = false;
default bool oneisbracketself(GProdList ps)
	= (production(str n,sequence([terminal(str x),nonterminal(n),terminal(str y)])) := head(ps) && bracketpair(x,y))
	|| oneisbracketself(tail(ps));

set[str] check4mp(bracketFakeSLStar(), GGrammar g) = {n | str n <- g.nts,
	([production(n,sequence([terminal(str x),
		optional(sequence([
			nonterminal(str elem),
			star(sequence([terminal(str sep), nonterminal(elem)])),
			optional(terminal(sep))
		])),terminal(str y)]))] := g.prods[n]
	||
	[production(n,sequence([terminal(str x),
		optional(sequence([
			nonterminal(str elem),
			star(sequence([terminal(str sep), nonterminal(elem)]))
		])),terminal(str y)]))] := g.prods[n]),
	bracketpair(x,y)};
bool     check4mp(bracketFakeSLStar(), GGrammar g, str n) = n in g.nts &&
	([production(n,sequence([terminal(str x),
		optional(sequence([
			nonterminal(str elem),
			star(sequence([terminal(str sep), nonterminal(elem)])),
			optional(terminal(sep))
		])),terminal(str y)]))] := g.prods[n]
	||
	[production(n,sequence([terminal(str x),
		optional(sequence([
			nonterminal(str elem),
			star(sequence([terminal(str sep), nonterminal(elem)]))
		])),terminal(str y)]))] := g.prods[n])
	&& bracketpair(x,y);

set[str] check4mp(bracketFakeSLPlus(), GGrammar g) = {n | str n <- g.nts,
	( [production(n,sequence([terminal(str x),nonterminal(_),star(sequence([terminal(_),nonterminal(_)])),terminal(str y)]))] := g.prods[n]
	||[production(n,sequence([terminal(str x),star(sequence([nonterminal(_),terminal(_)])),nonterminal(_),terminal(str y)]))] := g.prods[n]),
	bracketpair(x,y)};
bool     check4mp(bracketFakeSLPlus(), GGrammar g, str n) = n in g.nts &&
	( [production(n,sequence([terminal(str x),nonterminal(_),star(sequence([terminal(_),nonterminal(_)])),terminal(str y)]))] := g.prods[n]
	||[production(n,sequence([terminal(str x),star(sequence([nonterminal(_),terminal(_)])),nonterminal(_),terminal(str y)]))] := g.prods[n])
	&& bracketpair(x,y);

set[str] check4mp(bracketOptional(), GGrammar g) = {n | str n <- g.nts,
	[production(n,sequence([terminal(str x),optional(nonterminal(_)),terminal(str y)]))] := normanon(g.prods[n]),
	bracketpair(x,y)};
bool     check4mp(bracketOptional(), GGrammar g, str n) = n in g.nts &&
	[production(n,sequence([terminal(str x),optional(nonterminal(_)),terminal(str y)]))] := normanon(g.prods[n]) &&
	bracketpair(x,y);

set[str] check4mp(bracketPlus(), GGrammar g) = {n | str n <- g.nts,
	[production(n,sequence([terminal(str x),plus(nonterminal(_)),terminal(str y)]))] := normanon(g.prods[n]),
	bracketpair(x,y)};
bool     check4mp(bracketPlus(), GGrammar g, str n) = n in g.nts &&
	[production(n,sequence([terminal(str x),plus(nonterminal(_)),terminal(str y)]))] := normanon(g.prods[n]) &&
	bracketpair(x,y);

set[str] check4mp(bracketStar(), GGrammar g) = {n | str n <- g.nts,
	[production(n,sequence([terminal(str x),star(nonterminal(_)),terminal(str y)]))] := normanon(g.prods[n]),
	bracketpair(x,y)};
bool     check4mp(bracketStar(), GGrammar g, str n) = n in g.nts &&
	[production(n,sequence([terminal(str x),star(nonterminal(_)),terminal(str y)]))] := normanon(g.prods[n]) &&
	bracketpair(x,y);

set[str] check4mp(bracketSLPlus(), GGrammar g) = {n | str n <- g.nts,
	[production(n,sequence([terminal(str x),seplistplus(nonterminal(_),terminal(_)),terminal(str y)]))] := normanon(g.prods[n]),
	bracketpair(x,y)};
bool     check4mp(bracketSLPlus(), GGrammar g, str n) = n in g.nts &&
	[production(n,sequence([terminal(str x),seplistplus(nonterminal(_),terminal(_)),terminal(str y)]))] := normanon(g.prods[n]) &&
	bracketpair(x,y);

set[str] check4mp(bracketSLStar(), GGrammar g) = {n | str n <- g.nts,
	[production(n,sequence([terminal(str x),sepliststar(nonterminal(_),terminal(_)),terminal(str y)]))] := normanon(g.prods[n]),
	bracketpair(x,y)};
bool     check4mp(bracketSLStar(), GGrammar g, str n) = n in g.nts &&
	[production(n,sequence([terminal(str x),sepliststar(nonterminal(_),terminal(_)),terminal(str y)]))] := normanon(g.prods[n]) &&
	bracketpair(x,y);

bool     check4mp(delimited(), GGrammar g, str n) = n in g.nts && oneisdelimited(g.prods[n]);

bool oneisdelimited([]) = false;
default bool oneisdelimited(GProdList ps)
	= (production(_,sequence([terminal(str x),nonterminal(_),terminal(str y)])) := head(ps) && !bracketpair(x,y))
	|| oneisdelimited(tail(ps));

// TODO: we can arguably relax it by not posing any conditions of the tail
set[str] check4mp(distinguished(), GGrammar g) = {n | str n <- g.nts,
	(  [production(n,choice(L))] := normanon(g.prods[n])
	|| [production(n,star(choice(L)))] := normanon(g.prods[n])
	|| [production(n,plus(choice(L)))] := normanon(g.prods[n])),
	allstartwitht(L)};
bool     check4mp(distinguished(), GGrammar g, str n) = n in g.nts &&
	(  [production(n,choice(L))] := normanon(g.prods[n])
	|| [production(n,star(choice(L)))] := normanon(g.prods[n])
	|| [production(n,plus(choice(L)))] := normanon(g.prods[n])
	) && allstartwitht(L);

bool allstartwitht(GExprList L) = (true | it
	&& (terminal(_) := e
	||	sequence([terminal(_),nonterminal(_)]) := e
	||	sequence([terminal(_),optional(nonterminal(_))]) := e)
	| e <- L );

set[str] check4mp(elementAccess(), GGrammar g) = {n | str n <- g.nts,
	[production(n,sequence([nonterminal(_),terminal(str x),nonterminal(_),terminal(str y)]))] := g.prods[n],
	bracketpair(x,y)};
bool     check4mp(elementAccess(), GGrammar g, str n) = n in g.nts &&
	[production(n,sequence([nonterminal(_),terminal(str x),nonterminal(_),terminal(str y)]))] := g.prods[n] &&
	bracketpair(x,y);
	
// A non-trivial sequence of terminals, nonterminals and builtins.
set[str] check4mp(pureSequence(), GGrammar g) = {n | str n <- g.nts,
	[p] := normanon(g.prods[n]),
	sequence(_) := p.rhs,
	pureseq(p.rhs)};
bool     check4mp(pureSequence(), GGrammar g, str n) = n in g.nts &&
	[p] := normanon(g.prods[n]) &&
	sequence(_) := p.rhs &&
	pureseq(p.rhs);

bool pureseq(epsilon()) = true; // does not mean anything as a part of a sequence
bool pureseq(empty()) = false;
bool pureseq(anything()) = false; // arguable
bool pureseq(val(_)) = true; // arguable
bool pureseq(terminal(_)) = true;
bool pureseq(nonterminal(_)) = true;
bool pureseq(sequence(L)) = ( true | it && pureseq(e) | e <- L );
default bool pureseq(GExpr _) = false;
