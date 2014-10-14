@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::extract::RascalADT2BGF

import lang::rascal::\syntax::Rascal;
import ParseTree;
import String;
import IO;

import grammarlab::extract::rascal::AbstractType;
import grammarlab::io::Grammar;
import grammarlab::language::Grammar;
import grammarlab::transform::Normal;
import grammarlab::lib::Squeeze;

//import export::BNF; // ?

public void main(list[str] args) = writeBGF(extractBGF(|cwd:///|+args[0]),|cwd:///|+args[1]);
public void main(list[loc] las) = writeBGF(extractBGF(las[0]),las[1]);
public void main(loc z) = println(pp(extractBGF(z)));

GGrammar extractG(loc z)
{
	//= normalise(language::BGF::grammar([],module2aliases(parse(#Module,trim(readFile(z))))));
	Module m;
	println("Extracting <z.file>...");
	try
		m = parse(#Module,trim(readFile(z)));
	catch:
		m = parse(#start[Module],z).top;
	GProdList ps = module2decls(m);
	println("Extraction completed.");
	return grammar(squeeze([p.lhs | p <- ps]), ps, []);
}

public GProdList module2aliases(Module m) = [p | /Declaration d := m, p<-mapAlias(d) ];
public GProdList module2datas(Module m)   = [p | /Declaration d := m, p<-mapData(d)  ];
public GProdList module2decls(Module m)   = [p | /Declaration d := m, p<-mapDecl(d)  ];

test bool glg() {GGrammar g = extractG(|project://grammarlab/src/grammarlab/language/Grammar.rsc|);return true;}
test bool glx() {GGrammar g = extractG(|project://grammarlab/src/grammarlab/language/X.rsc|);return true;}
test bool glo() {GGrammar g = extractG(|project://grammarlab/src/grammarlab/language/XOutcome.rsc|);return true;}
test bool gls() {GGrammar g = extractG(|project://grammarlab/src/grammarlab/language/XScope.rsc|);return true;}
test bool glm() {GGrammar g = extractG(|project://grammarlab/src/grammarlab/language/Micro.rsc|);return true;}
test bool glt() {GGrammar g = extractG(|project://grammarlab/src/grammarlab/language/Tree.rsc|);return true;}
test bool gle() {GGrammar g = extractG(|project://grammarlab/src/grammarlab/language/EBNF.rsc|);return true;}
test bool glc() {GGrammar g = extractG(|project://grammarlab/src/grammarlab/language/LCI.rsc|);return true;}
