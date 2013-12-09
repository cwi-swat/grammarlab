@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
// GLUE = Grammar Lab Unified Entity
module grammarlab::language::GLUE

// These shoes are made for modularised parsing, that’s just what they’ll do
import grammarlab::language::glue::concrete::Top;
import grammarlab::language::glue::concrete::BGF;
import grammarlab::language::glue::concrete::XBGF;
import grammarlab::language::glue::concrete::Scope;
import grammarlab::language::glue::concrete::SLEIR;
import grammarlab::language::glue::concrete::Actions;
import grammarlab::language::glue::concrete::Rename;
// These shoes are made for implosion, that’s just what they’ll do
import grammarlab::language::glue::abstract::Top;
import grammarlab::language::glue::implode::XBGF;
import grammarlab::language::glue::implode::SLEIR;
import grammarlab::language::glue::implode::Actions;
import grammarlab::language::glue::implode::Top;
// These shoes are made for IDE support, that’s just what they’ll do
import util::IDE;
import grammarlab::language::glue::concrete::Colours;
import grammarlab::export::Grammar;
// These shoes are made for execution, that’s just what they’ll do
// import grammarlab::language::X;
import grammarlab::language::Grammar;
import grammarlab::language::glue::Interpreter;
import grammarlab::transform::Normal;

import ParseTree;
import String;
import IO;

public void startGlue()
{
	//regGlue();
	registerLanguage("GLUE","glue",grammarlab::language::glue::concrete::Top::getGlue);
	registerContributions("GLUE",
		grammarlab::language::glue::concrete::Colours::getGLColours()+
		{popup(menu("GrammarLab",[edit("execute!", execcmd)]))}
	);
}

public str execcmd(GLUEC g, loc z)
{execute(glimplode(g));return "";}


public void go()
{
	clearLanguages();
	clearNonRascalContributions();
	Tree t = char(0);
	try
		t = getGlue(|project://grammarlab/src/test/set/xbgf/massage_distr_ch.glue|);
	catch ParseError:
		println("Ungrammatical!");
	if (/amb(_) := t)
		println("Ambiguous!");
	else
		regGlue();
}

public void tr()
{
	t = getGlue(|project://grammarlab/src/tests/transform/set/renameL.glue|);
	d = glimplode(t);
	iprintln(d);
	//GGrammar g = EmptyGrammar;
	//for (GLUEA step <- d)
	//	g = execute(g,step);
	//println(ppx(g));
}
