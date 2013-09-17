@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::extract::PGF2BGF

import ParseTree;
import IO;
import grammarlab::language::PGF;
import grammarlab::language::Grammar;
import grammarlab::transform::Normal;
import grammarlab::lib::Squeeze;
import grammarlab::io::Grammar;

GGrammar extractG(loc f)
{
	GProdList ps = [mapC2P(c) | PGFCat c <- parse(#start[PGFFile],f).top.cs];
	return normalise(grammar(squeeze([p.lhs | p <- ps]),ps,[]));
}

GProd mapC2P(PGFCat c)
	= production("<c.super>",choice([nonterminal("<x>") |  PGFName x <- c.elems]));

test bool extractPGFgrammar()
{
	writeBGF(extractG(|home:///projects/slps/topics/grammars/type/pgf/figure2.txt|),
		|home:///projects/slps/topics/grammars/type/pgf/grammar.bgf|);
	return true;
}
