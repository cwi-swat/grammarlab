@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
// MOCKUP: SHOULD BE GENERATED? 
module grammarlab::language::glue::concrete::Actions

import grammarlab::language::glue::concrete::BGF;
import grammarlab::language::glue::concrete::GET;
//import lang::json::\syntax::JSON;
import grammarlab::language::json::Implode;

lexical GlueKdiff = @category="MetaKeyword" "diff";
lexical GlueKmerge = @category="MetaKeyword" "merge";
lexical GlueKinclude = @category="MetaKeyword" "include";
lexical GlueKextract = @category="MetaKeyword" "extract";
lexical GlueKgreedy = @category="MetaKeyword" "greedy";
lexical GlueKexport = @category="MetaKeyword" "export";
lexical GlueKmaybexbgf = @category="MetaKeyword" "maybe";
lexical GlueKannotate = @category="MetaKeyword" "annotate";

keyword GlueKw = GlueKdiff | GlueKmerge | GlueKinclude | GlueKextract | GlueKgreedy | GlueKexport | GlueKmaybexbgf | GlueKannotate;

syntax GlueCommand
	= GlueKdiff GlueProduction+ "."
	| GlueKmerge GlueProduction+ "."
	| GlueKinclude GlueLoc "."
	| GlueKextract GlueKSource GlueLoc "."
	| GlueKexport GlueKSource GlueLoc "."
	| GlueKmaybexbgf GlueCommand // plain recursion covers more than we want!
	| GlueKannotate JSONText "."
	| GlueKgreedy "{" GlueCommand+ "}" "."
	;

lexical GlueLoc = "|" GlueNotBar "|";
lexical GlueNotBar =  ![|]+ >> [|];
//[a-zA-Z!@#$%^&*()\[\]{}\-_+=:;\"\'\\`~,.\<\>?/01-9§±]
//lexical GlueNotBar = [a-zA-Z01-9:/.\-]+ !>> [a-zA-Z01-9:/.\-];
//lexical GlueNotBar = ![|]+;
lexical GlueWord = [a-zA-Z]+;
