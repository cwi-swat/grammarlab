@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::analyse::Micro

import grammarlab::language::Grammar;
import grammarlab::language::Micro;
import IO;

extend grammarlab::analyse::micro::Metasyntax;
extend grammarlab::analyse::micro::Global;
extend grammarlab::analyse::micro::Sugar;
extend grammarlab::analyse::micro::Naming;
extend grammarlab::analyse::micro::Concrete;
extend grammarlab::analyse::micro::Normal;
extend grammarlab::analyse::micro::Folding;
extend grammarlab::analyse::micro::Templates;

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
default bool check4mp(Micropattern mp, GGrammar g, str n)
 = false;
//{
//	println("Default case of check4mp of <mp> of <n>!");
//	return false;
//}

bool debug_check4mp(Micropattern mp, GGrammar g, str n)
{
	println("Checking check4mp of <mp> of <n>...");
	return check4mp(mp,g,n);
}

set[str] debug_check4mp(Micropattern mp, GGrammar g)
{
	println("Checking check4mp of <mp>...");
	return check4mp(mp,g);
}

@doc{Checks one nonterminal in a grammar for all micropatterns}
public MicroClassify nt2mp(GGrammar g, str n) = {mp | Micropattern mp <- ALLMPatterns, check4mp(mp,g,n)};

@doc{Checks all nonterminals in a grammar for all micropatterns, returns micropatterns per nonterminal}
public MicroPperN g2ppn(GGrammar g) = (nt:nt2mp(g,nt) | str nt <- g.nts);

@doc{Checks all nonterminals in a grammar for all micropatterns, returns nonterminals per micropattern}
public MicroNperP g2npp(GGrammar g) = (mp:check4mp(mp,g) | Micropattern mp <- ALLMPatterns);

@doc{Checks all nonterminals in a grammar for a micropattern}
// this is always correct, but non-default variants can be better optimised
public default set[str] check4mp(Micropattern mp, GGrammar g) = {n | str n <- g.nts, check4mp(mp,g,n)};
