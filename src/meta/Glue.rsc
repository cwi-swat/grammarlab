@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module meta::Glue

// bootstrap
import grammarlab::language::glue::Interpreter;
import grammarlab::io::GLUE;

import grammarlab::extract::EBNF2Rascal;
import grammarlab::lib::ebnf::Glue;
import grammarlab::language::Grammar;
import List;
import Set;
import Map;
import IO;

import grammarlab::extract::RascalADT2BGF;
import grammarlab::export::RascalSyntax;

void main()
{
	// Generate grammarlab::language::glue::Transformations
	G = grammarlab::extract::RascalADT2BGF::extractG(|project://grammarlab/src/grammarlab/language/X.rsc|);
	cs = (s:e | production("XCommand",choice(L)) <- G.P, label(s,e) <- L);
	csd = sort(domain(cs));
	writeFile(|project://grammarlab/src/meta/GlueLanguage.glue|,
		"importG\n\tGlueCommand ::= <intercalate("\n\t\t| ",["GlueK<c> <concretenotation(cs[c])> \".\"" | c <- csd])>\n\t;\n."
	);
	G2 = execute(|project://grammarlab/src/meta/GlueAdapt.glue|);
	writeFile(|project://grammarlab/src/grammarlab/language/glue/Transformations.rsc|,
		("@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
		 '@contributor{Generated by meta::Glue, do not edit manually!}
		 'module grammarlab::language::glue::Transformations\n
		 'import grammarlab::language::glue::Productions;\n"
		| "<it>\nlexical GlueK<s> = @category=\"MetaVariable\" \"<s>\";" | s <- csd)
		+ "\n\nkeyword GlueKw = GlueK"
		+ intercalate(" | GlueK", csd)
		+ ";\n\n"
		+ grammarlab::export::RascalSyntax::mapProds(G2.P, G2.S)
		//+ exportRascalSyntax(G2)
		//+"syntax GlueCommand
		//'	= "
		//+intercalate("\n\t| ",["GlueK<c> <concretenotation(cs[c])> \".\"" | c <- csd])
		//+"\n\t;\n"
	);
	// Generate grammarlab::language::glue::Productions
	writeFile(|project://grammarlab/src/grammarlab/language/glue/Productions.rsc|,
		"@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
		'@contributor{Generated by meta::Glue, do not edit manually!}\n"
		+EDD2Rascal(GlueEBNF,"Glue","grammarlab::language::glue::Productions"));
	// Generate grammarlab::language::glue::MapXBGF2A
	writeFile(|project://grammarlab/src/grammarlab/language/glue/MapXBGF2A.rsc|,
	"@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
	'@contributor{Generated by meta::Glue, do not edit manually!}
	'module grammarlab::language::glue::MapXBGF2A\n
	'import grammarlab::language::glue::Abstract;
	'import grammarlab::language::glue::Transformations;
	'import grammarlab::language::glue::Productions;
	'import grammarlab::language::glue::Scope;
	'import grammarlab::language::Grammar;
	'import grammarlab::language::XScope;
	'import grammarlab::language::X;
	'import util::Math;
	'import Boolean;\n\n"
	+intercalate("\n",["GLUEA glimplode((GlueCommand)`\<GlueK<c> _\> <fishnotation(cs[c])> .`) = xbgf(<c>(<allmarks(cs[c])>));" | c <- csd])
	);
}

str concretenotation(GExpr e) = intercalate(" ",[convertGType(s) | sequence(L) := e, mark(_,s) <- L]);
str fishnotation(GExpr e) = intercalate(" ",["\<<convertGType(s)> <n>\>" | sequence(L) := e, mark(n,s) <- L]);
str allmarks(GExpr e) = intercalate(",",[convertor(convertGType(s),n) | sequence(L) := e, mark(n,s) <- L]);

str convertor("GlueString", str name) = "\"\<<name>\>\"";
str convertor("GlueNonterminal", str name) = "\"\<<name>\>\"";
str convertor("GlueNonterminal+", str name) = "[\"\<each\>\" | each \<- <name>]";
str convertor("GlueTerminal", str name) = "\"\<<name>\>\"";
str convertor("GlueTerminal+", str name) = "[\"\<each\>\" | each \<- <name>]";
str convertor("GlueLabel", str name) = "\"\<<name>\>\"";
str convertor("GlueMark", str name) = "\"\<<name>\>\"";
str convertor("GlueString+", str name) = "[\"\<each\>\" | each \<- <name>]";
str convertor("GlueInteger", str name) = "toInt(\"\<<name>\>\")";
str convertor("GlueBoolean", str name) = "fromString(\"\<<name>\>\")";
str convertor("GlueProduction", str name) = "mapP(<name>)";
str convertor("GlueProduction+", str name) = "mapPs(<name>)";
str convertor("GlueSymbol", str name) = "mapS(<name>)";
str convertor("GlueScope", str name) = "mapScope(<name>)";
default str convertor(str gltype, str name) = "???(<name>)";

str convertGType(val(string())) = "GlueString";
str convertGType(val(integer())) = "GlueInteger";
str convertGType(val(boolean())) = "GlueBoolean";
str convertGType(nonterminal("GProd")) = "GlueProduction";
str convertGType(nonterminal("GProdList")) = "GlueProduction+";
str convertGType(nonterminal("GExpr")) = "GlueSymbol";
str convertGType(nonterminal("GNonTerm")) = "GlueNonterminal";
str convertGType(nonterminal("GTerm")) = "GlueTerminal";
str convertGType(nonterminal("GLabel")) = "GlueLabel";
str convertGType(nonterminal("GMark")) = "GlueMark";
str convertGType(nonterminal("XScope")) = "GlueScope";
str convertGType(star(GExpr e)) = convertGType(e)+"+";
default str convertGType(GExpr e) = "value";

