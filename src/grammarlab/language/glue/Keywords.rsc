@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::glue::Keywords

lexical GlueKwImport = @category="MetaVariable" "import";
lexical GlueKwAbridge = @category="MetaVariable" "abridge";
lexical GlueKwDiff = @category="MetaVariable" "diff";

keyword GlueKw = GlueKwImport | GlueKwAbridge | GlueKwDiff;