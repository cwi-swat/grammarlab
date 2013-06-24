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
public str ppx(GGrammar g, EBNF meta) = /grammarSymbol(b,e) := meta ? b+ppx(g.nts,g.prods,meta)+e : ppx(g.nts,g.prods,meta); 
public str ppx(list[str] nts, GProds prods, EBNF meta)
{
	str res = "";
	for (n <- nts, p <- prods[n])
		res += ppx(p,meta);
	return res;
}

public str ppx(GProd p, EBNF meta)
{
	str ds = /definingSymbol(dss) := meta ? dss : "";
	str ts = /terminatorSymbol(tss) := meta ? tss : "";
	// TODO: not used/propagated yet
	str ss = /defSeparatorSymbol(sss) := meta ? sss : "";
	return p.lhs + ds + ppx(p.rhs) + ts;
}
//alias GProdList = list[GProd];
//alias GProdSet  =  set[GProd];
//alias GExprList = list[GExpr];
//alias GExprSet  =  set[GExpr];
//
//alias GProds = map[str,GProdList];
//
//data GGrammar
//	= grammar(list[str] nts, list[str] roots, GProds prods)
//;
//
//data GProd
//	= production (str lhs, GExpr rhs)
//;


public str ppx(GExpr::epsilon(), EBNF meta) = /epsilonSymbol(s) := meta ? s : "EPSILON";
public str ppx(GExpr::empty(), EBNF meta) = /emptyLanguageSymbol(s) := meta ? s : "EMPTY";
public str ppx(GExpr::anything(), EBNF meta) = /universalSymbol(s) := meta ? s : "ANY";
public str ppx(GExpr::val(GValue v), EBNF meta) = ppx(v, meta);
public str ppx(GExpr::nonterminal(str t), EBNF meta) = /nonterminalSymbol(b,e) := meta ? b+t+e : t;
public str ppx(GExpr::terminal(str t), EBNF meta) = /terminalSymbol(b,e) := meta ? b+t+e : t;
public str ppx(GExpr::labelled(str lab, GExpr expr), EBNF meta) = "labelled(<lab>,<pp(expr)>)";
public str ppx(GExpr::selectable(str sel, GExpr expr), EBNF meta) = "selectable(<sel>,<pp(expr)>)";
public str ppx(GExpr::marked(GExpr expr), EBNF meta) = "marked(<pp(expr)>)";
public str ppx(GExpr::sequence(GExprList exprs), EBNF meta) =
	/concatenationSymbol(s) := meta ?
	mapjoin(str(GExpr e){return ppx(e,meta);}, exprs, s) : 
	mapjoin(str(GExpr e){return ppx(e,meta);}, exprs);
public str ppx(GExpr::choice(GExprList exprs), EBNF meta) =
	/defSeparatorSymbol(s) := meta ?
	mapjoin(str(GExpr e){return ppx(e,meta);}, exprs, s) : 
	mapjoin(str(GExpr e){return ppx(e,meta);}, exprs);

public str ppx(GExpr::allof(GExprList exprs), EBNF meta) = "allof(<pp(exprs)>)";
public str ppx(GExpr::not(GExpr expr), EBNF meta) = "not(<pp(expr)>)";
public str ppx(GExpr::optional(GExpr expr), EBNF meta) = "optional(<ppx(expr,meta)>)";
public str ppx(GExpr::star(GExpr expr), EBNF meta) = "star(<ppx(expr,meta)>)";
public str ppx(GExpr::plus(GExpr expr), EBNF meta) = "plus(<ppx(expr,meta)>)";
public str ppx(GExpr::sepliststar(GExpr expr, GExpr sep), EBNF meta) = "sepliststar(<pp(expr)>,<pp(sep)>)";
public str ppx(GExpr::seplistplus(GExpr expr, GExpr sep), EBNF meta) = "seplistplus(<pp(expr)>,<pp(sep)>)";
public default str ppx(GExpr smth, EBNF meta) = "??<smth>??";

public str ppx(GValue::string(), EBNF meta) = "string()";
public str ppx(GValue::integer(), EBNF meta) = "integer()";
public str ppx(GValue::boolean(), EBNF meta) = "boolean()";
public default str ppx(GValue smth, EBNF meta) = "??<smth>??";

