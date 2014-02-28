@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI; UvA}
module grammarlab::transform::SLEIR

import grammarlab::language::Grammar;
import grammarlab::language::SLEIR;
import grammarlab::language::XScope;
import grammarlab::lib::Scoping;
import grammarlab::compare::Differ;
extend grammarlab::transform::sleir::Massage;
import grammarlab::transform::sleir::Naming;
extend grammarlab::transform::sleir::Width;
import grammarlab::transform::Normal;
import grammarlab::transform::XBGF;
import grammarlab::lib::Sizes;
import Set;
import String;
import List;

public GGrammar mutate(MSequence ms, GGrammar g)
	= (g | normalise(mutate(m,it)) | MCommand m <- ms);

// SLEIR:LiftTopLabels
@doc{NEW: invented after the paper got published; does not fit in the paradigm!}
// Apparently I needed it for something. Looks weird. Legacy?
public GGrammar mutate(LiftTopLabels(), GGrammar g)
	= grammar(g.N, [labelsLifted(p) | p <- g.P], g.S);
GProd labelsLifted(production(str lhs, choice(GExprList L)))
	= production(lhs,choice([labelsLifted(e) | e <- L]));
default GProd labelsLifted(GProd p)
	= production(p.lhs, labelsLifted(p.rhs));
GExpr labelsLifted(label(str name, GExpr e))
	= sequence(nonterminal(name),e);
default GExpr labelsLifted(GExpr e) = e;

///////////////////////////////////////////////////////////////////////////
// SLEIR:AbridgeAll
@doc{abridge ⊢ AbridgeAll, Type I, page 4}
public GGrammar mutate(AbridgeAll(), GGrammar g)
{
	GProdList ps = [];
	for (GProd p <- g.P,
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

// Needed for: EliminateTop, Reroot2top
// TODO: extract to another module (grammar metrics?)
list[str] NONTOP(GGrammar g)
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
	return before;
}
list[str] TOP(GGrammar g) = g.N - NONTOP(g);

// SLEIR:EliminateTop
@doc{eliminate ⊢ EliminateTop, Type I, page 5}
public GGrammar mutate(EliminateTop(), GGrammar g)
{
	ns = NONTOP(g);
	return grammar(ns, [p | p <- g.P, p.lhs in ns], g.S);
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
		gxy = performRenameN(x,y,normalise(grammar([],ps2x,[])));
		gyy = normalise(grammar([],ps2y,[]));
		if (!gdts(gxy,gyy)) continue;
		if (x in usedNs(ps1x + ps3x))
			g = grammar(g.N, performReplace(nonterminal(x), nonterminal(y), ps1x+ps3x), g.S - x);
			//g = transform(replace(nonterminal(x),nonterminal(y),globally()), grammar(g.N, ps1x + ps3x, g.S - x)).g;
		else
			g = grammar(g.N, ps1x + ps3x, g.S - x);
	}
	return g;
}

// NOT done: extract

// factor ⊢ distribute (kinda covered by XBGF)

// TODO: factor ⊢ Undistribute

// SLEIR:FoldMax
@doc{fold ⊢ FoldMax, Type I, page 5}
public GGrammar mutate(FoldMax(), GGrammar g)
{
	// Slightly improved over the straightforward generalisation
	for (n <- g.N, <ps1,ps2,ps3> := splitPbyW(g.P,innt(n)), len(ps2)==1)
		g.P
			= performReplace(normalise(ps2[0].rhs), nonterminal(n), ps1)
			+ ps2
			+ performReplace(normalise(ps2[0].rhs), nonterminal(n), ps3)
			;
	return g;
}

// SLEIR:HorizontalAll
@doc{horizontal ⊢ HorizontalAll, Type I, page 5}
public GGrammar mutate(HorizontalAll(), GGrammar g)
{
	for (n <- g.N, <ps1,ps2,ps3> := splitPbyW(g.P,innt(n)))
		g.P = ps1 + production(n,choice([*y | y <- [(choice(L) := p.rhs || label(_,choice(L)) := p.rhs)?L:[p.rhs] | p <- ps2]])) + ps3;
	return g;
}

// NOT done: importG - page 11
// NOT done: inject - page 12 "Further generalisation of injection/projection is possible, but seems too idiosyncratic to include here."

// SLEIR:InlineMax
@doc{inline ⊢ InlineMax, Type I, page 5}
public GGrammar mutate(InlineMax(), GGrammar g)
{
	// Slightly improved over the straightforward generalisation
	for (
		n <- g.N - g.S,
		<ps1,ps2,ps3> := splitPbyW(g.P,innt(n)),
		len(ps2)==1,  // horizontal!
		/nonterminal(n) !:= ps2) // non-recursive!
	g.P = performReplace(nonterminal(n), normalise(ps2[0].rhs), ps1+ps3);
	return g;
}

// SLEIR:InlinePlus
@doc{inline ⊢ InlinePlus, Type II, NEW: never made it to the paper}
public GGrammar mutate(InlinePlus(), GGrammar g)
{
	for (n <- g.N - g.S,
		<ps1,ps2,ps3> := splitPbyW(g.P,innt(n)),
		[production(str lhs, plus(nonterminal(m)))] := ps2)
	g.P = grammarlab::transform::XBGF::performReplace(nonterminal(lhs), ps2[0].rhs, ps1+ps3);
	return g;
}

// introduce ⊢ importG (kinda done by XBGF)

// SLEIR:IterateXYXLeft
@doc{iterate ⊢ IterateXYXLeft, Type III, page 8}
public GGrammar mutate(IterateXYXLeft(), GGrammar g)
{
	for (n <- g.N, <ps1,ps2,ps3> := splitPbyW(g.P,innt(n)))
		g.P = ps1 + [
		production(n,
			(sequence([GExpr x,GExpr y,x]) := p.rhs) ? sequence([star(sequence([x,y])),x]) :
			(label(str name,sequence([GExpr x,GExpr y,x])) := p.rhs) ? label(name,sequence([star(sequence([x,y])),x])) :
			p.rhs) | p <- ps2] + ps3;
	return g;
}

// SLEIR:IterateXYXRight
@doc{iterate ⊢ IterateXYXRight, Type III, page 8}
public GGrammar mutate(IterateXYXRight(), GGrammar g)
{
	for (n <- g.N, <ps1,ps2,ps3> := splitPbyW(g.P,innt(n)))
		g.P = ps1 + [
		production(n,
			(sequence([GExpr x,GExpr y,x]) := p.rhs) ? sequence([x,star(sequence([y,x]))]) :
			(label(str name,sequence([GExpr x,GExpr y,x])) := p.rhs) ? label(name,sequence([x,star(sequence([y,x]))])) :
			p.rhs) | p <- ps2] + ps3;
	return g;
}

// SLEIR:IterateXX
@doc{iterate ⊢ IterateXX, Type III, page 8}
public GGrammar mutate(IterateXX(), GGrammar g)
{
	for (n <- g.N, <ps1,ps2,ps3> := splitPbyW(g.P,innt(n)))
		g.P = ps1 + [
		production(n,
			(sequence([GExpr x,x]) := p.rhs) ? plus(x) :
			(label(str name,sequence([GExpr x,x])) := p.rhs) ? label(name,plus(x)) :
			p.rhs) | p <- ps2] + ps3;
	return g;
}

// SLEIR:LAssocAll
@doc{iterate ⊢ LAssocAll, Type II, page 7}
public GGrammar mutate(LAssocAll(), GGrammar g)
{
	for (n <- g.N, <ps1,ps2,ps3> := splitPbyW(g.P,innt(n)))
		g.P = ps1 + [
		production(n,
			(plus(GExpr x) := p.rhs) ? sequence([x,x]) :
			(label(str name, plus(GExpr x)) := p.rhs) ? label(name,sequence([x,x])) :
			(sequence([GExpr x,star(sequence([GExpr y,x]))]) := p.rhs) ? sequence([x,y,x]) :
			(label(str name, sequence([GExpr x,star(sequence([GExpr y,x]))])) := p.rhs) ? label(name,sequence([x,y,x])) :
			(sequence([star(sequence([GExpr x, GExpr y])),x]) := p.rhs) ? sequence([x,y,x]) :
			(label(str name, sequence([star(sequence([GExpr x, GExpr y])),x])) := p.rhs) ? label(name,sequence([x,y,x])):
			p.rhs) | p <- ps2] + ps3;
	return g;
}

//SLEIR:Massage* -> see grammarlab::transform::sleir::Massage
// yet, some massage-related mutations are manually combined and redesigned

// SLEIR:MassageOrNot2NotAnd
@doc{massage ⊢ MassageOrNot2NotAnd, Type III, slightly redesigned from page 9}
public GGrammar mutate(MassageOrNot2NotAnd(), GGrammar g)
{
	g.P = visit(g.P){case choice(L) => not(allof([(not(ie):=e)?ie:not(e) | e <- L]))};
	return g;
}
// SLEIR:MassageNotAnd2OrNot
@doc{massage ⊢ MassageNotAnd2OrNot, Type III, slightly redesigned from page 9}
public GGrammar mutate(MassageNotAnd2OrNot(), GGrammar g)
{
	g.P = visit(g.P){case not(allof(L)) => choice([(not(ie):=e)?ie:not(e) | e <- L])};
	return g;
}
// SLEIR:MassageNotOr2AndNot
@doc{massage ⊢ MassageNotOr2AndNot, Type III, slightly redesigned from page 9}
public GGrammar mutate(MassageNotOr2AndNot(), GGrammar g)
{
	g.P = visit(g.P){case not(choice(L)) => allof([(not(ie):=e)?ie:not(e) | e <- L])};
	return g;
}
// SLEIR:MassageAndNot2NotOr
@doc{massage ⊢ MassageAndNot2NotOr, Type III, slightly redesigned from page 9}
public GGrammar mutate(MassageAndNot2NotOr(), GGrammar g)
{
	g.P = visit(g.P){case allof(L) => not(choice([(not(ie):=e)?ie:not(e) | e <- L]))};
	return g;
}

// SLEIR:MassageOrLabels
@doc{massage ⊢ MassageOrLabels, Type III, slightly redesigned from page 9}
public GGrammar mutate(MassageOrLabels(), GGrammar g)
{
	g.P = visit(g.P){case choice(L) => (label(_, GExpr x) := L[0] | it && label(_,x):=e | e <- tail(L)) ? x : choice(L)};
	return g;
}
// SLEIR:MassageOrMarks
@doc{massage ⊢ MassageOrMarks, Type III, slightly redesigned from page 9}
public GGrammar mutate(MassageOrMarks(), GGrammar g)
{
	g.P = visit(g.P){case choice(L) => (mark(_, GExpr x) := L[0] | it && mark(_,x):=e | e <- tail(L)) ? x : choice(L)};
	return g;
}
// SLEIR:MassageAndLabels
@doc{massage ⊢ MassageAndLabels, Type III, slightly redesigned from page 9}
public GGrammar mutate(MassageAndLabels(), GGrammar g)
{
	g.P = visit(g.P){case allof(L) => (label(_, GExpr x) := L[0] | it && label(_,x):=e | e <- tail(L)) ? x : allof(L)};
	return g;
}
// SLEIR:MassageAndMarks
@doc{massage ⊢ MassageAndMarks, Type III, slightly redesigned from page 9}
public GGrammar mutate(MassageAndMarks(), GGrammar g)
{
	g.P = visit(g.P){case allof(L) => (mark(_, GExpr x) := L[0] | it && mark(_,x):=e | e <- tail(L)) ? x : allof(L)};
	return g;
}

//SLEIR:Narrow* -> see grammarlab::transform::sleir::Width

// SLEIR:PermutePostfix2Prefix
@doc{permute ⊢ PermutePostfix2Prefix, Type III, page 9}
public GGrammar mutate(PermutePostfix2Prefix(), GGrammar g)
{
	g.P = visit (g.P)
	{
		case production(str n1, sequence([nonterminal(n1), terminal(t1)])) =>
			production(n1, sequence([terminal(t1), nonterminal(n1)]))
		case production(str n1, sequence([nonterminal(n1), nonterminal(n2)])) =>
			production(n1, sequence([nonterminal(n2), nonterminal(n1)]))
		case production(str n1, sequence([nonterminal(n1), nonterminal(n1), terminal(t1)])) =>
			production(n1, sequence([terminal(t1), nonterminal(n1), nonterminal(n1)]))
		case production(str n1, sequence([nonterminal(n1), nonterminal(n1), nonterminal(n2)])) =>
			production(n1, sequence([nonterminal(n2), nonterminal(n1), nonterminal(n1)]))
	};
	return g;
}
// SLEIR:PermutePostfix2Infix
@doc{permute ⊢ PermutePostfix2Infix, Type III, page 9}
public GGrammar mutate(PermutePostfix2Infix(), GGrammar g)
{
	g.P = visit (g.P)
	{
		case production(str n1, sequence([nonterminal(n1), nonterminal(n1), terminal(t1)])) =>
			production(n1, sequence([nonterminal(n1), terminal(t1), nonterminal(n1)]))
		case production(str n1, sequence([nonterminal(n1), nonterminal(n1), nonterminal(n2)])) =>
			production(n1, sequence([nonterminal(n1), nonterminal(n2), nonterminal(n1)]))
	};
	return g;
}
// SLEIR:PermutePrefix2Infix
@doc{permute ⊢ PermutePrefix2Infix, Type III, page 9}
public GGrammar mutate(PermutePrefix2Infix(), GGrammar g)
{
	g.P = visit (g.P)
	{
		case production(str n1, sequence([terminal(t1), nonterminal(n1), nonterminal(n1)])) =>
			production(n1, sequence([nonterminal(n1), terminal(t1), nonterminal(n1)]))
		case production(str n1, sequence([nonterminal(n2), nonterminal(n1), nonterminal(n1)])) =>
			production(n1, sequence([nonterminal(n1), nonterminal(n2), nonterminal(n1)]))
	};
	return g;
}
// SLEIR:PermutePrefix2Postfix
@doc{permute ⊢ PermutePrefix2Postfix, Type III, page 9}
public GGrammar mutate(PermutePrefix2Postfix(), GGrammar g)
{
	g.P = visit (g.P)
	{
		case production(str n1, sequence([terminal(t1), nonterminal(n1)])) =>
			production(n1, sequence([nonterminal(n1), terminal(t1)]))
		case production(str n1, sequence([nonterminal(n2), nonterminal(n1)])) =>
			production(n1, sequence([nonterminal(n1), nonterminal(n2)]))
		case production(str n1, sequence([terminal(t1), nonterminal(n1), nonterminal(n1)])) =>
			production(n1, sequence([nonterminal(n1), nonterminal(n1), terminal(t1)]))
		case production(str n1, sequence([nonterminal(n2), nonterminal(n1), nonterminal(n1)])) =>
			production(n1, sequence([nonterminal(n1), nonterminal(n1), nonterminal(n2)]))
	};
	return g;
}
// SLEIR:PermuteInfix2Prefix
@doc{permute ⊢ PermuteInfix2Prefix, Type III, page 9}
public GGrammar mutate(PermuteInfix2Prefix(), GGrammar g)
{
	g.P = visit (g.P)
	{
		case production(str n1, sequence([nonterminal(n1), terminal(t1), nonterminal(n1)])) =>
			production(n1, sequence([terminal(t1), nonterminal(n1), nonterminal(n1)]))
		case production(str n1, sequence([nonterminal(n1), nonterminal(n2), nonterminal(n1)])) =>
			production(n1, sequence([nonterminal(n2), nonterminal(n1), nonterminal(n1)]))
	};
	return g;
}
// SLEIR:PermuteInfix2Postfix
@doc{permute ⊢ PermuteInfix2Postfix, Type III, page 9}
public GGrammar mutate(PermuteInfix2Postfix(), GGrammar g)
{
	g.P = visit (g.P)
	{
		case production(str n1, sequence([nonterminal(n1), terminal(t1), nonterminal(n1)])) =>
			production(n1, sequence([nonterminal(n1), nonterminal(n1), terminal(t1)]))
		case production(str n1, sequence([nonterminal(n1), nonterminal(n2), nonterminal(n1)])) =>
			production(n1, sequence([nonterminal(n1), nonterminal(n1), nonterminal(n2)]))
	};
	return g;
}

// NOT done: project - page 12 "Further generalisation of injection/projection is possible, but seems too idiosyncratic to include here."

// SLEIR:RAssocAll
@doc{iterate ⊢ RAssocAll, Type II, page 7}
public GGrammar mutate(RAssocAll(), GGrammar g)
	= mutate(LAssocAll(), g);

// SLEIR:RedefineAll
@doc{redefine ⊢ RedefineAll, Type IV, page 11}
public GGrammar mutate(RedefineAll(GProdList ps), GGrammar g)
{
	// Generalised code is way too slow, replaced with an incredibly fast native Rascal alternative
	for (str n <- {p.lhs | p <- ps})
	{
		<ops1,ops2,ops3> = splitPbyW(g.P,n);
		<nps1,nps2,nps3> = splitPbyW(ps,n);
		g.P = ops1 + nps2 + ops3;
		ps = nps1 + nps3;
	}
	// TODO: "Even though redefining a nonterminal has been studied in various frameworks before [DCMS02, KLV02, LZ11],
	// the kind of grammar composition that RedefineAll offers, has never been explicitly considered."
	return g;
}

// NOT done: removeH, removeV - page 12

// SLEIR:DropSuffixN
@doc{renameN ⊢ DropSuffixN, Type IV, NEW: invented after the paper got published}
public GGrammar mutate(DropSuffixN(GNonTerm pre, GNonTerm post), GGrammar g)
{
	for (str n <- g.N, startsWith(n,pre), endsWith(n,post))
		g = grammarlab::transform::XBGF::performRenameN(n,replaceLast(replaceFirst(n,pre,""),post,""),g); 
	return g;
}

// TODO: RenameAllL [right now the implementation treats only top level labels!]

// SLEIR:RenameAllN
@doc{renameN ⊢ RenameAllN, Type IV, page 9}
public GGrammar mutate(RenameAllN(GNonTerm x, GNonTerm y), GGrammar g)
{
	nc1 = inferConvention(x);
	nc2 = inferConvention(y);
	for (str n <- g.N, confirmConvention(n,nc1), m := changeConvention(n,nc1,nc2), m notin g.N)
		g = grammarlab::transform::XBGF::performRenameN(n,m,g); 
	return g;
}

// SLEIR:RenameAllT
@doc{renameT ⊢ RenameAllT, Type IV, page 9}
public GGrammar mutate(RenameAllT(GTerm x, GTerm y), GGrammar g)
{
	nc1 = inferConvention(x);
	nc2 = inferConvention(y);
	for (str n <- g.N, confirmConvention(n,nc1), m := changeConvention(n,nc1,nc2), m notin g.N)
		g = grammarlab::transform::XBGF::performRenameT(n,m,g); 
	return g;
}

// TODO: RenameAllS [performRenameS is not defined, marks could be terribly local, the mutation should not destroy that!]

// NOT done: replace - page 11 "in a sense, replace ⊢ replace"

// SLEIR:Reroot2top
@doc{reroot ⊢ Reroot2top, Type II, page 8}
public GGrammar mutate(Reroot2top(), GGrammar g)
	= grammar(g.N, g.P, TOP(g));

// NOT done: splitN - page 12

// SLEIR:SplitAllT
@doc{splitT ⊢ SplitAllT, Type II, page 8}
public GGrammar mutate(SplitAllT(), GGrammar g)
{
	g.P = visit(g.P){
		case terminal(t):
			if (splittable(t)) insert sequence([terminal(st) | st <- splintered(t)]);
	};
	return g;
}

// Needed for: SplitAllT
bool splittable(str t) = !isAlpha(t) && len(t)>1;
list[str] splintered(str t)
{
	list[list[int]] ts = [];
	for (int c <- chars(t))
	{
		if(isAlpha(c) && !isEmpty(ts) && !isEmpty(ts[-1]) && isAlpha(ts[-1][-1]))
				ts[-1] += c;
		else
				ts += [[c]];
	}
	return [stringChars(cs) | cs <- ts];
}

// SLEIR:UnchainAll
@doc{unchain ⊢ UnchainAll, Type I, page 6}
public GGrammar mutate(UnchainAll(), GGrammar g)
{
	// Generalised code was too slow, replaced with a faster and shorter native Rascal alternative
	for (p <- g.P,
			(	production(n1,nonterminal(n2)) := p
			||	production(n1,label(_,nonterminal(n2))) := p
			||	production(n1,mark(_,nonterminal(n2))) := p
			||	production(n1,label(_,mark(_,nonterminal(n2)))) := p
			),
			n1 != n2,
			n2 in g.N)
		g.P -= p;
	return g;
}

// SLEIR:UndefineTrivial
@doc{undefine ⊢ UndefineTrivial, Type II, page 8}
public GGrammar mutate(UndefineTrivial(), GGrammar g)
{
	// Generalisation is based on undefineTrue
	for (
		x <- g.N, // for all nonterminals
		/nonterminal(x) := g.P, // which are used in the grammar
		<ps1,ps2,ps3> := splitPbyW(g.P,innt(x)),
		[production(x,rhs)] := ps2,
		(
			empty() := rhs // if it’s a failure
		||  epsilon() := rhs // or an empty string language
		||  anything() := rhs // or a universal symbol
		||  nothing() := rhs // (not really needed, just a safety net)
		))
	g.P = ps1 + ps3;
	return g;
}

// SLEIR:UnfoldMax
@doc{unfold ⊢ UnfoldMax, Type I, page 5}
public GGrammar mutate(UnfoldMax(), GGrammar g)
{
	// A code clone of InlineMax
	for (
		n <- g.N - g.S,
		<ps1,ps2,ps3> := splitPbyW(g.P,innt(n)),
		len(ps2)==1,  // horizontal!
		/nonterminal(n) !:= ps2) // non-recursive!
	g.P
		= performReplace(nonterminal(n), normalise(ps2[0].rhs), ps1)
		+ ps2
		+ performReplace(nonterminal(n), normalise(ps2[0].rhs), ps3);
	return g;
}

// SLEIR:UniteBySuffix
@doc{unite ⊢ UniteBySuffix, Type IV, page 11}
public GGrammar mutate(UniteBySuffix(GNonTerm pre, GNonTerm post), GGrammar g)
{
	if (pre+post in g.N) return g; //TODO: should be an error "united nonterminal name is not fresh"
	united = [n | n <- g.N, startsWith(n,pre), endsWith(n,post)];
	if (len(united)<2) return g; //TODO: should be an error "not enough nonterminals to unite"
	return transform([renameN(united[0],pre+post)] + [unite(pre+post,nt) | nt <- tail(united)], g);
}

// SLEIR:RetireLs
@doc{unlabel ⊢ RetireLs, Type II, stripped from the paper}
public GGrammar mutate(RetireLs(), GGrammar g)
{
	// the generalised code is too slow, replaced with a faster native Rascal alternative
	g.P = visit(g.P){case label(_,GExpr e) => e};
	return g;
}

// NOT done: upgrade - page 12

// SLEIR:VerticalAll
@doc{vertical ⊢ VerticalAll, Type I, page 6}
public GGrammar mutate(VerticalAll(), GGrammar g)
{
	for (n <- g.N, <ps1,ps2,ps3> := splitPbyW(g.P,innt(n)))
		g.P = ps1 + [production(n,e) | y <- [(choice(L) := p.rhs || label(_,choice(L)) := p.rhs)?L:[p.rhs] | p <- ps2], e <- y] + ps3;
	return g;
}

//SLEIR:Widen* -> see grammarlab::transform::sleir::Width

// WIP

// SLEIR:YaccifyAllL
@doc{yaccify ⊢ YaccifyAllL, Type III, page 10}
public GGrammar mutate(YaccifyAllL(), GGrammar g)
{
	GProdList ps = [];
	for (GProd p <- g.P)
	{
		if (production(n,sequence([y,star(x)])):=p)
			ps += [production(n,sequence([nonterminal(n),x])),
				   production(n,y)];
		if (production(n,plus(x)):=p)
			ps += [production(n,sequence([nonterminal(n),x])),
				   production(n,x)];
		if (production(n,star(x)):=p)
			ps += [production(n,sequence([nonterminal(n),x])),
				   production(n,epsilon())];
	};
	return grammar(g.N, ps, g.S);
}
// SLEIR:YaccifyAllR
@doc{yaccify ⊢ YaccifyAllR, Type III, page 10}
public GGrammar mutate(YaccifyAllR(), GGrammar g)
{
	GProdList ps = [];
	for (GProd p <- g.P)
	{
		if (production(n,sequence([star(x),y])):=p)
			ps += [production(n,sequence([x,nonterminal(n)])),
				   production(n,y)];
		if (production(n,plus(x)):=p)
			ps += [production(n,sequence([x,nonterminal(n)])),
				   production(n,x)];
		if (production(n,star(x)):=p)
			ps += [production(n,sequence([x,nonterminal(n)])),
				   production(n,epsilon())];
	};
	return grammar(g.N, ps, g.S);
}

public default GGrammar mutate(MCommand m, GGrammar g)
{
	println("Don’t know how to mutate with <m>.");
	return g;
}
