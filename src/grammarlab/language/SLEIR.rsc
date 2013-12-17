@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@contributor{Generated by meta::Mutations, do not edit manually!}
@doc{The suite consists of 182 mutations intentionally generalised from XBGF operators.}
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
	| MassageAndNotYX2NotOrXY()
	| MassageAndXY2NotOrNotXY()
	| MassageAndYX2NotOrNotXY()
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
	| MassageNotAndNotXY2OrYX()
	| MassageNotAndXY2OrNotXY()
	| MassageNotAndXY2OrNotYX()
	| MassageNotLabel2LabelNot()
	| MassageNotMark2MarkNot()
	| MassageNotNot2X()
	| MassageNotOrNotXY2AndXY()
	| MassageNotOrNotXY2AndYX()
	| MassageNotOrXY2AndNotXY()
	| MassageNotOrXY2AndNotYX()
	| MassageOpt2OptOpt()
	| MassageOpt2OrEpsOpt()
	| MassageOpt2OrEpsX()
	| MassageOpt2OrOptEps()
	| MassageOpt2OrOptX()
	| MassageOpt2OrXEps()
	| MassageOpt2OrXOpt()
	| MassageOptLabel2LabelOpt()
	| MassageOptMark2MarkOpt()
	| MassageOptOpt2Opt()
	| MassageOptPlus2Star()
	| MassageOptSLPlus2SLStar()
	| MassageOptSeqStarX2SLStar()
	| MassageOptSeqXStar2SLStar()
	| MassageOptStar2Star()
	| MassageOr1Star2Star()
	| MassageOrEpsOpt2Opt()
	| MassageOrEpsPlus2Star()
	| MassageOrEpsStar2Star()
	| MassageOrEpsX2Opt()
	| MassageOrLabels2()
	| MassageOrLabels3()
	| MassageOrMarks2()
	| MassageOrMarks3()
	| MassageOrNotXY2NotAndXY()
	| MassageOrNotYX2NotAndXY()
	| MassageOrOptEps2Opt()
	| MassageOrOptPlus2Star()
	| MassageOrOptStar2Star()
	| MassageOrOptX2Opt()
	| MassageOrPlusEps2Star()
	| MassageOrPlusOpt2Star()
	| MassageOrPlusStar2Star()
	| MassageOrPlusX2Plus()
	| MassageOrStar12Star()
	| MassageOrStarEps2Star()
	| MassageOrStarOpt2Star()
	| MassageOrStarPlus2Star()
	| MassageOrXEps2Opt()
	| MassageOrXOpt2Opt()
	| MassageOrXPlus2Plus()
	| MassageOrXY2NotAndNotXY()
	| MassageOrYX2NotAndNotXY()
	| MassagePlus2OrPlusX()
	| MassagePlus2OrXPlus()
	| MassagePlus2PlusPlus()
	| MassagePlus2SeqOptPlus()
	| MassagePlus2SeqPlusOpt()
	| MassagePlus2SeqPlusStar()
	| MassagePlus2SeqStarPlus()
	| MassagePlus2SeqStarX()
	| MassagePlus2SeqXStar()
	| MassagePlusLabel2LabelPlus()
	| MassagePlusMark2MarkPlus()
	| MassagePlusOpt2Star()
	| MassagePlusPlus2Plus()
	| MassagePlusStar2Star()
	| MassageSLPlus2SeqStarX()
	| MassageSLPlus2SeqXStar()
	| MassageSLStar2OptSLPlus()
	| MassageSLStar2OptSeqStarX()
	| MassageSLStar2OptSeqXStar()
	| MassageSeqOptPlus2Plus()
	| MassageSeqOptStar2Star()
	| MassageSeqOptX2SeqXOpt()
	| MassageSeqPlusOpt2Plus()
	| MassageSeqPlusStar2Plus()
	| MassageSeqPlusX2SeqXPlus()
	| MassageSeqStarOpt2Star()
	| MassageSeqStarPlus2Plus()
	| MassageSeqStarStar2Star()
	| MassageSeqStarX2Plus()
	| MassageSeqStarX2SLPlus()
	| MassageSeqStarX2SeqXStar()
	| MassageSeqXOpt2SeqOptX()
	| MassageSeqXPlus2SeqPlusX()
	| MassageSeqXStar2Plus()
	| MassageSeqXStar2SLPlus()
	| MassageSeqXStar2SeqStarX()
	| MassageStar2OptPlus()
	| MassageStar2OptStar()
	| MassageStar2Or1Star()
	| MassageStar2OrEpsPlus()
	| MassageStar2OrEpsStar()
	| MassageStar2OrOptPlus()
	| MassageStar2OrOptStar()
	| MassageStar2OrPlusEps()
	| MassageStar2OrPlusOpt()
	| MassageStar2OrPlusStar()
	| MassageStar2OrStar1()
	| MassageStar2OrStarEps()
	| MassageStar2OrStarOpt()
	| MassageStar2OrStarPlus()
	| MassageStar2PlusOpt()
	| MassageStar2PlusStar()
	| MassageStar2SeqOptStar()
	| MassageStar2SeqStarOpt()
	| MassageStar2SeqStarStar()
	| MassageStar2StarOpt()
	| MassageStar2StarPlus()
	| MassageStar2StarStar()
	| MassageStarLabel2LabelStar()
	| MassageStarMark2MarkStar()
	| MassageStarOpt2Star()
	| MassageStarPlus2Star()
	| MassageStarStar2Star()
	| MassageX2NotNot()
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