@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI; UvA}
module grammarlab::transform::SLEIR

// TODO: not imported from SLPS yet, the file included for the sake of integrity
// UPDATE: in the process of being imported/reengineered

import Set;
import grammarlab::language::Grammar;
import grammarlab::language::SLEIR;
import grammarlab::transform::Normal;
import grammarlab::transform::sleir::TypeI;
import grammarlab::transform::sleir::TypeIV;

public GGrammar mutate(MSequence ms, GGrammar g)
	= (g | normalise(mutate(m,it)) | MCommand m <- ms);

public GGrammar legacyMutate(AbridgeAll(), GGrammar g)
	= grammarlab::transform::sleir::TypeI::runAbridgeAll(g);
public GGrammar legacyMutate(DeyaccifyAll(), GGrammar g)
	= grammarlab::transform::sleir::TypeI::runDeyaccifyAll(g);
public GGrammar legacyMutate(DistributeAll(), GGrammar g) = runDistributeAll(g);
public GGrammar legacyMutate(EliminateTop(), GGrammar g) = runEliminateTop(g);
public GGrammar legacyMutate(EquateAll(), GGrammar g) = runEquateAll(g);
public GGrammar legacyMutate(FoldMax(), GGrammar g) = runFoldMax(g);
public GGrammar legacyMutate(HorizontalAll(), GGrammar g) = runHorizontalAll(g);
public GGrammar legacyMutate(InlineMax(), GGrammar g) = runInlineMax(g);
public GGrammar legacyMutate(LiftTopLabels(), GGrammar g) = runLiftTopLabels(g);
public GGrammar legacyMutate(UnchainAll(), GGrammar g) = runUnchainAll(g);
public GGrammar legacyMutate(UnfoldMax(), GGrammar g) = runUnfoldMax(g);
public GGrammar legacyMutate(VerticalAll(), GGrammar g) = runVerticalAll(g);

public GGrammar legacyMutate(DropPrefixN(str p), GGrammar g) = runDropPrefixN(p,g);
public GGrammar legacyMutate(DropPostfixN(str p), GGrammar g) = runDropPostfixN(p,g);
public GGrammar legacyMutate(RenameAllN(str n1, str n2), GGrammar g) = runRenameAllN(n1,n2,g);

public default GGrammar legacyMutate(MCommand m, GGrammar g)
{
	println("Don’t know how to legacyMutate with <m>.");
	return g;
}

///////////////////////////////////////////////////////////////////////////
// TODO: get rid of the rest of the file
public GGrammar RetireSs(GGrammar g)
{
	ps = visit(g.prods) {case selectable(_,GExpr e) => e};
	return grammar(g.nts, g.roots, normalise(ps));
}
public GProd RetireSs(GProd p) {return visit(p) {case selectable(_,GExpr e) => e};}
public GExpr RetireSs(GExpr x) {return visit(x) {case selectable(_,GExpr e) => e};}

public GGrammar RetireLs(GGrammar g)
{
	ps = visit(g.prods) {case labelled(_,GExpr e) => e};
	return grammar(g.nts, g.roots, normalise(ps));
}

public GProd RetireLs(GProd p) {return visit(p) {case labelled(_,GExpr e) => e};}
public GExpr RetireLs(GExpr x) {return visit(x) {case labelled(_,GExpr e) => e};}

// TODO: turn into a proper mutation later!
public GGrammar runLiftTopLabels(GGrammar g) = normalise(grammar(g.N,mapper(LiftTopLabels,g.P),g.S));
default GProd runLiftTopLabels(production(str lhs, label(str name, GExpr e))) =
	production(lhs,sequence(nonterminal(name),e));
default GProd runLiftTopLabels(production(str lhs, choice(L))) = production(lhs,choice(mapper(LiftTopLabels,L)));
default GProd runLiftTopLabels(GProd p) = p;
GExpr runLiftTopLabels(label(str name, GExpr e)) = sequence(nonterminal(name),e);
default GExpr runLiftTopLabels(GExpr e) = e;

/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
// SLEIR:AbridgeAll
@doc{abridge ⊢ AbridgeAll, Type I, page 4}
public GGrammar mutate(AbridgeAll(), GGrammar g)
{
	GProdList ps = [];
	for (GProd p <- p.P,
		production(str n, nonterminal(n)) !:= p &&
		production(str n, mark(_,nonterminal(n))) !:= p &&
		production(str n, label(_,nonterminal(n))) !:= p &&
		production(str n, label(_,mark(_,nonterminal(n)))) !:= p)
		ps += p;
	return grammar(g.N, ps, g.S);
}

// SLEIR:RetireTs
@doc{abstractize ⊢ RetireTs, Type II, page 6}
public GGrammar mutate(RetireTs(), GGrammar g)
{
	// the generalised code is too slow, replaced with a faster native Rascal alternative
	g.P = visit(g.P){case terminal(_) => epsilon()};
	// NB: implicitly count on normalisation
	return g;
}

// NOT done: addC, addV - page 12

// SLEIR:RetireMs
@doc{anonymize ⊢ RetireMs, Type II, stripped from the paper}
public GGrammar mutate(RetireMs(), GGrammar g)
{
	// the generalised code is too slow, replaced with a faster native Rascal alternative
	g.P = visit(g.P){case mark(_,GExpr e) => e};
	return g;
}

// SLEIR:InsertLayout
@doc{appear ⊢ InsertLayout, Type II, page 7}
public GGrammar mutate(InsertLayout(), GGrammar g)
{
	// TODO
	return g;
}

// NOT done: bypass

// SLEIR:ChainMixed
@doc{chain ⊢ ChainMixed, Type II, page 7}
public GGrammar mutate(ChainMixed(), GGrammar g)
{
	// code manually rewritten for the sake of productivity
	map[str,int] ids = ();
	list[str] processed = [];
	GProdList ps = [];
	for (GProd p <- g.P)
	{
		<ps1,ps2,ps3> = splitPbyW(g.P,innt(p.lhs));
		if (len(ps2)==1)
			ps += p;
		elseif (production(n1,nonterminal(n2)) := p)
			ps += p;
		else
		{
			if (p.lhs notin ids) ids[p.lhs] = 1;
			while("<p.lhs><ids[p.lhs]>" in g.N) ids[p.lhs] += 1;
			ps += [production(p.lhs,nonterminal("<p.lhs><ids[p.lhs]>")), production("<p.lhs><ids[p.lhs]>",p.rhs)];
			g.N += "<p.lhs><ids[p.lhs]>";
		}
	}
	return grammar(g.N, ps, g.S);
}

// TODO: clone?

// SLEIR:ConcatAllT
@doc{concatT ⊢ ConcatAllT, Type II, page 7}
public GGrammar mutate(ConcatAllT(), GGrammar g)
{
	// the generalised code is too slow, replaced with a faster native Rascal alternative
	g.P=visit(g.P){case sequence([*LB,terminal(t1),terminal(t2),*LA]) => sequence([*LB,terminal(t1+t2),*LA])};
	// TODO: TEST!
	return g;
}

// SLEIR:ParenthesizeAll
@doc{concretize ⊢ ParenthesizeAll, Type II, page 7}
public GGrammar mutate(ParenthesizeAll(), GGrammar g)
{
	// TODO
	// NB: "M-expressions, S-expressions, Sweet-expressions, I-expressions, G-expressions and alike"
	return g;
}

// NOT done: deanonymize ⊢ MarkAll???


// SLEIR:DefineMin
@doc{define ⊢ DefineMin, Type II, page 7}
public GGrammar mutate(DefineMin(), GGrammar g)
{
	list[str] ns = toList({n | /nonterminal(str n) := g.P, n notin g.N});	
	return grammar(g.N + ns, g.P + [production(nt,empty()) | nt <- ns], g.S);
}

// TODO: designate - will be needed to ADT generation

// NOT done: detour - page 12

// SLEIR:DeyaccifyAll
@doc{deyaccify ⊢ DeyaccifyAll, Type I, page 5}
public GGrammar mutate(DeyaccifyAll(), GGrammar g)
{
	GProdList ps = [];
	if (str n <- g.N)
	{
		<ps1,ps2,ps3> = splitPbyW(g.P,innt(n));
		if (len(ps2) > 2)
			ps += ps2;
		elseif (len(ps2) == 2)
			ps += performDeYaccAll(toSet(ps2));
		elseif ([production(n,choice([e1,e2]))] := ps2)
			ps += performDeYaccAll({production(n,e1),production(n,e2)});
	}
	return grammar(g.N, ps, g.S);
}

// Needed for: DeyaccifyAll
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

// SLEIR:DisappearEverywhere
@doc{disappear ⊢ DisappearEverywhere, Type IV, page 10}
public GGrammar mutate(DisappearEverywhere(GExpr e), GGrammar g)
{
	if (optional(_) !:= e || star(_) !:= e)
		return g; // TODO: should actually be an error
	g.P = visit(g.P){case e => epsilon()};
	// NB: assumes normalisation afterwards
	return g;
}

// SLEIR:DistributeAll
@doc{distribute ⊢ DistributeAll, Type I, page 5}
public GGrammar mutate(DistributeAll(), GGrammar g)
	= grammar(g.N, [grammarlab::transform::XBGF::makeDistributed(p) | p <- g.P], g.S);

// NOT done: downgrade - page 12

// SLEIR:EliminateTop
@doc{eliminate ⊢ EliminateTop, Type I, page 5}
public GGrammar mutate(EliminateTop(), GGrammar g)
{
	before = [];
	reached = g.S;
	while(!isEmpty(reached))
	{
		n = getOneFrom(reached);
		reached -= n;
		before += n;
		for (p <- g.P, p.lhs == n)
			for (rn <- {name | /nonterminal(name) := p})
				if (rn notin before+reached && rn in g.N)
					reached += rn;
	}
	return grammar(before, [p <- g.P, p.lhs in before], g.S);
}

// SLEIR:EquateAll
@doc{equate ⊢ EquateAll, Type I, page 5}
public GGrammar mutate(EquateAll(), GGrammar g)
{
	for (x <- g.N, y <- g.N)
	{
		if (x == y) continue;
		<ps1x,ps2x,ps3x> = splitPbyW(g.P,innt(x));
		<_,ps2y,_> = splitPbyW(g.P,innt(y));
		XResult rep = transform(renameN(x,y), normalise(grammar([],ps2x,[])));
		if (ok() !:= rep.r) continue;
		gxy = rep.g;
		gyy = normalise(grammar([],ps2y,[]));
		if (!gdts(gxy,gyy)) continue;
		if (x in usedNs(ps1x + ps3x))
			g = transform(replace(nonterminal(x),nonterminal(y),globally()), grammar(g.N, ps1x + ps3x, g.S - x)).g;
		else
			g = grammar(g.N, ps1x + ps3x, g.S - x);
	}
}

// NOT done: extract

// factor ⊢ distribute (kinda covered by XBGF)

// TODO: factor ⊢ Undistribute

// SLEIR:FoldMax
@doc{fold ⊢ FoldMax, Type I, page 5}
public GGrammar mutate(FoldMax(), GGrammar g)
{
	// Slightly improved over the straightforward generalisation
	for (n <- g.N)
	{
		<_,ps,_> := splitPbyW(g.P,innt(n));
		if (len(ps)!=1) continue;
		g.P = performReplace(normalise(ps[0].rhs),nonterminal(n), g.P);
	}
	return g;
}

// SLEIR:HorizontalAll
@doc{horizontal ⊢ HorizontalAll, Type I, page 5}
public GGrammar mutate(HorizontalAll(), GGrammar g)
{
	for (n <- g.N)
	{
		<ps1,ps2,ps3> := splitPbyW(g.P,innt(n));
		if (len(ps2)==1) continue;
		GExprList es4 = [];
		for (production(str x, GExpr e) <- ps2)
			if (choice(L) := e)
				es4 += L;
			else
				es4 += e;
		g.P = ps1 + production(x,choice(es4)) + ps3;
	}
}

// NOT done: importG - page 11
// NOT done: inject - page 12

// SLEIR:InlineMax
@doc{inline ⊢ InlineMax, Type I, page 5}
public GGrammar mutate(InlineMax(), GGrammar g)
{
	// Slightly improved over the straightforward generalisation
	for (n <- g.N - g.S)
	{
		<ps1,ps2,ps3> := splitPbyW(g.P,innt(n));
		if (len(ps2)!=1) continue; // not horizontal!
		if (/nonterminal(n) := ps2) continue; // recursive!
		g.P = performReplace(normalise(ps2[0].rhs),nonterminal(n), ps1+ps3);
	}
	return g;
}

// introduce ⊢ importG (kinda done by XBGF)

// SLEIR:IterateXYXLeft
@doc{iterate ⊢ IterateXYXLeft, Type III, page 8}
public GGrammar mutate(IterateXYXLeft(), GGrammar g)
{
	for (n <- g.N)
	{
		<ps1,ps2,ps3> := splitPbyW(g.P,innt(n));
		if (len(ps2)!=1) continue; // not horizontal!
		if ([production(str lhs, sequence([GExpr x,GExpr y,x]))] := ps2)
			g.P = ps1 + [production(lhs, sequence([star(sequence([x,y])),x]))] + ps3;
	}
	return g;
}

// SLEIR:IterateXYXRight
@doc{iterate ⊢ IterateXYXRight, Type III, page 8}
public GGrammar mutate(IterateXYXRight(), GGrammar g)
{
	for (n <- g.N)
	{
		<ps1,ps2,ps3> := splitPbyW(g.P,innt(n));
		if (len(ps2)!=1) continue; // not horizontal!
		if ([production(str lhs, sequence([GExpr x,GExpr y,x]))] := ps2)
			g.P = ps1 + [production(lhs, sequence([x,star(sequence([y,x]))]))] + ps3;
	}
	return g;
}

// SLEIR:IterateXX
@doc{iterate ⊢ IterateXX, Type III, page 8}
public GGrammar mutate(IterateXX(), GGrammar g)
{
	for (n <- g.N)
	{
		<ps1,ps2,ps3> := splitPbyW(g.P,innt(n));
		if (len(ps2)!=1) continue; // not horizontal!
		if ([production(str lhs, sequence([GExpr x,x]))] := ps2)
			g.P = ps1 + [production(lhs, plus(x))] + ps3;
	}
	return g;
}

// SLEIR:LAssocAll
@doc{iterate ⊢ LAssocAll, Type II, page 7}
public GGrammar mutate(LAssocAll(), GGrammar g)
{
	for (n <- g.N)
	{
		<ps1,ps2,ps3> := splitPbyW(g.P,innt(n));
		if (len(ps2)!=1) continue; // not horizontal!
		if ([production(str lhs, plus(GExpr x))] := ps2)
			g.P = ps1 + [production(lhs, sequence([x,x]))] + ps3;
		elseif ([production(lhs, sequence([GExpr x,star(sequence([GExpr y,x]))]))] := ps2
			|| [production(lhs, sequence([star(sequence([GExpr x,GExpr y])),x]))] := ps2)
			g.P = ps1 + [production(lhs, sequence([x,y,x]))] + ps3;
	}
	return g;
}

// SLEIR:RAssocAll
@doc{iterate ⊢ RAssocAll, Type II, page 7}
public GGrammar mutate(RAssocAll(), GGrammar g) = mutate(LAssocAll(), g);


// NOT done: removeH, removeV - page 12


