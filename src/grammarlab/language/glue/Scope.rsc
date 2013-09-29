@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::glue::Scope

import grammarlab::language::glue::Productions;
import grammarlab::language::XScope;

syntax GlueScope
	= GlueKwIn GlueWhere
	| @category="MetaVariable" "globally"
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

XScope mapScope((GlueScope)`globally`) = globally();
XScope mapScope((GlueScope)`in <GlueNonterminal name>`) = innt("<name>");
XScope mapScope((GlueScope)`notin <GlueNonterminal name>`) = notinnt("<name>");
XScope mapScope((GlueScope)`in [<GlueLabel name>]`) = inlabel("<name>");
XScope mapScope((GlueScope)`notin [<GlueLabel name>]`) = notinlabel("<name>");
XScope mapScope((GlueScope)`in \<<GlueMark name>\>`) = inmark("<name>");
XScope mapScope((GlueScope)`notin \<<GlueMark name>\>`) = notinmark("<name>");
default XScope mapScope(GlueScope _) = globally();
// TODO or not TODO:comboscope(XScope w1, XScope w2)
