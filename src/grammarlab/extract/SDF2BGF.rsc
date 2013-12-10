@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::extract::SDF2BGF

import lang::sdf2::\syntax::Sdf2;
import lang::sdf2::util::SDF2Grammar;
//import ParseTree;
import grammarlab::language::Grammar;
import grammarlab::extract::rascal::Grammar;
import lang::rascal::grammar::definition::Modules;
import grammarlab::transform::Merge;
import grammarlab::transform::Normal;
import IO; // listEntries
import String; // endsWith
import grammarlab::lib::RascalPlus;
import ParseTree;
import util::IDE; // DEBUG

public GGrammar extractG(loc sdf)
{
	str input = "definition " + trim(readFile(sdf));
	str name = replaceAll(split("\n",split("module ",input)[1])[0],"\\","");
	println("Extracting <name>...");
	GGrammar G =
		normalise(
		grammarlab::extract::rascal::Grammar::grammar2grammar(
		lang::rascal::grammar::definition::Modules::fuse(
		lang::sdf2::util::SDF2Grammar::sdf2grammar(name, parse(#SDF, input))
		)));
	println("Extraction completed.");
	return G;
}

public GGrammar extractGs(loc sdfs) = mergeGs([extractG(sdfs+sdf) | str sdf <- listEntries(sdfs), endsWith(sdf,".sdf")]);

//Tree getSDF(str s, loc z) = parse(#SDF,z);
//public void registerSDF() = registerLanguage("SDF","sdf",getSDF);
