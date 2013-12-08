@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module meta::Glue

// debug
import grammarlab::language::X;
import grammarlab::language::glue::abstract::Top;

// bootstrap
import grammarlab::language::glue::Interpreter;
import grammarlab::io::GLUE;

import grammarlab::Extractors;
import grammarlab::export::RascalSyntax;
import grammarlab::extract::EBNF2Rascal;

import grammarlab::lib::ebnf::Glue;
import grammarlab::language::Grammar;
import List;
import Set;
import Map;
import IO;
import String;


void main()
{
	// Generate grammarlab::language::glue::concrete::BGF
	writeFile(|project://grammarlab/src/grammarlab/language/glue/concrete/BGF.rsc|,
		"@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
		'@contributor{Generated by meta::Glue, do not edit manually!}\n"
		+EDD2Rascal(GlueEBNF,"Glue","grammarlab::language::glue::concrete::BGF"));
	// Generate grammarlab::language::glue::concrete::XBGF
	G = rscd2bgf(|project://grammarlab/src/grammarlab/language/X.rsc|);
	cs = (s:e | production("XCommand",choice(L)) <- G.P, label(s,e) <- L);
	csd = sort(domain(cs));
	writeFile(|project://grammarlab/src/meta/GlueLanguageT.glue|,
		"importG\n\tGlueCommand ::= <intercalate("\n\t\t| ",["GlueK<c> <concretenotation(cs[c])> \".\"" | c <- csd])>\n\t;\n."
	);
	G2 = execute(|project://grammarlab/src/meta/GlueAdaptT.glue|);
	//writeGlue([xbgf(importG(G2.P))],|project://grammarlab/src/meta/GlueResult.glue|);
	rhss = (k:v | [GProd p] := G2.P, choice(L) := p.rhs, line <- L, sequence(v) := line, nonterminal(k) := v[0]);
	writeFile(|project://grammarlab/src/grammarlab/language/glue/concrete/XBGF.rsc|,
	("@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
	 '@contributor{Generated by meta::Glue, do not edit manually!}
	 'module grammarlab::language::glue::concrete::XBGF
	 '
	 'import grammarlab::language::glue::concrete::BGF;\n"
	| "<it>\nlexical GlueK<s> = @category=\"MetaVariable\" \"<s>\";" | s <- csd)
	+"\nlexical GlueKwFrom = @category=\"MetaVariable\" \"from\";
	'lexical GlueKwTo = @category=\"MetaVariable\" \"to\";
	'lexical GlueKwInto = @category=\"MetaVariable\" \"into\";
	'lexical GlueKwWith = @category=\"MetaVariable\" \"with\";"
	+ "\n\nkeyword GlueKw = GlueKwFrom | GlueKwTo | GlueKwInto | GlueKwWith | GlueK"
	+ intercalate(" | GlueK", csd)
	+ ";\n\n"
	+ // HACK!
	replaceAll(replaceAll(
	grammarlab::export::RascalSyntax::mapProds(G2.P, G2.S)
	,"(",""),")","")
	);
	// Generate grammarlab::language::glue::implode::XBGF
	writeFile(|project://grammarlab/src/grammarlab/language/glue/implode/XBGF.rsc|,
	"@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
	'@contributor{Generated by meta::Glue, do not edit manually!}
	'module grammarlab::language::glue::implode::XBGF
	'
	'import grammarlab::language::glue::abstract::Top;
	'import grammarlab::language::glue::concrete::BGF;
	'import grammarlab::language::glue::concrete::XBGF;
	'import grammarlab::language::glue::concrete::Scope;
	'import grammarlab::language::glue::implode::Scope;
	'import grammarlab::language::Grammar;
	'import grammarlab::language::XScope;
	'import grammarlab::language::X;
	'import util::Math;
	'import Boolean;\n\n"
	+intercalate("\n",["GLUEA glimplode((GlueCommand)`<tofishnotation(cs[c],rhss["GlueK<c>"])>`) = xbgf(<c>(<allmarks(cs[c])>));" | c <- csd])
	);
	// Generate grammarlab::language::glue::concrete::SLEIR
	G = rscd2bgf(|project://grammarlab/src/grammarlab/language/SLEIR.rsc|);
	cs = (s:e | production("MCommand",choice(L)) <- G.P, label(s,e) <- L);
	csd = sort(domain(cs));
	writeFile(|project://grammarlab/src/meta/GlueLanguageM.glue|,
		"importG\n\tGlueCommand ::= <intercalate("\n\t\t| ",["GlueK<c> <concretenotation(cs[c])> \".\"" | c <- csd])>\n\t;\n."
	);
	G2 = execute(|project://grammarlab/src/meta/GlueAdaptM.glue|);
	//writeGlue([xbgf(importG(G2.P))],|project://grammarlab/src/meta/GlueResult.glue|);
	rhss = (k:v | [GProd p] := G2.P, choice(L) := p.rhs, line <- L, sequence(v) := line, nonterminal(k) := v[0]);
	writeFile(|project://grammarlab/src/grammarlab/language/glue/concrete/SLEIR.rsc|,
	("@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
	 '@contributor{Generated by meta::Glue, do not edit manually!}
	 'module grammarlab::language::glue::concrete::SLEIR
	 '
	 'import grammarlab::language::glue::concrete::BGF;
	 'import grammarlab::language::glue::concrete::XBGF;\n"
	| "<it>\nlexical GlueK<s> = @category=\"MetaAmbiguity\" \"<s>\";" | s <- csd)
	+ "\n\nkeyword GlueKw = GlueK"
	+ intercalate(" | GlueK", csd)
	+ ";\n\n"
	+ // HACK!
	replaceAll(replaceAll(
	grammarlab::export::RascalSyntax::mapProds(G2.P, G2.S)
	,"(",""),")","")
	);
	// Generate grammarlab::language::glue::implode::SLEIR
	writeFile(|project://grammarlab/src/grammarlab/language/glue/implode/SLEIR.rsc|,
	"@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
	'@contributor{Generated by meta::Glue, do not edit manually!}
	'module grammarlab::language::glue::implode::SLEIR
	'
	'import grammarlab::language::glue::abstract::Top;
	'import grammarlab::language::glue::concrete::BGF;
	'import grammarlab::language::glue::concrete::XBGF;
	'import grammarlab::language::glue::concrete::SLEIR;
	'import grammarlab::language::Grammar;
	'import grammarlab::language::SLEIR;\n\n"
	+intercalate("\n",["GLUEA glimplode((GlueCommand)`<tofishnotation(cs[c],rhss["GlueK<c>"])>`) = sleir(<c>(<allmarks(cs[c])>));" | c <- csd])
	);
	// Extraction
	// TODO WTF
	// G = rscd2bgf(|project://grammarlab/src/grammarlab/language/glue/abstract/Top.rsc|);
	// ls = [s | production("GExternalType",choice(L)) <- G.P, label(s) <- L];
	// writeFile(|project://grammarlab/src/grammarlab/language/glue/Extraction.rsc|,
	// "@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
	// '@contributor{Generated by meta::Glue, do not edit manually!}
	// 'module grammarlab::language::glue::Extraction\n
	// 'import grammarlab::language::glue::abstract::Top;
	// 'import grammarlab::language::Extractors;
	// 'import grammarlab::language::Grammar;\n\n"+
	// intercalate("\n",["public GGrammar execute(GGrammar g, glaction(extract(<l>(), loc z))) = <l>2bgf(z);" | production("GExternalType",choice(L)) <- G.P, label(l) <- L])
	// );
	// GET language from available extractors:
	G = rscf2bgf(|project://grammarlab/src/grammarlab/Extractors.rsc|);
	lines = readFileLines(|project://grammarlab/src/grammarlab/Extractors.rsc|);
	extractors = [replaceAll("<l>","2bgf","") | production("GGrammar",label(str l,_)) <- G.P];
	map[str,str] m = ();
	for (line <- lines, ext <- extractors)
		if (findFirst(line,"<ext>2bgf")>0)
			m[ext] = replaceAll(split("::",line)[-2],"2BGF","");
	writeFile(|project://grammarlab/src/grammarlab/language/GET.rsc|,
	"@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
	'@contributor{Generated by meta::Glue, do not edit manually!}
	'module grammarlab::language::GET
	'
	'data GExternalType
	'	= GET" + intercalate("()\n\t| GET",extractors)+
	"()\n\t;\n");
	writeFile(|project://grammarlab/src/grammarlab/language/glue/concrete/GET.rsc|,
	"@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
	'@contributor{Generated by meta::Glue, do not edit manually!}
	'module grammarlab::language::glue::concrete::GET\n\n"+
	intercalate("\n",["lexical GlueKT<ext> = @category=\"MetaVariable\" \"<m[ext]>\";" | ext <- domain(m)])+
	"\n\nlexical GlueKSource = "+
	intercalate(" | ",["GlueKT<ext>" | ext <- domain(m)])+
	";\nkeyword GlueKw = GlueKSource;");
	writeFile(|project://grammarlab/src/grammarlab/language/glue/implode/GET.rsc|,
	"@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
	'@contributor{Generated by meta::Glue, do not edit manually!}
	'module grammarlab::language::glue::implode::GET
	'
	'import grammarlab::language::GET;
	'import grammarlab::language::glue::abstract::Top;
	'import grammarlab::language::glue::concrete::BGF;
	'import grammarlab::language::glue::concrete::GET;
	'import grammarlab::language::glue::concrete::Actions;
	'import IO;
	'
	'loc toLocation(str s) = (/\\|\<car:.*\>\\:\\/\\/\<cdr:.*\>\\|/ := s) ? |\<car\>://\<cdr\>| : |cwd:///\<s\>|;
	'
	'GLUEA glimplode((GlueCommand)`\<GlueKextract _\>\<GlueKSource t\>\<GlueLoc s\>.`)
	'	= glaction(extract(mapSrc(t),toLocation(\"\<s\>\")));
	'GLUEA glimplode((GlueCommand)`\<GlueKexport _\>\<GlueKSource t\>\<GlueLoc s\>.`)
	'	= glaction(export(mapSrc(t),toLocation(\"\<s\>\"),\"Unknown\"));\n\n"+
	// TODO: put the grammar name to exporters
	intercalate("\n",["GExternalType mapSrc((GlueKSource)`\<GlueKT<ext> _\>`) = GET<ext>();" | ext <- domain(m)])+
	"\ndefault GExternalType mapSrc(GlueKSource src)
	'{
	'	println(\"External grammar type unknown to GrammarLab: \<src\>\");
	'	return GETbgf();
	'}
	"
	);
}

str tofishnotation(GExpr e1, GExprList l1)
{
	str buf = "";
	for (GExpr e <- l1)
		if (nonterminal(n) := e)
			buf += "\<<n> _\> ";
		elseif (mark(m,nonterminal(n)) := e)
			buf += "\<<n> <m>\> ";
		elseif (mark(m,plus(nonterminal(n))) := e)
			buf += "\<<n>+ <m>\> ";
		elseif (terminal(t) := e)
			buf += "<t> ";
		else
			println("UNMATCHED <e>");
	return trim(buf);
	return "<e1>&<l1>";
}

str concretenotation(GExpr e) = intercalate(" ",["\<<m>\>:<convertGType(s)>" | sequence(L) := e, mark(m,s) <- L]);
str fishnotation(GExpr e) = intercalate(" ",["\<<convertGType(s)> <n>\>" | sequence(L) := e, mark(n,s) <- L]);
str allmarks(GExpr e) = intercalate(",",[convertor(convertGType(s),n) | sequence(L) := e, mark(n,s) <- L]);

str convertor("GlueString", str name) = "\"\<<name>\>\"";
str convertor("GlueNonterminal", str name) = "\"\<<name>.name\>\"";
str convertor("(GlueNonterminal+)", str name) = "[\"\<each.name\>\" | each \<- <name>]";
str convertor("GlueTerminal", str name) = "\"\<<name>.name\>\"";
str convertor("(GlueTerminal+)", str name) = "[\"\<each.name\>\" | each \<- <name>]";
str convertor("GlueLabel", str name) = "\"\<<name>\>\"";
str convertor("GlueMark", str name) = "\"\<<name>\>\"";
str convertor("GlueString+", str name) = "[\"\<each\>\" | each \<- <name>]";
str convertor("GlueInteger", str name) = "toInt(\"\<<name>\>\")";
str convertor("GlueBoolean", str name) = "fromString(\"\<<name>\>\")";
str convertor("GlueProduction", str name) = "mapP(<name>)";
str convertor("(GlueProduction+)", str name) = "mapPs(<name>)";
str convertor("GlueSymbol", str name) = "mapS(<name>)";
str convertor("GlueScope", str name) = "mapScope(<name>)";
default str convertor(str gltype, str name) = "???(<gltype>,<name>)";

str convertGType(val(string())) = "GlueString";
str convertGType(val(integer())) = "GlueInteger";
str convertGType(val(boolean())) = "GlueBoolean";
str convertGType(nonterminal("GProd")) = "GlueProduction";
str convertGType(nonterminal("GProdList")) = "(GlueProduction+)";
str convertGType(nonterminal("GExpr")) = "GlueSymbol";
str convertGType(nonterminal("GNonTerm")) = "GlueNonterminal";
str convertGType(nonterminal("GTerm")) = "GlueTerminal";
str convertGType(nonterminal("GLabel")) = "GlueLabel";
str convertGType(nonterminal("GMark")) = "GlueMark";
str convertGType(nonterminal("XScope")) = "GlueScope";
str convertGType(star(GExpr e)) = "(<convertGType(e)>+)";
default str convertGType(GExpr e)
{
	println("Could not convert type <e>");
	return "value";
}

