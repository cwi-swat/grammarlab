@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
// MOCKUP: SHOULD BE GENERATED? 
module grammarlab::language::glue::MapGLA2A

import grammarlab::language::glue::Abstract;
import grammarlab::language::glue::Actions;
import grammarlab::language::glue::Productions;
// A lot of things are needed to transform grammars :~-(
import grammarlab::language::Grammar;
import grammarlab::language::X;
import grammarlab::transform::XBGF;

GLUEA glimplode((GlueCommand)`<GlueKdiff _><GlueProduction+ ps>.`) = glaction(diff(transform(importG(mapPs(ps)),EmptyGrammar).g));
