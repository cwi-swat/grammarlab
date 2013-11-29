@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::glue::implode::Rename

import grammarlab::language::glue::concrete::BGF;
import grammarlab::language::glue::concrete::XBGF;
import grammarlab::language::glue::concrete::Scope;
import grammarlab::language::glue::concrete::Rename;
import grammarlab::language::glue::abstract::Top;
import grammarlab::language::glue::implode::Scope;
import grammarlab::language::X;

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
