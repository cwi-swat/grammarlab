@contributor{ADT2PP: automatically transformed the language definition (ADT) into the pretty-printer}
@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::export::RascalSyntax

import grammarlab::language::Grammar;
import grammarlab::lib::RascalPlus;
import grammarlab::lib::ebnf::Rascal;
import String;
import List;
// only needed for testing
import grammarlab::extract::RascalSyntax2BGF;
import grammarlab::export::Grammar;
import IO;

public str exportRascalSyntax(GGrammar g) = exportRascalSyntax("Unknown", g);

// TODO: change the naming convention of the grammar
public str exportRascalSyntax(str name, GGrammar g) =
	"@contributor{GrammarLab Rascal syntax definition exporter}
	'module <name>
	'
	'<mapProds(g.P,g.S)>
	'";


str mapProds(GProdList ps, list[str] rs) = wpp(ps,rs);

// wrapper! almost mapjoin, but Rascal ain’t Haskell
str wpp(GProdList ps, list[str] rs) = intercalate("\n",[wpp(p,rs) | p <- ps]);

str wpp(GProd p, list[str] rs)
	= (p.lhs in rs)?"start ":""
	+ "syntax <p.lhs>\n\t= <wpp(p.rhs)>\n\t;"
	;

str wpp(GExpr e)
{
	e2 = visit(e)
	{
		case mark(str name, nonterminal(str nt)) => nonterminal("<nt> <name>")
	}
	return ppx(e2,RascalEBNF);
}

//
//str mapProd(production(str lhs, label(str name, GExpr e))) = "data <lhs>\n\t= <name>(<mapExpr(e)>)\n\t;";
//str mapProd(production(str lhs, choice(L))) = "data <lhs>\n\t= <mapjoin(mapExprTop,L,"\n\t| ")>\n\t;";
//str mapProd(production(str lhs, val(string()))) = "alias <lhs> = str;";
//str mapProd(production(str lhs, val(integer()))) = "alias <lhs> = int;";
//str mapProd(production(str lhs, val(boolean()))) = "alias <lhs> = bool;";
//str mapProd(production(str lhs, star(GExpr e))) = "alias <lhs> = list[<mapExpr(e)>];";
//str mapProd(production(str lhs, plus(GExpr e))) = "alias <lhs> = list[<mapExpr(e)>];";
//str mapProd(production(str lhs, sepliststar(GExpr e, terminal(_)))) = "alias <lhs> = list[<mapExpr(e)>]";
//str mapProd(production(str lhs, seplistplus(GExpr e, terminal(_)))) = "alias <lhs> = list[<mapExpr(e)>]";
//default str mapProd(production(str lhs, sepliststar(GExpr e1, GExpr e2))) = "alias <lhs> = rel[<mapExpr(e1)>,<mapExpr(e2)>]";
//default str mapProd(production(str lhs, seplistplus(GExpr e1, GExpr e2))) = "alias <lhs> = rel[<mapExpr(e1)>,<mapExpr(e2)>]";
//
//str mapExprTop(label(str name, GExpr e)) = "<name>(<mapExpr(e)>)";
//str mapExprTop(GExpr _) = "NOT_ALLOWED_IN_ADT()";
//
//str mapExpr(mark(str name, GExpr e)) = "<mapExpr(e)> <name>";
//str mapExpr(label(str name, GExpr e)) = "<mapExpr(e)> <name>"; // should not happen, but let’s be tolerant
//str mapExpr(epsilon()) = "";
//str mapExpr(nothing()) = ""; // also should not happen
//str mapExpr(val(string())) = "str";
//str mapExpr(val(integer())) = "int";
//str mapExpr(val(boolean())) = "bool";
//str mapExpr(nonterminal(str name)) = name;
//str mapExpr(sequence(L)) = mapjoin(mapExpr,L,", "); 
//str mapExpr(allof(L)) = mapjoin(mapExpr,L,", "); // no distinction between a conjunction and a sequence
//str mapExpr(except(GExpr e1, GExpr e2)) = mapExpr(e1); // no negation in ADTs, this is an approximation
//str mapExpr(optional(GExpr e)) = "list[<mapExpr(e)>]"; // only one of the ways to map it
//str mapExpr(star(GExpr e)) = "list[<mapExpr(e)>]";
//str mapExpr(plus(GExpr e)) = "list[<mapExpr(e)>]";
//str mapExpr(sepliststar(GExpr e, terminal(_))) = "list[<mapExpr(e)>]";
//str mapExpr(seplistplus(GExpr e, terminal(_))) = "list[<mapExpr(e)>]";
//str mapExpr(GExpr _) = "NOT_ALLOW_IN_ADT";

void m() = println(exportRascalSyntax(grammarlab::extract::RascalSyntax2BGF::extractG(|project://grammarlab/src/grammarlab/language/glue/Productions.rsc|)));

