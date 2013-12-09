@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::extract::RascalSyntax2BGF

import lang::rascal::\syntax::Rascal;
import lang::rascal::grammar::definition::Modules;
import grammarlab::io::Grammar;
import grammarlab::language::Grammar;
import grammarlab::transform::Normal;
import grammarlab::extract::rascal::Grammar;
import grammarlab::extract::rascal::Name;

import grammarlab::export::Grammar;
import ParseTree;
import String;

import IO;

GGrammar extractG(loc z) = extractG(readFile(z)); 

GGrammar extractG(str s)
{
	str name = trim(grammarlab::extract::rascal::Name::module2name(s));
	println("Extracting <name>...");
	GGrammar G = normalise(grammarlab::extract::rascal::Grammar::grammar2grammar(modules2grammar(name,{parse(#start[Module],s).top})));
	println("Extraction completed.");
	return G;
}

public void main(list[str] args) = writeBGF(extractG(|cwd:///|+args[0]),|cwd:///|+args[1]);

public void main(loc z) = println(ppx(extractG(z)));

test bool flc() {main(|home:///projects/slps/topics/fl/rascal/src/Concrete.rsc|);return true;}
test bool glue1() {main(|project://grammarlab/src/grammarlab/language/GLUE.rsc|);return true;}
test bool glue2() {main(|project://grammarlab/src/grammarlab/language/glue/Productions.rsc|);return true;}
test bool glue3() {main(|project://grammarlab/src/grammarlab/language/glue/Transformations.rsc|);return true;}
test bool glue4() {main(|project://grammarlab/src/grammarlab/language/glue/Mutations.rsc|);return true;}
