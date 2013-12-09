@contributor{ADT2PP: automatically transformed the language definition (ADT) into the pretty-printer}
@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::export::Grammar

import grammarlab::language::Grammar;
import grammarlab::language::EBNF;
import grammarlab::lib::ebnf::Default;
import grammarlab::lib::RascalPlus;

public str ppx(GExpr smth) = ppx(smth,DefaultEBNF);
public str ppx(GExprList smth) = ppx(smth,DefaultEBNF);
public str ppx(GExprSet smth) = ppx(smth,DefaultEBNF);
public str ppx(GProdList smth) = ppx(smth,DefaultEBNF);
public str ppx(GProdSet smth) = ppx(smth,DefaultEBNF);
//public str ppx(GProds smth) = ppx(smth,DefaultEBNF);
public str ppx(GProd smth) = ppx(smth,DefaultEBNF);
public str ppx(GGrammar smth) = ppx(smth,DefaultEBNF);

// NB: by default mapjoin joins with " ": technically, it should be "", but it is easier to see grouped rules
public str ppx(GProdList smth, EBNF meta) = mapjoin(str(GProd p){return ppx(p,meta);}, smth);
public str ppx(GExprList smth, EBNF meta) = mapjoin(str(GExpr e){return ppx(e,meta);}, smth, getMeta(concatenate_symbol(), meta));

// TODO roots?
public str ppx(GGrammar g, EBNF meta) =
	getMeta(start_grammar_symbol(), meta)
	+ppx(g.N,g.P,meta)+
	getMeta(end_grammar_symbol(), meta);

public str ppx(list[str] nts, GProdList prods, EBNF meta)
	= joinStrings([ppx(p,meta) | GProd p <- prods], "");

public str ppx(GProd p, EBNF meta) =
	getMeta(start_nonterminal_symbol(), meta)
	+p.lhs+
	getMeta(end_nonterminal_symbol(), meta)+
	getMetaE(defining_symbol(), meta)
	+ppx(p.rhs, meta)+
	getMetaE(terminator_symbol(), meta);

public str ppx(GExpr::epsilon(), EBNF meta) = getMetaE(epsilon_metasymbol(), meta);
public str ppx(GExpr::empty(), EBNF meta) = getMetaE(empty_metasymbol(), meta);
public str ppx(GExpr::anything(), EBNF meta) = getMetaE(universal_metasymbol(), meta);

public str ppx(GExpr::val(GValue v), EBNF meta) = ppx(v, meta);

public str ppx(GExpr::nonterminal(str t), EBNF meta) =
	getMeta(start_nonterminal_symbol(), meta)
	+t+
	getMeta(end_nonterminal_symbol(), meta);

public str ppx(GExpr::terminal(str t), EBNF meta) =
	getMeta(start_terminal_symbol(), meta)
	+t+
	getMeta(end_terminal_symbol(), meta);

public str ppx(GExpr::label(str name, GExpr expr), EBNF meta) =
	getMetaE(start_label_symbol(), meta)
	+name+
	getMetaE(end_label_symbol(), meta)+
	//getMeta(concatenate_symbol(), meta)+
	ppxpg(expr,meta);

public str ppx(GExpr::mark(str name, GExpr expr), EBNF meta) =
	getMetaE(start_mark_symbol(), meta)
	+name+
	getMetaE(end_mark_symbol(), meta)+
	ppxpg(expr,meta);

public str ppx(GExpr::sequence(GExprList exprs), EBNF meta) =
	mapjoin(str(GExpr e){return ppxpg(e,meta);}, exprs, getMeta(concatenate_symbol(), meta));

public str ppx(GExpr::choice(GExprList exprs), EBNF meta) =
	mapjoin(str(GExpr e){return ppxpg(e,meta);}, exprs, getMetaE(definition_separator_symbol(), meta));

public str ppx(GExpr::allof(GExprList exprs), EBNF meta) =
	mapjoin(str(GExpr e){return ppxpg(e,meta);}, exprs, getMetaE(conjunction_symbol(), meta));

// TODO: this style of (meta)programming is not entirely clean
// will result in strage results when both prefix and postfix metasymbols are present
// On the other hand, such a metasyntax would be weird by itself!
public str ppx(GExpr::not(GExpr expr), EBNF meta) =
	getMeta(prefix_negation_symbol(), meta)
	+ppxpg(expr,meta)+
	getMeta(postfix_negation_symbol(), meta);

public str ppx(GExpr::optional(GExpr expr), EBNF meta) = 
	getMeta(start_option_symbol(), meta)+getMeta(end_option_symbol(), meta)+getMeta(postfix_option_symbol(), meta)=="" ?
	"ERRORopt(<ppx(expr,meta)>)":
	getMeta(start_option_symbol(), meta)
	+ppxpg(expr,meta)+
	getMeta(end_option_symbol(), meta)+
	getMeta(postfix_option_symbol(), meta);
	
public str ppx(GExpr::star(GExpr expr), EBNF meta) =
	getMeta(start_repetition_star_symbol(), meta)+getMeta(end_repetition_star_symbol(), meta)+getMeta(postfix_option_symbol(), meta)=="" ?
	"ERRORstar(<ppx(expr,meta)>)":
	getMeta(start_repetition_star_symbol(), meta)
	+ppxpg(expr,meta)+
	getMeta(end_repetition_star_symbol(), meta)+
	getMeta(postfix_repetition_star_symbol(), meta);

public str ppx(GExpr::plus(GExpr expr), EBNF meta) =
	getMeta(start_repetition_star_symbol(), meta)+getMeta(end_repetition_star_symbol(), meta)+getMeta(postfix_option_symbol(), meta)=="" ?
	"ERRORplus(<ppx(expr,meta)>)":
	getMeta(start_repetition_star_symbol(), meta)
	+ppxpg(expr,meta)+
	getMeta(end_repetition_star_symbol(), meta)+
	getMeta(postfix_repetition_plus_symbol(), meta);

public str ppx(GExpr::sepliststar(GExpr expr, GExpr sep), EBNF meta) =
	getMeta(start_seplist_star_symbol(), meta)
	+ppxpg(expr,meta)+
	getMeta(concatenate_symbol(), meta)
	+ppxpg(sep,meta)+
	getMeta(end_seplist_star_symbol(), meta);

public str ppx(GExpr::seplistplus(GExpr expr, GExpr sep), EBNF meta) =
	getMeta(start_seplist_plus_symbol(), meta)
	+ppxpg(expr,meta)+
	getMeta(concatenate_symbol(), meta)
	+ppxpg(sep,meta)+
	getMeta(end_seplist_plus_symbol(), meta);

public str ppx(except(GExpr e1, GExpr e2), EBNF meta) =
	ppxpg(e1,meta)+
	getMeta(exception_symbol(), meta)
	+ppxpg(e2,meta);

public default str ppx(GExpr smth, EBNF meta) = "??<smth>??";

public str ppx(GValue::string(), EBNF meta) = "STR";
public str ppx(GValue::integer(), EBNF meta) = "INT";
public str ppx(GValue::boolean(), EBNF meta) = "BOOL";
public default str ppx(GValue smth, EBNF meta) = "??<smth>??";

// possibly grouped expression
public str ppxpg(e:epsilon(), EBNF meta) = ppx(e, meta);
public str ppxpg(e:empty(), EBNF meta) = ppx(e, meta);
public str ppxpg(e:anything(), EBNF meta) = ppx(e, meta);
public str ppxpg(e:val(_), EBNF meta) = ppx(e, meta);
public str ppxpg(e:nonterminal(_), EBNF meta) = ppx(e, meta);
public str ppxpg(e:terminal(_), EBNF meta) = ppx(e, meta);
public str ppxpg(e:label(_,_), EBNF meta) = ppx(e, meta);
public str ppxpg(e:mark(_,_), EBNF meta) = ppx(e, meta);
public str ppxpg(e:not(_), EBNF meta) = ppx(e, meta);
public str ppxpg(e:optional(_), EBNF meta) = ppx(e, meta);
public str ppxpg(e:star(_), EBNF meta) = ppx(e, meta);
public str ppxpg(e:plus(_), EBNF meta) = ppx(e, meta);
public str ppxpg(e:sepliststar(_,_), EBNF meta) = ppx(e, meta);
public str ppxpg(e:seplistplus(_,_), EBNF meta) = ppx(e, meta);
default str ppxpg(GExpr e, EBNF meta)
	= getMeta(start_group_symbol(), meta)
	+ ppx(e, meta)
	+ getMeta(end_group_symbol(), meta);
