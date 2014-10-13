@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::EBNF

alias EBNF = map[Metasymbol,str];
//alias WNF = set[Metasymbol];

alias WNF = set[Metaconcept];

data Metaconcept
	// zero-arity metaconcepts
	= mc_universal()
	| mc_emptystring()
	| mc_emptylanguage()
	| mc_string()
	| mc_number()
	| mc_boolean()
	// unary metaconcepts
	| mc_optionality()
	| mc_star()
	| mc_plus()
	| mc_group()
	// binary metaconcepts
	| mc_sep_star()
	| mc_sep_plus()
	// multiary metaconcepts
	| mc_disjunction()
	| mc_conjunction()
	| mc_concatenation()
	;

data Metasymbol
	= start_grammar_symbol()
	| end_grammar_symbol()
	| epsilon_metasymbol()
	| empty_metasymbol()
	| universal_metasymbol()
	| line_continuation_symbol()
	| tabulation_symbol()
	| start_label_symbol()
	| end_label_symbol()
	| start_mark_symbol()
	| end_mark_symbol()
	| defining_symbol()
	| multiple_defining_symbol()
	| terminator_symbol()
	| definition_separator_symbol()
	| concatenate_symbol()
	| start_comment_symbol()
	| end_comment_symbol()
	| start_group_symbol()
	| end_group_symbol()
	| start_option_symbol()
	| end_option_symbol()
	| start_terminal_symbol()
	| end_terminal_symbol()
	| start_nonterminal_symbol()
	| end_nonterminal_symbol()
	| start_seplist_star_symbol()
	| end_seplist_star_symbol()
	| start_seplist_plus_symbol()
	| end_seplist_plus_symbol()
	| start_repetition_star_symbol()
	| end_repetition_star_symbol()
	| start_repetition_plus_symbol()
	| end_repetition_plus_symbol()
	| postfix_option_symbol()
	| prefix_option_symbol()
	| postfix_repetition_star_symbol()
	| postfix_repetition_plus_symbol()
	| nonterminals_may_start_with()
	| nonterminals_may_contain()
	| nonterminal_if_contains()
	//| terminal_if_undefined::(except()*)
	//| nonterminal_if_defined::(except()*)
	//| decompose_symbols::(except()*)
	| terminal_if_uppercase()
	| terminal_if_lowercase()
	| terminal_if_mixedcase()
	| terminal_if_camelcase()
	| nonterminal_if_uppercase()
	| nonterminal_if_lowercase()
	| nonterminal_if_mixedcase()
	| nonterminal_if_camelcase()
	| glue_nonalphanumeric_terminals()
	| break_tokens_at_whitespace()
	| disregard_labels()
	| consider_indentation()
	| disjunction_symbol()
	// Boolean grammars arsenal
	| conjunction_symbol()
	| exception_symbol()
	| prefix_negation_symbol()
	| postfix_negation_symbol()
	| ignore_tokens()
;

public str getMeta(Metasymbol ms, EBNF ebnf) = ms in ebnf ? ebnf[ms] : "";
public str getMetaE(Metasymbol ms, EBNF ebnf) = ms in ebnf ? ebnf[ms] : "ERROR<ms>!";

public bool isEBNFinWNF(EBNF e, WNF w) = domain(e) <= w;
public bool isWNFinEBNF(WNF w, EBNF e) = w <= domain(e);
