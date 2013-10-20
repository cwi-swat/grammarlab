@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
// GLUE = Grammar Lab Unified Entity
module grammarlab::language::GlueScript

// These shoes are made for modularised parsing, that’s just what they’ll do
import grammarlab::language::glue::Transformations;
import grammarlab::language::glue::Mutations;
import grammarlab::language::glue::Actions;
import grammarlab::language::glue::Productions;
import grammarlab::language::glue::Scope;
import grammarlab::language::glue::Concrete;
// These shoes are made for implosion, that’s just what they’ll do
import grammarlab::language::glue::Abstract;
import grammarlab::language::glue::MapXBGF2A;
import grammarlab::language::glue::MapSLEIR2A;
import grammarlab::language::glue::MapGLA2A;
import grammarlab::language::glue::Mapper;
// These shoes are made for IDE support, that’s just what they’ll do
import util::IDE;
import grammarlab::language::glue::Colours;
import grammarlab::export::Grammar;
// These shoes are made for execution, that’s just what they’ll do
// import grammarlab::language::X;
import grammarlab::language::Grammar;
import grammarlab::language::glue::Interpreter;
import grammarlab::transform::Normal;

import ParseTree;
import String;
import IO;

public void go()
{
	clearLanguages();
	clearNonRascalContributions();
	Tree t = char(0);
	try
		t = getGlue(|project://grammarlab/src/tests/transform/XBGF.glue|);
	catch ParseError:
		println("Ungrammatical!");
	if (/amb(_) := t)
		println("Ambiguous!");
	else
		regGlue();
}

public void tr()
{
	t = getGlue(|project://grammarlab/src/tests/transform/XBGF.glue|);
	d = glimplode(t);
	// iprintln(d);
	GGrammar g = EmptyGrammar;
	for (GLUEA step <- d)
		g = execute(g,step);
	println(ppx(g));
}
