@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::analyse::micro::Folding

import grammarlab::language::Grammar;
import grammarlab::language::Micro;

set[str] check4mp(justEmpty(), GGrammar g) = {n | str n <- g.nts, [production(n,epsilon())] := g.prods[n]};
bool     check4mp(justEmpty(), GGrammar g, str n) = n in g.nts && [production(n,epsilon())] := g.prods[n];

set[str] check4mp(justFailure(), GGrammar g) = {n | str n <- g.nts,  isEmpty(g.prods[n]) || [production(n,empty())] := g.prods[n]};
bool     check4mp(justFailure(), GGrammar g, str n) = n in g.nts && (isEmpty(g.prods[n]) || [production(n,empty())] := g.prods[n]);

set[str] check4mp(justOptional(), GGrammar g) = {n | str n <- g.nts, [production(n,optional(nonterminal(_)))] := g.prods[n]};
bool     check4mp(justOptional(), GGrammar g, str n) = n in g.nts && [production(n,optional(nonterminal(_)))] := g.prods[n];

set[str] check4mp(justPlus(), GGrammar g) = {n | str n <- g.nts, [production(n,plus(nonterminal(_)))] := g.prods[n]};
bool     check4mp(justPlus(), GGrammar g, str n) = n in g.nts && [production(n,plus(nonterminal(_)))] := g.prods[n];

set[str] check4mp(justStar(), GGrammar g) = {n | str n <- g.nts, [production(n,star(nonterminal(_)))] := g.prods[n]};
bool     check4mp(justStar(), GGrammar g, str n) = n in g.nts && [production(n,star(nonterminal(_)))] := g.prods[n];

set[str] check4mp(justSLPlus(), GGrammar g) = {n | str n <- g.nts, [production(n,seplistplus(nonterminal(_),terminal(_)))] := g.prods[n]};
bool     check4mp(justSLPlus(), GGrammar g, str n) = n in g.nts && [production(n,seplistplus(nonterminal(_),terminal(_)))] := g.prods[n];

set[str] check4mp(justSLStar(), GGrammar g) = {n | str n <- g.nts, [production(n,sepliststar(nonterminal(_),terminal(_)))] := g.prods[n]};
bool     check4mp(justSLStar(), GGrammar g, str n) = n in g.nts && [production(n,sepliststar(nonterminal(_),terminal(_)))] := g.prods[n];

set[str] check4mp(justChains(), GGrammar g) = {n | str n <- g.nts, alljustchains(g.prods[n])};
bool     check4mp(justChains(), GGrammar g, str n) = n in g.nts && alljustchains(g.prods[n]);

bool alljustchains([production(n,choice(L))]) = (true | it && nonterminal(_) := e | e <- L );
default bool alljustchains(GProdList ps) = ( len(ps) > 1 | it && production(_,_,nonterminal(_)) := p  | p <- ps );

set[str] check4mp(justOneChain(), GGrammar g) = {n | str n <- g.nts, [production(n,nonterminal(_))] := g.prods[n]};
bool     check4mp(justOneChain(), GGrammar g, str n) = n in g.nts && [production(n,nonterminal(_))] := g.prods[n];

set[str] check4mp(reflexiveChain(), GGrammar g) = {n | str n <- g.nts, [production(n,nonterminal(n))] := normanon(g.prods[n])};
bool     check4mp(reflexiveChain(), GGrammar g, str n) = n in g.nts && [production(n,nonterminal(n))] := normanon(g.prods[n]);

set[str] check4mp(chainOrTerminal(), GGrammar g) = {n | str n <- g.nts, ischainort(normanon(g.prods[n]))};
bool     check4mp(chainOrTerminal(), GGrammar g, str n) = n in g.nts && ischainort(normanon(g.prods[n]));

bool ischainort([production(_,choice([nonterminal(_),terminal(_)]))]) = true;
bool ischainort([production(_,choice([terminal(_),nonterminal(_)]))]) = true;
bool ischainort([production(_,terminal(_)),production(_,nonterminal(_))]) = true;
bool ischainort([production(_,nonterminal(_)),production(_,terminal(_))]) = true;
default bool ischainort(GProdList _) = false;

set[str] check4mp(chainsAndTerminals(), GGrammar g) = {n | str n <- g.nts, allchainort(normanon(g.prods[n]))};
bool     check4mp(chainsAndTerminals(), GGrammar g, str n) = n in g.nts && allchainort(normanon(g.prods[n]));

bool allchainort([production(_,choice(L))])
	= findchain(L)
	&& findt(L)
	&& allnort(L);
default bool allchainort(GProdList ps)
	= findchain([p.rhs | p <- ps])
	&& findt([p.rhs | p <- ps])
	&& allnort([p.rhs | p <- ps]);

bool findt(GExprList es) = ( false | it || terminal(_) := e | e <- es);
bool findchain(GExprList es) = ( false | it || nonterminal(_) := e | e <- es);
bool allnort(GExprList es) = ( !isEmpty(es) | it && (terminal(_) := e || nonterminal(_) := e) | e <- es );
