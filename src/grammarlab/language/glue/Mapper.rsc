@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::glue::Mapper

import grammarlab::language::glue::MapXBGF2A;
import grammarlab::language::glue::MapSLEIR2A;
import grammarlab::language::glue::MapGLA2A;

import grammarlab::language::glue::Abstract;

import grammarlab::language::glue::Concrete;
import grammarlab::language::glue::Transformations;
import grammarlab::language::glue::Mutations;
import grammarlab::language::glue::Actions;
import grammarlab::language::glue::Productions;
import grammarlab::language::glue::Scope;
import grammarlab::language::glue::Rename;

import IO;

public GLUE glimplode(start[GLUEC] raw) = [glimplode(c) | GlueCommand c <- raw.top.cs];

public default GLUE glimplode(GlueCommand c)
{
	println("Uncovered command: <c>");
}
