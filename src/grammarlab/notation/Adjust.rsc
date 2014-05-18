@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module grammarlab::notation::Adjust

import grammarlab::notation::Operations;
import grammarlab::notation::Detection;
import grammarlab::notation::Rules;

import grammarlab::language::Grammar;
import grammarlab::language::EBNF;
//import grammarlab::lib::ebnf::Default;
import grammarlab::lib::ebnf::Glue;

import Map;
import IO;

EBNF MyEBNF = (
	epsilon_metasymbol(): "ε",
	empty_metasymbol(): "φ",
	universal_metasymbol(): "α",
	defining_symbol(): " ::= ",
	terminator_symbol(): " ;",
	definition_separator_symbol(): " | ",
	disjunction_symbol(): " | ",
	concatenate_symbol(): " ",
	start_group_symbol(): "(",
	end_group_symbol(): ")",
	start_terminal_symbol(): "\"",
	end_terminal_symbol(): "\"",
	start_nonterminal_symbol(): "",
	end_nonterminal_symbol(): "",
	postfix_option_symbol(): "?",
	postfix_repetition_star_symbol(): "*",
	postfix_repetition_plus_symbol(): "+",
	conjunction_symbol(): " & ",
	prefix_negation_symbol(): "¬",
	nonterminals_may_start_with():"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
	nonterminals_may_contain(): "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ⟙_-/"
	);

void m()
{
	GGrammar g1 = grammar([],[production("foo",optional(nonterminal("bar")))],[]);
	EBNF bnf1 = detect(g1);
	EBNF bnf2 = MyEBNF;
	println("A - B = <sub(bnf1,bnf2)>");
	s = sub(bnf1,bnf2);
	println("B - A = <sub(bnf2,bnf1)>");
	g2 = g1;
	for (p <- ruleset)
	{
		if (p.ls <= domain(s) && p.rs <= domain(bnf2))
		{
			g2 = p.f(g2);
			println("Applied rule <p.ls> =\> <p.rs>!");
		}
		else
			println("Inapplicable: <p.ls> =\> <p.rs>!");
	}
}