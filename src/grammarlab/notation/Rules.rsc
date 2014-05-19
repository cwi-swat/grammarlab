@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module grammarlab::notation::Rules

import grammarlab::language::Grammar;
import grammarlab::language::EBNF;

alias g2g = GGrammar(GGrammar);
alias ng = tuple[EBNF n,GGrammar g];
alias ng2ng = ng(ng);

GGrammar id (GGrammar g) = g;

ng justmeta(ng x, g2g f) = <x.n,f(x.g)>;
ng2ng justmeta(g2g f) = ng (ng x){return <x.n,f(x.g)>;};

public rel[set[Metasymbol] ls, set[Metasymbol] rs, ng2ng f] ruleset =
	{
		<{start_option_symbol(),end_option_symbol()},{postfix_option_symbol(),start_group_symbol(),end_group_symbol()}, justmeta(id)>,
		<{start_option_symbol(),end_option_symbol()},{prefix_option_symbol(),start_group_symbol(),end_group_symbol()}, justmeta(id)>,
		<{postfix_option_symbol(),start_group_symbol(),end_group_symbol()},{start_option_symbol(),end_option_symbol()}, justmeta(id)>,
		<{prefix_option_symbol(),start_group_symbol(),end_group_symbol()},{start_option_symbol(),end_option_symbol()}, justmeta(id)>
	};
