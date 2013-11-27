@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
// MOCKUP: SHOULD BE GENERATED? 
module grammarlab::language::glue::Actions

import grammarlab::language::glue::Productions;

lexical GlueKdiff = @category="MetaKeyword" "diff";
lexical GlueKmerge = @category="MetaKeyword" "merge";
lexical GlueKinclude = @category="MetaKeyword" "include";
lexical GlueKmaybexbgf = @category="MetaKeyword" "maybe";

keyword GlueKw = GlueKdiff | GlueKmerge | GlueKinclude | GlueKmaybexbgf;

syntax GlueCommand
	= GlueKdiff GlueProduction+ "."
	| GlueKmerge GlueProduction+ "."
	| GlueKinclude GlueLoc "."
	| GlueKmaybexbgf GlueCommand // plain recursion covers more than we want!
	;

lexical GlueLoc = [|] ![|]+ [|];
lexical GlueWord = [a-zA-Z]+;

lexical GlueKextract = @category="MetaKeyword" "extract";

keyword GlueKw = GlueKextract;
syntax GlueCommand = GlueKextract GlueWord GlueLoc;
