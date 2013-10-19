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
str wpp(GProdList ps, list[str] rs) = mapjoin(str(GProd p){return wpp(p,rs);},ps,"\n");

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

void m() = println(exportRascalSyntax(grammarlab::extract::RascalSyntax2BGF::extractG(|project://grammarlab/src/grammarlab/language/glue/Productions.rsc|)));

