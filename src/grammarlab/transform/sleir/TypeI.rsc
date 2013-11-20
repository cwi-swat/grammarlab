@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::sleir::TypeI

import grammarlab::language::Grammar;
import grammarlab::language::XScope;
import grammarlab::lib::Scoping;
import grammarlab::lib::Sizes;
//extend mutate::type1::AbridgeAll;
//extend mutate::type1::DeyaccifyAll;
//extend mutate::type1::DistributeAll;
//extend mutate::type1::EliminateTop;
//extend mutate::type1::EquateAll;
//extend mutate::type1::FoldMax;
//extend mutate::type1::HorizontalAll;
//extend mutate::type1::InlineMax;
//extend mutate::type1::RetireLs;
//extend mutate::type1::UnchainAll;
//extend mutate::type1::UnfoldMax;
//extend mutate::type1::VerticalAll;

import List; //toSet

// code cloned and refactored from grammarlab::transform::xbgf::Chaining
GGrammar runAbridgeAll(GGrammar g)
{
	GProdList ps = [];
	for (GProd p <- g.P)
	{
		if (production(str n,nonterminal(n)) !:= p &&
			production(str n,mark(_,nonterminal(n))) !:= p &&
			production(str n,label(_,nonterminal(n))) !:= p &&
			production(str n,label(_,mark(_,nonterminal(n)))) !:= p)
			ps += p;
	}
	return grammar(g.N, ps, g.S);
}

// code cloned and refactored from grammarlab::transform::xbgf::Yacc
GProdList performDeYaccAll(GProdSet pset)
{
	// TODO figure out a way to do the same as with yaccify
	switch(pset)
	{
		case {production(n,sequence([nonterminal(n),x])),
		      production(n,x)}:
			return [production(n,plus(x))];
		case {production(n,sequence([x,nonterminal(n)])),
		      production(n,x)}:
			return [production(n,plus(x))];
		case {production(n,sequence([nonterminal(n),x])),
		      production(n,y)}:
			return [production(n,sequence([y,star(x)]))];
		case {production(n,sequence([x,nonterminal(n)])),
		      production(n,y)}:
			return [production(n,sequence([star(x),y]))];
		case {production(n,sequence([x,nonterminal(n)])),
		      production(n,epsilon())}:
			return [production(n,star(x))];
		case {production(n,sequence([nonterminal(n),x])),
		      production(n,epsilon())}:
			return [production(n,star(x))];
		default:
			return toList(pset);
	};
}

// code cloned and refactored from grammarlab::transform::xbgf::Yacc
GGrammar runDeyaccifyAll(GGrammar g)
{
	GProdList ps = [];
	for (str n <- g.N)
	{
		<ps1,ps2,ps3> = splitPbyW(g.P,innt(n));
		//ps += ps1;
		if (len(ps2) != 2)
			ps += ps2;
		else
			ps += performDeYaccAll(toSet(ps2));
		//ps += ps3;
	}
	return grammar(g.N, ps, g.S);
}
