@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module transform::XBGF

import language::BGF;
import language::X;
import language::XScope;
import language::XOutcome;
import transform::Normal;
import export::X;
import IO;

extend transform::xbgf::Associativity; // assoc, iterate
extend transform::xbgf::Brutal; // replace
extend transform::xbgf::Chaining; // abridge, detour, chain, unchain
extend transform::xbgf::Factoring; // factor, distribute
extend transform::xbgf::Folding; // fold, unfold, extract, inline, downgrade, upgrade
extend transform::xbgf::Conjunction; // addC
extend transform::xbgf::Disjunction; // addH, removeH, vertical, horizontal
extend transform::xbgf::Labels; // renameL, unlabel, designate; renameS, anonymize, deanonimize
extend transform::xbgf::Massage; // massage
extend transform::xbgf::Nonterminals; // renameN, equate, splitN, clone, reroot, unite
extend transform::xbgf::Productions; // addV, removeV, define, undefine, redefine, eliminate, introduce, import
extend transform::xbgf::Sequential; // appear, disappear, inject, permute, project
extend transform::xbgf::Terminals; // renameT, splitT, concatT, abstractize, concretize
extend transform::xbgf::Width; // narrow, widen
extend transform::xbgf::Yacc; // yaccify, deyaccify
extend transform::xbgf::Util;


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
public XResult transform(define(list[GProd] ps), GGrammar g)
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
public XResult transform(factor(BGFExpression e1, BGFExpression e2, XScope w), GGrammar g)
	= runFactor(e1,e2,w,g);
public XResult transform(fold(str x, XScope w), GGrammar g)
	= runFold(x,w,g);
public XResult transform(horizontal(XScope w), GGrammar g)
	= runHorizontal(w,g);
public XResult transform(importG(list[GProd] ps), GGrammar g)
	= runImportG(ps,g);
public XResult transform(inject(GProd p), GGrammar g)
	= runInject(p,g);
public XResult transform(inline(str x), GGrammar g)
	= runInline(x,g);
public XResult transform(introduce(list[GProd] ps), GGrammar g)
	= runIntroduce(ps,g);
public XResult transform(iterate(GProd p), GGrammar g)
	= runIterate(p,g);
public XResult transform(lassoc(GProd p), GGrammar g)
	= runLAssoc(p,g);
public XResult transform(massage(BGFExpression e1, BGFExpression e2, XScope w), GGrammar g)
	= runMassage(e1,e2,w,g);
public XResult transform(narrow(BGFExpression e1, BGFExpression e2, XScope w), GGrammar g)
	= runNarrow(e1,e2,w,g);
public XResult transform(permute(GProd p), GGrammar g)
	= runPermute(p,g);
public XResult transform(project(GProd p), GGrammar g)
	= runProject(p,g);
public XResult transform(rassoc(GProd p), GGrammar g)
	= runRAssoc(p,g);
public XResult transform(redefine(list[GProd] ps), GGrammar g)
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
public XResult transform(XCommand::replace(BGFExpression e1, BGFExpression e2, XScope w), GGrammar g)
	= runReplace(e1,e2,w,g);
public XResult transform(reroot(list[str] xs), GGrammar g)
	= runReroot(xs,g);
public XResult transform(splitN(str x, list[GProd] ps, XScope w), GGrammar g)
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
public XResult transform(widen(BGFExpression e1, BGFExpression e2, XScope w), GGrammar g)
	= runWiden(e1,e2,w,g);
public XResult transform(yaccify(list[GProd] ps), GGrammar g)
	= runYaccify(ps,g);
public XResult transform(atomic(list[XCommand] steps), GGrammar g)
	= transform(steps,g); // NB: different from the rest
public XResult transform(strip(str a), GGrammar g)
	= runStrip(a,g); // semi-deprecated
public default XResult transform(XCommand x, GGrammar g) {throw "Unknown XBGF command <x>";}

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

public GGrammar vtransform(XBGFSequence xbgf, GGrammar g)
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



// legacy code
XResult runStrip(str a, GGrammar g)
{
	// TODO: semi-deprecated
	list[GProd] ps2;
	if (a=="allLabels")
		ps2 = visit(g.prods){case production(_,str x,BGFExpression e) => production("",x,e)}
	elseif (a=="allSelectors")
		ps2 = visit(g.prods){case selectable(_,BGFExpression e) => e}
	elseif (a=="allTerminals")
		{ // deprecated, please use a mutation that generates abstractize commands
			ps2 = visit(g.prods){case terminal(_) => epsilon()};
			ps2 = normalise(ps2);
		}
	else
		return <problemStr("Unknown strip parameter",a),g>;
	return <ok(),grammar(g.roots,ps2)>;
}
