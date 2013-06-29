@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
@wiki{iterate,rassoc,lassoc}
module transform::xbgf::Associativity

import language::Grammar;
import language::XScope;
import language::XOutcome;
import transform::xbgf::Util;

bool admit(sequence([nonterminal(n),nonterminal(x),nonterminal(n)]),
		   sequence([nonterminal(n),star(sequence([nonterminal(x),nonterminal(n)]))])) = true;
bool admit(sequence([nonterminal(n),nonterminal(x),nonterminal(n)]),
		   sequence([star(sequence([nonterminal(n),nonterminal(x)])),nonterminal(n)])) = true;
bool admit(sequence([nonterminal(n),nonterminal(n)]),
		   plus(nonterminal(n))) = true;
default bool admit(GExpr e1, GExpr e2) = false;

// NB: rassoc and lassoc are the same when they work on the grammar level
// the differences can only be observed on the instance level
public XResult transform(rassoc(GProd p), GGrammar g) = runAssoc(p,g);
public XResult transform(lassoc(GProd p), GGrammar g) = runAssoc(p,g);

XResult runAssoc(production(str l, str x, GExpr e1), GGrammar g)
{
	<ps1,ps2,ps3> = splitPbyW(g.prods,comboscope(inlabel(l),innt(x)));
	if ([production(l, x, GExpr e2)] := ps2)
		if (admit(e1,e2))
			return <ok(),grammar(g.roots,ps1 + production(l, x, e1) + ps3)>;
		else
			return <problemProd("Production rule must admit associativity transformation",production(l,x,e1)),g>;
	else
		return <problemPinProds("Cannot find the right production rule to match",production(l,x,e1),ps2),g>;
}

public XResult transform(iterate(GProd p), GGrammar g)
// XResult runIterate(production(str l, str x, GExpr e1), GGrammar g)
// TODO: x -> p.lhs, e1 -> p.rhs, how to treat label?
{
	<ps1,ps2,ps3> = splitPbyW(g.prods,comboscope(inlabel(l),innt(x)));
	if ([production(l, x, GExpr e2)] := ps2)
		if (admit(e2,e1))
			return <ok(),grammar(g.roots,ps1 + production(l, x, e1) + ps3)>;
		else
			return <problemProd("Production rule must admit associativity transformation",production(l,x,e1)),g>;
	else
		return <problemPinProds("Cannot find the right production rule to match",production(l,x,e1),ps2),g>;
}

