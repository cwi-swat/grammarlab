@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::analyse::micro::Global

import grammarlab::language::Grammar;
import grammarlab::language::Micro;

set[str] check4mp(top(), GGrammar g) = {n | str n <- g.nts, /nonterminal(n) !:= g.prods};
bool     check4mp(top(), GGrammar g, str n) = n in g.nts && /nonterminal(n) !:= g.prods;

set[str] check4mp(bottom(), GGrammar g) = {n | /nonterminal(str n) := g.prods} - toSet(g.nts);
bool     check4mp(bottom(), GGrammar g, str n) = n notin g.nts && /nonterminal(n) := g.prods;

set[str] check4mp(leaf(), GGrammar g) = {n | str n <- g.nts, !isEmpty(g.prods[n]),   /nonterminal(_) !:= g.prods[n]};
bool     check4mp(leaf(), GGrammar g, str n) = n in g.nts && !isEmpty(g.prods[n]) && /nonterminal(_) !:= g.prods[n];

set[str] check4mp(root(), GGrammar g) = toSet(g.roots & g.nts);
bool     check4mp(root(), GGrammar g, str n) = n in g.roots && n in g.nts;

set[str] check4mp(multiroot(), GGrammar g) = {n | str n <- g.roots, [production(n,choice(L))] := g.prods[n],   allnonterminals(L)};
bool     check4mp(multiroot(), GGrammar g, str n) = n in g.roots && [production(n,choice(L))] := g.prods[n] && allnonterminals(L);

bool allnonterminals(GExprList xs) = ( true | it && nonterminal(_) := e | e <- xs );
// bool allnonterminals(GExprSet  xs) = ( true | it && nonterminal(_) := e | e <- xs );

set[str] check4mp(disallowed(), GGrammar g) = {n | str n <- g.nts,
	[production(n,empty())] := normanon(g.prods[n])};
bool     check4mp(disallowed(), GGrammar g, str n) = n in g.nts &&
	[production(n,empty())] := normanon(g.prods[n]);

set[str] check4mp(singleton(), GGrammar g) = {n | str n <- g.nts,
	[production(n,E)] := normanon(g.prods[n]),
	choice(_) !:= E,
	empty() !:= E};
bool     check4mp(singleton(), GGrammar g, str n) = n in g.nts &&
	[production(n,E)] := normanon(g.prods[n]) &&
	choice(_) !:= E &&
	empty() !:= E;

set[str] check4mp(horizontal(), GGrammar g) = {n | str n <- g.nts, [production(n,choice(L))] := normanon(g.prods[n])};
bool     check4mp(horizontal(), GGrammar g, str n) = n in g.nts && [production(n,choice(L))] := normanon(g.prods[n]);

set[str] check4mp(vertical(), GGrammar g) = {n | str n <- g.nts,
	len(g.prods[n])>1,
	/production(n,choice(_)) !:= normanon(g.prods[n])};
bool     check4mp(vertical(), GGrammar g, str n) = n in g.nts &&
	len(g.prods[n])>1 &&
	/production(n,choice(_)) !:= normanon(g.prods[n]);

set[str] check4mp(zigzag(), GGrammar g) = {n | str n <- g.nts,
	len(g.prods[n])>1,
	/production(n,choice(_)) := normanon(g.prods[n])};
bool     check4mp(zigzag(), GGrammar g, str n) = n in g.nts &&
	len(g.prods[n])>1 &&
	/production(n,choice(_)) := normanon(g.prods[n]);
