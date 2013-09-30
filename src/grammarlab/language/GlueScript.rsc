@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::GlueScript

// These shoes are made for modularised parsing, that’s just what they’ll do
import grammarlab::language::glue::Transformations;
import grammarlab::language::glue::Mutations;
import grammarlab::language::glue::Actions;
import grammarlab::language::glue::Productions;
import grammarlab::language::glue::Scope;
// These shoes are made for implosion, that’s just what they’ll do
import grammarlab::language::glue::Abstract;
import grammarlab::language::glue::MapXBGF2A;
import grammarlab::language::glue::MapSLEIR2A;
import grammarlab::language::glue::MapGLA2A;
// These shoes are made for IDE support, that’s just what they’ll do
import util::IDE;
import grammarlab::language::glue::Colours;
// These shoes are made for execution, that’s just what they’ll do
import grammarlab::language::X;

import String;
import IO;

import ParseTree;
import vis::Figure;
import vis::ParseTree;
import vis::Render;

start syntax GLUEC = GlueCommand+;

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
