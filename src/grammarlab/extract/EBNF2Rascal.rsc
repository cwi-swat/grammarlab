@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::extract::EBNF2Rascal

import grammarlab::language::EBNF;
import IO;
import String;

// list[&T] slice(list[&T] lst, int start, int len)
list[&T] sliceFromTo(list[&T] lst, int s, int e) = slice(lst,s,e-s);

map[str,str] quotedEscapes = ("\"" : "\\\"", "\n": "\\n");
map[str,str] charClassEscapes = ("\"" : "\\\"","-" : "\\-", "\\" : "\\\\");

public void main(list[str] args)
{
	// loc src = |cwd:///|+args[0];
	// println("Loading the EDD from <src>...");
	// map[str,str] edd = loadEDD(src);
	// loc rsc = |cwd:///|+(args[1]+".rsc");
	// println("Writing Rascal code to <rsc>...");
	// writeFile(rsc,EDD2Rascal(edd,args[1]));
	// // possible future work: ignored lines?
	// println("Done.");
	println(EDD2Rascal(PicoEBNF,"Pico"));
}

str EDD2Rascal(EBNF edd, str name)
{
	str prep = "module <name>
	'import util::IDE; // needed only for advanced IDE support (see last two lines)
	'start syntax <name>Grammar = <name>LayoutList <name>Production* <name>LayoutList;
	'syntax <name>Production = <name>Nonterminal <quoted(edd,defining_symbol())> {<name>Definition <quoted(edd,definition_separator_symbol())>}+ <quoted(edd,terminator_symbol())>;
	'";
	if (concatenate_symbol() in edd && trim(getMeta(concatenate_symbol(),edd))!="")
		prep += "syntax <name>Definition = {<name>Symbol <quoted(edd,concatenate_symbol())>}+;";
	else
		prep += "syntax <name>Definition = <name>Symbol+;";
	prep +=	"
	'syntax <name>Symbol
 	' = @category=\"Identifier\" nonterminal: <name>Nonterminal
 	' | @category=\"Constant\" terminal: <name>Terminal";
	if (start_group_symbol() in edd && end_group_symbol() in edd)
		if (definition_separator_symbol() in edd)
			prep += "\n | group: <quoted(edd,start_group_symbol())> {<name>Definition <quoted(edd,disjunction_symbol())>}+ <quoted(edd,end_group_symbol())>";
		else
 			prep += "\n | group: <quoted(edd,start_group_symbol())> <name>Definition <quoted(edd,end_group_symbol())>";
	if (postfix_option_symbol() in edd)
 		prep += "\n | optional: <name>Symbol <quoted(edd,postfix_option_symbol())>";
	if (postfix_repetition_star_symbol() in edd)
 		prep += "\n | star: <name>Symbol <quoted(edd,postfix_repetition_star_symbol())>";
	if (postfix_repetition_plus_symbol() in edd)
 		prep += "\n | plus: <name>Symbol <quoted(edd,postfix_repetition_plus_symbol())>";
	if (start_seplist_star_symbol() in edd && end_seplist_star_symbol() in edd)
 		prep += "\n | sepliststar: <quoted(edd,start_seplist_star_symbol())> <name>Symbol <name>Symbol <quoted(edd,end_seplist_star_symbol())>";
	if (start_seplist_plus_symbol() in edd && end_seplist_plus_symbol() in edd)
 		prep += "\n | seplistplus: <quoted(edd,start_seplist_plus_symbol())> <name>Symbol <name>Symbol <quoted(edd,end_seplist_plus_symbol())>";
 	prep += ";"; // end of <name>Symbol
	if (start_terminal_symbol() in edd && end_terminal_symbol() in edd)
 		prep += "\nlexical <name>Terminal = <quoted(edd,start_terminal_symbol())> <name>TerminalSymbols <quoted(edd,end_terminal_symbol())>;
 		'lexical <name>TerminalSymbols = ![<inlex(edd,end_terminal_symbol())>]* !\>\> ![<inlex(edd,end_terminal_symbol())>];";
 	else
 		prep += "\nlexical <name>Terminal = ![ \\t-\\n]* !\>\> ![ \\t-\\n];";
	prep += "\nlexical <name>Nonterminal = <quoted(edd,start_nonterminal_symbol())> <name>NonterminalSymbols <quoted(edd,end_nonterminal_symbol())>;";
	if (start_nonterminal_symbol() in edd && end_nonterminal_symbol() in edd)
 		prep += "\nlexical <name>NonterminalSymbols = ![<inlex(edd,end_nonterminal_symbol())>]+ !\>\> ![<inlex(edd,end_nonterminal_symbol())>];";
 	else
 		prep += "\nlexical <name>NonterminalSymbols = [A-Za-z_01-9<inlex(edd,nonterminals_may_contain())>]+ !\>\> [A-Za-z_01-9<inlex(edd,nonterminals_may_contain())>];";

	prep += "\nlayout <name>LayoutList = <name>Layout* !\>\> [\\t-\\n \\r \\ ]";
	bool comment = false;
	if (start_comment_symbol() in edd)
	{
		prep += " !\>\> <quoted(edd,start_comment_symbol())>";
		comment = true;
	}
	// if ("start-multiline-comment-symbol" in edd && "end-multiline-comment-symbol" in edd)
	// {
	// 	prep += "!\>\> <quoted(edd,"start-multiline-comment-symbol")>";
	// 	comment = true;
	// }
	prep += ";\nlexical <name>Layout = [\\t-\\n \\r \\ ]";
	if (comment)
	{
		prep += " | <name>Comment ;\nlexical <name>Comment = @category=\"Comment\" ";
		if (start_comment_symbol() in edd)
		// if ("start-one-line-comment-symbol" in edd)
			prep += quoted(edd,start_comment_symbol()) + " ![\\n]* [\\n]";
		// TODO: make it so later, too complicated for now
		// if ("start-one-line-comment-symbol" in edd && "start-multiline-comment-symbol" in edd)
		// 	prep += "\n| @category=\"Comment\" ";
		// if ("start-multiline-comment-symbol" in edd && "end-multiline-comment-symbol" in edd)
		// 	// @category="Comment" "/*" (![*] | [*] !>> [/])* "*/"
		// 	prep += quoted(edd,"start-multiline-comment-symbol") + multilineCommentElement(edd["end-multiline-comment-symbol"]) + quoted(edd,"end-multiline-comment-symbol");
	}
	prep += ";\n"; 
	// the following is not necessary, but nice to have
	prep += "
	'Tree get<name>(str s,loc z) = parse(#<name>Grammar,z);
	'public void register<name>() = registerLanguage(\"<name>\",\"<toLowerCase(name)>\",get<name>);";
	return prep;
}

str multilineCommentElement(str end)
{
	if (size(end)==1)
	{
		// one letter end metasymbol
		return "![" + escape(end,charClassEscapes) + "]*";
	}
	elseif (size(end)==2)
	{
		// two letter end metasymbol
		str first = "[" + escape(end[0],charClassEscapes) + "]";
		str second = "[" + escape(end[1],charClassEscapes) + "]";
		return "(!<first> | <first> !\>\> <second>)*";
	}
	elseif (size(end)==3)
	{
		// three letter end metasymbol
		str first = "[" + escape(end[0],charClassEscapes) + "]";
		str second = "[" + escape(end[1],charClassEscapes) + "]";
		str third = "[" + escape(end[1],charClassEscapes) + "]";
		return "(!<first> | <first> !\>\> <second> | <first> <second> !\>\> <third>)*";
	}
	else
		// give up
		return "NOT YET IMPLEMENTED";
}

map[str,str] makeCompleteEDDof(map[str,str] edd)
{
	map[str,str] r = ();
	for (key <- edd)
		if (key == "nonterminals-may-contain")
			r[key] = escape(edd[key],charClassEscapes);
		else
			r[key] = "\"" + escape(edd[key],charClassEscapes) + "\"";
	for (key <- hunter::Hunter::empty_edd)
		r[key] ?= "";
	return r;
}

str quoted(EBNF ebnf, Metasymbol ms) = ms in ebnf? "\"" + trim(escape(ebnf[ms],quotedEscapes)) + "\"" : "";
str inlex(EBNF ebnf, Metasymbol ms) = ms in ebnf? escape(ebnf[ms],charClassEscapes) : "";

str quoted(map[str,str] m, str k) = k in m? "\"" + escape(m[k],quotedEscapes) + "\"" : "";
str inlex(map[str,str] m, str k) = k in m? escape(m[k],charClassEscapes) : "";

// str mayContain(EBNF enbf)
// 	= /nonterminals_may_contain(str x) := ebnf
// 	? escape(x,charClassEscapes)
// 	: "";
