@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
// MOCKUP: WILL BE GENERATED
module grammarlab::language::glue::Mutations

//import grammarlab::language::glue::Productions;

lexical GlueKDeYaccifyAll = @category="MetaAmbiguity" "DeYaccifyAll";
lexical GlueKLiftTopLabels = @category="MetaAmbiguity" "LiftTopLabels";

keyword GlueKw = GlueKDeYaccifyAll;

syntax GlueCommand
	= GlueKDeYaccifyAll "."
	= GlueKLiftTopLabels "."
	;

