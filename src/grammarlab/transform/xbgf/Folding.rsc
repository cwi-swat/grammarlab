@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::xbgf::Folding

//import lib::Rascalware;
import grammarlab::language::Grammar;
import grammarlab::language::XScope;
import grammarlab::language::XOutcome;
import grammarlab::transform::xbgf::Util;
import grammarlab::transform::xbgf::Brutal;
import grammarlab::transform::Normal;

XResult runExtract(production(str l, str x, GExpr rhs), XScope w, GGrammar g)
{
	if (x in definedNs(g.prods))
		return <notFreshN(x),g>;
	// TODO hard to check if rhs occurs in the grammar; it was somehow done in xbgf1.pro 
	XResult rep = grammarlab::transform::xbgf::Brutal::runReplace(rhs,nonterminal(x),w,g);
	if (ok() !:= rep.r) return rep;
	else return <ok(),grammar(rep.g.roots,rep.g.prods + production(l,x,rhs))>;
}

XResult runFold(str x, XScope w, GGrammar g)
{
	if (<_,[production(_, x, GExpr rhs)],_> := splitPbyW(g.prods,innt(x)))
		return grammarlab::transform::xbgf::Brutal::runReplace(rhs,nonterminal(x),comboscope(notinnt(x),w),g);
	else 
		return <problemStr("Nonterminal must be defined horizontally prior to folding.",x),g>;
}

XResult runInline(str x, GGrammar g)
{
	if (<ps1,[production(str l, x, GExpr rhs)],ps2> := splitPbyW(g.prods,innt(x)))
	{
		if (l=="")
			return grammarlab::transform::xbgf::Brutal::runReplace(nonterminal(x),rhs,globally(),grammar(g.roots,ps1+ps2));
		else
			return grammarlab::transform::xbgf::Brutal::runReplace(nonterminal(x),selectable(l,rhs),globally(),grammar(g.roots,ps1+ps2));
	}
	else 
		return <problemStr("Nonterminal must be defined horizontally prior to inlining.",x),g>;
}

XResult runUnfold(str x, XScope w, GGrammar g)
{
	if (<_,[production(str l, x, GExpr rhs)],_> := splitPbyW(g.prods,innt(x)))
	{
		if (l=="")
			return grammarlab::transform::xbgf::Brutal::runReplace(nonterminal(x),rhs,comboscope(notinnt(x),w),g);
		else
			return grammarlab::transform::xbgf::Brutal::runReplace(nonterminal(x),selectable(l,rhs),comboscope(notinnt(x),w),g);
	}
	else
		return <problemStr("Nonterminal must be defined horizontally prior to unfolding.",x),g>;
}

// Liberal forms of folding
XResult runDowngrade(GProd p1, GProd p2, GGrammar g)
{
	if (/marked(nonterminal(str x)) := p1)
		if (production(x,GExpr e) := p2)
		{
			p3 = visit(p1){case marked(_) => e};
			return <ok(),grammar(g.roots,replaceP(g.prods,unmark(p1),normalise(p3)))>;
		}
		else
			return <problemProd2("Production rules do not agree on nonterminal",p1,p2),g>;
	else
		return <problemProd("Production rule does not have a single nonterminal marked",p1),g>;
}

XResult runUpgrade(GProd p1, GProd p2, GGrammar g)
{
	if (/marked(nonterminal(str x)) := p1)
		if (production(x,GExpr e) := p2)
		{
			p3 = visit(p1){case marked(_) => e};
			p3 = normalise(p3);
			return <ok(),grammar(g.roots,replaceP(g.prods,p3,unmark(p1)))>;
		}
		else
			return <problemProd2("Production rules do not agree on nonterminal",p1,p2),g>;
	else
		return <problemProd("Production rule must have one single nonterminal marked",p1),g>;
}
