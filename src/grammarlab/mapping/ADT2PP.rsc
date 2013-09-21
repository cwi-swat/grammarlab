@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
@doc{This tool takes an Abstract Data Type defined in Rascal, and generates a minimal
pretty-printer for it, relying on pattern-driven dispatch and the presence of pp() functions
for all inner types}
module grammarlab::mapping::ADT2PP

import grammarlab::lib::RascalPlus;
import IO;
import grammarlab::language::Grammar;
import grammarlab::extract::RascalADT2BGF;

public void main(list[str] args) = main(|cwd:///|+args[0], |cwd:///|+args[1]);

public void main(loc rsc1, loc rsc2)
{
	GGrammar g = grammarlab::extract::RascalADT2BGF::extractG(rsc1);
	writeFile(rsc2,
	"@contributor{ADT2PP}
	'module PrettyPrinter // feel free to change that after moving the file
	'
	'// put relevant imports here: ADT definitions and all necessary pp() functions!
	'<for (production(str n, choice(rhs)) <- g.P){><for (label(s,e) <- rhs){>
	'public str ppx(<n>::<s>(<showargs(e)>)) = \"<s>(<showppd(e)>)\";<}>
	'public default str ppx(<n> smth) = \"??\<smth\>??\";
	'<}>
	'");
}

str showargs(epsilon()) = "";
str showargs(mark(s,e)) = "<showtype(e)> <s>";
str showargs(sequence(es)) = mapjoin(showargs,es,", ");
default str showargs(GExpr e) = "<e>";

str showppd(epsilon()) = "";
str showppd(mark(s,val(e))) = "\<<s>\>";
str showppd(mark(s,e)) = "\<pp(<s>)\>";
str showppd(sequence(es)) = mapjoin(showppd,es,",");
default str showppd(GExpr e) = "<e>";

str showtype(val(string())) = "str";
str showtype(val(integer())) = "int";
str showtype(star(e)) = "list[<showtype(e)>]";
str showtype(plus(e)) = "list[<showtype(e)>]";
str showtype(nonterminal(n)) = "<n>";
default str showtype(e) = ""; // silence is gold

public void tst2() = main(
	|project://grammarlab/src/grammarlab/language/X.rsc|,
	|project://grammarlab/src/grammarlab/export/XBNF2.rsc|
);

public void tst3() = main(
	|project://grammarlab/src/grammarlab/language/Grammar.rsc|,
	|project://grammarlab/src/grammarlab/export/GrammarLab2.rsc|
);
