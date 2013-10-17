@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::lib::ebnf::Pico

import grammarlab::language::EBNF;

public EBNF PicoEBNF = (
	defining_symbol(): " ::= ",
	start_option_symbol(): "[",
	end_option_symbol(): "]",
	definition_separator_symbol(): " | ",
	disjunction_symbol(): " | ",
	start_repetition_star_symbol(): "{",
	end_repetition_star_symbol(): "}",
	start_group_symbol(): "(",
	end_group_symbol(): ")",
	ignore_tokens(): "`"
);
