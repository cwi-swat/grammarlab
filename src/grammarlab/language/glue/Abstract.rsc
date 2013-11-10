@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::glue::Abstract

import grammarlab::language::Grammar;
import grammarlab::language::X;

alias GLUE = list[GLUEA];

data GLUEA
	= xbgf(XCommand tcmd)
	| sleir(MCommand mcmd)
	| glaction(LCommand xcmd)
	;

// WIP: GrammarLab actions
data LCommand
	= diff(GGrammar g)
	| merge(GGrammar g)
	| include(loc z)
	| maybexbgf(XCommand tcmd)
	;

// WIP: mutations
data MCommand
	= liftTopLabels()
	| deyaccifyAll()
	;
