@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
// MOCKUP: SHOULD BE GENERATED? 
module grammarlab::language::glue::Actions

import grammarlab::language::glue::Productions;

lexical GlueKdiff = @category="MetaKeyword" "diff";

keyword GlueKw = GlueKdiff;

syntax GlueCommand
	= GlueKdiff GlueProduction+ "."
	;

