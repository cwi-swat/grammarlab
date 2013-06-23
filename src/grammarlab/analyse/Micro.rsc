@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::analyse::Micro

import grammarlab::language::Grammar;
import grammarlab::language::Micro;

extend grammarlab::analyse::micro::Metasyntax;

// alias MicroGrammar = map[str,MicroClassify];
// alias MicroClassify = set[Micropattern];

@doc{Checks one nonterminal in a grammar for a micropattern}
bool check4mp(Micropattern mp, str n, GGrammar g)
{
	// ...
}

@doc{Checks one nonterminal in a grammar for all micropatterns}
MicroClassify nt2mp(str n, GGrammar g)
{
	// ...
}

@doc{Checks all nonterminals in a grammar for all micropatterns}
MicroGrammar g2mp(GGrammar g)
{
	// ...
}

@doc{Checks all nonterminals in a grammar for a micropattern}
set[str] check4mp(Micropattern mp, GGrammar g)
{
	// ...
}