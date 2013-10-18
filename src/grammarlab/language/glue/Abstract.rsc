@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::glue::Abstract

import grammarlab::language::Grammar;
import grammarlab::language::X;

alias GLUE = list[GLUEA];

data GLUEA
	= xbgf(XCommand tcmd)
	| sleir(LCommand mcmd)
	| glaction(LCommand xcmd)
	;

// WIP: GrammarLab actions
data LCommand
	= diff(GGrammar g)
	| include(loc z)
	;

// WIP: mutations
data LCommand
	= liftTopLabels()
	| deyaccifyAll()
	;
