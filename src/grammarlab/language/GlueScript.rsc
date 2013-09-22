module grammarlab::language::GlueScript

import util::IDE;

extend grammarlab::language::GlueGrammar;

start syntax GLUE = GlueCommand+;
syntax GlueCommand
	= @category="Keyword" "import" GlueGrammarProduction+ "."
	// WIP
	;

Tree getGlue(str s,loc z) = parse(#GLUE,trim(readFile(z)));
public void register() = registerLanguage("GLUE","glue",getGlue);
