@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::analyse::micro::Metasyntax

import grammarlab::language::Grammar;
import grammarlab::language::Micro;

set[str] check4mp(containsStar(), GGrammar g) = {n | str n <- g.nts, /star(_) := g.prods[n]};
bool     check4mp(containsStar(), GGrammar g, str n) = n in g.nts && /star(_) := g.prods[n];
                          
set[str] check4mp(containsPlus(), GGrammar g) = {n | str n <- g.nts, /plus(_) := g.prods[n]};
bool     check4mp(containsPlus(), GGrammar g, str n) = n in g.nts && /plus(_) := g.prods[n];
                          
set[str] check4mp(containsOptional(), GGrammar g) = {n | str n <- g.nts, /optional(_) := g.prods[n]};
bool     check4mp(containsOptional(), GGrammar g, str n) = n in g.nts && /optional(_) := g.prods[n];
                          
set[str] check4mp(containsEpsilon(), GGrammar g) = {n | str n <- g.nts, /epsilon() := g.prods[n]};
bool     check4mp(containsEpsilon(), GGrammar g, str n) = n in g.nts && /epsilon() := g.prods[n];
                          
set[str] check4mp(containsFailure(), GGrammar g) = {n | str n <- g.nts, /empty() := g.prods[n]};
bool     check4mp(containsFailure(), GGrammar g, str n) = n in g.nts && /empty() := g.prods[n];
                          
set[str] check4mp(containsUniversal(), GGrammar g) = {n | str n <- g.nts, /anything() := g.prods[n]};
bool     check4mp(containsUniversal(), GGrammar g, str n) = n in g.nts && /anything() := g.prods[n];
                          
set[str] check4mp(containsInteger(), GGrammar g) = {n | str n <- g.nts, /val(integer()) := g.prods[n]};
bool     check4mp(containsInteger(), GGrammar g, str n) = n in g.nts && /val(integer()) := g.prods[n];
                          
set[str] check4mp(containsString(), GGrammar g) = {n | str n <- g.nts, /val(string()) := g.prods[n]};
bool     check4mp(containsString(), GGrammar g, str n) = n in g.nts && /val(string()) := g.prods[n];
                          
set[str] check4mp(containsBoolean(), GGrammar g) = {n | str n <- g.nts, /val(boolean()) := g.prods[n]};
bool     check4mp(containsBoolean(), GGrammar g, str n) = n in g.nts && /val(boolean()) := g.prods[n];
                          
set[str] check4mp(containsSelector(), GGrammar g) = {n | str n <- g.nts, /selectable(_,_) := g.prods[n]};
bool     check4mp(containsSelector(), GGrammar g, str n) = n in g.nts && /selectable(_,_) := g.prods[n];
                          
set[str] check4mp(containsLabel(), GGrammar g) = {n | str n <- g.nts, /labelled(_,_) := g.prods[n]};
bool     check4mp(containsLabel(), GGrammar g, str n) = n in g.nts && /labelled(_,_) := g.prods[n];
                          
set[str] check4mp(containsMark(), GGrammar g) = {n | str n <- g.nts, /marked(_) := g.prods[n]};
bool     check4mp(containsMark(), GGrammar g, str n) = n in g.nts && /marked(_) := g.prods[n];
                          
set[str] check4mp(containsSequence(), GGrammar g) = {n | str n <- g.nts, /sequence(_) := g.prods[n]};
bool     check4mp(containsSequence(), GGrammar g, str n) = n in g.nts && /sequence(_) := g.prods[n];
                          
set[str] check4mp(containsDisjunction(), GGrammar g) = {n | str n <- g.nts, /choice(_) := g.prods[n]};
bool     check4mp(containsDisjunction(), GGrammar g, str n) = n in g.nts && /choice(_) := g.prods[n];
                          
set[str] check4mp(containsConjunction(), GGrammar g) = {n | str n <- g.nts, /allof(_) := g.prods[n]};
bool     check4mp(containsConjunction(), GGrammar g, str n) = n in g.nts && /allof(_) := g.prods[n];
                          
set[str] check4mp(containsNegation(), GGrammar g) = {n | str n <- g.nts, /not(_) := g.prods[n]};
bool     check4mp(containsNegation(), GGrammar g, str n) = n in g.nts && /not(_) := g.prods[n];
                          
set[str] check4mp(containsSLStar(), GGrammar g) = {n | str n <- g.nts, /sepliststar(_,_) := g.prods[n]};
bool     check4mp(containsSLStar(), GGrammar g, str n) = n in g.nts && /sepliststar(_,_) := g.prods[n];
                          
set[str] check4mp(containsSLPlus(), GGrammar g) = {n | str n <- g.nts, /seplistplus(_,_) := g.prods[n]};
bool     check4mp(containsSLPlus(), GGrammar g, str n) = n in g.nts && /seplistplus(_,_) := g.prods[n];
                          
set[str] check4mp(containsTerminal(), GGrammar g) = {n | str n <- g.nts, /terminal(_) := g.prods[n]};
bool     check4mp(containsTerminal(), GGrammar g, str n) = n in g.nts && /terminal(_) := g.prods[n];
                          
set[str] check4mp(containsNonterminal(), GGrammar g) = {n | str n <- g.nts, /nonterminal(_) := g.prods[n]};
bool     check4mp(containsNonterminal(), GGrammar g, str n) = n in g.nts && /nonterminal(_) := g.prods[n];

set[str] check4mp(abstractSyntax(), GGrammar g) = {n | str n <- g.nts, !isEmpty(g.prods[n]),   /terminal(_) !:= g.prods[n]};
bool     check4mp(abstractSyntax(), GGrammar g, str n) = n in g.nts && !isEmpty(g.prods[n]) && /terminal(_) !:= g.prods[n];
