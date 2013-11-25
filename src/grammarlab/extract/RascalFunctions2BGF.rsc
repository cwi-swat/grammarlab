@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::extract::RascalFunctions2BGF

import lang::rascal::\syntax::Rascal;
import grammarlab::io::Grammar;
import grammarlab::language::Grammar;
import grammarlab::transform::Normal;
import grammarlab::extract::rascal::Function;
import grammarlab::export::Grammar;

import ParseTree;
import String;
import IO;

GGrammar extractG(loc z) = extractG(readFile(z)); 

GGrammar extractG(str s)
{
	str gs = trim(s);
	str name = replaceAll(split("\n",split("module ",gs)[1])[0],"\\","");
	println("Extracting <name>...");
	GGrammar G = normalise(grammar([],module2functions(parse(#start[Module],gs).top),[]));
	println("Extraction completed.");
	return G;
}

public GProdList module2functions(Module m) = [mapFunDecl(fd) | /FunctionDeclaration fd := m];

test bool extractself() {GGrammar g = extractG(|project://grammarlab/src/grammarlab/extract/RascalFunctions2BGF.rsc|);println(ppx(g));return true;}
test bool extractass() {GGrammar g = extractG(|project://grammarlab/src/grammarlab/transform/xbgf/Associativity.rsc|);println(ppx(g));return true;}
