@contributor{ADT2PP: automatically transformed the language definition (ADT) into the pretty-printer}
@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::export::Grammar

import grammarlab::language::Grammar;
import grammarlab::language::EBNF;
import grammarlab::lib::Joining;

public str ppx(GExpr smth) = ppx(smth,DefaultEBNF);
public str ppx(GExprList smth) = ppx(smth,DefaultEBNF);
public str ppx(GExprSet smth) = ppx(smth,DefaultEBNF);
public str ppx(GProdList smth) = ppx(smth,DefaultEBNF);
public str ppx(GProdSet smth) = ppx(smth,DefaultEBNF);
//public str ppx(GProds smth) = ppx(smth,DefaultEBNF);
public str ppx(GProd smth) = ppx(smth,DefaultEBNF);
public str ppx(GGrammar smth) = ppx(smth,DefaultEBNF);

// TODO roots?
public str ppx(GGrammar g, EBNF meta) =
	getMeta(start_grammar_symbol(), meta)
	+ppx(g.nts,g.prods,meta)+
	getMeta(end_grammar_symbol(), meta);
public str ppx(list[str] nts, GProds prods, EBNF meta)
{
	str res = "";
	for (n <- nts, p <- prods[n])
		res += ppx(p,meta);
	return res;
}

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
// TODO always or not?
public str ppx(GExpr::val(GValue v), EBNF meta) = ppx(v, meta);
public str ppx(GExpr::nonterminal(str t), EBNF meta) =
	getMeta(start_nonterminal_symbol(), meta)
	+t+
	getMeta(end_nonterminal_symbol(), meta);
public str ppx(GExpr::terminal(str t), EBNF meta) =
	getMeta(start_terminal_symbol(), meta)
	+t+
	getMeta(end_terminal_symbol(), meta);
public str ppx(GExpr::labelled(str lab, GExpr expr), EBNF meta) =
	getMetaE(start_label_symbol(), meta)
	+lab+
	getMetaE(end_label_symbol(), meta)+
	getMeta(concatenate_symbol(), meta)
	+ppx(expr,meta);
public str ppx(GExpr::selectable(str sel, GExpr expr), EBNF meta) =
	getMetaE(start_selector_symbol(), meta)
	+sel+
	getMetaE(end_selector_symbol(), meta)
	+ppx(expr,meta);
public str ppx(GExpr::marked(GExpr expr), EBNF meta) =
	getMetaE(start_mark_symbol(), meta)
	+ppx(expr,meta)+
	getMetaE(end_mark_symbol(), meta);
public str ppx(GExpr::sequence(GExprList exprs), EBNF meta) =
	mapjoin(str(GExpr e){return ppx(e,meta);}, exprs, getMeta(concatenate_symbol(), meta));
public str ppx(GExpr::choice(GExprList exprs), EBNF meta) =
	mapjoin(str(GExpr e){return ppx(e,meta);}, exprs, getMetaE(definition_separator_symbol(), meta));

public str ppx(GExpr::allof(GExprList exprs), EBNF meta) = "allof(<pp(exprs)>)";
public str ppx(GExpr::not(GExpr expr), EBNF meta) = "not(<pp(expr)>)";
public str ppx(GExpr::optional(GExpr expr), EBNF meta) = 
	getMeta(start_option_symbol(), meta)+getMeta(end_option_symbol(), meta)+getMeta(postfix_option_symbol(), meta)=="" ?
	"ERRORopt(<ppx(expr,meta)>)":
	getMeta(start_option_symbol(), meta)
	+ppx(expr,meta)+
	getMeta(end_option_symbol(), meta)+
	getMeta(postfix_option_symbol(), meta);
	
public str ppx(GExpr::star(GExpr expr), EBNF meta) =
	getMeta(start_repetition_star_symbol(), meta)+getMeta(end_repetition_star_symbol(), meta)+getMeta(postfix_option_symbol(), meta)=="" ?
	"ERRORstar(<ppx(expr,meta)>)":
	getMeta(start_repetition_star_symbol(), meta)
	+ppx(expr,meta)+
	getMeta(end_repetition_star_symbol(), meta)+
	getMeta(postfix_repetition_star_symbol(), meta);

public str ppx(GExpr::plus(GExpr expr), EBNF meta) =
	getMeta(start_repetition_star_symbol(), meta)+getMeta(end_repetition_star_symbol(), meta)+getMeta(postfix_option_symbol(), meta)=="" ?
	"ERRORplus(<ppx(expr,meta)>)":
	getMeta(start_repetition_star_symbol(), meta)
	+ppx(expr,meta)+
	getMeta(end_repetition_star_symbol(), meta)+
	getMeta(postfix_repetition_plus_symbol(), meta);

public str ppx(GExpr::sepliststar(GExpr expr, GExpr sep), EBNF meta) =
	getMeta(start_seplist_star_symbol(), meta)
	+ppx(expr,meta)+
	getMeta(concatenate_symbol(), meta)
	+ppx(sep,meta)+
	getMeta(end_seplist_star_symbol(), meta);

public str ppx(GExpr::seplistplus(GExpr expr, GExpr sep), EBNF meta) =
	getMeta(plust_seplist_plus_symbol(), meta)
	+ppx(expr,meta)+
	getMeta(concatenate_symbol(), meta)
	+ppx(sep,meta)+
	getMeta(end_seplist_plus_symbol(), meta);

public default str ppx(GExpr smth, EBNF meta) = "??<smth>??";

public str ppx(GValue::string(), EBNF meta) = "string()";
public str ppx(GValue::integer(), EBNF meta) = "integer()";
public str ppx(GValue::boolean(), EBNF meta) = "boolean()";
public default str ppx(GValue smth, EBNF meta) = "??<smth>??";

