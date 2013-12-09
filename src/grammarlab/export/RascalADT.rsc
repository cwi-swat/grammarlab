@contributor{ADT2PP: automatically transformed the language definition (ADT) into the pretty-printer}
@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::export::RascalADT

import grammarlab::language::Grammar;
import grammarlab::lib::RascalPlus;
// only needed for testing
//import grammarlab::extract::RascalADT2BGF;
//import IO;

public str exportRascalADT(GGrammar g) = exportRascalADT("Unknown", g);

public str exportRascalADT(str name, GGrammar g) =
	"@contributor{GrammarLab Rascal ADT exporter}
	'module <name>
	'
	'<mapProds(g.P)>
	'";

str mapProds(GProdList ps) = ("" | it + "\n" + mapProd(p) | GProd p <- ps);

str mapProd(production(str lhs, label(str name, GExpr e))) = "data <lhs>\n\t= <name>(<mapExpr(e)>)\n\t;";
str mapProd(production(str lhs, choice(L))) = "data <lhs>\n\t= <mapjoin(mapExprTop,L,"\n\t| ")>\n\t;";
str mapProd(production(str lhs, val(string()))) = "alias <lhs> = str;";
str mapProd(production(str lhs, val(integer()))) = "alias <lhs> = int;";
str mapProd(production(str lhs, val(boolean()))) = "alias <lhs> = bool;";
str mapProd(production(str lhs, star(GExpr e))) = "alias <lhs> = list[<mapExpr(e)>];";
str mapProd(production(str lhs, plus(GExpr e))) = "alias <lhs> = list[<mapExpr(e)>];";
str mapProd(production(str lhs, sepliststar(GExpr e, terminal(_)))) = "alias <lhs> = list[<mapExpr(e)>]";
str mapProd(production(str lhs, seplistplus(GExpr e, terminal(_)))) = "alias <lhs> = list[<mapExpr(e)>]";
default str mapProd(production(str lhs, sepliststar(GExpr e1, GExpr e2))) = "alias <lhs> = rel[<mapExpr(e1)>,<mapExpr(e2)>]";
default str mapProd(production(str lhs, seplistplus(GExpr e1, GExpr e2))) = "alias <lhs> = rel[<mapExpr(e1)>,<mapExpr(e2)>]";
default str mapProd(production(str lhs, GExpr rhs)) = "// ERROR <lhs> ::= <mapExpr(rhs)>"; 

str mapExprTop(label(str name, GExpr e)) = "<name>(<mapExpr(e)>)";
str mapExprTop(GExpr e) = "NOT_ALLOWED_IN_ADT() // <mapExpr(e)>";

str mapExpr(mark(str name, GExpr e)) = "<mapExpr(e)> <name>";
str mapExpr(label(str name, GExpr e)) = "<mapExpr(e)> <name>"; // should not happen, but let’s be tolerant
str mapExpr(epsilon()) = "";
str mapExpr(nothing()) = ""; // also should not happen
str mapExpr(val(string())) = "str";
str mapExpr(val(integer())) = "int";
str mapExpr(val(boolean())) = "bool";
str mapExpr(nonterminal(str name)) = name;
str mapExpr(sequence(L)) = mapjoin(mapExpr,L,", "); 
str mapExpr(allof(L)) = mapjoin(mapExpr,L,", "); // no distinction between a conjunction and a sequence
str mapExpr(except(GExpr e1, GExpr e2)) = mapExpr(e1); // no negation in ADTs, this is an approximation
str mapExpr(optional(GExpr e)) = "list[<mapExpr(e)>]"; // only one of the ways to map it
str mapExpr(star(GExpr e)) = "list[<mapExpr(e)>]";
str mapExpr(plus(GExpr e)) = "list[<mapExpr(e)>]";
str mapExpr(sepliststar(GExpr e, terminal(_))) = "list[<mapExpr(e)>]";
str mapExpr(seplistplus(GExpr e, terminal(_))) = "list[<mapExpr(e)>]";
str mapExpr(GExpr _) = "NOT_ALLOW_IN_ADT";

//void m() = println(exportRascalADT(grammarlab::extract::RascalADT2BGF::extractG(|project://grammarlab/src/grammarlab/language/X.rsc|)));

