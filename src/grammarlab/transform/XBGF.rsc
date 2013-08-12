@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::XBGF

import grammarlab::language::Grammar;
import grammarlab::language::X;
import grammarlab::language::XScope;
import grammarlab::language::XOutcome;
import grammarlab::transform::Normal;
import grammarlab::export::XBNF;
import IO;

extend grammarlab::transform::xbgf::Associativity; // assoc, iterate
extend grammarlab::transform::xbgf::Brutal; // replace
extend grammarlab::transform::xbgf::Chaining; // abridge, detour, chain, unchain
extend grammarlab::transform::xbgf::Factoring; // factor, distribute
extend grammarlab::transform::xbgf::Folding; // fold, unfold, extract, inline, downgrade, upgrade
extend grammarlab::transform::xbgf::Conjunction; // addC
extend grammarlab::transform::xbgf::Disjunction; // addH, removeH, vertical, horizontal
extend grammarlab::transform::xbgf::Labels; // renameL, unlabel, designate; renameS, anonymize, deanonimize
extend grammarlab::transform::xbgf::Massage; // massage
extend grammarlab::transform::xbgf::Nonterminals; // renameN, equate, splitN, clone, reroot, unite
extend grammarlab::transform::xbgf::Productions; // addV, removeV, define, undefine, redefine, eliminate, introduce, import
extend grammarlab::transform::xbgf::Sequential; // appear, disappear, inject, permute, project
extend grammarlab::transform::xbgf::Terminals; // renameT, splitT, concatT, abstractize, concretize
extend grammarlab::transform::xbgf::Width; // narrow, widen
extend grammarlab::transform::xbgf::Yacc; // yaccify, deyaccify
extend grammarlab::transform::xbgf::Util;


public XResult transform(abridge(GProd p), GGrammar g)
	= runAbridge(p,g);
public XResult transform(abstractize(GProd p), GGrammar g)
	= runAbstractize(p,g);
public XResult transform(addC(GProd p), GGrammar g)
	= runAddC(p,g);
public XResult transform(addH(GProd p), GGrammar g)
	= runAddH(p,g);
public XResult transform(addV(GProd p), GGrammar g)
	= runAddV(p,g);
public XResult transform(anonymize(GProd p), GGrammar g)
	= runAnonymize(p,g);
public XResult transform(appear(GProd p), GGrammar g)
	= runAppear(p,g);
public XResult transform(bypass(), GGrammar g)
	= <ok(),g>;
public XResult transform(chain(GProd p), GGrammar g)
	= runChain(p,g);
public XResult transform(clone(str x, str y, XScope w), GGrammar g)
	= runClone(x,y,w,g);
public XResult transform(concatT(list[str] xs, str y, XScope w), GGrammar g)
	= runConcatT(xs,y,w,g);
public XResult transform(concretize(GProd p), GGrammar g)
	= runConcretize(p,g);
public XResult transform(deanonymize(GProd p), GGrammar g)
	= runDeanonymize(p,g);
public XResult transform(define(GProdList ps), GGrammar g)
	= runDefine(ps,g);
public XResult transform(designate(GProd p), GGrammar g)
	= runDesignate(p,g);
public XResult transform(detour(GProd p), GGrammar g)
	= runDetour(p,g);
public XResult transform(deyaccify(str x), GGrammar g)
	= runDeyaccify(x,g);
public XResult transform(disappear(GProd p), GGrammar g)
	= runDisappear(p,g);
public XResult transform(distribute(XScope w), GGrammar g)
	= runDistribute(w,g);
public XResult transform(downgrade(GProd p1,GProd p2), GGrammar g)
	= runDowngrade(p1,p2,g);
public XResult transform(eliminate(str x), GGrammar g)
	= runEliminate(x,g);
public XResult transform(equate(str x, str y), GGrammar g)
	= runEquate(x,y,g);
public XResult transform(extract(GProd p, XScope w), GGrammar g)
	= runExtract(p,w,g);
public XResult transform(factor(GExpr e1, GExpr e2, XScope w), GGrammar g)
	= runFactor(e1,e2,w,g);
public XResult transform(fold(str x, XScope w), GGrammar g)
	= runFold(x,w,g);
public XResult transform(horizontal(XScope w), GGrammar g)
	= runHorizontal(w,g);
public XResult transform(importG(GProdList ps), GGrammar g)
	= runImportG(ps,g);
public XResult transform(inject(GProd p), GGrammar g)
	= runInject(p,g);
public XResult transform(inline(str x), GGrammar g)
	= runInline(x,g);
public XResult transform(introduce(GProdList ps), GGrammar g)
	= runIntroduce(ps,g);
// public XResult transform(iterate(GProd p), GGrammar g)
// 	= runIterate(p,g);
// public XResult transform(lassoc(GProd p), GGrammar g)
// 	= runLAssoc(p,g);
public XResult transform(massage(GExpr e1, GExpr e2, XScope w), GGrammar g)
	= runMassage(e1,e2,w,g);
public XResult transform(narrow(GExpr e1, GExpr e2, XScope w), GGrammar g)
	= runNarrow(e1,e2,w,g);
public XResult transform(permute(GProd p), GGrammar g)
	= runPermute(p,g);
public XResult transform(project(GProd p), GGrammar g)
	= runProject(p,g);
// public XResult transform(rassoc(GProd p), GGrammar g)
// 	= runRAssoc(p,g);
public XResult transform(redefine(GProdList ps), GGrammar g)
	= runRedefine(ps,g);
public XResult transform(removeH(GProd p), GGrammar g)
	= runRemoveH(p,g);
public XResult transform(removeV(GProd p), GGrammar g)
	= runRemoveV(p,g);
public XResult transform(renameL(str x, str y), GGrammar g)
	= runRenameL(x,y,g);
public XResult transform(renameN(str x, str y), GGrammar g)
	= runRenameN(x,y,g);
public XResult transform(renameS(str x, str y, XScope w), GGrammar g)
	= runRenameS(x,y,w,g);
public XResult transform(renameT(str x, str y), GGrammar g)
	= runRenameT(x,y,g);
public XResult transform(XCommand::replace(GExpr e1, GExpr e2, XScope w), GGrammar g)
	= runReplace(e1,e2,w,g);
public XResult transform(reroot(list[str] xs), GGrammar g)
	= runReroot(xs,g);
public XResult transform(splitN(str x, GProdList ps, XScope w), GGrammar g)
	= runSplitN(x,ps,w,g);
public XResult transform(splitT(str x, list[str] ys, XScope w), GGrammar g)
	= runSplitT(x,ys,w,g);
public XResult transform(unchain(GProd p), GGrammar g)
	= runUnchain(p,g);
public XResult transform(undefine(list[str] xs), GGrammar g)
	= runUndefine(xs,g);
public XResult transform(unfold(str x, XScope w), GGrammar g)
	= runUnfold(x,w,g);
public XResult transform(unite(str x, str y), GGrammar g)
	= runUnite(x,y,g);
public XResult transform(unlabel(str x), GGrammar g)
	= runUnlabel(x,g);
public XResult transform(upgrade(GProd p1, GProd p2), GGrammar g)
	= runUpgrade(p1,p2,g);
public XResult transform(vertical(XScope w), GGrammar g)
	= runVertical(w,g);
public XResult transform(widen(GExpr e1, GExpr e2, XScope w), GGrammar g)
	= runWiden(e1,e2,w,g);
public XResult transform(yaccify(GProdList ps), GGrammar g)
	= runYaccify(ps,g);
public default XResult transform(XCommand x, GGrammar g)
	{throw "Unknown XBGF command <x>";}

public GGrammar transform(XBGFSequence xbgf, GGrammar g)
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
