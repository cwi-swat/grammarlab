@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::glue::concrete::Rename

import grammarlab::language::glue::concrete::BGF;
import grammarlab::language::glue::concrete::Scope;

lexical GlueKrename = @category="MetaVariable" "rename";

keyword GlueKw = GlueKrename;

syntax GlueCommand
	= GlueKrename GlueNonterminal n1 GlueKwTo GlueNonterminal n2 GlueScope w "."
	| GlueKrename GlueMarkR m1 GlueKwTo GlueMarkR m2 GlueScope w "."
	| GlueKrename GlueLabelR l1 GlueKwTo GlueLabelR l2 GlueScope w "."
	| GlueKrename GlueTerminal t1 GlueKwTo GlueTerminal GlueScope w "."
	;
lexical GlueMarkR = "\<" GlueMark name "\>";
lexical GlueLabelR = "[" GlueLabel name "]";
