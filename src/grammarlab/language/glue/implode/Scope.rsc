@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::glue::implode::Scope

import grammarlab::language::glue::concrete::BGF;
import grammarlab::language::glue::concrete::Scope;
import grammarlab::language::XScope;

XScope mapScope((GlueScope)`everywhere`) = globally();
XScope mapScope((GlueScope)`globally`) = globally();
XScope mapScope((GlueScope)`nowhere`) = nowhere();
XScope mapScope((GlueScope)`in <GlueNonterminal name>`) = innt("<name>");
XScope mapScope((GlueScope)`notin <GlueNonterminal name>`) = notinnt("<name>");
XScope mapScope((GlueScope)`in [<GlueLabel name>]`) = inlabel("<name>");
XScope mapScope((GlueScope)`notin [<GlueLabel name>]`) = notinlabel("<name>");
XScope mapScope((GlueScope)`in \<<GlueMark name>\>`) = inmark("<name>");
XScope mapScope((GlueScope)`notin \<<GlueMark name>\>`) = notinmark("<name>");
default XScope mapScope(GlueScope _) = globally();
// TODO or not TODO:comboscope(XScope w1, XScope w2)
