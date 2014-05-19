@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module grammarlab::notation::Adjust

import grammarlab::notation::Operations;
import grammarlab::notation::Detection;
import grammarlab::notation::Rules;

import grammarlab::language::Grammar;
import grammarlab::language::EBNF;
//import grammarlab::lib::ebnf::Default;
import grammarlab::lib::ebnf::Glue;
import grammarlab::lib::Sizes;

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
WNF MyWNF = domain(MyEBNF);

void m()
{
	GGrammar g1 = grammar([],[production("foo",optional(nonterminal("bar")))],[]);
	WNF wnf1 = detect(g1);
	WNF wnf2 = MyWNF;
	println("A - B = <wnf1 - wnf2>");
	println("B - A = <wnf2 - wnf1>");
	g2 = g1;
	wnfi = wnf1;
	while(true)
	{
		s = wnfi - wnf2;
		println("\tA - B = <s>");
		if (isEmpty(s))
		{
			println("Difference in notations successfully bridged!");
			break;
		}
		for (p <- ruleset)
		{
			println("if (<p.ls <= s> && <p.rs <= wnf2>) ...");
			if (p.ls <= s && p.rs <= wnf2)
			{
				<wnfi,g2> = p.f(<wnfi,g2>);
				println("\t<p.ls> =\> <p.rs>!");
			}
		}
		sp = s;
		s = wnfi - wnf2;
		if (s == sp)
		{
			println("Difference in notations cannot be bridged.");
			break;
		}
	}
}