@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::glue::implode::Top

import grammarlab::language::glue::implode::XBGF;
import grammarlab::language::glue::implode::Scope;
import grammarlab::language::glue::implode::SLEIR;
import grammarlab::language::glue::implode::GET;
import grammarlab::language::glue::implode::Actions;
import grammarlab::language::glue::implode::Rename;

import grammarlab::language::glue::abstract::Top;

import grammarlab::language::glue::concrete::Top;
import grammarlab::language::glue::concrete::BGF;
import grammarlab::language::glue::concrete::XBGF;
import grammarlab::language::glue::concrete::Scope;
import grammarlab::language::glue::concrete::SLEIR;
import grammarlab::language::glue::concrete::GET;
import grammarlab::language::glue::concrete::Actions;
import grammarlab::language::glue::concrete::Rename;

import IO;

public GLUE glimplode(start[GLUEC] raw) = [glimplode(c) | GlueCommand c <- raw.top.cs];
public GLUE glimplode(GLUEC raw) = [glimplode(c) | GlueCommand c <- raw.cs];

public default GLUE glimplode(GlueCommand c)
{
	println("Uncovered command: <c>");
}
