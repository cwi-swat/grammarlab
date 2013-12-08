@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI; UvA}
module grammarlab::transform::sleir::TypeIV

import String;

import grammarlab::language::Grammar;
import grammarlab::language::XScope;
import grammarlab::language::XOutcome;
import grammarlab::transform::sleir::Naming;

import grammarlab::transform::xbgf::Nonterminals;

GGrammar runRenameAllN(str x, str y, GGrammar g)
{
	nc1 = inferConvention(x);
	nc2 = inferConvention(y);
	for (str n <- g.N, confirmConvention(n,nc1), m := changeConvention(n,nc1,nc2), m notin g.N)
		g = grammarlab::transform::xbgf::Nonterminals::performRenameN(n,m,g); 
	return g;
}

GGrammar runDropPrefixN(str p, GGrammar g)
{
	for (str n <- g.N, startsWith(n,p))
		g = grammarlab::transform::xbgf::Nonterminals::performRenameN(n,replaceFirst(n,p,""),g); 
	return g;
}

GGrammar runDropPostfixN(str p, GGrammar g)
{
	for (str n <- g.N, endsWith(n,p))
		g = grammarlab::transform::xbgf::Nonterminals::performRenameN(n,replaceLast(n,p,""),g); 
	return g;
}

