@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
@contributor{Generated by meta::Glue, do not edit manually!}
module grammarlab::language::glue::Productions
// import util::IDE; // needed only for advanced IDE support
import String; import IO;
import grammarlab::language::Grammar;
import grammarlab::io::Grammar;
import grammarlab::lib::Sizes;
start syntax GlueGrammar = GlueProduction*;
syntax GlueProduction = GlueNonterminal "::=" {GlueDefinition "|"}+ ";";
syntax GlueDefinition = {GlueSequence "&"}+;
syntax GlueSequence = GlueSymbol+;
syntax GlueSymbol
 = nonterminal: GlueNonterminal
 | terminal: GlueTerminal
 | labelled: "[" GlueLabel "]::" GlueSymbol
 | marked: "\<" GlueMark "\>:" GlueSymbol
 | group: "(" {GlueDefinition "|"}+ ")"
 | negation: "¬" GlueSymbol 
 | optional: GlueSymbol "?"
 | star: GlueSymbol "*"
 | plus: GlueSymbol "+"
 | sepliststar: "{" GlueSymbol GlueSymbol "}*"
 | seplistplus: "{" GlueSymbol GlueSymbol "}+"
 | @category="MetaSkipped" nothing: "φ"
 | @category="MetaSkipped" emptystring: "ε"
 | @category="MetaSkipped" everything: "α";
lexical GlueTerminal = @category="Constant" "\"" GlueTerminalSymbols name "\"";
lexical GlueTerminalSymbols = ![\"]* !>> ![\"];
lexical GlueNonterminal = @category="Identifier"  GlueNonterminalSymbols name ;
lexical GlueLabel = @category="NonterminalLabel" ![\]]+ >> [\]];
lexical GlueMark = @category="NonterminalLabel" ![\>]* >> [\>];
lexical GlueNonterminalSymbols = [A-Za-z_01-9⟙_\-/]+ !>> [A-Za-z_01-9⟙_\-/];
layout GlueLayoutList = GlueLayout* !>> [\t-\n \r \  ] !>> "//";
lexical GlueLayout = [\t-\n \r \  ] | GlueComment ;
lexical GlueComment = @category="Comment" "//" ![\n]* [\n];

//Tree getGlue(str s,loc z) = parse(#GlueGrammar,z);
//public void registerGlue() = registerLanguage("Glue","glue",getGlue);

Tree parseGlue(loc z) = parse(#GlueGrammar, trim(readFile(z)));
GGrammar mapG((GlueGrammar)`<GlueProduction* ps>`)
{
	GProdList ps2 = []; list[str] nts = [];
	for(p <- ps){p2 = mapP(p); if(p.lhs notin nts)nts+=p.lhs; ps2+=p2;}
	return grammar(nts, [], ps2);
}
GProdList mapPs(GlueProduction+ ps) = [mapP(p) | p <- ps];
GProd mapP((GlueProduction)`<GlueNonterminal lhs>::=<{GlueDefinition "|"}+ rhds>;`) = production("<lhs>",mapDs(rhds));
GExpr mapDs({GlueDefinition "|"}+ ds)
{
	GExprList es = [mapD(d) | GlueDefinition d <- ds];
	return (len(es)==1) ? es[0] : choice(es);
}
GExpr mapS((GlueSymbol)`<GlueNonterminal n>`) = nonterminal("<n.name >");
GExpr mapS((GlueSymbol)`<GlueTerminal t>`) = terminal("<t.name>");
GExpr mapS((GlueSymbol)`(<{GlueDefinition "|"}+ ds>)`) = mapIDs(ds);GExpr mapS((GlueSymbol)`¬<GlueSymbol smb>`) = not(mapS(smb));
GExpr mapS((GlueSymbol)`<GlueSymbol smb>?`) = optional(mapS(smb));
GExpr mapS((GlueSymbol)`<GlueSymbol smb>*`) = star(mapS(smb));
GExpr mapS((GlueSymbol)`<GlueSymbol smb>+`) = plus(mapS(smb));
GExpr mapS((GlueSymbol)`{<GlueSymbol smb1><GlueSymbol smb2>}*`) = sepliststar(mapS(smb1),mapS(smb2));
GExpr mapS((GlueSymbol)`{<GlueSymbol smb1><GlueSymbol smb2>}+`) = seplistplus(mapS(smb1),mapS(smb2));
GExpr mapS((GlueSymbol)`φ`) = empty();
GExpr mapS((GlueSymbol)`ε`) = epsilon();
GExpr mapS((GlueSymbol)`α`) = anything();
GExpr mapS((GlueSymbol)`[ <GlueLabel l> ]:: <GlueSymbol smb>`) = label("<l>",mapS(smb));
GExpr mapS((GlueSymbol)`\< <GlueMark m> \>: <GlueSymbol smb>`) = mark("<m>",mapS(smb));
default GExpr mapS(GlueSymbol smb) {println("Cannot map symbol <smb>!");return empty();}

GExpr mapIDs({GlueDefinition "|"}+ ds)
{
	GExprList es = [mapD(d) | GlueDefinition d <- ds];
	return (len(es)==1) ? es[0] : choice(es);
}
GExpr mapD((GlueDefinition)`<{GlueSequence "&"}+ ds>`)
{
	GExprList es = [mapE(d) | GlueSequence d <- ds];
	return (len(es)==1) ? es[0] : allof(es);
}
GExpr mapE((GlueSequence)`<GlueSymbol s>`) = mapS(s);
default GExpr mapE((GlueSequence)`<GlueSymbol+ ss>`) = sequence([mapS(s) | GlueSymbol s <- ss]);
public void main(list[str] args)
	= (len(args)==2)
	? writeBGF(mapG(parse(#GlueGrammar, trim(readFile(|cwd:///|+args[0])))), |cwd:///|+args[1])
	: println("Please provide two arguments: input and output.");
