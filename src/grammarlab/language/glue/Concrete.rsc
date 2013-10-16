@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::glue::Concrete

// These shoes are made for modularised parsing, that’s just what they’ll do
import grammarlab::language::glue::Transformations;
import grammarlab::language::glue::Mutations;
import grammarlab::language::glue::Actions;
import grammarlab::language::glue::Productions;
import grammarlab::language::glue::Scope;

// These shoes are made for IDE support, that’s just what they’ll do
import util::IDE;
import grammarlab::language::glue::Colours;

import String;
import IO;

import ParseTree;
import vis::Figure;
import vis::ParseTree;
import vis::Render;

start syntax GLUEC = GlueCommand+ cs;

public Tree getGlue(loc z) = parse(#start[GLUEC],z);
public Tree getGlue(str s) = parse(#start[GLUEC],s);

Tree getGlue(str _, loc z) = getGlue(z);

public void regGlue()
{
	registerLanguage("GLUE","glue",getGlue);
	registerContributions("GLUE",getGLColours());
}

public void visGlue(loc z) = render(space(visParsetree(getGlue(z)),std(gap(10,15)),std(resizable(true))));