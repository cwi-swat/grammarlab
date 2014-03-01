@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
// GLUE = Grammar Lab Unified Entity
module grammarlab::language::GLUE

// These shoes are made for language definition, that’s just what they’ll do
import grammarlab::language::glue::concrete::Top;
import grammarlab::language::glue::abstract::Top;
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
import vis::ParseTree;
import String;
import IO;

// troubleshooting
import Ambiguity;

public void startGlue()
{
	//regGlue();
	registerLanguage("GLUE","glue",grammarlab::language::glue::concrete::Top::getGlue);
	registerContributions("GLUE",
		grammarlab::language::glue::concrete::Colours::getGLColours()+
		{popup(menu("GrammarLab",[edit("Run", execcmd),edit("Visualise", viscmd)]))}
	);
}

public str execcmd(GLUEC g, loc z){execute(glimplode(g));return "";}
public str viscmd(GLUEC g, loc z){visGlue(z);return "";}


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
	//t = getGlue(|project://grammarlab/src/tests/transform/set/renameL.glue|);
	t = getGlue(|project://grammarlab/src/test/annotation.glue|);
	renderParsetree(t);
	if (/amb(_) := t) iprintln(diagnose(t));
	d = glimplode(t);
	iprintln(d);
}
