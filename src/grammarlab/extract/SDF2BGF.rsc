@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::extract::SDF2BGF

import lang::sdf2::\syntax::Sdf2;
import lang::sdf2::util::SDF2Grammar;
//import ParseTree;
import grammarlab::language::Grammar;
import grammarlab::extract::RascalGrammar;
import lang::rascal::grammar::definition::Modules;

public grammarlab::language::Grammar::GGrammar extractG(loc bgf)
{
	println("Extracting <name>...");
	GGrammar G =
		normalise(
		grammarlab::extract::RascalGrammar::grammar2grammar(
		lang::rascal::grammar::definition::Modules::fuse(
		lang::sdf2::util::SDF2Grammar::sdf2grammar(bgf)
		)));
println("Extraction completed.");
	return G;
}
