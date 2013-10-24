@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
// MOCKUP: SHOULD BE GENERATED? 
module grammarlab::language::glue::Actions

import grammarlab::language::glue::Productions;

lexical GlueKdiff = @category="MetaKeyword" "diff";
lexical GlueKinclude = @category="MetaKeyword" "include";
lexical GlueKmaybexbgf = @category="MetaKeyword" "maybe";

keyword GlueKw = GlueKdiff;

syntax GlueCommand
	= GlueKdiff GlueProduction+ "."
	| GlueKinclude GlueLoc "."
	| GlueKmaybexbgf GlueCommand // plain recursion covers more than we want!
	;

lexical GlueLoc = [|] ![|]+ [|];
