@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module grammarlab::notation::Detection

import grammarlab::notation::Operations;
import grammarlab::language::Grammar;
import grammarlab::language::EBNF;
import String; // stringChars, charAt
import List; // intercalate
import Set; // isEmpty
import IO;

// Somewhat ugly, but who cares
bool findInnerChoices(GGrammar g)
{
	for (/c:choice(_) := g.P)
		if (/production(_,c) !:= g.P)
			return true;
	return false;
}

public EBNF detectE(GGrammar g)
{
	EBNF c = (() | it + fromDefault(m) | m <- detect(g));
	// Somewhat more complex than just one pattern match: what characters can nonterminal names start with?
	if (/nonterminal(_) := g.P)
	{
		set[str] nts = {n[0] | /nonterminal(n) := g.P};
		set[str] lcs = {stringChars([i]) | i <- [97..123]}; // [a-z]
		set[str] ucs = {stringChars([i]) | i <- [65..91]}; // [A-Z]
		if (!isEmpty(nts & lcs)) nts += lcs; // the "if some, then all" heuristic
		if (!isEmpty(nts & ucs)) nts += ucs; // the "if some, then all" heuristic
		c += (nonterminals_may_start_with() : intercalate("",sort(nts))); 
		// What characters can nonterminal names contain in general?
		nts = {stringChars([charAt(n,cx)]) | /nonterminal(n) := g.P, cx <- [0..size(n)]};
		if (!isEmpty(nts & lcs)) nts += lcs; // the "if some, then all" heuristic
		if (!isEmpty(nts & ucs)) nts += ucs; // the "if some, then all" heuristic
		c += (nonterminals_may_contain() : intercalate("",sort(nts))); 
		// nonterminal_if_contains()
	}
	return c;
}

// NB: this detection favours start_... and end_... metasymbols to their postfix counterparts
// to avoid issues with group detection
public WNF detect(GGrammar g)
{
	WNF c = {};
	// start_grammar_symbol()
	// end_grammar_symbol()
	if (/epsilon() := g.P) c += epsilon_metasymbol();
	if (/empty() := g.P) c += empty_metasymbol();
	if (/anything() := g.P) c += universal_metasymbol();
	// line_continuation_symbol()
	// tabulation_symbol()
	if (/label(_,_) := g.P) c += {start_label_symbol(), end_label_symbol()};
	if (/mark(_,_) := g.P) c += {start_mark_symbol(), end_mark_symbol()};
	// multiple_defining_symbol()
	if (g.P != []) c += {defining_symbol(), terminator_symbol()};
	if (/production(_,choice(_)) := g.P) c += definition_separator_symbol();
	if (/sequence(_) := g.P) c += concatenate_symbol();
	// start_comment_symbol()
	// end_comment_symbol()
	if (/label(_,sequence(_)) := g.P
	|| /mark(_,sequence(_)) := g.P
	|| /choice([*_,sequence(_),*_]) := g.P
	|| /allof([*_,sequence(_),*_]) := g.P
	|| /not(sequence(_)) := g.P
	|| /except(_,sequence(_)) := g.P
	|| /except(sequence(_),_) := g.P
	|| /optional(sequence(_)) := g.P
	|| /star(sequence(_)) := g.P
	|| /plus(sequence(_)) := g.P
	|| /sepliststar(_,sequence(_)) := g.P
	|| /sepliststar(sequence(_),_) := g.P
	|| /seplistplus(_,sequence(_)) := g.P
	|| /seplistplus(sequence(_),_) := g.P
	) c += {start_group_symbol(), end_group_symbol()};
	if (/optional(_) := g.P) c += {start_option_symbol(), end_option_symbol()};
	if (/terminal(_) := g.P) c += {start_terminal_symbol(), end_terminal_symbol()};
	if (/nonterminal(_) := g.P) c += {start_nonterminal_symbol(), end_nonterminal_symbol()};
	if (/sepliststar(_,_) := g.P) c += {start_seplist_star_symbol(), end_seplist_star_symbol()};
	if (/seplistplus(_,_) := g.P) c += {start_seplist_plus_symbol(), end_seplist_plus_symbol()};
	if (/star(_) := g.P) c += {start_repetition_star_symbol(), end_repetition_star_symbol()};
	if (/plus(_) := g.P) c += {start_repetition_plus_symbol(), end_repetition_plus_symbol()};
	// postfix_option_symbol()
	// postfix_repetition_star_symbol()
	// postfix_repetition_plus_symbol()
	// nonterminals_may_start_with() - treated in detectE
	// nonterminal_if_contains() - treated in detectE
	// terminal_if_uppercase()
	// terminal_if_lowercase()
	// terminal_if_mixedcase()
	// terminal_if_camelcase()
	// nonterminal_if_uppercase()
	// nonterminal_if_lowercase()
	// nonterminal_if_mixedcase()
	// nonterminal_if_camelcase()
	// glue_nonalphanumeric_terminals()
	// break_tokens_at_whitespace()
	// disregard_labels()
	// consider_indentation()
	if (findInnerChoices(g)) c += disjunction_symbol();
	if (/allof(_) := g.P) c += conjunction_symbol();
	if (/except(_,_) := g.P) c += exception_symbol();
	if (/not(_) := g.P) c += prefix_negation_symbol();
	// postfix_negation_symbol()
	// ignore_tokens()
	return c;
}

void main()
{
	iprintln(detect(grammar([],[],[])));
	iprintln(detect(grammar([],[production("foo",epsilon())],[])));
	iprintln(detect(grammar([],[production("foo",nonterminal("bar"))],[])));
	iprintln(detect(grammar([],[production("foo",choice([nonterminal("bar"),sequence([terminal("a"),terminal("b")])]))],[])));
}