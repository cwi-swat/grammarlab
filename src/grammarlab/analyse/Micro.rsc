@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::analyse::Micro

import grammarlab::language::Grammar;
import grammarlab::language::Micro;

extend grammarlab::analyse::micro::Metasyntax;
extend grammarlab::analyse::micro::Global;

// alias MicroGrammar = map[str,MicroClassify];
// alias MicroClassify = set[Micropattern];

@doc{Checks one nonterminal in a grammar for a micropattern}
default bool check4mp(Micropattern mp, str n, GGrammar g)
{
	// ...
	return false;
}

@doc{Checks one nonterminal in a grammar for all micropatterns}
default MicroClassify nt2mp(str n, GGrammar g)
{
	// ...
	return {};
}

@doc{Checks all nonterminals in a grammar for all micropatterns}
default MicroGrammar g2mp(GGrammar g)
{
	// ...
	return ();
}

@doc{Checks all nonterminals in a grammar for a micropattern}
default set[str] check4mp(Micropattern mp, GGrammar g)
{
	// ...
	return {};
}