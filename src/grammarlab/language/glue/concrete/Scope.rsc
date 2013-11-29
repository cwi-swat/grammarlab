@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::glue::concrete::Scope

import grammarlab::language::glue::concrete::BGF;

syntax GlueScope
	= GlueKwIn GlueWhere
	| @category="MetaVariable" "everywhere"
	| @category="MetaVariable" "globally"
	| @category="MetaVariable" "nowhere"
	;
lexical GlueKwIn
	= @category="MetaVariable" "in"
	| @category="MetaVariable" "notin"
	;
keyword GlueKw = GlueKwIn;

syntax GlueWhere
	= GlueNonterminal
	| "[" GlueLabel "]"
	| "\<" GlueMark "\>"
 	;
