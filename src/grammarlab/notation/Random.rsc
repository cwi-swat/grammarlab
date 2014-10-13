@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module grammarlab::notation::Random

import grammarlab::notation::Operations;
import grammarlab::language::Grammar;
import grammarlab::language::EBNF;
import Set; // randomness

set[set[Metasymbol]] metaelements
	= {
		{ epsilon_metasymbol() },
		{ empty_metasymbol() },
		{ universal_metasymbol() },
		{ start_label_symbol(), end_label_symbol() },
		{ start_mark_symbol(), end_mark_symbol() },
		{ defining_symbol(), terminator_symbol() },
		{ multiple_defining_symbol() },
		{ definition_separator_symbol() },
		{ concatenate_symbol() },
		{ start_group_symbol(), end_group_symbol() },
		{ start_option_symbol(), end_option_symbol() },
		{ start_terminal_symbol(), end_terminal_symbol() },
		{ start_nonterminal_symbol(), end_nonterminal_symbol() },
		{ start_seplist_star_symbol(), end_seplist_star_symbol() },
		{ start_seplist_plus_symbol(), end_seplist_plus_symbol() },
		{ start_repetition_star_symbol(), end_repetition_star_symbol() },
		{ start_repetition_plus_symbol(), end_repetition_plus_symbol() },
		{ postfix_option_symbol() },
		{ prefix_option_symbol() },
		{ postfix_repetition_star_symbol() },
		{ postfix_repetition_plus_symbol() },
		{ nonterminals_may_start_with() },
	//| nonterminals_may_contain()
	//| nonterminal_if_contains()
	//| terminal_if_uppercase()
	//| terminal_if_lowercase()
	//| terminal_if_mixedcase()
	//| terminal_if_camelcase()
		{ disjunction_symbol() },
		{ conjunction_symbol() },
		{ exception_symbol() },
		{ prefix_negation_symbol() },
		{ postfix_negation_symbol() }
	};

public WNF randomWNF()
{
	int m = getOneFrom({1,2,3,4});
	WNF n = {*getOneFrom(metaelements) | i <- [0..m]};
	return n;
}

public EBNF randomEBNF() = fromDefault(randomWNF());
