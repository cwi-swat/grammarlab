@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module grammarlab::notation::Detection

import grammarlab::language::Grammar;
import grammarlab::language::EBNF;
import grammarlab::lib::ebnf::Default;
import String; // stringChars, charAt
import List; // intercalate
import Set; // isEmpty
import IO;

EBNF fromDefault(Metasymbol m) = (m : (m in DefaultEBNF) ? DefaultEBNF[m] : "");
EBNF fromDefault(Metasymbol m1, Metasymbol m2) = fromDefault(m1) + fromDefault(m2);

// Somewhat ugly, but who cares
bool findInnerChoices(GGrammar g)
{
	for (/c:choice(_) := g.P)
		if (/production(_,c) !:= g.P)
			return true;
	return false;
}

// NB: this detection favours start_... and end_... metasymbols to their postfix counterparts
// to avoid issues with group detection
EBNF detect(GGrammar g)
{
	EBNF c = ();
	// start_grammar_symbol()
	// end_grammar_symbol()
	if (/epsilon() := g.P) c += fromDefault(epsilon_metasymbol());
	if (/empty() := g.P) c += fromDefault(empty_metasymbol());
	if (/anything() := g.P) c += fromDefault(universal_metasymbol());
	// line_continuation_symbol()
	// tabulation_symbol()
	if (/label(_,_) := g.P) c += fromDefault(start_label_symbol(), end_label_symbol());
	if (/mark(_,_) := g.P) c += fromDefault(start_mark_symbol(), end_mark_symbol());
	// multiple_defining_symbol()
	if (g.P != []) c += fromDefault(defining_symbol(), terminator_symbol());
	if (/production(_,choice(_)) := g.P) c += fromDefault(definition_separator_symbol());
	if (/sequence(_) := g.P) c += fromDefault(concatenate_symbol());
	// start_comment_symbol()
	// end_comment_symbol()
	// start_group_symbol()
	// end_group_symbol()
	if (/optional(_) := g.P) c += fromDefault(start_option_symbol(), end_option_symbol());
	if (/terminal(_) := g.P) c += fromDefault(start_terminal_symbol(), end_terminal_symbol());
	if (/nonterminal(_) := g.P) c += fromDefault(start_nonterminal_symbol(), end_nonterminal_symbol());
	if (/sepliststar(_,_) := g.P) c += fromDefault(start_seplist_star_symbol(), end_seplist_star_symbol());
	if (/seplistplus(_,_) := g.P) c += fromDefault(start_seplist_plus_symbol(), end_seplist_plus_symbol());
	if (/star(_) := g.P) c += fromDefault(start_repetition_star_symbol(), end_repetition_star_symbol());
	if (/plus(_) := g.P) c += fromDefault(start_repetition_plus_symbol(), end_repetition_plus_symbol());
	// postfix_option_symbol()
	// postfix_repetition_star_symbol()
	// postfix_repetition_plus_symbol()
	if (/nonterminal(_) := g.P)
	{
		// Somewhat more complex than just one pattern match: what characters can nonterminal names start with?
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
	if (findInnerChoices(g)) c += fromDefault(disjunction_symbol());
	if (/allof(_) := g.P) c += fromDefault(conjunction_symbol());
	if (/except(_,_) := g.P) c += fromDefault(exception_symbol());
	if (/not(_) := g.P) c += fromDefault(prefix_negation_symbol());
	// postfix_negation_symbol()
	// ignore_tokens()
	return c;
}

void main()
{
	iprintln(detect(grammar([],[],[])));
	iprintln(detect(grammar([],[production("foo",epsilon())],[])));
	iprintln(detect(grammar([],[production("foo",nonterminal("bar"))],[])));
	iprintln(detect(grammar([],[production("foo",choice([nonterminal("bar"),epsilon()]))],[])));
}