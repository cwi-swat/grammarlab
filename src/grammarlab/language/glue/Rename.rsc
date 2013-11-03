@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::glue::Rename

import grammarlab::language::glue::Productions;
import grammarlab::language::glue::Transformations;
import grammarlab::language::glue::Abstract;
import grammarlab::language::glue::Scope;
import grammarlab::language::X;

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

// TODO: implement scope for renameN
GLUEA glimplode((GlueCommand)`<GlueKrename _> <GlueNonterminal n1> <GlueKwTo _> <GlueNonterminal n2> <GlueScope w> .`)
	= xbgf(renameN("<n1.name>","<n2.name>"));
// TODO: implement scope for renameT
GLUEA glimplode((GlueCommand)`<GlueKrename _> <GlueTerminal t1> <GlueKwTo _> <GlueTerminal t2> <GlueScope w> .`)
	= xbgf(renameT("<t1.name>","<t2.name>"));
GLUEA glimplode((GlueCommand)`<GlueKrename _> <GlueMarkR m1> <GlueKwTo _> <GlueMarkR m2> <GlueScope w> .`)
	= xbgf(renameS("<m1.name>","<m2.name>",mapScope(w)));
// TODO: implement scope for renameL
GLUEA glimplode((GlueCommand)`<GlueKrename _> <GlueLabelR l1> <GlueKwTo _> <GlueLabelR l2> <GlueScope w> .`)
	= xbgf(renameL("<l1.name>","<l2.name>"));
