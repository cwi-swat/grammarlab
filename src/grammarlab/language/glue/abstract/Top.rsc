@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::glue::abstract::Top

import grammarlab::language::Grammar;
import grammarlab::language::X;
import grammarlab::language::SLEIR;
import grammarlab::language::GET;
import lang::json::ast::JSON;

alias GLUE = list[GLUEA];
alias MetaInfo = map[str,Value];

data GLUEA
	= xbgf(XCommand tcmd)
	| sleir(MCommand mcmd)
	| glaction(LCommand xcmd)
	| metadata(MetaInfo meta)
	;

// WIP: GrammarLab actions
data LCommand
	= diff(GGrammar g)
	| merge(GGrammar g)
	| include(loc z)
	| maybexbgf(XCommand tcmd)
	| extract(GExternalType src, loc where)
	| export(GExternalType src, loc where, str name)
	;

// Reference from lang::json::ast::JSON
//data Value
//	= null() 
//	| object(map[str memberName, Value memberValue] members) 
//	| array(list[Value] values) 
//	| integer(int n)
//	| float(real r)
//	| string(str s) 
//	| boolean(bool b)
//	;