@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::xbgf::Folding

//import lib::Rascalware;
import grammarlab::language::Grammar;
import grammarlab::language::XScope;
import grammarlab::language::XOutcome;
import grammarlab::lib::Scoping;
import grammarlab::transform::xbgf::Brutal;
import grammarlab::transform::Normal;

XResult runExtract(GProd p, XScope w, GGrammar g)
{
	if (p.lhs in g.N)
		return <notFreshN(p.lhs),g>;
	// TODO hard to check if rhs occurs in the grammar; it was somehow done in xbgf1.pro 
	XResult rep = grammarlab::transform::xbgf::Brutal::runReplace(p.rhs,nonterminal(p.lhs),w,g);
	if (ok() !:= rep.r) return rep;
	else return <ok(),normalise(grammar(g.N + p.lhs, rep.g.P + p, rep.g.S))>;
}

XResult runFold(str x, XScope w, GGrammar g)
{
	if (<_,[production(x, GExpr rhs)],_> := splitPbyW(g.P,innt(x)))
		return grammarlab::transform::xbgf::Brutal::runReplace(rhs,nonterminal(x),comboscope(notinnt(x),w),g);
	else 
		return <problemStr("Nonterminal must be defined horizontally prior to folding",x),g>;
}

XResult runInline(str x, GGrammar g)
{
	if (x in g.S)
		return <problemStr("Cannot inline root nonterminal",x),g>;
	if (<ps1,[production(x, GExpr rhs)],ps2> := splitPbyW(g.P,innt(x)))
		return grammarlab::transform::xbgf::Brutal::runReplace(nonterminal(x),rhs,globally(),grammar(g.N-x, ps1+ps2, g.S));
	else 
		return <problemStr("Nonterminal must be defined horizontally prior to inlining.",x),g>;
}

XResult runUnfold(str x, XScope w, GGrammar g)
{
	if (<_,[production(x, GExpr rhs)],_> := splitPbyW(g.P,innt(x)))
		return grammarlab::transform::xbgf::Brutal::runReplace(nonterminal(x),rhs,comboscope(notinnt(x),w),g);
	else
		return <problemStr("Nonterminal must be defined horizontally prior to unfolding",x),g>;
}

// Liberal forms of folding
XResult runDowngrade(GProd p1, GProd p2, GGrammar g)
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

XResult runUpgrade(GProd p1, GProd p2, GGrammar g)
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
