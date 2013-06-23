@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::analyse::micro::Metasyntax

import grammarlab::language::Grammar;
import grammarlab::language::Micro;

set[str] check4mp(contains-star(), GGrammar g) = {n | str n <- g.nts, /star(_) := g.prods[n]};
bool     check4mp(contains-star(), GGrammar g, str n) = n in g.nts && /star(_) := g.prods[n];

set[str] check4mp(contains-plus(), GGrammar g) = {n | str n <- g.nts, /plus(_) := g.prods[n]};
bool     check4mp(contains-plus(), GGrammar g, str n) = n in g.nts && /plus(_) := g.prods[n];

set[str] check4mp(contains-optional(), GGrammar g) = {n | str n <- g.nts, /optional(_) := g.prods[n]};
bool     check4mp(contains-optional(), GGrammar g, str n) = n in g.nts && /optional(_) := g.prods[n];

set[str] check4mp(contains-epsilon(), GGrammar g) = {n | str n <- g.nts, /epsilon() := g.prods[n]};
bool     check4mp(contains-epsilon(), GGrammar g, str n) = n in g.nts && /epsilon() := g.prods[n];

set[str] check4mp(contains-failure(), GGrammar g) = {n | str n <- g.nts, /empty(_) := g.prods[n]};
bool     check4mp(contains-failure(), GGrammar g, str n) = n in g.nts && /empty(_) := g.prods[n];

set[str] check4mp(contains-universal(), GGrammar g) = {n | str n <- g.nts, /anything(_) := g.prods[n]};
bool     check4mp(contains-universal(), GGrammar g, str n) = n in g.nts && /anything(_) := g.prods[n];

set[str] check4mp(contains-integer(), GGrammar g) = {n | str n <- g.nts, /val(integer(_)) := g.prods[n]};
bool     check4mp(contains-integer(), GGrammar g, str n) = n in g.nts && /val(integer(_)) := g.prods[n];

set[str] check4mp(contains-string(), GGrammar g) = {n | str n <- g.nts, /val(string(_)) := g.prods[n]};
bool     check4mp(contains-string(), GGrammar g, str n) = n in g.nts && /val(string(_)) := g.prods[n];

set[str] check4mp(contains-boolean(), GGrammar g) = {n | str n <- g.nts, /val(boolean(_)) := g.prods[n]};
bool     check4mp(contains-boolean(), GGrammar g, str n) = n in g.nts && /val(boolean(_)) := g.prods[n];

set[str] check4mp(contains-selector(), GGrammar g) = {n | str n <- g.nts, /selectable(_,_) := g.prods[n]};
bool     check4mp(contains-selector(), GGrammar g, str n) = n in g.nts && /selectable(_,_) := g.prods[n];

set[str] check4mp(contains-label(), GGrammar g) = {n | str n <- g.nts, /labelled(_,_) := g.prods[n]};
bool     check4mp(contains-label(), GGrammar g, str n) = n in g.nts && /labelled(_,_) := g.prods[n];

set[str] check4mp(contains-mark(), GGrammar g) = {n | str n <- g.nts, /marked(_) := g.prods[n]};
bool     check4mp(contains-mark(), GGrammar g, str n) = n in g.nts && /marked(_) := g.prods[n];

set[str] check4mp(contains-sequence(), GGrammar g) = {n | str n <- g.nts, /sequence(_) := g.prods[n]};
bool     check4mp(contains-sequence(), GGrammar g, str n) = n in g.nts && /sequence(_) := g.prods[n];

set[str] check4mp(contains-disjunction(), GGrammar g) = {n | str n <- g.nts, /choice(_) := g.prods[n]};
bool     check4mp(contains-disjunction(), GGrammar g, str n) = n in g.nts && /choice(_) := g.prods[n];

set[str] check4mp(contains-conjunction(), GGrammar g) = {n | str n <- g.nts, /allof(_) := g.prods[n]};
bool     check4mp(contains-conjunction(), GGrammar g, str n) = n in g.nts && /allof(_) := g.prods[n];

set[str] check4mp(contains-negation(), GGrammar g) = {n | str n <- g.nts, /not(_) := g.prods[n]};
bool     check4mp(contains-negation(), GGrammar g, str n) = n in g.nts && /not(_) := g.prods[n];

set[str] check4mp(contains-sl-star(), GGrammar g) = {n | str n <- g.nts, /sepliststar(_) := g.prods[n]};
bool     check4mp(contains-sl-star(), GGrammar g, str n) = n in g.nts && /sepliststar(_) := g.prods[n];

set[str] check4mp(contains-sl-plus(), GGrammar g) = {n | str n <- g.nts, /seplistplus(_) := g.prods[n]};
bool     check4mp(contains-sl-plus(), GGrammar g, str n) = n in g.nts && /seplistplus(_) := g.prods[n];

set[str] check4mp(contains-terminal(), GGrammar g) = {n | str n <- g.nts, /terminal(_) := g.prods[n]};
bool     check4mp(contains-terminal(), GGrammar g, str n) = n in g.nts && /terminal(_) := g.prods[n];

set[str] check4mp(contains-nonterminal(), GGrammar g) = {n | str n <- g.nts, /nonterminal(_) := g.prods[n]};
bool     check4mp(contains-nonterminal(), GGrammar g, str n) = n in g.nts && /nonterminal(_) := g.prods[n];

set[str] check4mp(abstractSyntax(), GGrammar g) = {n | str n <- g.nts, !isEmpty(g.prods[n]),   /terminal(_) !:= g.prods[n]};
bool     check4mp(abstractSyntax(), GGrammar g, str n) = n in g.nts && !isEmpty(g.prods[n]) && /terminal(_) !:= g.prods[n];
