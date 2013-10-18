@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::lib::ebnf::Rascal

import grammarlab::language::EBNF;

public EBNF RascalEBNF = (
	epsilon_metasymbol(): "ε",
	empty_metasymbol(): "φ",
	universal_metasymbol(): "α",
	start_label_symbol(): "",
	end_label_symbol(): ": ",
	// start_mark_symbol(): "\<",
	// end_mark_symbol(): "\>:",
	defining_symbol(): "\n\t= ",
	terminator_symbol(): " ;\n",
	definition_separator_symbol(): "\n\t| ",
	disjunction_symbol(): " | ",
	concatenate_symbol(): " ",
	start_comment_symbol(): "//",
	end_comment_symbol(): "\n",
	start_group_symbol(): "(",
	end_group_symbol(): ")",
	start_terminal_symbol(): "\"",
	end_terminal_symbol(): "\"",
	start_seplist_star_symbol(): "{",
	end_seplist_star_symbol(): "}*",
	start_seplist_plus_symbol(): "{",
	end_seplist_plus_symbol(): "}+",
	postfix_option_symbol(): "?",
	postfix_repetition_star_symbol(): "*",
	postfix_repetition_plus_symbol(): "+",
	conjunction_symbol(): " & ",
	exception_symbol(): " &! ",
	prefix_negation_symbol(): "¬"
);
