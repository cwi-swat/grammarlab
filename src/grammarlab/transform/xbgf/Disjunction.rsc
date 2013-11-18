@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::xbgf::Disjunction

//import lib::Rascalware;
import grammarlab::language::Grammar;
import grammarlab::language::XScope;
import grammarlab::language::XOutcome;
import grammarlab::lib::Scoping;
import grammarlab::compare::Differ;

XResult runAddH(GProd p1, GGrammar g)
{
	p2 = unmark(p1);
	p3 = demarkH(p1);
	if (!inProds(p3,g.P))
		return <notFoundP(p3),g>;
	return <ok(),grammar(g.N, replaceP(g.P,p3,p2), g.S)>;
}

XResult runHorizontal(XScope w, GGrammar g)
{
	// For xbgf1.pro, the context must be strictly vertical. Here we are more relaxed. 
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

XResult runRemoveH(GProd p1, GGrammar g)
{
	p2 = unmark(p1);
	if (!inProds(p2, g.P))
		return <notFoundP(p2),g>;
	return <ok(),grammar(g.N, replaceP(g.P,p2,demarkH(p1)), g.S)>;
}

XResult runVertical(XScope w, GGrammar g)
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
