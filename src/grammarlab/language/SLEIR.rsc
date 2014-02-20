@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@contributor{Generated by meta::Mutations, do not edit manually!}
@doc{The suite consists of 135 mutations intentionally generalised from XBGF operators.}
module grammarlab::language::SLEIR

import grammarlab::language::Grammar;
import grammarlab::language::X;

alias MSequence = list[MCommand];

data MCommand
	= AbridgeAll()
	| ChainMixed()
	| ConcatAllT()
	| DefineMin()
	| DeyaccifyAll()
	| DisappearEverywhere(GExpr e)
	| DistributeAll()
	| DropSuffixN(GNonTerm pre, GNonTerm post)
	| EliminateTop()
	| EquateAll()
	| FoldMax()
	| HorizontalAll()
	| InlineMax()
	| InlinePlus()
	| InsertLayout()
	| IterateXX()
	| IterateXYXLeft()
	| IterateXYXRight()
	| LAssocAll()
	| LiftTopLabels()
	| MassageAndNot2Except()
	| MassageAndNotXY2NotOrXY()
	| MassageAndXY2NotOrNotXY()
	| MassageExcept2AndNot()
	| MassageLabelNot2NotLabel()
	| MassageLabelOpt2OptLabel()
	| MassageLabelPlus2PlusLabel()
	| MassageLabelStar2StarLabel()
	| MassageMarkNot2NotMark()
	| MassageMarkOpt2OptMark()
	| MassageMarkPlus2PlusMark()
	| MassageMarkStar2StarMark()
	| MassageNotAndNotXY2OrXY()
	| MassageNotAndXY2OrNotXY()
	| MassageNotLabel2LabelNot()
	| MassageNotMark2MarkNot()
	| MassageNotNot()
	| MassageNotOrNotXY2AndXY()
	| MassageNotOrXY2AndNotXY()
	| MassageOpt2OrEpsX()
	| MassageOpt2OrXEps()
	| MassageOptLabel2LabelOpt()
	| MassageOptMark2MarkOpt()
	| MassageOptOpt()
	| MassageOptPlus2Star()
	| MassageOptSLPlus2SLStar()
	| MassageOptSeqStarX2SLStar()
	| MassageOptSeqXStar2SLStar()
	| MassageOptStar()
	| MassageOrEpsX2Opt()
	| MassageOrLabels2()
	| MassageOrLabels3()
	| MassageOrMarks2()
	| MassageOrMarks3()
	| MassageOrNotXY2NotAndXY()
	| MassageOrOptEps()
	| MassageOrOptX()
	| MassageOrPlusEps2Star()
	| MassageOrPlusOpt2Star()
	| MassageOrPlusX()
	| MassageOrStar()
	| MassageOrStarEps()
	| MassageOrStarOpt()
	| MassageOrStarPlus()
	| MassageOrXEps2Opt()
	| MassageOrXPlus()
	| MassageOrXY2NotAndNotXY()
	| MassagePlus2SeqStarX()
	| MassagePlus2SeqXStar()
	| MassagePlusLabel2LabelPlus()
	| MassagePlusMark2MarkPlus()
	| MassagePlusOpt2Star()
	| MassagePlusPlus()
	| MassagePlusStar()
	| MassageSLPlus2SeqStarX()
	| MassageSLPlus2SeqXStar()
	| MassageSLStar2OptSLPlus()
	| MassageSLStar2OptSeqStarX()
	| MassageSLStar2OptSeqXStar()
	| MassageSeqOptPlus()
	| MassageSeqOptStar()
	| MassageSeqOptX2SeqXOpt()
	| MassageSeqPlusOpt()
	| MassageSeqPlusStar()
	| MassageSeqPlusX2SeqXPlus()
	| MassageSeqStarOpt()
	| MassageSeqStarPlus()
	| MassageSeqStarStar()
	| MassageSeqStarX2Plus()
	| MassageSeqStarX2SLPlus()
	| MassageSeqStarX2SeqXStar()
	| MassageSeqXOpt2SeqOptX()
	| MassageSeqXPlus2SeqPlusX()
	| MassageSeqXStar2Plus()
	| MassageSeqXStar2SLPlus()
	| MassageSeqXStar2SeqStarX()
	| MassageStar2OptPlus()
	| MassageStar2OrPlusEps()
	| MassageStar2OrPlusOpt()
	| MassageStar2PlusOpt()
	| MassageStarLabel2LabelStar()
	| MassageStarMark2MarkStar()
	| MassageStarOpt()
	| MassageStarPlus()
	| MassageStarStar()
	| NarrowOpt2X()
	| NarrowPlus2X()
	| NarrowStar2Opt()
	| NarrowStar2Plus()
	| NarrowStar2X()
	| ParenthesizeAll()
	| PermuteInfix2Postfix()
	| PermuteInfix2Prefix()
	| PermutePostfix2Infix()
	| PermutePostfix2Prefix()
	| PermutePrefix2Infix()
	| PermutePrefix2Postfix()
	| RAssocAll()
	| RedefineAll(GProdList ps)
	| RenameAllN(GNonTerm x, GNonTerm y)
	| RenameAllT(GTerm x, GTerm y)
	| Reroot2top()
	| RetireLs()
	| RetireMs()
	| RetireTs()
	| SplitAllT()
	| UnchainAll()
	| UndefineTrivial()
	| UnfoldMax()
	| UniteBySuffix(GNonTerm pre, GNonTerm post)
	| VerticalAll()
	| WidenOpt2Star()
	| WidenPlus2Star()
	| YaccifyAllL()
	| YaccifyAllR()
;