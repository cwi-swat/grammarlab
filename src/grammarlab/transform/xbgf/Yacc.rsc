@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::xbgf::Yacc

//import lib::Rascalware;
import grammarlab::language::Grammar;
import grammarlab::language::XScope;
import grammarlab::language::XOutcome;
import grammarlab::lib::Scoping;

bool yaccification(production(n,sequence([y,star(x)])),
				  {production(n,sequence([nonterminal(n),x])),
				   production(n,y)}) = true;
bool yaccification(production(n,plus(x)),
				  {production(n,sequence([nonterminal(n),x])),
				   production(n,x)}) = true;
bool yaccification(production(n,sequence([star(x),y])),
				  {production(n,sequence([x,nonterminal(n)])),
				   production(n,y)}) = true;
bool yaccification(production(n,plus(x)),
				  {production(n,sequence([x,nonterminal(n)])),
				   production(n,x)}) = true;
// the next two are not really necessary, if we figure out how to combine pattern matching with normalisations
bool yaccification(production(n,star(x)),
				  {production(n,sequence([x,nonterminal(n)])),
				   production(n,epsilon())}) = true;
bool yaccification(production(n,star(x)),
				  {production(n,sequence([nonterminal(n),x])),
				   production(n,epsilon())}) = true;
default bool yaccification(GProd p,GProdSet ps) = false;
//bool yaccification(_,_) = false;

GProd performDeYacc(GProdSet pset)
{
	// TODO figure out a way to do the same as with yaccify
	switch(pset)
	{
		case {production(n,sequence([nonterminal(n),x])),
		      production(n,x)}:
			return production(n,plus(x));
		case {production(n,sequence([x,nonterminal(n)])),
		      production(n,x)}:
			return production(n,plus(x));
		case {production(n,sequence([nonterminal(n),x])),
		      production(n,y)}:
			return production(n,sequence([y,star(x)]));
		case {production(n,sequence([x,nonterminal(n)])),
		      production(n,y)}:
			return production(n,sequence([star(x),y]));
		case {production(n,sequence([x,nonterminal(n)])),
		      production(n,epsilon())}:
			return production(n,star(x));
		case {production(n,sequence([nonterminal(n),x])),
		      production(n,epsilon())}:
			return production(n,star(x));
		default:
			throw "Nonterminal <x> is not deyaccifiable.";
	};
}

XResult runDeyaccify(str n, GGrammar g)
{
	if (n notin g.N)
		return <freshName(n),g>;
	<ps1,ps2,ps3> = splitPbyW(g.P,innt(n));
	if (len(ps2) > 2)
		return <problemProds("No deyaccification patterns for <len(ps2)> production rules known",ps2),g>;
	elseif (len(ps2) == 2)
		return <ok(),grammar(g.N, ps1 + performDeYacc(toSet(ps2)) + ps3, g.S)>;
	elseif ([production(n,choice([e1,e2]))] := ps2)
		return <ok(),grammar(g.N, ps1 + performDeYacc({production(n,e1),production(n,e2)}) + ps3, g.S)>;
	return <problemStr("Nonterminal must be defined vertically for deyaccification to work",n),g>;
}

XResult runYaccify(GProdList ps1, GGrammar g)
{
	if ({str x} := definedNs(ps1))
	{
		<ps3,ps4,ps5> = splitPbyW(g.P,innt(x));
		if ([dyp1] := ps4 && [yp1,yp2] := ps1 && yaccification(dyp1,{yp1,yp2}))
			return <ok(), grammar(g.N, ps3 + ps1 + ps5, g.S)>;
		elseif ([dyp2] := ps4 && [production(x,choice([e1,e2]))] := ps1 && yaccification(dyp2,{production(x,e1),production(x,e2)}))
			return <ok(), grammar(g.N, ps3 + ps1 + ps5, g.S)>;
		else
			return <problemProds2("Unsuitable yaccification",ps1,ps4),g>;
	}
	else 
		return <problem("Production rules must define just one nonterminal."),g>;
}

