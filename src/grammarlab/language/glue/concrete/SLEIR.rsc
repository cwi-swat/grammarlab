@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
@contributor{Generated by meta::Glue, do not edit manually!}
module grammarlab::language::glue::concrete::SLEIR

import grammarlab::language::glue::concrete::BGF;
import grammarlab::language::glue::concrete::XBGF;

lexical GlueKAbridgeAll = @category="MetaAmbiguity" "AbridgeAll";
lexical GlueKChainMixed = @category="MetaAmbiguity" "ChainMixed";
lexical GlueKConcatAllT = @category="MetaAmbiguity" "ConcatAllT";
lexical GlueKDefineMin = @category="MetaAmbiguity" "DefineMin";
lexical GlueKDeyaccifyAll = @category="MetaAmbiguity" "DeyaccifyAll";
lexical GlueKDisappearEverywhere = @category="MetaAmbiguity" "DisappearEverywhere";
lexical GlueKDistributeAll = @category="MetaAmbiguity" "DistributeAll";
lexical GlueKDropSuffixN = @category="MetaAmbiguity" "DropSuffixN";
lexical GlueKEliminateTop = @category="MetaAmbiguity" "EliminateTop";
lexical GlueKEquateAll = @category="MetaAmbiguity" "EquateAll";
lexical GlueKFoldMax = @category="MetaAmbiguity" "FoldMax";
lexical GlueKHorizontalAll = @category="MetaAmbiguity" "HorizontalAll";
lexical GlueKInlineMax = @category="MetaAmbiguity" "InlineMax";
lexical GlueKInlinePlus = @category="MetaAmbiguity" "InlinePlus";
lexical GlueKInsertLayout = @category="MetaAmbiguity" "InsertLayout";
lexical GlueKIterateXX = @category="MetaAmbiguity" "IterateXX";
lexical GlueKIterateXYXLeft = @category="MetaAmbiguity" "IterateXYXLeft";
lexical GlueKIterateXYXRight = @category="MetaAmbiguity" "IterateXYXRight";
lexical GlueKLAssocAll = @category="MetaAmbiguity" "LAssocAll";
lexical GlueKLiftTopLabels = @category="MetaAmbiguity" "LiftTopLabels";
lexical GlueKMassageAndNot2Except = @category="MetaAmbiguity" "MassageAndNot2Except";
lexical GlueKMassageAndNotXY2NotOrXY = @category="MetaAmbiguity" "MassageAndNotXY2NotOrXY";
lexical GlueKMassageAndNotYX2NotOrXY = @category="MetaAmbiguity" "MassageAndNotYX2NotOrXY";
lexical GlueKMassageAndXY2NotOrNotXY = @category="MetaAmbiguity" "MassageAndXY2NotOrNotXY";
lexical GlueKMassageAndYX2NotOrNotXY = @category="MetaAmbiguity" "MassageAndYX2NotOrNotXY";
lexical GlueKMassageExcept2AndNot = @category="MetaAmbiguity" "MassageExcept2AndNot";
lexical GlueKMassageLabelNot2NotLabel = @category="MetaAmbiguity" "MassageLabelNot2NotLabel";
lexical GlueKMassageLabelOpt2OptLabel = @category="MetaAmbiguity" "MassageLabelOpt2OptLabel";
lexical GlueKMassageLabelPlus2PlusLabel = @category="MetaAmbiguity" "MassageLabelPlus2PlusLabel";
lexical GlueKMassageLabelStar2StarLabel = @category="MetaAmbiguity" "MassageLabelStar2StarLabel";
lexical GlueKMassageMarkNot2NotMark = @category="MetaAmbiguity" "MassageMarkNot2NotMark";
lexical GlueKMassageMarkOpt2OptMark = @category="MetaAmbiguity" "MassageMarkOpt2OptMark";
lexical GlueKMassageMarkPlus2PlusMark = @category="MetaAmbiguity" "MassageMarkPlus2PlusMark";
lexical GlueKMassageMarkStar2StarMark = @category="MetaAmbiguity" "MassageMarkStar2StarMark";
lexical GlueKMassageNotAndNotXY2OrXY = @category="MetaAmbiguity" "MassageNotAndNotXY2OrXY";
lexical GlueKMassageNotAndNotXY2OrYX = @category="MetaAmbiguity" "MassageNotAndNotXY2OrYX";
lexical GlueKMassageNotAndXY2OrNotXY = @category="MetaAmbiguity" "MassageNotAndXY2OrNotXY";
lexical GlueKMassageNotAndXY2OrNotYX = @category="MetaAmbiguity" "MassageNotAndXY2OrNotYX";
lexical GlueKMassageNotLabel2LabelNot = @category="MetaAmbiguity" "MassageNotLabel2LabelNot";
lexical GlueKMassageNotMark2MarkNot = @category="MetaAmbiguity" "MassageNotMark2MarkNot";
lexical GlueKMassageNotNot2X = @category="MetaAmbiguity" "MassageNotNot2X";
lexical GlueKMassageNotOrNotXY2AndXY = @category="MetaAmbiguity" "MassageNotOrNotXY2AndXY";
lexical GlueKMassageNotOrNotXY2AndYX = @category="MetaAmbiguity" "MassageNotOrNotXY2AndYX";
lexical GlueKMassageNotOrXY2AndNotXY = @category="MetaAmbiguity" "MassageNotOrXY2AndNotXY";
lexical GlueKMassageNotOrXY2AndNotYX = @category="MetaAmbiguity" "MassageNotOrXY2AndNotYX";
lexical GlueKMassageOpt2OptOpt = @category="MetaAmbiguity" "MassageOpt2OptOpt";
lexical GlueKMassageOpt2OrEpsOpt = @category="MetaAmbiguity" "MassageOpt2OrEpsOpt";
lexical GlueKMassageOpt2OrEpsX = @category="MetaAmbiguity" "MassageOpt2OrEpsX";
lexical GlueKMassageOpt2OrOptEps = @category="MetaAmbiguity" "MassageOpt2OrOptEps";
lexical GlueKMassageOpt2OrOptX = @category="MetaAmbiguity" "MassageOpt2OrOptX";
lexical GlueKMassageOpt2OrXEps = @category="MetaAmbiguity" "MassageOpt2OrXEps";
lexical GlueKMassageOpt2OrXOpt = @category="MetaAmbiguity" "MassageOpt2OrXOpt";
lexical GlueKMassageOptLabel2LabelOpt = @category="MetaAmbiguity" "MassageOptLabel2LabelOpt";
lexical GlueKMassageOptMark2MarkOpt = @category="MetaAmbiguity" "MassageOptMark2MarkOpt";
lexical GlueKMassageOptOpt2Opt = @category="MetaAmbiguity" "MassageOptOpt2Opt";
lexical GlueKMassageOptPlus2Star = @category="MetaAmbiguity" "MassageOptPlus2Star";
lexical GlueKMassageOptSLPlus2SLStar = @category="MetaAmbiguity" "MassageOptSLPlus2SLStar";
lexical GlueKMassageOptSeqStarX2SLStar = @category="MetaAmbiguity" "MassageOptSeqStarX2SLStar";
lexical GlueKMassageOptSeqXStar2SLStar = @category="MetaAmbiguity" "MassageOptSeqXStar2SLStar";
lexical GlueKMassageOptStar2Star = @category="MetaAmbiguity" "MassageOptStar2Star";
lexical GlueKMassageOr1Star2Star = @category="MetaAmbiguity" "MassageOr1Star2Star";
lexical GlueKMassageOrEpsOpt2Opt = @category="MetaAmbiguity" "MassageOrEpsOpt2Opt";
lexical GlueKMassageOrEpsPlus2Star = @category="MetaAmbiguity" "MassageOrEpsPlus2Star";
lexical GlueKMassageOrEpsStar2Star = @category="MetaAmbiguity" "MassageOrEpsStar2Star";
lexical GlueKMassageOrEpsX2Opt = @category="MetaAmbiguity" "MassageOrEpsX2Opt";
lexical GlueKMassageOrLabels2 = @category="MetaAmbiguity" "MassageOrLabels2";
lexical GlueKMassageOrLabels3 = @category="MetaAmbiguity" "MassageOrLabels3";
lexical GlueKMassageOrMarks2 = @category="MetaAmbiguity" "MassageOrMarks2";
lexical GlueKMassageOrMarks3 = @category="MetaAmbiguity" "MassageOrMarks3";
lexical GlueKMassageOrNotXY2NotAndXY = @category="MetaAmbiguity" "MassageOrNotXY2NotAndXY";
lexical GlueKMassageOrNotYX2NotAndXY = @category="MetaAmbiguity" "MassageOrNotYX2NotAndXY";
lexical GlueKMassageOrOptEps2Opt = @category="MetaAmbiguity" "MassageOrOptEps2Opt";
lexical GlueKMassageOrOptPlus2Star = @category="MetaAmbiguity" "MassageOrOptPlus2Star";
lexical GlueKMassageOrOptStar2Star = @category="MetaAmbiguity" "MassageOrOptStar2Star";
lexical GlueKMassageOrOptX2Opt = @category="MetaAmbiguity" "MassageOrOptX2Opt";
lexical GlueKMassageOrPlusEps2Star = @category="MetaAmbiguity" "MassageOrPlusEps2Star";
lexical GlueKMassageOrPlusOpt2Star = @category="MetaAmbiguity" "MassageOrPlusOpt2Star";
lexical GlueKMassageOrPlusStar2Star = @category="MetaAmbiguity" "MassageOrPlusStar2Star";
lexical GlueKMassageOrPlusX2Plus = @category="MetaAmbiguity" "MassageOrPlusX2Plus";
lexical GlueKMassageOrStar12Star = @category="MetaAmbiguity" "MassageOrStar12Star";
lexical GlueKMassageOrStarEps2Star = @category="MetaAmbiguity" "MassageOrStarEps2Star";
lexical GlueKMassageOrStarOpt2Star = @category="MetaAmbiguity" "MassageOrStarOpt2Star";
lexical GlueKMassageOrStarPlus2Star = @category="MetaAmbiguity" "MassageOrStarPlus2Star";
lexical GlueKMassageOrXEps2Opt = @category="MetaAmbiguity" "MassageOrXEps2Opt";
lexical GlueKMassageOrXOpt2Opt = @category="MetaAmbiguity" "MassageOrXOpt2Opt";
lexical GlueKMassageOrXPlus2Plus = @category="MetaAmbiguity" "MassageOrXPlus2Plus";
lexical GlueKMassageOrXY2NotAndNotXY = @category="MetaAmbiguity" "MassageOrXY2NotAndNotXY";
lexical GlueKMassageOrYX2NotAndNotXY = @category="MetaAmbiguity" "MassageOrYX2NotAndNotXY";
lexical GlueKMassagePlus2OrPlusX = @category="MetaAmbiguity" "MassagePlus2OrPlusX";
lexical GlueKMassagePlus2OrXPlus = @category="MetaAmbiguity" "MassagePlus2OrXPlus";
lexical GlueKMassagePlus2PlusPlus = @category="MetaAmbiguity" "MassagePlus2PlusPlus";
lexical GlueKMassagePlus2SeqOptPlus = @category="MetaAmbiguity" "MassagePlus2SeqOptPlus";
lexical GlueKMassagePlus2SeqPlusOpt = @category="MetaAmbiguity" "MassagePlus2SeqPlusOpt";
lexical GlueKMassagePlus2SeqPlusStar = @category="MetaAmbiguity" "MassagePlus2SeqPlusStar";
lexical GlueKMassagePlus2SeqStarPlus = @category="MetaAmbiguity" "MassagePlus2SeqStarPlus";
lexical GlueKMassagePlus2SeqStarX = @category="MetaAmbiguity" "MassagePlus2SeqStarX";
lexical GlueKMassagePlus2SeqXStar = @category="MetaAmbiguity" "MassagePlus2SeqXStar";
lexical GlueKMassagePlusLabel2LabelPlus = @category="MetaAmbiguity" "MassagePlusLabel2LabelPlus";
lexical GlueKMassagePlusMark2MarkPlus = @category="MetaAmbiguity" "MassagePlusMark2MarkPlus";
lexical GlueKMassagePlusOpt2Star = @category="MetaAmbiguity" "MassagePlusOpt2Star";
lexical GlueKMassagePlusPlus2Plus = @category="MetaAmbiguity" "MassagePlusPlus2Plus";
lexical GlueKMassagePlusStar2Star = @category="MetaAmbiguity" "MassagePlusStar2Star";
lexical GlueKMassageSLPlus2SeqStarX = @category="MetaAmbiguity" "MassageSLPlus2SeqStarX";
lexical GlueKMassageSLPlus2SeqXStar = @category="MetaAmbiguity" "MassageSLPlus2SeqXStar";
lexical GlueKMassageSLStar2OptSLPlus = @category="MetaAmbiguity" "MassageSLStar2OptSLPlus";
lexical GlueKMassageSLStar2OptSeqStarX = @category="MetaAmbiguity" "MassageSLStar2OptSeqStarX";
lexical GlueKMassageSLStar2OptSeqXStar = @category="MetaAmbiguity" "MassageSLStar2OptSeqXStar";
lexical GlueKMassageSeqOptPlus2Plus = @category="MetaAmbiguity" "MassageSeqOptPlus2Plus";
lexical GlueKMassageSeqOptStar2Star = @category="MetaAmbiguity" "MassageSeqOptStar2Star";
lexical GlueKMassageSeqOptX2SeqXOpt = @category="MetaAmbiguity" "MassageSeqOptX2SeqXOpt";
lexical GlueKMassageSeqPlusOpt2Plus = @category="MetaAmbiguity" "MassageSeqPlusOpt2Plus";
lexical GlueKMassageSeqPlusStar2Plus = @category="MetaAmbiguity" "MassageSeqPlusStar2Plus";
lexical GlueKMassageSeqPlusX2SeqXPlus = @category="MetaAmbiguity" "MassageSeqPlusX2SeqXPlus";
lexical GlueKMassageSeqStarOpt2Star = @category="MetaAmbiguity" "MassageSeqStarOpt2Star";
lexical GlueKMassageSeqStarPlus2Plus = @category="MetaAmbiguity" "MassageSeqStarPlus2Plus";
lexical GlueKMassageSeqStarStar2Star = @category="MetaAmbiguity" "MassageSeqStarStar2Star";
lexical GlueKMassageSeqStarX2Plus = @category="MetaAmbiguity" "MassageSeqStarX2Plus";
lexical GlueKMassageSeqStarX2SLPlus = @category="MetaAmbiguity" "MassageSeqStarX2SLPlus";
lexical GlueKMassageSeqStarX2SeqXStar = @category="MetaAmbiguity" "MassageSeqStarX2SeqXStar";
lexical GlueKMassageSeqXOpt2SeqOptX = @category="MetaAmbiguity" "MassageSeqXOpt2SeqOptX";
lexical GlueKMassageSeqXPlus2SeqPlusX = @category="MetaAmbiguity" "MassageSeqXPlus2SeqPlusX";
lexical GlueKMassageSeqXStar2Plus = @category="MetaAmbiguity" "MassageSeqXStar2Plus";
lexical GlueKMassageSeqXStar2SLPlus = @category="MetaAmbiguity" "MassageSeqXStar2SLPlus";
lexical GlueKMassageSeqXStar2SeqStarX = @category="MetaAmbiguity" "MassageSeqXStar2SeqStarX";
lexical GlueKMassageStar2OptPlus = @category="MetaAmbiguity" "MassageStar2OptPlus";
lexical GlueKMassageStar2OptStar = @category="MetaAmbiguity" "MassageStar2OptStar";
lexical GlueKMassageStar2Or1Star = @category="MetaAmbiguity" "MassageStar2Or1Star";
lexical GlueKMassageStar2OrEpsPlus = @category="MetaAmbiguity" "MassageStar2OrEpsPlus";
lexical GlueKMassageStar2OrEpsStar = @category="MetaAmbiguity" "MassageStar2OrEpsStar";
lexical GlueKMassageStar2OrOptPlus = @category="MetaAmbiguity" "MassageStar2OrOptPlus";
lexical GlueKMassageStar2OrOptStar = @category="MetaAmbiguity" "MassageStar2OrOptStar";
lexical GlueKMassageStar2OrPlusEps = @category="MetaAmbiguity" "MassageStar2OrPlusEps";
lexical GlueKMassageStar2OrPlusOpt = @category="MetaAmbiguity" "MassageStar2OrPlusOpt";
lexical GlueKMassageStar2OrPlusStar = @category="MetaAmbiguity" "MassageStar2OrPlusStar";
lexical GlueKMassageStar2OrStar1 = @category="MetaAmbiguity" "MassageStar2OrStar1";
lexical GlueKMassageStar2OrStarEps = @category="MetaAmbiguity" "MassageStar2OrStarEps";
lexical GlueKMassageStar2OrStarOpt = @category="MetaAmbiguity" "MassageStar2OrStarOpt";
lexical GlueKMassageStar2OrStarPlus = @category="MetaAmbiguity" "MassageStar2OrStarPlus";
lexical GlueKMassageStar2PlusOpt = @category="MetaAmbiguity" "MassageStar2PlusOpt";
lexical GlueKMassageStar2PlusStar = @category="MetaAmbiguity" "MassageStar2PlusStar";
lexical GlueKMassageStar2SeqOptStar = @category="MetaAmbiguity" "MassageStar2SeqOptStar";
lexical GlueKMassageStar2SeqStarOpt = @category="MetaAmbiguity" "MassageStar2SeqStarOpt";
lexical GlueKMassageStar2SeqStarStar = @category="MetaAmbiguity" "MassageStar2SeqStarStar";
lexical GlueKMassageStar2StarOpt = @category="MetaAmbiguity" "MassageStar2StarOpt";
lexical GlueKMassageStar2StarPlus = @category="MetaAmbiguity" "MassageStar2StarPlus";
lexical GlueKMassageStar2StarStar = @category="MetaAmbiguity" "MassageStar2StarStar";
lexical GlueKMassageStarLabel2LabelStar = @category="MetaAmbiguity" "MassageStarLabel2LabelStar";
lexical GlueKMassageStarMark2MarkStar = @category="MetaAmbiguity" "MassageStarMark2MarkStar";
lexical GlueKMassageStarOpt2Star = @category="MetaAmbiguity" "MassageStarOpt2Star";
lexical GlueKMassageStarPlus2Star = @category="MetaAmbiguity" "MassageStarPlus2Star";
lexical GlueKMassageStarStar2Star = @category="MetaAmbiguity" "MassageStarStar2Star";
lexical GlueKMassageX2NotNot = @category="MetaAmbiguity" "MassageX2NotNot";
lexical GlueKNarrowOpt2X = @category="MetaAmbiguity" "NarrowOpt2X";
lexical GlueKNarrowPlus2X = @category="MetaAmbiguity" "NarrowPlus2X";
lexical GlueKNarrowStar2Opt = @category="MetaAmbiguity" "NarrowStar2Opt";
lexical GlueKNarrowStar2Plus = @category="MetaAmbiguity" "NarrowStar2Plus";
lexical GlueKNarrowStar2X = @category="MetaAmbiguity" "NarrowStar2X";
lexical GlueKParenthesizeAll = @category="MetaAmbiguity" "ParenthesizeAll";
lexical GlueKPermuteInfix2Postfix = @category="MetaAmbiguity" "PermuteInfix2Postfix";
lexical GlueKPermuteInfix2Prefix = @category="MetaAmbiguity" "PermuteInfix2Prefix";
lexical GlueKPermutePostfix2Infix = @category="MetaAmbiguity" "PermutePostfix2Infix";
lexical GlueKPermutePostfix2Prefix = @category="MetaAmbiguity" "PermutePostfix2Prefix";
lexical GlueKPermutePrefix2Infix = @category="MetaAmbiguity" "PermutePrefix2Infix";
lexical GlueKPermutePrefix2Postfix = @category="MetaAmbiguity" "PermutePrefix2Postfix";
lexical GlueKRAssocAll = @category="MetaAmbiguity" "RAssocAll";
lexical GlueKRedefineAll = @category="MetaAmbiguity" "RedefineAll";
lexical GlueKRenameAllN = @category="MetaAmbiguity" "RenameAllN";
lexical GlueKRenameAllT = @category="MetaAmbiguity" "RenameAllT";
lexical GlueKReroot2top = @category="MetaAmbiguity" "Reroot2top";
lexical GlueKRetireLs = @category="MetaAmbiguity" "RetireLs";
lexical GlueKRetireMs = @category="MetaAmbiguity" "RetireMs";
lexical GlueKRetireTs = @category="MetaAmbiguity" "RetireTs";
lexical GlueKSplitAllT = @category="MetaAmbiguity" "SplitAllT";
lexical GlueKUnchainAll = @category="MetaAmbiguity" "UnchainAll";
lexical GlueKUndefineTrivial = @category="MetaAmbiguity" "UndefineTrivial";
lexical GlueKUnfoldMax = @category="MetaAmbiguity" "UnfoldMax";
lexical GlueKUniteBySuffix = @category="MetaAmbiguity" "UniteBySuffix";
lexical GlueKVerticalAll = @category="MetaAmbiguity" "VerticalAll";
lexical GlueKWidenOpt2Star = @category="MetaAmbiguity" "WidenOpt2Star";
lexical GlueKWidenPlus2Star = @category="MetaAmbiguity" "WidenPlus2Star";
lexical GlueKYaccifyAllL = @category="MetaAmbiguity" "YaccifyAllL";
lexical GlueKYaccifyAllR = @category="MetaAmbiguity" "YaccifyAllR";

keyword GlueKw = GlueKAbridgeAll | GlueKChainMixed | GlueKConcatAllT | GlueKDefineMin | GlueKDeyaccifyAll | GlueKDisappearEverywhere | GlueKDistributeAll | GlueKDropSuffixN | GlueKEliminateTop | GlueKEquateAll | GlueKFoldMax | GlueKHorizontalAll | GlueKInlineMax | GlueKInlinePlus | GlueKInsertLayout | GlueKIterateXX | GlueKIterateXYXLeft | GlueKIterateXYXRight | GlueKLAssocAll | GlueKLiftTopLabels | GlueKMassageAndNot2Except | GlueKMassageAndNotXY2NotOrXY | GlueKMassageAndNotYX2NotOrXY | GlueKMassageAndXY2NotOrNotXY | GlueKMassageAndYX2NotOrNotXY | GlueKMassageExcept2AndNot | GlueKMassageLabelNot2NotLabel | GlueKMassageLabelOpt2OptLabel | GlueKMassageLabelPlus2PlusLabel | GlueKMassageLabelStar2StarLabel | GlueKMassageMarkNot2NotMark | GlueKMassageMarkOpt2OptMark | GlueKMassageMarkPlus2PlusMark | GlueKMassageMarkStar2StarMark | GlueKMassageNotAndNotXY2OrXY | GlueKMassageNotAndNotXY2OrYX | GlueKMassageNotAndXY2OrNotXY | GlueKMassageNotAndXY2OrNotYX | GlueKMassageNotLabel2LabelNot | GlueKMassageNotMark2MarkNot | GlueKMassageNotNot2X | GlueKMassageNotOrNotXY2AndXY | GlueKMassageNotOrNotXY2AndYX | GlueKMassageNotOrXY2AndNotXY | GlueKMassageNotOrXY2AndNotYX | GlueKMassageOpt2OptOpt | GlueKMassageOpt2OrEpsOpt | GlueKMassageOpt2OrEpsX | GlueKMassageOpt2OrOptEps | GlueKMassageOpt2OrOptX | GlueKMassageOpt2OrXEps | GlueKMassageOpt2OrXOpt | GlueKMassageOptLabel2LabelOpt | GlueKMassageOptMark2MarkOpt | GlueKMassageOptOpt2Opt | GlueKMassageOptPlus2Star | GlueKMassageOptSLPlus2SLStar | GlueKMassageOptSeqStarX2SLStar | GlueKMassageOptSeqXStar2SLStar | GlueKMassageOptStar2Star | GlueKMassageOr1Star2Star | GlueKMassageOrEpsOpt2Opt | GlueKMassageOrEpsPlus2Star | GlueKMassageOrEpsStar2Star | GlueKMassageOrEpsX2Opt | GlueKMassageOrLabels2 | GlueKMassageOrLabels3 | GlueKMassageOrMarks2 | GlueKMassageOrMarks3 | GlueKMassageOrNotXY2NotAndXY | GlueKMassageOrNotYX2NotAndXY | GlueKMassageOrOptEps2Opt | GlueKMassageOrOptPlus2Star | GlueKMassageOrOptStar2Star | GlueKMassageOrOptX2Opt | GlueKMassageOrPlusEps2Star | GlueKMassageOrPlusOpt2Star | GlueKMassageOrPlusStar2Star | GlueKMassageOrPlusX2Plus | GlueKMassageOrStar12Star | GlueKMassageOrStarEps2Star | GlueKMassageOrStarOpt2Star | GlueKMassageOrStarPlus2Star | GlueKMassageOrXEps2Opt | GlueKMassageOrXOpt2Opt | GlueKMassageOrXPlus2Plus | GlueKMassageOrXY2NotAndNotXY | GlueKMassageOrYX2NotAndNotXY | GlueKMassagePlus2OrPlusX | GlueKMassagePlus2OrXPlus | GlueKMassagePlus2PlusPlus | GlueKMassagePlus2SeqOptPlus | GlueKMassagePlus2SeqPlusOpt | GlueKMassagePlus2SeqPlusStar | GlueKMassagePlus2SeqStarPlus | GlueKMassagePlus2SeqStarX | GlueKMassagePlus2SeqXStar | GlueKMassagePlusLabel2LabelPlus | GlueKMassagePlusMark2MarkPlus | GlueKMassagePlusOpt2Star | GlueKMassagePlusPlus2Plus | GlueKMassagePlusStar2Star | GlueKMassageSLPlus2SeqStarX | GlueKMassageSLPlus2SeqXStar | GlueKMassageSLStar2OptSLPlus | GlueKMassageSLStar2OptSeqStarX | GlueKMassageSLStar2OptSeqXStar | GlueKMassageSeqOptPlus2Plus | GlueKMassageSeqOptStar2Star | GlueKMassageSeqOptX2SeqXOpt | GlueKMassageSeqPlusOpt2Plus | GlueKMassageSeqPlusStar2Plus | GlueKMassageSeqPlusX2SeqXPlus | GlueKMassageSeqStarOpt2Star | GlueKMassageSeqStarPlus2Plus | GlueKMassageSeqStarStar2Star | GlueKMassageSeqStarX2Plus | GlueKMassageSeqStarX2SLPlus | GlueKMassageSeqStarX2SeqXStar | GlueKMassageSeqXOpt2SeqOptX | GlueKMassageSeqXPlus2SeqPlusX | GlueKMassageSeqXStar2Plus | GlueKMassageSeqXStar2SLPlus | GlueKMassageSeqXStar2SeqStarX | GlueKMassageStar2OptPlus | GlueKMassageStar2OptStar | GlueKMassageStar2Or1Star | GlueKMassageStar2OrEpsPlus | GlueKMassageStar2OrEpsStar | GlueKMassageStar2OrOptPlus | GlueKMassageStar2OrOptStar | GlueKMassageStar2OrPlusEps | GlueKMassageStar2OrPlusOpt | GlueKMassageStar2OrPlusStar | GlueKMassageStar2OrStar1 | GlueKMassageStar2OrStarEps | GlueKMassageStar2OrStarOpt | GlueKMassageStar2OrStarPlus | GlueKMassageStar2PlusOpt | GlueKMassageStar2PlusStar | GlueKMassageStar2SeqOptStar | GlueKMassageStar2SeqStarOpt | GlueKMassageStar2SeqStarStar | GlueKMassageStar2StarOpt | GlueKMassageStar2StarPlus | GlueKMassageStar2StarStar | GlueKMassageStarLabel2LabelStar | GlueKMassageStarMark2MarkStar | GlueKMassageStarOpt2Star | GlueKMassageStarPlus2Star | GlueKMassageStarStar2Star | GlueKMassageX2NotNot | GlueKNarrowOpt2X | GlueKNarrowPlus2X | GlueKNarrowStar2Opt | GlueKNarrowStar2Plus | GlueKNarrowStar2X | GlueKParenthesizeAll | GlueKPermuteInfix2Postfix | GlueKPermuteInfix2Prefix | GlueKPermutePostfix2Infix | GlueKPermutePostfix2Prefix | GlueKPermutePrefix2Infix | GlueKPermutePrefix2Postfix | GlueKRAssocAll | GlueKRedefineAll | GlueKRenameAllN | GlueKRenameAllT | GlueKReroot2top | GlueKRetireLs | GlueKRetireMs | GlueKRetireTs | GlueKSplitAllT | GlueKUnchainAll | GlueKUndefineTrivial | GlueKUnfoldMax | GlueKUniteBySuffix | GlueKVerticalAll | GlueKWidenOpt2Star | GlueKWidenPlus2Star | GlueKYaccifyAllL | GlueKYaccifyAllR;

syntax GlueCommand
	= GlueKAbridgeAll "."
	| GlueKChainMixed "."
	| GlueKConcatAllT "."
	| GlueKDefineMin "."
	| GlueKDeyaccifyAll "."
	| GlueKDisappearEverywhere GlueSymbol e "."
	| GlueKDistributeAll "."
	| GlueKDropSuffixN GlueNonterminal pre GlueNonterminal post "."
	| GlueKEliminateTop "."
	| GlueKEquateAll "."
	| GlueKFoldMax "."
	| GlueKHorizontalAll "."
	| GlueKInlineMax "."
	| GlueKInlinePlus "."
	| GlueKInsertLayout "."
	| GlueKIterateXX "."
	| GlueKIterateXYXLeft "."
	| GlueKIterateXYXRight "."
	| GlueKLAssocAll "."
	| GlueKLiftTopLabels "."
	| GlueKMassageAndNot2Except "."
	| GlueKMassageAndNotXY2NotOrXY "."
	| GlueKMassageAndNotYX2NotOrXY "."
	| GlueKMassageAndXY2NotOrNotXY "."
	| GlueKMassageAndYX2NotOrNotXY "."
	| GlueKMassageExcept2AndNot "."
	| GlueKMassageLabelNot2NotLabel "."
	| GlueKMassageLabelOpt2OptLabel "."
	| GlueKMassageLabelPlus2PlusLabel "."
	| GlueKMassageLabelStar2StarLabel "."
	| GlueKMassageMarkNot2NotMark "."
	| GlueKMassageMarkOpt2OptMark "."
	| GlueKMassageMarkPlus2PlusMark "."
	| GlueKMassageMarkStar2StarMark "."
	| GlueKMassageNotAndNotXY2OrXY "."
	| GlueKMassageNotAndNotXY2OrYX "."
	| GlueKMassageNotAndXY2OrNotXY "."
	| GlueKMassageNotAndXY2OrNotYX "."
	| GlueKMassageNotLabel2LabelNot "."
	| GlueKMassageNotMark2MarkNot "."
	| GlueKMassageNotNot2X "."
	| GlueKMassageNotOrNotXY2AndXY "."
	| GlueKMassageNotOrNotXY2AndYX "."
	| GlueKMassageNotOrXY2AndNotXY "."
	| GlueKMassageNotOrXY2AndNotYX "."
	| GlueKMassageOpt2OptOpt "."
	| GlueKMassageOpt2OrEpsOpt "."
	| GlueKMassageOpt2OrEpsX "."
	| GlueKMassageOpt2OrOptEps "."
	| GlueKMassageOpt2OrOptX "."
	| GlueKMassageOpt2OrXEps "."
	| GlueKMassageOpt2OrXOpt "."
	| GlueKMassageOptLabel2LabelOpt "."
	| GlueKMassageOptMark2MarkOpt "."
	| GlueKMassageOptOpt2Opt "."
	| GlueKMassageOptPlus2Star "."
	| GlueKMassageOptSLPlus2SLStar "."
	| GlueKMassageOptSeqStarX2SLStar "."
	| GlueKMassageOptSeqXStar2SLStar "."
	| GlueKMassageOptStar2Star "."
	| GlueKMassageOr1Star2Star "."
	| GlueKMassageOrEpsOpt2Opt "."
	| GlueKMassageOrEpsPlus2Star "."
	| GlueKMassageOrEpsStar2Star "."
	| GlueKMassageOrEpsX2Opt "."
	| GlueKMassageOrLabels2 "."
	| GlueKMassageOrLabels3 "."
	| GlueKMassageOrMarks2 "."
	| GlueKMassageOrMarks3 "."
	| GlueKMassageOrNotXY2NotAndXY "."
	| GlueKMassageOrNotYX2NotAndXY "."
	| GlueKMassageOrOptEps2Opt "."
	| GlueKMassageOrOptPlus2Star "."
	| GlueKMassageOrOptStar2Star "."
	| GlueKMassageOrOptX2Opt "."
	| GlueKMassageOrPlusEps2Star "."
	| GlueKMassageOrPlusOpt2Star "."
	| GlueKMassageOrPlusStar2Star "."
	| GlueKMassageOrPlusX2Plus "."
	| GlueKMassageOrStar12Star "."
	| GlueKMassageOrStarEps2Star "."
	| GlueKMassageOrStarOpt2Star "."
	| GlueKMassageOrStarPlus2Star "."
	| GlueKMassageOrXEps2Opt "."
	| GlueKMassageOrXOpt2Opt "."
	| GlueKMassageOrXPlus2Plus "."
	| GlueKMassageOrXY2NotAndNotXY "."
	| GlueKMassageOrYX2NotAndNotXY "."
	| GlueKMassagePlus2OrPlusX "."
	| GlueKMassagePlus2OrXPlus "."
	| GlueKMassagePlus2PlusPlus "."
	| GlueKMassagePlus2SeqOptPlus "."
	| GlueKMassagePlus2SeqPlusOpt "."
	| GlueKMassagePlus2SeqPlusStar "."
	| GlueKMassagePlus2SeqStarPlus "."
	| GlueKMassagePlus2SeqStarX "."
	| GlueKMassagePlus2SeqXStar "."
	| GlueKMassagePlusLabel2LabelPlus "."
	| GlueKMassagePlusMark2MarkPlus "."
	| GlueKMassagePlusOpt2Star "."
	| GlueKMassagePlusPlus2Plus "."
	| GlueKMassagePlusStar2Star "."
	| GlueKMassageSLPlus2SeqStarX "."
	| GlueKMassageSLPlus2SeqXStar "."
	| GlueKMassageSLStar2OptSLPlus "."
	| GlueKMassageSLStar2OptSeqStarX "."
	| GlueKMassageSLStar2OptSeqXStar "."
	| GlueKMassageSeqOptPlus2Plus "."
	| GlueKMassageSeqOptStar2Star "."
	| GlueKMassageSeqOptX2SeqXOpt "."
	| GlueKMassageSeqPlusOpt2Plus "."
	| GlueKMassageSeqPlusStar2Plus "."
	| GlueKMassageSeqPlusX2SeqXPlus "."
	| GlueKMassageSeqStarOpt2Star "."
	| GlueKMassageSeqStarPlus2Plus "."
	| GlueKMassageSeqStarStar2Star "."
	| GlueKMassageSeqStarX2Plus "."
	| GlueKMassageSeqStarX2SLPlus "."
	| GlueKMassageSeqStarX2SeqXStar "."
	| GlueKMassageSeqXOpt2SeqOptX "."
	| GlueKMassageSeqXPlus2SeqPlusX "."
	| GlueKMassageSeqXStar2Plus "."
	| GlueKMassageSeqXStar2SLPlus "."
	| GlueKMassageSeqXStar2SeqStarX "."
	| GlueKMassageStar2OptPlus "."
	| GlueKMassageStar2OptStar "."
	| GlueKMassageStar2Or1Star "."
	| GlueKMassageStar2OrEpsPlus "."
	| GlueKMassageStar2OrEpsStar "."
	| GlueKMassageStar2OrOptPlus "."
	| GlueKMassageStar2OrOptStar "."
	| GlueKMassageStar2OrPlusEps "."
	| GlueKMassageStar2OrPlusOpt "."
	| GlueKMassageStar2OrPlusStar "."
	| GlueKMassageStar2OrStar1 "."
	| GlueKMassageStar2OrStarEps "."
	| GlueKMassageStar2OrStarOpt "."
	| GlueKMassageStar2OrStarPlus "."
	| GlueKMassageStar2PlusOpt "."
	| GlueKMassageStar2PlusStar "."
	| GlueKMassageStar2SeqOptStar "."
	| GlueKMassageStar2SeqStarOpt "."
	| GlueKMassageStar2SeqStarStar "."
	| GlueKMassageStar2StarOpt "."
	| GlueKMassageStar2StarPlus "."
	| GlueKMassageStar2StarStar "."
	| GlueKMassageStarLabel2LabelStar "."
	| GlueKMassageStarMark2MarkStar "."
	| GlueKMassageStarOpt2Star "."
	| GlueKMassageStarPlus2Star "."
	| GlueKMassageStarStar2Star "."
	| GlueKMassageX2NotNot "."
	| GlueKNarrowOpt2X "."
	| GlueKNarrowPlus2X "."
	| GlueKNarrowStar2Opt "."
	| GlueKNarrowStar2Plus "."
	| GlueKNarrowStar2X "."
	| GlueKParenthesizeAll "."
	| GlueKPermuteInfix2Postfix "."
	| GlueKPermuteInfix2Prefix "."
	| GlueKPermutePostfix2Infix "."
	| GlueKPermutePostfix2Prefix "."
	| GlueKPermutePrefix2Infix "."
	| GlueKPermutePrefix2Postfix "."
	| GlueKRAssocAll "."
	| GlueKRedefineAll GlueProduction+ ps "."
	| GlueKRenameAllN GlueKwFrom GlueNonterminal x GlueKwTo GlueNonterminal y "."
	| GlueKRenameAllT GlueKwFrom GlueTerminal x GlueKwTo GlueTerminal y "."
	| GlueKReroot2top "."
	| GlueKRetireLs "."
	| GlueKRetireMs "."
	| GlueKRetireTs "."
	| GlueKSplitAllT "."
	| GlueKUnchainAll "."
	| GlueKUndefineTrivial "."
	| GlueKUnfoldMax "."
	| GlueKUniteBySuffix GlueNonterminal pre GlueNonterminal post "."
	| GlueKVerticalAll "."
	| GlueKWidenOpt2Star "."
	| GlueKWidenPlus2Star "."
	| GlueKYaccifyAllL "."
	| GlueKYaccifyAllR "."
	;