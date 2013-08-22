@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::xbgf::Chaining

//import lib::Rascalware;
import grammarlab::lib::Sizes;
import grammarlab::language::Grammar;
import grammarlab::language::XScope;
import grammarlab::language::XOutcome;
import grammarlab::transform::xbgf::Util;
import grammarlab::transform::xbgf::Brutal;
import grammarlab::compare::Differ;

@doc{Removes a reflexive chain production rule - http://github.com/grammarware/slps/wiki/Abridge}
XResult runAbridge(GProd p, GGrammar g)
{
	if (production(str n,nonterminal(n)) !:= p &&
		production(str n,label(_,nonterminal(n))) !:= p &&
		production(str n,label(_,mark(_,nonterminal(n)))) !:= p)
		return <problemProd("Production cannot be abridged.",p),g>;
	if (!inProds(p, g.P))
		return <notFoundP(p),g>;
	return <ok(),grammar(g.N, g.P - p, g.S)>;
}

@doc{Introduces a chain production rule - http://github.com/grammarware/slps/wiki/Chain}
XResult runChain(GProd p, GGrammar g)
{
	GProdList ps1,ps2,ps3;
	if (production(str n1,nonterminal(n1)) := p)
		return <problem("Do not introduce reflexive chain productions with chain, use detour instead"),g>;
	if (production(str n1,nonterminal(str n2)) := p)
		{
			if (n2 in allNs(g.P))
				return <notFreshName(n2),g>;
			<ps1,ps2,ps3> = splitPbyW(g.P,innt(n1));
			if ([production(n1,GExpr e)] := ps2)
				return <ok(),grammar(g.N + n2, ps1 + p + production(n2,e) + ps3, g.S)>;
			else
				return <problemProds("Production rule has unexpected form",ps2),g>;
		}
	elseif (production(str n1, label(str l,nonterminal(str n2))) := p)
		{
			if (n2 in allNs(g.P))
				return <notFreshName(n2),g>;
			GProdList ps1,ps2,ps3;
			<ps1,ps2,ps3> = splitPbyW(g.P,inlabel(l));
			if ([production(n1,label(l,e))] := ps2)
				return <ok(),grammar(g.N + n2, ps1 + p + production(n2,e) + ps3, g.S)>;
			else
				return <problemProds("Production rule has unexpected form",ps2),g>;
		}
	else
		return <problemProd("Not a chain production rule.",p),g>;
}

@doc{Adds a reflexive chain production rule - http://github.com/grammarware/slps/wiki/Detour}
XResult runDetour(GProd p, GGrammar g)
{
	if (production(str x,nonterminal(x)) := p
	|| production(str x,label(_,nonterminal(x))) := p
	|| production(str x,label(_,mark(_,nonterminal(x)))) := p)
	{
		if (x notin definedNs(g.P))
			return <freshN(x),g>;
		<ps1,ps2,ps3> = splitPbyW(g.P,innt(x));
		return <ok(),grammar(g.N, ps1 + ps2 + p + ps3, g.S)>;
	}
	else
		return <problemProd("Not a reflexive chain production rule",p),g>;
}

@doc{Removes a chain production rule - http://github.com/grammarware/slps/wiki/Unchain}
XResult runUnchain(GProd p, GGrammar g)
{
	str nt1,nt2,l="";
	if (!inProds(p,g.P))
		return <notFoundP(r,p),g>;
	if (production(str n1, nonterminal(n1)) := p)
		return <problem("Do not remove reflexive chain productions with chain, use abridge instead"),g>;
	if (p.lhs in g.S)
		return <problemStr("Nonterminal must not be root",n2),g>;
	if (production(str n1, nonterminal(str n2)) := p
	|| production(str n1, mark(_,nonterminal(str n2))) := p)
		{
			nt1 = n1;
			nt2 = n2;
			l = n2;
		}
	else	if (production(str n1, label(str l1, nonterminal(str n2))) := p
		|| production(str n1, label(str l1, mark(_,nonterminal(str n2)))) := p)
		{
			nt1 = n1;
			nt2 = n2;
			l = l1;
		}
	if (isEmpty(l))
		return <problemProd("Not a chain production rule",p),g>;

	//if (n2 in allNs(ps)) r = notFreshN(r,n2);
	GProdList ps1,ps2,ps3;
	<ps1,ps2,ps3> = splitPbyW(g.P - p, innt(nt2));
	if (len(ps2) != 1)
		return <problemStr("Nonterminal must occur exactly once",nt2),g>;
	if ([production(nt2,e)] := ps2)
		return <ok(),grammar(g.N - nt2, ps1 + production(nt1,label(l,e)) + ps3, g.S)>;
	else
		return <problemProds("Production rules have unexpected form",ps2),g>;
}

