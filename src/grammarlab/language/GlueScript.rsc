@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::GlueScript

import grammarlab::language::glue::Colours;
import grammarlab::language::glue::Productions;
import util::IDE;
import String;
import IO;

import ParseTree;
import vis::Figure;
import vis::ParseTree;
import vis::Render;

start syntax GLUE = GlueCommand+;
syntax GlueCommand
	= @Category="GlueCommand" "import"
	 GlueProduction+
	"."
	// WIP
	;

Tree getGlue(str s,loc z) = parse(#GLUE,trim(readFile(z)));
public void register()
{
	registerLanguage("GLUE","glue",getGlue);
	registerContributions("GLUE",getGLColours());
}

public void go()
{
	clearLanguages();
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
