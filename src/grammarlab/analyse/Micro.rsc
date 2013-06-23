@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::analyse::Micro

import grammarlab::language::Grammar;
import grammarlab::language::Micro;

extend grammarlab::analyse::micro::Metasyntax;
extend grammarlab::analyse::micro::Global;
extend grammarlab::analyse::micro::Sugar;
extend grammarlab::analyse::micro::Naming;

bool bracketpair("\"","\"") = true;
bool bracketpair("\'","\'") = true;
bool bracketpair("(",")") = true;
bool bracketpair("[","]") = true;
bool bracketpair("[[","]]") = true;
bool bracketpair("{","}") = true;
bool bracketpair("{{","}}") = true;
bool bracketpair("\<","\>") = true;
bool bracketpair("\<\<","\>\>") = true;
bool bracketpair("\<!--","--\>") = true; // !!!
default bool bracketpair(str x, str y) = false;

@doc{Checks one nonterminal in a grammar for a micropattern}
// by default, the micropattern is assumed to NOT be satisfied
default bool check4mp(Micropattern mp, str n, GGrammar g) = false;

@doc{Checks one nonterminal in a grammar for all micropatterns}
MicroClassify nt2mp(str n, GGrammar g) = {mp | Micropattern mp <- ALLMPatterns, check4mp(mp,n,g)};

@doc{Checks all nonterminals in a grammar for all micropatterns}
MicroGrammar g2mp(GGrammar g) = (nt:nt2mp(nt,g) | str nt <- g.gnts);

@doc{Checks all nonterminals in a grammar for a micropattern}
// this is always correct, but non-default variants are better optimised
default set[str] check4mp(Micropattern mp, GGrammar g) = {n | str n <- g.nts, check4mp(mp,n,g)};
