@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::extract::RascalADT2BGF

import lang::rascal::\syntax::Rascal;
import ParseTree;

import grammarlab::extract::RascalType;
import grammarlab::language::Grammar;
import grammarlab::io::Grammar;
import grammarlab::transform::Normal;
import String;

import IO;
//import export::BNF; // ?

public void main(list[str] args) = writeBGF(extractBGF(|cwd:///|+args[0]),|cwd:///|+args[1]);
public void main(list[loc] las) = writeBGF(extractBGF(las[0]),las[1]);
public void main(loc z) = println(pp(extractBGF(z)));

GGrammar extractG(loc z)
{
	//= normalise(language::BGF::grammar([],module2aliases(parse(#Module,trim(readFile(z))))));
	Module m;
	println("Extracting <z>...");
	try
		m = parse(#Module,trim(readFile(z)));
	catch:
		m = parse(#Module,readFile(z));
	GProdList ps = module2decls(m);
	println("Extraction completed.");
	return grammarlab::language::BGF::grammar([],ps);
}

public GProdList module2aliases(Module m) = [p | /Declaration d := m, p<-mapAlias(d) ];
public GProdList module2datas(Module m)   = [p | /Declaration d := m, p<-mapData(d)  ];
public GProdList module2decls(Module m)   = [p | /Declaration d := m, p<-mapDecl(d)  ];
