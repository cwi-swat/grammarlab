@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::glue::implode::Top

import grammarlab::language::glue::concrete::Top;
import grammarlab::language::glue::abstract::Top;

import grammarlab::language::glue::implode::XBGF;
import grammarlab::language::glue::implode::Scope;
import grammarlab::language::glue::implode::SLEIR;
import grammarlab::language::glue::implode::GET;
import grammarlab::language::glue::implode::Actions;
import grammarlab::language::glue::implode::Rename;

import IO;
import ParseTree;
import vis::ParseTree;

public GLUE glimplode(start[GLUEC] raw) = [glimplode(c) | GlueCommand c <- raw.top.cs];
public GLUE glimplode(GLUEC raw) = [glimplode(c) | GlueCommand c <- raw.cs];

public GLUEA glimplode((GlueCommand)`<GlueKgreedy _>{<GlueCommand+ cmds>}.`)
	= greedy([glimplode(c) | GlueCommand c <- cmds]);

public default GLUE glimplode(GlueCommand c)
{
	println("Uncovered command: <c>");
	renderParsetree(c);
	return [];
}
