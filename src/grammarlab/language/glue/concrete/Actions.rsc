@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
// MOCKUP: SHOULD BE GENERATED? 
module grammarlab::language::glue::concrete::Actions

import grammarlab::language::glue::concrete::BGF;
import grammarlab::language::glue::concrete::GET;

lexical GlueKdiff = @category="MetaKeyword" "diff";
lexical GlueKmerge = @category="MetaKeyword" "merge";
lexical GlueKinclude = @category="MetaKeyword" "include";
lexical GlueKextract = @category="MetaKeyword" "extract";
lexical GlueKmaybexbgf = @category="MetaKeyword" "maybe";

keyword GlueKw = GlueKdiff | GlueKmerge | GlueKinclude | GlueKmaybexbgf;

syntax GlueCommand
	= GlueKdiff GlueProduction+ "."
	| GlueKmerge GlueProduction+ "."
	| GlueKinclude GlueLoc "."
	| GlueKextract GlueKSource GlueLoc "."
	| GlueKmaybexbgf GlueCommand // plain recursion covers more than we want!
	;

lexical GlueLoc = [|] ![|]+ [|];
lexical GlueWord = [a-zA-Z]+;
