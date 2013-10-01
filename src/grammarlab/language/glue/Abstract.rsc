@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::glue::Abstract

import grammarlab::language::X;

alias GLUE = list[GLUEA];

data GLUEA
	= xbgf(XCommand cmd)
	| sleir() // WIP: mutations
	| glaction() // WIP: GrammarLab actions
	;
