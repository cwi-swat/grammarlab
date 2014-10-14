@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module grammarlab::extract::ANTLR4

import grammarlab::language::Grammar;
import grammarlab::io::Grammar;
import grammarlab::lib::Squeeze;
import grammarlab::lib::Sizes;
import IO;
import vis::ParseTree;

start syntax ANTLR4Grammar = //DOC_COMMENT?
		GrammarType Id name ";"
		PrequelConstruct*
		RuleSpec* rs
		ModeSpec* ;
syntax GrammarType = ("lexer" | "parser")? "grammar";
lexical Id = [a-zA-Z_01-9]+ !>> [a-zA-Z_01-9];
syntax PrequelConstruct = OptionsSpec
	|	DelegateGrammars
	|	TokensSpec
	|	Action
	;
syntax OptionsSpec = "options" "{" (Option ";")* "}";
syntax Option = Id "=" OptionValue;
syntax OptionValue = Id ("." Id)*
	|	STRING_LITERAL
	|	ACTION
	|	INT
	;

lexical STRING_LITERAL = [\'] (ESC_SEQ | ![\'\r\n\\])* [\'];
lexical ESC_SEQ = [\\][btnfru\"\'\\];
lexical ACTION = [{] ACTIONEL* [}];
lexical ACTIONEL = ![}] | ACTION;
lexical INT = [0-9]+ !>> [0-9];

syntax DelegateGrammars = "import" {DelegateGrammar ","}+ ";" ;
syntax DelegateGrammar = Id ("=" Id)?;

lexical BLOCK_COMMENT = [/][*] BCEL* [*][/];
lexical BCEL = ![*] | [*] !>> [/];
lexical LINE_COMMENT = [/][/] ![\n]* [\n];
lexical LAYOUT = [\t-\n \r \  ] | LINE_COMMENT | BLOCK_COMMENT ;
layout ANTLR4Layout = LAYOUT* !>> [\t-\n \r \  ] !>> "//" !>> "/*";

syntax TokensSpec = "tokens" "{" {Id ","}+ "}";
syntax Action = "@" (Id "::")? Id ACTION;
//syntax ActionScopeName = Id ;//| "lexer" | "parser";
syntax ModeSpec = "mode" Id ";" LexerRule*;
syntax RuleSpec = ParserRuleSpec | LexerRule;
syntax LexerRule = "fragment"? Id ":" {LexerAlt "|"}+ ";" ;
syntax LexerAlt = LexerElement+ LexerCommands?;
syntax LexerElement = LabeledLexerElement EbnfSuffix?
	|	LexerAtom EbnfSuffix?
	|	LexerBlock EbnfSuffix?
	|	ACTION "?"?
	;
syntax LexerBlock = "(" {LexerAlt "|"}+ ")";
syntax LabeledLexerElement = Id ("=" | "+=") (LexerAtom | Block);
syntax LexerAtom = Range
	|	(Id | STRING_LITERAL) ElementOptions?
	//| Id ARG_ACTION? ElementOptions?
	| "~" (SetElement | BlockSet)
	| LEXER_CHAR_SET
	| "." ElementOptions?
	;
lexical LEXER_CHAR_SET = [\[] LCCHAR* [\]];
lexical LCCHAR = ![\\\]] | [\\] ![];
//[\]\[a-zA-Z\"\'\\\-];
//: ~[\r\n\u2028\u2029\]\\]
//~[\r\n\u2028\u2029*\\/\[]

syntax ParserRuleSpec = RuleModifier* Id ARG_ACTION?
        RuleReturns? ThrowsSpec? LocalsSpec?
		RulePrequel*
		":" RuleBlock LexerCommands? // lexerCommands is not here in the original
		";" ExceptionGroup;
syntax RuleModifier = "public" | "private" | "protected" | "fragment";
syntax RuleReturns = "returns" ARG_ACTION;
syntax ThrowsSpec = "throws" {Id ","}+;
syntax LocalsSpec = "locals" ARG_ACTION	;
syntax RulePrequel = OptionsSpec | RuleAction;
syntax ExceptionGroup = ("catch" ARG_ACTION ACTION)* ("finally" ACTION)?;
syntax RuleBlock = {LabeledAlt "|"}+ ;
syntax LabeledAlt = Alternative ("#" Id)?;
syntax Alternative = ElementOptions? Element*;
syntax ElementOptions = "\<" {ElementOption ","}+ "\>";
syntax Element
	= LabeledElement EbnfSuffix?
	| Atom EbnfSuffix?
	| Ebnf
	| ACTION "?"?
	;
syntax ElementOption = Id ("=" (Id | STRING_LITERAL))?;
syntax LabeledElement = Id ("=" | "+=") (Atom | Block);
syntax Ebnf = Block EbnfSuffix?;
syntax EbnfSuffix = ("?" | "*" | "+") "?"?;
syntax RuleAction = "@" Id ACTION;

syntax Atom
	= Range
	| (Id | STRING_LITERAL) ElementOptions?
	| Id ARG_ACTION? ElementOptions?
	| "~" (SetElement | BlockSet)
	| "." ElementOptions?
	;
syntax Range = STRING_LITERAL ".." STRING_LITERAL;
syntax SetElement = Id ElementOptions?
	|	STRING_LITERAL ElementOptions?
	|	Range
	|	LEXER_CHAR_SET;
syntax Block = "(" ( OptionsSpec? RuleAction* ":" )? AltList ")";
syntax AltList = {Alternative "|"}+;
syntax BlockSet = "(" {SetElement "|"}+ ")";

// E.g., channel(HIDDEN), skip, more, mode(INSIDE), push(INSIDE), pop
syntax LexerCommands = "-\>" {LexerCommand ","}+;
syntax LexerCommand = (Id | "mode") ( "(" (Id | INT) ")" )?;

// [int x, List<String> a[]]
lexical ARG_ACTION = BOXEDISLAND; 
lexical BOXEDISLAND = [\[] AACHAR* [\]];
lexical AACHAR = ![\[\]] | ARG_ACTION;

GGrammar extractG(loc z)
{
	ANTLR4Grammar t = parse(#start[ANTLR4Grammar],z).top;
	println("Extracting <z>...");
	//println(t);
	renderParsetree(t);
	//visit(t)
	//{
	//	case RuleSpec r: println(r);
	//}
	//rs = {r | /RuleSpec r := t};
	//return g2g([r | /RuleSpec r := t]);
	return grammar([],[],[]);
}

//GGrammar g2g((ANTLR4Grammar)`<GrammarType _><Id name>;<PrequelConstruct* _><RuleSpec* rs><ModeSpec* _>`)
//GGrammar g2g(ANTLR4Grammar g)
GGrammar g2g(list[RuleSpec] rs)
{
	//ps = [*rule2prods(rules[s]) | s <- rules, sort(_) := s];
	println("Extracting from <len(rs)> rules...");
	ps = [p2p(r) | RuleSpec r <- rs];
	return grammarlab::language::Grammar::grammar(squeeze([p.lhs | p <- ps]), ps, []);
}

GProd p2p(RuleSpec r) = production("?",epsilon());

test bool a4g01() {GGrammar g = extractG(|home:///projects/webzoo-prep/zoo/_a4_/icalendar/fetched/ICalendar.g4|);return /amb(_) !:= g;}
test bool a4g02() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/_a4_/icalendar/fetched/ICalendar.g4|);return /amb(_) !:= g;}
test bool a4g03() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/_a4_/idl/fetched/IDL.g4|);return /amb(_) !:= g;}
test bool a4g04() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/_a4_/iri/fetched/IRI.g4|);return /amb(_) !:= g;}
test bool a4g05() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/_a4_/java/fetched/Java.g4|);return /amb(_) !:= g;}
test bool a4g06() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/_a4_/java8/fetched/Java8.g4|);return /amb(_) !:= g;}
test bool a4g07() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/_a4_/lua/fetched/Lua.g4|);return /amb(_) !:= g;}
test bool a4g08() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/_a4_/pcre/fetched/PCRE.g4|);return /amb(_) !:= g;}
test bool a4g09() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/_a4_/pgn/fetched/PGN.g4|);return /amb(_) !:= g;}
test bool a4g10() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/_a4_/r/fetched/R.g4|);return /amb(_) !:= g;}
test bool a4g11() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/_a4_/r/fetched/RFilter.g4|);return /amb(_) !:= g;}
test bool a4g12() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/_a4_/redcode/fetched/redcode.g4|);return /amb(_) !:= g;}
test bool a4g13() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/_a4_/scala/fetched/scala.g4|);return /amb(_) !:= g;}
test bool a4g14() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/_a4_/scss/fetched/ScssLexer.g4|);return /amb(_) !:= g;}
test bool a4g15() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/_a4_/scss/fetched/ScssParser.g4|);return /amb(_) !:= g;}
test bool a4g16() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/_a4_/sqlite/fetched/SQLite.g4|);return /amb(_) !:= g;}
test bool a4g17() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/_a4_/swift/fetched/Swift.g4|);return /amb(_) !:= g;}
test bool a4g18() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/_a4_/tnsnames/fetched/tnsnames.g4|);return /amb(_) !:= g;}
test bool a4g19() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/_a4_/tnt/fetched/tnt.g4|);return /amb(_) !:= g;}
test bool a4g20() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/_a4_/turtle/fetched/TURTLE.g4|);return /amb(_) !:= g;}
test bool a4g21() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/_a4_/webidl/fetched/WebIDL.g4|);return /amb(_) !:= g;}
test bool a4g22() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/assembly/6502/fetched/asm6502.g4|);return /amb(_) !:= g;}
test bool a4g23() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/basic/jvm/fetched/jvmBasic.g4|);return /amb(_) !:= g;}
test bool a4g24() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/c/c11/harwell/fetched/C.g4|);return /amb(_) !:= g;}
test bool a4g25() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/clojure/parr/fetched/Clojure.g4|);return /amb(_) !:= g;}
test bool a4g26() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/erlang/parr/fetched/Erlang.g4|);return /amb(_) !:= g;}
test bool a4g27() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/hardware/verilog/2001-parr/fetched/Verilog2001.g4|);return /amb(_) !:= g;}
test bool a4g28() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/html/everett/fetched/HTMLLexer.g4|);return /amb(_) !:= g;}
test bool a4g29() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/html/everett/fetched/HTMLParser.g4|);return /amb(_) !:= g;}
test bool a4g30() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/js/kiers/fetched/ECMAScript.g4|);return /amb(_) !:= g;}
test bool a4g31() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/js/kiers-vitorelli/fetched/ECMAScript.CSharpTarget.g4|);return /amb(_) !:= g;}
test bool a4g32() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/logo/everett/fetched/logo.g4|);return /amb(_) !:= g;}
test bool a4g33() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/logo/kiers/fetched/UCBLogo.g4|);return /amb(_) !:= g;}
test bool a4g34() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/markup/graphical/dot/parr/fetched/DOT.g4|);return /amb(_) !:= g;}
test bool a4g35() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/markup/scientific/fasta/everett/fetched/fasta.g4|);return /amb(_) !:= g;}
test bool a4g36() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/markup/scientific/gff/everett/fetched/gff3.g4|);return /amb(_) !:= g;}
test bool a4g37() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/markup/textual/csv/parr/fetched/CSV.g4|);return /amb(_) !:= g;}
test bool a4g38() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/markup/textual/json/concrete/parr/fetched/JSON.g4|);return /amb(_) !:= g;}
test bool a4g39() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/markup/textual/wiki/creole/everett/fetched/creole.g4|);return /amb(_) !:= g;}
test bool a4g40() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/meta/syntax/abnf/fetched/Abnf.g4|);return /amb(_) !:= g;}
test bool a4g41() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/meta/syntax/antlr/antlr4/parr-harwell/fetched/ANTLRv4Lexer.g4|);return /amb(_) !:= g;}
test bool a4g42() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/meta/syntax/antlr/antlr4/parr-harwell/fetched/ANTLRv4Parser.g4|);return /amb(_) !:= g;}
test bool a4g43() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/meta/syntax/bnf/everett/fetched/bnf.g4|);return /amb(_) !:= g;}
test bool a4g44() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/objective-c/cuche-parr-mejia/fetched/ObjC.g4|);return /amb(_) !:= g;}
test bool a4g45() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/python/v3.x/v3.3.5/parr/fetched/Python3.g4|);return /amb(_) !:= g;}
test bool a4g46() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/smalltalk/redline/fetched/Smalltalk.g4|);return /amb(_) !:= g;}
test bool a4g47() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/xmlware/xml/parr/fetched/XMLLexer.g4|);return /amb(_) !:= g;}
test bool a4g48() {GGrammar g = extractG(|home:///projects/webzoo-prep//zoo/xmlware/xml/parr/fetched/XMLParser.g4|);return /amb(_) !:= g;}
