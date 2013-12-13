@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI; UvA}
module grammarlab::transform::XBGF

import grammarlab::compare::Differ;
import grammarlab::export::XBNF;
import grammarlab::language::Grammar;
import grammarlab::language::X;
import grammarlab::language::XOutcome;
import grammarlab::language::XScope;
import grammarlab::lib::Scoping;
import grammarlab::lib::Sizes;
import grammarlab::transform::Normal;
import IO; // debug
import List; //slice
import Set;

// XBGF:abridge
@doc{Removes a reflexive chain production rule - http://github.com/grammarware/slps/wiki/Abridge}
public XResult transform(abridge(GProd p), GGrammar g)
{
	if (production(str n, nonterminal(n)) !:= p &&
		production(str n, mark(_,nonterminal(n))) !:= p &&
		production(str n, label(_,nonterminal(n))) !:= p &&
		production(str n, label(_,mark(_,nonterminal(n)))) !:= p)
		return <problemProd("Production cannot be abridged.",p),g>;
	if (!inProds(p, g.P))
		return <notFoundP(p),g>;
	return <ok(), grammar(g.N, g.P - p, g.S)>;
}

// XBGF:abstractize
// TODO: reimplement for arbitrary markers
public XResult transform(abstractize(GProd p1), GGrammar g)
{
	p2 = unmark(p1);
	if (!inProds(p2,g.P))
		return <notFoundP(p2),g>;
	for (/mark("",e) := p1)
		if (terminal(_) !:= e)
			return <problem("Abstractize only works with marked terminals, use project instead."),g>;
	return transform(project(p1),g);
}

// XBGF:addC
public XResult transform(addC(GProd p), GGrammar g)
{
	<ps1,ps2,ps3> = splitPbyW(g.P,innt(p.lhs));
	if ([GProd q] := ps2)
	{
		if (p.lhs != q.lhs)
			return <problemStr("Incorrect splitting by nonterminal scope",p.lhs),g>;
		pq = production(p.lhs,allof([p.rhs,q.rhs]));
		return <ok(),grammar(g.N, ps1 + [pq] + ps3, g.S)>;
	}
	else
		return <problemStr("Nonterminal must be defined horizontally",p.lhs),g>;
}

// XBGF:addH
public XResult transform(addH(GProd p1), GGrammar g)
{
	p2 = unmark(p1);
	p3 = demarkH(p1);
	if (!inProds(p3,g.P))
		return <notFoundP(p3),g>;
	return <ok(),grammar(g.N, replaceP(g.P,p3,p2), g.S)>;
}

// XBGF:addV
public XResult transform(addV(GProd p1), GGrammar g)
{
	GProdList ps1,ps2,ps3;
	iprintln(g.P);
	<ps1,ps2,ps3> = splitPbyW(g.P,innt(p1.lhs));
	if (isEmpty(ps2))
		return <problemStr("Nonterminal must be defined",p1.lhs),g>;
	if (inProds(p1,ps2))
		return <problemProd("Production rule is already present",p1),g>;
	if (label(str name, _) := p1.rhs)
		if (production(_,label(name,_)) <- ps1+ps3)
			return <problemStr("Another production rule with the same label is already present",name),g>;
	return <ok(), grammar(g.N, ps1 + ps2 + p1 + ps3, g.S)>;
}

// XBGF:anonymize
// selectors for subexpressions
public XResult transform(anonymize(GProd p1), GGrammar g)
{
	p2 = unmark(p1);
	p3 = demarkS(p1);
	if (!inProds(p2,g.P))
		return <notFoundP(p1),g>;
	return <ok(),grammar(g.N, replaceP(g.P,p2,p3), g.S)>;
}

// XBGF:appear
// TODO: reimplement for arbitrary markers
public XResult transform(appear(GProd p1), GGrammar g)
{
	p2 = demark(p1);
	if (!inProds(p2,g.P))
		return <notFoundP(p2),g>;
	for (/mark("",e) := p1)
		if (optional(_) !:= e && star(_) !:= e)
			return <problemProd("Production rule does not have an optional part marked",p1),g>;
	return <ok(),grammar(g.N, replaceP(g.P,p2,unmark(p1)), g.S)>;
}

public XResult transform(bypass(), GGrammar g)
	= <ok(),g>;

// XBGF:chain
@doc{Introduces a chain production rule - http://github.com/grammarware/slps/wiki/Chain}
public XResult transform(chain(GProd p), GGrammar g)
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
				return <problemProds("Too many production rules qualify",ps2),g>;
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

// XBGF:clone
public XResult transform(clone(str x, str y, XScope w), GGrammar g)
{
	// TODO
	return <ok(),g>;
}

// XBGF:concatT
public XResult transform(concatT(list[str] xs, str y, XScope w), GGrammar g)
{
	if (y != intercalate("",xs))
		return <problemStrs("Terminal \'<y>\' cannot be combined from",xs),g>;
	// TODO: more preconditions?
	return transform(replace(sequence([terminal(x) | x <- xs]),terminal(y),w), g);
}

// XBGF:concretize
public XResult transform(concretize(GProd p1), GGrammar g)
{
	p2 = demark(p1);
	if (!inProds(p2,g.P))
		return <notFoundP(p2),g>;
	for (/mark("",e) := p1)
		if (terminal(_) !:= e)
			return <problem("Concretize only works with marked terminals, use inject instead."),g>;
	return transform(inject(p1),g);
}

// XBGF:deanonymize
public XResult transform(deanonymize(GProd p1), GGrammar g)
{
	p2 = unmark(p1);
	p3 = demarkS(p1);
	if (!inProds(p3,g.P))
		return <notFoundP(p1),g>;
	return <ok(),grammar(g.N, replaceP(g.P,p3,p2), g.S)>;
}

// XBGF:define
public XResult transform(define(GProdList ps), GGrammar g)
{
	if ({str n} := {p.lhs | GProd p <- ps})
	{
		if (/nonterminal(n) !:= g.P)
			return <problemStr("Nonterminal must not be fresh, use introduce instead",n),g>;
		return <ok(), grammar(g.N + n, g.P + ps, g.S)>;
	}
	else
		return <problem("Multiple defined nonterminals found"),g>;
}

// XBGF:designate
// true labels; TODO: sort out separation of features between designate and deanonymise
public XResult transform(designate(GProd p), GGrammar g)
{
	if (label(str name, GExpr expr) := p.rhs)
	{
		str plhs = p.lhs; // TODO: fix Rascal bug
		if (production(plhs, expr) <- g.P)
			return <ok(),grammar(g.N, replaceP(g.P, production(p.lhs, expr), p), g.S)>;
		else
			return <problemProd("Production rule not found, use renameL instead",p),g>;
	}
	else
		return <problemProd("Production rule must me labelled, use unlabel or renameL instead",p),g>;
}

// XBGF:detour
@doc{Adds a reflexive chain production rule - http://github.com/grammarware/slps/wiki/Detour}
public XResult transform(detour(GProd p), GGrammar g)
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

// Needed for: deyaccify
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

// XBGF:deyaccify
public XResult transform(deyaccify(str n), GGrammar g)
{
	if (n notin g.N)
		return <freshName(n),g>;
	<ps1,ps2,ps3> = splitPbyW(g.P,innt(n));
	if (len(ps2) > 2)
		return <problemProds("No deyaccification patterns for <len(ps2)> production rules known",ps2),g>;
	elseif (len(ps2) == 2)
		return <ok(), grammar(g.N, ps1 + performDeYacc(toSet(ps2)) + ps3, g.S)>;
	elseif ([production(n,choice([e1,e2]))] := ps2)
		return <ok(), grammar(g.N, ps1 + performDeYacc({production(n,e1),production(n,e2)}) + ps3, g.S)>;
	return <problemStr("Nonterminal must be defined vertically for deyaccification to work",n),g>;
}

// XBGF:disappear
// TODO: reimplement for arbitrary markers
public XResult transform(disappear(GProd p1), GGrammar g)
{
	p2 = unmark(p1);
	if (!inProds(p2,g.P))
		return <notFoundP(p2),g>;
	for (/mark("",e) := p1)
		if (optional(_) !:= e && star(_) !:= e)
			return <problemProd("Production rule does not have an optional part marked",p2),g>;
	return <ok(),grammar(g.N, replaceP(g.P,p2,demark(p1)), g.S)>;
}

// Needed for: distribute
GProd makeDistributed(GProd p) = production(p.lhs, makeDistributed(p.rhs));

// propagating distribution - could possibly be rewritten as a visitor, but more understandable this way
GExpr makeDistributed(label(str name, GExpr expr)) = label(name,makeDistributed(expr));
GExpr makeDistributed(mark(str name, GExpr expr)) = mark(name,makeDistributed(expr));
GExpr makeDistributed(not(GExpr expr)) = not(makeDistributed(expr));
GExpr makeDistributed(except(GExpr expr1, GExpr expr2)) = except(makeDistributed(expr1),makeDistributed(expr2));
GExpr makeDistributed(optional(GExpr expr)) = optional(makeDistributed(expr));
GExpr makeDistributed(star(GExpr expr)) = star(makeDistributed(expr));
GExpr makeDistributed(plus(GExpr expr)) = plus(makeDistributed(expr));
GExpr makeDistributed(sepliststar(GExpr expr, GExpr sep)) = sepliststar(makeDistributed(expr),makeDistributed(sep));
GExpr makeDistributed(seplistplus(GExpr expr, GExpr sep)) = seplistplus(makeDistributed(expr),makeDistributed(sep));
GExpr makeDistributed(choice(GExprList L1))
{
	GExprList Ln = [];
	for (e2 <- L1)
	{
		e3 = makeDistributed(e2);
		if (choice(L2) := e3)
			Ln += L2;
		else
			Ln += e2; // TODO or e3?
	}
	return choice(Ln);
}

// The real magic of distribution happens here
GExpr makeDistributed(sequence(L1))
{
	list[GExprList] Ln = [[]];
	for (e2 <- L1)
	{
		e3 = makeDistributed(e2);
		if (choice(L2) := e3)
			Ln = [Li + e4 | Li <- Ln, e4 <- L2];
		else
			Ln = [Li + e3 | Li <- Ln]; // TODO or e2?
	}
	return choice([sequence(Li) | Li <- Ln]);
}

default GExpr makeDistributed(GExpr e) = e;


// XBGF:distribute
public XResult transform(distribute(XScope w), GGrammar g)
{
	<ps1,ps2,ps3> = splitPbyW(g.P,w);
	if (/choice(_) !:= ps2)
		return <problemScope("No choices found, nothing to distribute",w),g>;
	return <ok(),grammar(g.N, ps1 + normalise([makeDistributed(p) | p <- ps2]) + ps3, g.S)>;
}

// XBGF:downgrade
// Liberal form of folding
public XResult transform(downgrade(GProd p1,GProd p2), GGrammar g)
{
	// TODO: generalise to work on named markers
	if (/mark("",nonterminal(str x)) := p1)
		if (production(x,GExpr e) := p2)
		{
			GProd p3 = visit(p1){case mark("",_) => e};
			return <ok(), normalise(grammar(g.N, replaceP(g.P,unmark(p1),p3), g.S))>;
		}
		else
			return <problemProd2("Production rules do not agree on nonterminal",p1,p2),g>;
	else
		return <problemProd("Production rule does not have a single nonterminal marked",p1),g>;
}

// XBGF:eliminate
public XResult transform(eliminate(str x), GGrammar g)
{
	if (x in g.S)
		return <problemStr("Cannot eliminate root nonterminal",x),g>;
	if (x notin g.N)
		return <freshName(x),g>;
	GProdList ps = [p | GProd p <- g.P, p.lhs != x];
	if (/nonterminal(x) := ps)
		return <notFreshName(x),g>;
	return <ok(), grammar(g.N - x, ps, g.S)>;
}

// XBGF:equate
public XResult transform(equate(str x, str y), GGrammar g)
{
	if (x == y)
		return <problemStr("Nonterminal is already equated with itself",x),g>;
	<ps1x,ps2x,ps3x> = splitPbyW(g.P,innt(x));
	<_,ps2y,_> = splitPbyW(g.P,innt(y));
	XResult rep = transform(renameN(x,y), normalise(grammar([],ps2x,[])));
	if (ok() !:= rep.r) return rep;
	gxy = rep.g;
	gyy = normalise(grammar([],ps2y,[]));
	if (!gdts(gxy,gyy))
		return <problemStr2("Definitions of nonterminals must be equal",x,y),g>;
	if (x in usedNs(ps1x + ps3x))
		return transform(replace(nonterminal(x),nonterminal(y),globally()), grammar(g.N, ps1x + ps3x, g.S - x));
	else
		return <ok(),grammar(g.N, ps1x + ps3x, g.S - x)>;
}

// XBGF:extract
public XResult transform(extract(GProd p, XScope w), GGrammar g)
{
	if (p.lhs in g.N)
		return <notFreshN(p.lhs),g>;
	// TODO hard to check if rhs occurs in the grammar; it was somehow done in xbgf1.pro 
	XResult rep = transform(replace(p.rhs,nonterminal(p.lhs),w),g);
	if (ok() !:= rep.r) return rep;
	else return <ok(),normalise(grammar(g.N + p.lhs, rep.g.P + p, rep.g.S))>;
}

// XBGF:factor
public XResult transform(factor(GExpr e1, GExpr e2, XScope w), GGrammar g)
{
	GExpr e3 = normalise(makeDistributed(e1));
	GExpr e4 = normalise(makeDistributed(e2));
	if (!eqE(e3, e4))
		return <problemExpr2("Expressions must be related by distribution.",e1,e2),g>;
	return transform(replace(e1,e2,w),g);
}

// XBGF:fold
public XResult transform(fold(str x, XScope w), GGrammar g)
{
	if (<_,[production(x, GExpr rhs)],_> := splitPbyW(g.P,innt(x)))
		return transform(replace(rhs,nonterminal(x),comboscope(notinnt(x),w)),g);
	else 
		return <problemStr("Nonterminal must be defined horizontally prior to folding",x),g>;
}

// XBGF:horizontal
public XResult transform(horizontal(XScope w), GGrammar g)
{
	// NB: for xbgf1.pro, the context must be strictly vertical. Here we are more relaxed. 
	<ps1,ps2,ps3> = splitPbyW(g.P,w);
	if ([production(_,choice(_))] := ps2)
		return <problemScope("Scope is already horizontal",w),g>;
	GExprList es4 = [];
	for (production(str x, GExpr e) <- ps2)
		if (choice(L) := e)
			es4 += L;
		else
			es4 += e;
	if (innt(str x) := w)
		return <ok(),grammar(g.N, ps1 + production(x,choice(es4)) + ps3, g.S)>;
	else
		return <problemScope("Scope for horizontal must be a nonterminal",w),g>;
}

// XBGF:importG
public XResult transform(importG(GProdList ps), GGrammar g)
{
	set[str] defs1 = {p.lhs | GProd p <- ps};
	set[str] defs12 = defs1 & toSet(g.N);
	set[str] du12 = defs1 & {n | /nonterminal(str n) := g.P};
	if (!isEmpty(defs12))
		return <problemStrs("Import clashes with existing definitions", toList(defs12)),g>;
	if (!isEmpty(du12))
		return <problemStrs("Import clashes with existing definitions", toList(du12)),g>;
	// WTF
	if (/production("⟙",rhs) := ps)
	{
		<ps1,ps2,ps3> = splitPbyW(ps,innt("⟙"));
		if (choice(RS) := rhs)
			return <ok(), normalise(grammar(g.N, g.P+ps1+ps3, g.S+[r | nonterminal(str r) <- RS]))>;
		if (nonterminal(str r) := rhs)
			return <ok(), normalise(grammar(g.N, g.P+ps1+ps3, g.S+[r]))>;
	}
	return <ok(), normalise(grammar(g.N, g.P + ps, g.S))>;
}

// XBGF:inject
// TODO: reimplement for arbitrary markers?
public XResult transform(inject(GProd p1), GGrammar g)
{
	p2 = demark(p1);
	if (!inProds(p2,g.P))
		return <notFoundP(p2),g>;
	return <ok(),grammar(g.N, replaceP(g.P,p2,unmark(p1)), g.S)>;
}

// XBGF:inline
public XResult transform(inline(str x), GGrammar g)
{
	if (x in g.S)
		return <problemStr("Cannot inline root nonterminal",x),g>;
	if (<ps1,[production(x, GExpr rhs)],ps2> := splitPbyW(g.P,innt(x)))
		return transform(replace(nonterminal(x),rhs,globally()),grammar(g.N-x, ps1+ps2, g.S));
	else 
		return <problemStr("Nonterminal must be defined horizontally prior to inlining.",x),g>;
}

// XBGF:introduce
public XResult transform(introduce(GProdList ps), GGrammar g)
{
	if ({str n} := {p.lhs | GProd p <- ps})
	{
		if (n in g.N)
			return <problemStr("Definition for nonterminal clashes with existing definition",n),g>;
		if (/nonterminal(n) := g.P)
			return <notFreshN(n),g>;
		return <ok(),grammar(g.N + n, g.P + ps, g.S)>;
	}
	else
		return <problem("Multiple defined nonterminals found"),g>;
}

// needed for: iterate, rassoc, lassoc
bool admit(sequence([nonterminal(n),nonterminal(x),nonterminal(n)]),
		   sequence([nonterminal(n),star(sequence([nonterminal(x),nonterminal(n)]))])) = true;
bool admit(sequence([nonterminal(n),nonterminal(x),nonterminal(n)]),
		   sequence([star(sequence([nonterminal(n),nonterminal(x)])),nonterminal(n)])) = true;
bool admit(sequence([nonterminal(n),nonterminal(n)]),
		   plus(nonterminal(n))) = true;
default bool admit(GExpr e1, GExpr e2) = false;

// XBGF:iterate
public XResult transform(iterate(GProd p), GGrammar g)
{
	str x = p.lhs;
	GProdList ps1,ps2,ps3;
	GExpr e1,e2;
	if (label(str l, GExpr e) := p.rhs)
	{
		<ps1,ps2,ps3> = splitPbyW(g.P,comboscope(inlabel(l),innt(x)));
		e1 = e;
	}
	else
	{
		<ps1,ps2,ps3> = splitPbyW(g.P,innt(x));
		e1 = p.rhs;
	}
	if ([production(x, GExpr e2a)] := ps2)
	{
		if (label(_, GExpr e2b) := e2a) e2 = e2b; else e2 = e2a;
		if (admit(e2, e1))
			return <ok(),grammar(g.N, ps1 + p + ps3, g.S)>;
		else
			return <problemExpr2("Production rule must admit associativity transformation",e1,e2),g>;
	}
	else
		return <problemPinProds("Cannot find the right production rule to match",p,ps2),g>;
}

// XBGF:lassoc
public XResult transform(lassoc(GProd p), GGrammar g)
{
	str x = p.lhs;
	GProdList ps1,ps2,ps3;
	GExpr e1,e2;
	if (label(str l, GExpr e) := p.rhs)
	{
		<ps1,ps2,ps3> = splitPbyW(g.P,comboscope(inlabel(l),innt(x)));
		e1 = e;
	}
	else
	{
		<ps1,ps2,ps3> = splitPbyW(g.P,innt(x));
		e1 = p.rhs;
	}
	if ([production(x, GExpr e2a)] := ps2)
	{
		if (label(_, GExpr e2b) := e2a) e2 = e2b; else e2 = e2a;
		if (admit(e1, e2))
			return <ok(),grammar(g.N, ps1 + p + ps3, g.S)>;
		else
			return <problemExpr2("Production rule must admit associativity transformation",e1,e2),g>;
	}
	else
		return <problemPinProds("Cannot find the right production rule to match",p,ps2),g>;
}

// Needed for: massage
// lifting and sinking marks and labels
bool massage_eq({optional(mark(s,x)), mark(s,optional(x))}) = true; //@OptMark-MarkOpt
bool massage_eq({optional(label(s,x)), label(s,optional(x))}) = true; //@OptLabel-LabelOpt
bool massage_eq({star(mark(s,x)), mark(s,star(x))}) = true; //@StarMark-MarkStar
bool massage_eq({star(label(s,x)), label(s,star(x))}) = true; //@StarLabel-LabelStar
bool massage_eq({plus(mark(s,x)), mark(s,plus(x))}) = true; //@PlusMark-MarkPlus
bool massage_eq({plus(label(s,x)), label(s,plus(x))}) = true; //@PlusLabel-LabelPlus
bool massage_eq({not(label(s,x)), label(s,not(x))}) = true; //@NotLabel-LabelNot
bool massage_eq({not(mark(s,x)), mark(s,not(x))}) = true; //@NotMark-MarkNot

// combinations of optionality and closures
bool massage_eq({optional(optional(x)), optional(x)}) = true; //@OptOpt-Opt
bool massage_eq({optional(star(x)), star(x)}) = true; //@OptStar-Star
bool massage_eq({optional(plus(x)), star(x)}) = true; //@OptPlus-Star
bool massage_eq({star(optional(x)), star(x)}) = true; //@StarOpt-Star
bool massage_eq({star(star(x)), star(x)}) = true; //@StarStar-Star
bool massage_eq({star(plus(x)), star(x)}) = true; //@StarPlus-Star
bool massage_eq({plus(optional(x)), star(x)}) = true; //@PlusOpt-Star
bool massage_eq({plus(star(x)), star(x)}) = true; //@PlusStar-Star
bool massage_eq({plus(plus(x)), plus(x)}) = true; //@PlusPlus-Plus

// sequential variants of closures
bool massage_eq({sequence([star(x),star(x)]), star(x)}) = true; //@SeqStarStar-Star
bool massage_eq({sequence([optional(x),star(x)]), star(x)}) = true; //@SeqOptStar-Star
bool massage_eq({sequence([star(x),optional(x)]), star(x)}) = true; //@SeqStarOpt-Star
bool massage_eq({sequence([optional(x),plus(x)]), plus(x)}) = true; //@SeqOptPlus-Plus
bool massage_eq({sequence([plus(x),optional(x)]), plus(x)}) = true; //@SeqPlusOpt-Plus
bool massage_eq({sequence([plus(x),star(x)]), plus(x)}) = true; //@SeqPlusStar-Plus
bool massage_eq({sequence([star(x),plus(x)]), plus(x)}) = true; //@SeqStarPlus-Plus
bool massage_eq({sequence([x,star(x)]), plus(x)}) = true; //@SeqXStar-Plus
bool massage_eq({sequence([star(x),x]), plus(x)}) = true; //@SeqStarX-Plus

// disjunctions of optionality and closures, equivalent to x?
bool massage_eq({choice([x,epsilon()]), optional(x)}) = true; //@OrXEps-Opt
bool massage_eq({choice([epsilon(),x]), optional(x)}) = true; //@OrEpsX-Opt
bool massage_eq({choice([optional(x),epsilon()]), optional(x)}) = true; //@OrOptEps-Opt
bool massage_eq({choice([epsilon(),optional(x)]), optional(x)}) = true; //@OrEpsOpt-Opt
bool massage_eq({choice([optional(x),x]), optional(x)}) = true; //@OrOptX-Opt
bool massage_eq({choice([x,optional(x)]), optional(x)}) = true; //@OrXOpt-Opt

// disjunctions of optionality and closures, equivalent to x*
bool massage_eq({choice([star(x),x]), star(x)}) = true; //@OrStar1-Star
bool massage_eq({choice([x,star(x)]), star(x)}) = true; //@Or1Star-Star
bool massage_eq({choice([star(x),plus(x)]), star(x)}) = true; //@OrStarPlus-Star
bool massage_eq({choice([plus(x),star(x)]), star(x)}) = true; //@OrPlusStar-Star
bool massage_eq({choice([star(x),optional(x)]), star(x)}) = true; //@OrStarOpt-Star
bool massage_eq({choice([optional(x),star(x)]), star(x)}) = true; //@OrOptStar-Star
bool massage_eq({choice([star(x),epsilon()]), star(x)}) = true; //@OrStarEps-Star
bool massage_eq({choice([epsilon(),star(x)]), star(x)}) = true; //@OrEpsStar-Star
bool massage_eq({choice([plus(x),epsilon()]), star(x)}) = true; //@OrPlusEps-Star
bool massage_eq({choice([epsilon(),plus(x)]), star(x)}) = true; //@OrEpsPlus-Star
bool massage_eq({choice([plus(x),optional(x)]), star(x)}) = true; //@OrPlusOpt-Star
bool massage_eq({choice([optional(x),plus(x)]), star(x)}) = true; //@OrOptPlus-Star

// disjunctions of optionality and closures, equivalent to x+
bool massage_eq({choice([plus(x),x]), plus(x)}) = true; //@OrPlusX-Plus
bool massage_eq({choice([x,plus(x)]), plus(x)}) = true; //@OrXPlus-Plus

// introducing multiple labels and marks
bool massage_eq({x, choice([label(_,x),label(_,x)])}) = true; //@OrLabels2-
bool massage_eq({x, choice([label(_,x),label(_,x),label(_,x)])}) = true; //@OrLabels3-
bool massage_eq({x, choice([mark(_,x),mark(_,x)])}) = true; //@OrMarks2-
bool massage_eq({x, choice([mark(_,x),mark(_,x),mark(_,x)])}) = true; //@OrMarks3-

// separator lists
bool massage_eq({sequence([x,optional(sequence([y,x]))]), sequence([optional(sequence([x,y])),x])}) = true; //@SeqXOpt-SeqOptX
bool massage_eq({sequence([x,plus(sequence([y,x]))]), sequence([plus(sequence([x,y])),x])}) = true; //@SeqXPlus-SeqPlusX
bool massage_eq({sequence([x,star(sequence([y,x]))]), sequence([star(sequence([x,y])),x])}) = true; //@SeqXStar-SeqStarX
bool massage_eq({sequence([x,star(sequence([y,x]))]), seplistplus(x,y)}) = true; //@SeqXStar-SLPlus
bool massage_eq({sequence([star(sequence([x,y])),x]), seplistplus(x,y)}) = true; //@SeqStarX-SLPlus
bool massage_eq({optional(sequence([x,star(sequence([y,x]))])), sepliststar(x,y)}) = true; //@OptSeqXStar-SLStar
bool massage_eq({optional(sequence([star(sequence([x,y])),x])), sepliststar(x,y)}) = true; //@OptSeqStarX-SLStar
bool massage_eq({optional(seplistplus(x,y)), sepliststar(x,y)}) = true; //@OptSLPlus-SLStar

// Boolean grammars
bool massage_eq({not(not(x)), x}) = true; //@NotNot-X
bool massage_eq({not(allof([x,y])), choice([not(x),not(y)])}) = true; //@NotAndXY-OrNotXY
bool massage_eq({not(allof([x,y])), choice([not(y),not(x)])}) = true; //@NotAndXY-OrNotYX
bool massage_eq({not(allof([not(x),not(y)])), choice([x,y])}) = true; //@NotAndNotXY-OrXY
bool massage_eq({not(allof([not(x),not(y)])), choice([y,x])}) = true; //@NotAndNotXY-OrYX
bool massage_eq({not(choice([x,y])), allof([not(x),not(y)])}) = true; //@NotOrXY-AndNotXY
bool massage_eq({not(choice([x,y])), allof([not(y),not(x)])}) = true; //@NotOrXY-AndNotYX
bool massage_eq({not(choice([not(x),not(y)])), allof([x,y])}) = true; //@NotOrNotXY-AndXY
bool massage_eq({not(choice([not(x),not(y)])), allof([y,x])}) = true; //@NotOrNotXY-AndYX
bool massage_eq({allof([x,not(y)]), except(x,y)}) = true; //@AndNot-Except

// otherwise, no
default bool massage_eq(GExprSet s) = false;

// XBGF:massage
public XResult transform(massage(GExpr e1, GExpr e2, XScope w), GGrammar g)
{
	if (massage_eq({e1,e2}))
		return transform(replace(e1,e2,w),g);
	else
		return <problemExpr2("Expressions are not massage-equivalent.",e1,e2),g>;
}

// Needed for: narrow, widen
// narrow-equivalence (the reverse, widen-equivalence, is hereby also implicitly defined)
bool narrowing(anything(),_) = true;
bool narrowing(star(e),plus(e)) = true;
bool narrowing(star(e),optional(e)) = true;
bool narrowing(star(e),e) = true;
bool narrowing(plus(e),e) = true;
bool narrowing(optional(e),e) = true;
default bool narrowing(_,_) = false;

// XBGF:narrow
public XResult transform(narrow(GExpr e1, GExpr e2, XScope w), GGrammar g)
{
	if (!narrowing(e1,e2))
		return <problemExpr2("Expressions are not in narrowing relation.",e1,e2),g>;
	return transform(replace(e1,e2,w),g);
}

// XBGF:permute
public XResult transform(permute(GProd p), GGrammar g)
{
	if (production(str n, sequence(L1)) := p)
	{
		<ps1,ps2,ps3> = splitPbyW(g.P,innt(n));
		if ([production(n, sequence(L2))] := ps2)
		{
			if (eqEsN(L1,L2))
				return <ok(),grammar(g.N, ps1 + p + ps3, g.S)>;
			else
				return <problemExpr2("Phrases must be permutations of each other",sequence(L1),sequence(L2)),g>;
		}
		else
			return <problemProds("Permutation requires a single sequence instead of",ps2),g>;
	}
	else
		return <problemProd("Permutation parameter requires a sequence instead of",p),g>;
	// TODO check if really dead code
	return <ok(),g>;
}

// XBGF:project
public XResult transform(project(GProd p1), GGrammar g)
{
	p2 = unmark(p1);
	if (!inProds(p2,g.P))
		return <notFoundP(p2),g>;
	return <ok(), grammar(g.N, replaceP(g.P, p2, demark(p1)), g.S)>;
}

// XBGF:rassoc
// NB: rassoc and lassoc are the same when they work on the grammar level
// the differences can only be observed on the instance level
public XResult transform(rassoc(GProd p), GGrammar g)
	= transform(lassoc(p), g);

// XBGF:redefine
public XResult transform(redefine(GProdList ps), GGrammar g)
{
	// inlined superposition of undefine and define, with two exceptional details:
	// (1) if ps1.n is a root, undefine would have stripped it from this status
	// (2) redefine preserves original order of production rules
	if ({str n} := {p.lhs | GProd p <- ps})
	{
		if (n notin g.N)
			return <freshName(n),g>;
		if (/nonterminal(n) !:= g.P)
			return <problemStr("Nonterminal must be used",n),g>;
		<ps1,_,ps2> = splitPbyW(g.P, innt(n));
		return <ok(),grammar(g.N, ps1 + ps + ps2, g.S)>; 
	}
	else
		return <problem("Please redefine one nonterminal at a time"),g>;
}

// XBGF:removeH
public XResult transform(removeH(GProd p1), GGrammar g)
{
	p2 = unmark(p1);
	if (!inProds(p2, g.P))
		return <notFoundP(p2),g>;
	return <ok(),grammar(g.N, replaceP(g.P,p2,demarkH(p1)), g.S)>;
}

// XBGF:removeV
public XResult transform(removeV(GProd p), GGrammar g)
{
	GProdList ps1,ps2,ps3,ps4;
	<ps1,ps2,ps3> = splitPbyW(g.P, innt(p.lhs));
	if (isEmpty(ps2))
		return <freshN(p.lhs),g>;
	ps4 = [q | GProd q <- ps2, !eqP(normalise(p),normalise(q))];
	if (ps2 == ps4)
		return <notFoundP(p),g>;
	if (isEmpty(ps4))
		return <problemStr("Cannot remove the last production rule with removeV, use undefine or eliminate",p.lhs),g>;
	return <ok(),grammar(g.N, ps1 + ps4 + ps3, g.S)>;
}

// XBGF:renameL
public XResult transform(renameL(str x, str y), GGrammar g)
{
	if (x == "")
		return <problem("Source label must not be empty for renaming, use designate"),g>;
	if (y == "")
		return <problem("Target label must not be empty for renaming, use unlabel"),g>;
	if (len([e | /label(x,e) <- g.P]) != 1)
		return <problemStr("Source name for renaming must be uniquely used",x),g>;
	if (/label(y,_) := g.P)
		return <problemStr("Target name for renaming must be fresh",y),g>;
	<ps1,ps2,ps3> = splitPbyW(g.P, inlabel(x));
	if ([production(lhs, label(x, GExpr e))] := ps2)
		return <ok(), grammar(g.N, ps1 + production(lhs, label(y, e)) + ps3, g.S)>;
	else
		return <problemStr("Label not found or not unique",x),g>; // the latter should never happen
}

// Needed for: renameN
GGrammar performRenameN(str x, str y, GGrammar g)
{
	GProdList ps1,ps2,ps3,ps4;
	list[str] rs2;
	list[str] ns2 = [];
	if ([*L1, x, *L2] := g.S) rs2 = L1 + y + L2;
	else rs2 = g.S;
	for (n <- g.N)
		if (n == x)
			ns2 += y;
		else
			ns2 += n;
	if (x in g.N)
	{
		<ps1,ps2,ps3> = splitPbyW(g.P,innt(x));
		ps4 = ps1 + [production(y, p.rhs) | p <- ps2, p.lhs == x] + ps3;
	}
	else
		ps4 = g.P;
	if (x in usedNs(ps4))
		return grammar(ns2, performReplace(nonterminal(x),nonterminal(y),ps4), rs2);
	else
		return grammar(ns2, ps4, rs2);
}

// XBGF:renameN
public XResult transform(renameN(str x, str y), GGrammar g)
{
	ns = allNs(g.P);
	if (x notin ns)
		return <freshN(x),g>;
	if (y in ns)
		return <notFreshN(y),g>;
	return
		<ok(),performRenameN(x,y,g)>;
}

// XBGF:renameS
public XResult transform(renameS(str x, str y, XScope w), GGrammar g)
{
	<ps1,ps2,ps3> = splitPbyW(g.P, w);
	if (/mark(x,_) !:= ps2)
		return <freshName("Source name",x),g>;
	if (/mark(y,_) := ps2)
		return <notFreshName("Target name",y),g>;
	ps4 = visit(ps2){case mark(x,GExpr e) => mark(y,e)}
	return <ok(),grammar(g.N, ps1 + ps4 + ps3, g.S)>;
}

// XBGF:renameT
public XResult transform(renameT(str x, str y), GGrammar g)
{
	ts = allTs(g.P);
	if (x notin ts)
		return <freshName("Source name",x),g>;
	if (y in ts)
		return <notFreshName("Target name",y),g>;
	return transform(replace(terminal(x),terminal(y),globally()), g);
}

// Low level operation, needed for: replace, performRenameN
GProdList performReplace(GExpr e1, GExpr e2, GProdList psi)
{
	GProdList ps;
	if (nonterminal(str a) := e1 && nonterminal(str b) := e2)
		ps = [production((p.lhs==a)?b:p.lhs,p.rhs) | GProd p <- psi];
	else
		ps = psi;
	return performReplaceRHS(e1,e2,ps);
}

// Low level operation, needed for: replace
GProdList performReplaceRHS(GExpr e1, GExpr e2, GProdList ps)
{
	GExprList L5;
	switch(e1)
	{
		// TODO: perhaps a different strategy for conjunctions?
		case sequence(L1):
		{
			if (sequence(L4) := e2) L5 = L4; else L5 = [e2];
			return visit(ps){case sequence(L2) => sequence(replaceSubsequence(L2,L1,L5))};
		}
		case choice(L1): 
		{
			if (choice(L4) := e2) L5 = L4; else L5 = [e2];
			return visit(ps){case choice(L2) => choice(replaceChoice(L2,L1,L5))};
		}
		default:
			return visit(ps){case e1 => e2}
	}
}

// Low level operation, needed for: replace
GExprList replaceSubsequence(GExprList where, GExprList what, GExprList with)
{
	if (eqE(sequence(where),sequence(what))) return with;
	int i = 0, sz = len(what);
	while (i+sz <= len(where))
	{
		if (eqE(sequence(slice(where,i,sz)),sequence(what)))
			return slice(where,0,i) + with + slice(where, i+sz, len(where)-i-sz);
		i+=1;
	}
	return where;
}

// Low level operation, needed for: replace
GExprList replaceChoice(GExprList where, GExprList what, GExprList with)
{
	if (eqE(choice(where),choice(what))) return with;
	unmatched = where;
	<res,es1,es2> = grammarlab::compare::Differ::tryMatchChoices(what,where);
	if (res)
		return es1 + with + es2;
	else
		return where;
}

// XBGF:replace
public XResult transform(replace(GExpr e1, GExpr e2, XScope w), GGrammar g)
{
	GProdList ps1,ps2,ps3,ps4;
	<ps1,ps2,ps3> = splitPbyW(g.P, w);
	ps4 = performReplace(e1,e2,ps2);
	if (eqPs(ps2,ps4))
		{
			ps4 = performReplace(normalise(e1),normalise(e2),ps2); // TODO check if needed
			println("Replacing <e1> with <e2>...");
			println("IN:  <ps2>");
			println("OUT: <ps4>");
			if (eqPs(ps2,ps4))
				return <problemExpr2("Vacuous replace",e1,e2),g>;
		}
	return <ok(),grammar(g.N, ps1 + normalise(ps4) + ps3, g.S)>;
}

// XBGF:reroot
public XResult transform(reroot(list[str] xs), GGrammar g)
{
	if (toSet(xs) == toSet(g.S))
		return <problemStrs("Vacuous reroot",xs),g>;
	// xbgf1.pro only asked for it to be a subset of allNs, not definedNs; we're more strict here
	for (str x <- xs, x notin g.N)
		return <problemStr("Cannot reroot to undefined nonterminal",x),g>;
	return <ok(), grammar(g.N, g.P, xs)>;
}

// XBGF:splitN
public XResult transform(splitN(str x, GProdList ps0, XScope w), GGrammar g)
{
	if ({str y} := definedNs(ps0))
	{
		if (x notin g.N)
			return <freshN(x),g>;
		if (y in allNs(g.P))
			return <notFreshN(y),g>;
		<ps2,ps3,ps4> = splitPbyW(g.P,innt(x));
		GProdList ps5 = [production(x,e) | production(y,GExpr e) <- ps0];
		if (x in g.S) rs2 = g.S + y; else rs2 = g.S;
		g = grammar(g.N, ps2 + (ps3 - ps5) + ps0 + ps4, rs2);
		if (nowhere() := w)
			return <ok(),g>;
		else
		{
			<pz1,pz2,pz3> = splitPbyW(g.P,w);
			return <ok(),grammar(g.N,pz1+performReplaceRHS(nonterminal(x),nonterminal(y),pz2)+pz3,g.S)>;
		}
	}
	else
		return <problem("Splitting into more than two nonterminals not supported"),g>;
		// TODO OR NOT TODO
}

// XBGF:splitT
public XResult transform(splitT(str x, list[str] ys, XScope w), GGrammar g)
{
	if (x != intercalate("",ys))
		return <problemStrs("Terminal \'<x>\' cannot be split into",ys),g>;
	// TODO: more preconditions?
	return transform(replace(terminal(x),sequence([terminal(y) | y <- ys]),w), g);
}


// XBGF:unchain
@doc{Removes a chain production rule - http://github.com/grammarware/slps/wiki/Unchain}
public XResult transform(unchain(GProd p), GGrammar g)
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

// XBGF:undefine
//TODO: undefine only one nonterminal per transformation
public XResult transform(undefine(list[str] xs), GGrammar g)
{
	XResult r = <ok(),g>;
	for (str x <- xs)
	{
		r = runUndefineTrue(x,r.g);
		if (ok() !:= r.r)
			return r;
	}
	return r;
}

// Needed for: undefine (to be replaced later)
XResult runUndefineTrue(str x, GGrammar g)
{
	if (x notin g.N)
		return <problemStr("Nonterminal must be defined.",x),g>;
	if (/nonterminal(x) !:= g.P)
		return <problemStr("Nonterminal must be used.",x),g>;
	return <ok(), grammar(g.N - x, [p | GProd p <- g.P, p.lhs != x], g.S - x)>;
}

// XBGF:unfold
public XResult transform(unfold(str x, XScope w), GGrammar g)
{
	if (<_,[production(x, GExpr rhs)],_> := splitPbyW(g.P,innt(x)))
		return transform(replace(nonterminal(x),rhs,comboscope(notinnt(x),w)),g);
	else
		return <problemStr("Nonterminal must be defined horizontally prior to unfolding",x),g>;
}

// XBGF:unite
public XResult transform(unite(str x, str y), GGrammar g)
{
	if (x == y)
		return <problemStr("Nonterminal is already united with itself",x),g>;
	used = allNs(g.P);
	if (x notin used)
		return <freshN(x),g>;
	if (y notin used)
		return <freshN(y),g>;
	<ps1x,ps2x,ps3x> = splitPbyW(g.P, innt(x));
	GProdList ps4x = ps1x + [production(y, p.rhs) | p <- ps2x, p.lhs == x] + ps3x;
	if (x in usedNs(ps4x))
		return transform(replace(nonterminal(x),nonterminal(y),globally()), grammar(g.N,ps4x,g.S));
	else
		return <ok(),grammar(g.N,ps4x,g.S)>;
}

// XBGF:unlabel
public XResult transform(unlabel(str x), GGrammar g)
{
	if (x == "")
		return <problem("Please specify which label to unlabel"),g>;
	<ps1,ps2,ps3> = splitPbyW(g.P, inlabel(x));
	if ([production(lhs, label(x, GExpr e))] := ps2)
		return <ok(),grammar(g.N, ps1 + production(lhs, e) + ps3, g.S)>;
	else
		return <problemStr("Label not found or not unique",x),g>; // the latter should never happen
}

// XBGF:upgrade
// Liberal form of folding
public XResult transform(upgrade(GProd p1, GProd p2), GGrammar g)
{
	// TODO: generalise to work on named markers
	if (/mark("",nonterminal(str x)) := p1)
		if (production(x,GExpr e) := p2)
		{
			p3 = visit(p1){case mark("",_) => e};
			return <ok(), normalise(grammar(g.N, replaceP(g.P,p3,unmark(p1)), g.S))>;
		}
		else
			return <problemProd2("Production rules do not agree on nonterminal",p1,p2),g>;
	else
		return <problemProd("Production rule must have one single nonterminal marked",p1),g>;
}


// XBGF:vertical
public XResult transform(vertical(XScope w), GGrammar g)
{
	<ps1,ps2,ps3> = splitPbyW(g.P, w);
	ps4 = [];
	// TODO: rethink the model of working with labels and marks
	for (production(str x, GExpr e) <- ps2)
		// TODO: should we really discard a label?
		if (choice(L) := e || label(_,choice(L)) := e)
			for (se <- L)
				if (label(str s, GExpr e2) := se)
					// TODO: this will always happen and does not make sense with the new label paradigm
					if (/production(_,label(s,_)) := g.P)
						return <problemStr("Label clashes with an existing label",s),g>;
					elseif (/production(_,label(s,_)) := ps4)
						return <problemStr("Labels ambiguous",s),g>;
					else
						ps4 += production(x,se);
				else
					ps4 += production(x,se);
		else ps4 += production(x,e);
	if (eqPs(ps2,ps4))
		return <problemScope("Scope is already vertical",w),g>;
	return <ok(),grammar(g.N, ps1 + ps4 + ps3, g.S)>;
}

// XBGF:widen
public XResult transform(widen(GExpr e1, GExpr e2, XScope w), GGrammar g)
{
	if (!narrowing(e2,e1))
		return <problemExpr2("Expressions are not in widening relation",e2,e1),g>;
	return transform(replace(e1,e2,w),g);
}

// Needed for: yacc
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
default bool yaccification(GProd _,GProdSet _) = false;

// XBGF:yaccify
public XResult transform(yaccify(GProdList ps1), GGrammar g)
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

public default XResult transform(XCommand x, GGrammar g)
	{throw "Unknown XBGF command <x>";}

public GGrammar transform(XSequence xbgf, GGrammar g)
{
	XResult out = <ok(),normalise(g)>;
	for (XCommand step <- xbgf)
	{
		out = transform(step,out.g);
		thw(out.r);
		out.g = normalise(out.g);
	}
	return out.g;
}

// TODO: later redo with keyword parameters?
public XResult vtransform(XCommand x, GGrammar g)
{
	println("[XBGF] <ppx(x)>");
	return transform(x,g);
}

public GGrammar vtransform(XSequence xbgf, GGrammar g)
{
	XResult out = <ok(),normalise(g)>;
	for (XCommand step <- xbgf)
	{
		out = vtransform(step,out.g);
		thw(out.r);
		out.g = normalise(out.g);
	}
	return out.g;
}
