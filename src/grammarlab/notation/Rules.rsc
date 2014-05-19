@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module grammarlab::notation::Rules

import grammarlab::notation::Operations;
import grammarlab::language::Grammar;
import grammarlab::language::EBNF;

alias g2g = GGrammar(GGrammar);
alias ng = tuple[WNF n,GGrammar g];
alias ng2ng = ng(ng);
alias rule = tuple[set[Metasymbol] ls, set[Metasymbol] rs, ng2ng f];

GGrammar id (GGrammar g) = g;

ng justmeta(ng x, g2g f) = <x.n,f(x.g)>;
ng2ng justmeta(g2g f) = ng (ng x){return <x.n,f(x.g)>;};

ng2ng con2post(g2g f, Metasymbol s, Metasymbol e, Metasymbol p)
	= ng (ng x){return <x.n - {s,e} + {p,start_group_symbol(),end_group_symbol()},f(x.g)>;};

rule rule_confix2affix(Metasymbol s, Metasymbol e, Metasymbol p)
	= <
		{s,e},
		{p,start_group_symbol(),end_group_symbol()},
		ng (ng x){return <x.n - {s,e} + {p,start_group_symbol(),end_group_symbol()}, x.g>;}
	>;

// NB: not entirely bijective! TODO: check if groups are needed at the end
rule rule_affix2confix(Metasymbol s, Metasymbol e, Metasymbol p)
	= <
		{p,start_group_symbol(),end_group_symbol()},
		{s,e},
		ng (ng x){return <x.n - {p} + {s,e}, x.g>;}
	>;

public rel[set[Metasymbol] ls, set[Metasymbol] rs, ng2ng f] ruleset =
	{
		rule_confix2affix(start_option_symbol(),end_option_symbol(),postfix_option_symbol()),
		rule_confix2affix(start_option_symbol(),end_option_symbol(),prefix_option_symbol()),
		rule_affix2confix(start_option_symbol(),end_option_symbol(),postfix_option_symbol()),
		rule_affix2confix(start_option_symbol(),end_option_symbol(),prefix_option_symbol())
	};
