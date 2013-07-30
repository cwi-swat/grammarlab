@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::extract::RascalSyntax2BGF

import lang::rascal::\syntax::Rascal;
import lang::rascal::grammar::definition::Modules;
import grammarlab::io::Grammar;
import grammarlab::language::Grammar;
import grammarlab::transform::Normal;
import grammarlab::extract::RascalGrammar;

//import grammarlab::export::BNF;
import ParseTree;
import String;

import IO;

GGrammar extractG(loc z) = extractG(readFile(z)); 

GGrammar extractG(str z)
{
	str gs = trim(z);
	str name = replaceAll(split("\n",split("module ",gs)[1])[0],"\\","");
	println("Extracting <name>...");
	GGrammar G = normalise(grammarlab::extract::RascalGrammar::grammar2grammar(modules2grammar(name,{parse(#Module,gs)})));
	println("Extraction completed.");
	return G;
}

public void main(list[str] args) = writeBGF(extractG(|cwd:///|+args[0]),|cwd:///|+args[1]);

public void main() = main(|project://fl/src/Concrete.rsc|);

public void main(loc z) = println(pp(extractG(z)));

