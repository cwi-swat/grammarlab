@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module grammarlab::notation::Rules

import grammarlab::language::Grammar;
import grammarlab::language::EBNF;

alias g2g = GGrammar(GGrammar);

GGrammar id (GGrammar g) = g;

public rel[set[Metasymbol] ls, set[Metasymbol] rs, g2g f] ruleset =
	{
		<{start_option_symbol(),end_option_symbol()},{postfix_option_symbol(),start_group_symbol(),end_group_symbol()}, id>,
		<{start_option_symbol(),end_option_symbol()},{prefix_option_symbol(),start_group_symbol(),end_group_symbol()}, id>,
		<{postfix_option_symbol(),start_group_symbol(),end_group_symbol()},{start_option_symbol(),end_option_symbol()}, id>,
		<{prefix_option_symbol(),start_group_symbol(),end_group_symbol()},{start_option_symbol(),end_option_symbol()}, id>
	};
