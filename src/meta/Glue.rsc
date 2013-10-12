@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module meta::Glue

import grammarlab::extract::EBNF2Rascal;
import grammarlab::language::EBNF;
import grammarlab::language::Grammar;
import List;
import Set;
import Map;
import IO;

import grammarlab::extract::RascalADT2BGF;

public EBNF GlueEBNF = (
	epsilon_metasymbol(): "ε",
	empty_metasymbol(): "φ",
	universal_metasymbol(): "α",
	start_label_symbol(): "[",
	end_label_symbol(): "]::",
	start_mark_symbol(): "\<",
	end_mark_symbol(): "\>:",
	defining_symbol(): " ::= ",		// or '='?
	terminator_symbol(): " ;",
	definition_separator_symbol(): " | ",
	disjunction_symbol(): " | ",
	concatenate_symbol(): " ",
	start_comment_symbol(): "//",
	end_comment_symbol(): "\n",
	start_group_symbol(): "(",
	end_group_symbol(): ")",
	start_terminal_symbol(): "\"",
	end_terminal_symbol(): "\"",
	//start_nonterminal_symbol(): "",
	//end_nonterminal_symbol(): "",
	start_seplist_star_symbol(): "{",
	end_seplist_star_symbol(): "}*",
	start_seplist_plus_symbol(): "{",
	end_seplist_plus_symbol(): "}+",
	postfix_option_symbol(): "?",
	postfix_repetition_star_symbol(): "*",
	postfix_repetition_plus_symbol(): "+",
	conjunction_symbol(): " & ",
	exception_symbol(): " &! ",
	prefix_negation_symbol(): "¬",
	nonterminals_may_contain(): "⟙"
);

void main()
{
	// Generate grammarlab::language::glue::Productions
	writeFile(|project://grammarlab/src/grammarlab/language/glue/Productions.rsc|,
		"@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
		'@contributor{Generated by meta::Glue, do not edit manually!}\n"
		+EDD2Rascal(GlueEBNF,"Glue","grammarlab::language::glue::Productions"));
	// Generate grammarlab::language::glue::Transformations
	G = grammarlab::extract::RascalADT2BGF::extractG(|project://grammarlab/src/grammarlab/language/X.rsc|);
	cs = (s:e | production("XCommand",choice(L)) <- G.P, label(s,e) <- L);
	csd = sort(domain(cs));
	writeFile(|project://grammarlab/src/grammarlab/language/glue/Transformations.rsc|,
		("@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
		 '@contributor{Generated by meta::Glue, do not edit manually!}
		 'module grammarlab::language::glue::Transformations\n
		 'import grammarlab::language::glue::Productions;\n"
		| "<it>\nlexical GlueK<s> = @category=\"MetaVariable\" \"<s>\";" | s <- csd)
		+ "\n\nkeyword GlueKw = GlueK"
		+ intercalate(" | GlueK", csd)
		+ ";\n\n"
		+"syntax GlueCommand
		'	= "
		+intercalate("\n\t| ",["GlueK<c> <concretenotation(cs[c])> \".\"" | c <- csd])
		+"\n\t;\n"
	);
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

