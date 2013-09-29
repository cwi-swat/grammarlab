@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::GlueScript

extend grammarlab::language::glue::Transformations;
extend grammarlab::language::glue::Productions;
extend grammarlab::language::glue::Scope;
extend grammarlab::language::glue::Abstract;
import grammarlab::language::glue::Colours;
import grammarlab::language::glue::MapC2A;
import grammarlab::language::X;
import util::IDE;
import String;
import IO;

import ParseTree;
import vis::Figure;
import vis::ParseTree;
import vis::Render;


start syntax GLUEC = GlueCommand+;
syntax GlueCommand
	= GlueKdiff GlueProduction+ "."
	;
lexical GlueKdiff = @category="MetaKeyword" "diff";

Tree getGlue(str s,loc z) = parse(#GLUEC,trim(readFile(z)));
public void register()
{
	registerLanguage("GLUE","glue",getGlue);
	registerContributions("GLUE",getGLColours());
}

public void go()
{
	clearLanguages();
	clearNonRascalContributions();
	Tree t = char(0);
	try
		t = getGlue("",|project://grammarlab/src/tests/transform/XBGF.glue|);
	catch ParseError:
		println("Ungrammatical!");
	//renderParsetree(t);
	//render(space(visParsetree(t),std(gap(10,15)),std(resizable(true))));
	if (/amb(_) := t)
		println("Ambiguous!");
	else
		register();
}
