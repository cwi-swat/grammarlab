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
lexical GlueKMassageAndNot2NotOr = @category="MetaAmbiguity" "MassageAndNot2NotOr";
lexical GlueKMassageExcept2AndNot = @category="MetaAmbiguity" "MassageExcept2AndNot";
lexical GlueKMassageLabelNot2NotLabel = @category="MetaAmbiguity" "MassageLabelNot2NotLabel";
lexical GlueKMassageLabelOpt2OptLabel = @category="MetaAmbiguity" "MassageLabelOpt2OptLabel";
lexical GlueKMassageLabelPlus2PlusLabel = @category="MetaAmbiguity" "MassageLabelPlus2PlusLabel";
lexical GlueKMassageLabelStar2StarLabel = @category="MetaAmbiguity" "MassageLabelStar2StarLabel";
lexical GlueKMassageMarkNot2NotMark = @category="MetaAmbiguity" "MassageMarkNot2NotMark";
lexical GlueKMassageMarkOpt2OptMark = @category="MetaAmbiguity" "MassageMarkOpt2OptMark";
lexical GlueKMassageMarkPlus2PlusMark = @category="MetaAmbiguity" "MassageMarkPlus2PlusMark";
lexical GlueKMassageMarkStar2StarMark = @category="MetaAmbiguity" "MassageMarkStar2StarMark";
lexical GlueKMassageNotAnd2OrNot = @category="MetaAmbiguity" "MassageNotAnd2OrNot";
lexical GlueKMassageNotLabel2LabelNot = @category="MetaAmbiguity" "MassageNotLabel2LabelNot";
lexical GlueKMassageNotMark2MarkNot = @category="MetaAmbiguity" "MassageNotMark2MarkNot";
lexical GlueKMassageNotNot = @category="MetaAmbiguity" "MassageNotNot";
lexical GlueKMassageNotOr2AndNot = @category="MetaAmbiguity" "MassageNotOr2AndNot";
lexical GlueKMassageOpt2OrEpsX = @category="MetaAmbiguity" "MassageOpt2OrEpsX";
lexical GlueKMassageOpt2OrXEps = @category="MetaAmbiguity" "MassageOpt2OrXEps";
lexical GlueKMassageOptLabel2LabelOpt = @category="MetaAmbiguity" "MassageOptLabel2LabelOpt";
lexical GlueKMassageOptMark2MarkOpt = @category="MetaAmbiguity" "MassageOptMark2MarkOpt";
lexical GlueKMassageOptOpt = @category="MetaAmbiguity" "MassageOptOpt";
lexical GlueKMassageOptPlus2Star = @category="MetaAmbiguity" "MassageOptPlus2Star";
lexical GlueKMassageOptSLPlus2SLStar = @category="MetaAmbiguity" "MassageOptSLPlus2SLStar";
lexical GlueKMassageOptSeqStarX2SLStar = @category="MetaAmbiguity" "MassageOptSeqStarX2SLStar";
lexical GlueKMassageOptSeqXStar2SLStar = @category="MetaAmbiguity" "MassageOptSeqXStar2SLStar";
lexical GlueKMassageOptStar = @category="MetaAmbiguity" "MassageOptStar";
lexical GlueKMassageOrEpsX2Opt = @category="MetaAmbiguity" "MassageOrEpsX2Opt";
lexical GlueKMassageOrLabels2 = @category="MetaAmbiguity" "MassageOrLabels2";
lexical GlueKMassageOrLabels3 = @category="MetaAmbiguity" "MassageOrLabels3";
lexical GlueKMassageOrMarks2 = @category="MetaAmbiguity" "MassageOrMarks2";
lexical GlueKMassageOrMarks3 = @category="MetaAmbiguity" "MassageOrMarks3";
lexical GlueKMassageOrNot2NotAnd = @category="MetaAmbiguity" "MassageOrNot2NotAnd";
lexical GlueKMassageOrOptEps = @category="MetaAmbiguity" "MassageOrOptEps";
lexical GlueKMassageOrOptX = @category="MetaAmbiguity" "MassageOrOptX";
lexical GlueKMassageOrPlusEps2Star = @category="MetaAmbiguity" "MassageOrPlusEps2Star";
lexical GlueKMassageOrPlusOpt2Star = @category="MetaAmbiguity" "MassageOrPlusOpt2Star";
lexical GlueKMassageOrPlusX = @category="MetaAmbiguity" "MassageOrPlusX";
lexical GlueKMassageOrStarEps = @category="MetaAmbiguity" "MassageOrStarEps";
lexical GlueKMassageOrStarOpt = @category="MetaAmbiguity" "MassageOrStarOpt";
lexical GlueKMassageOrStarPlus = @category="MetaAmbiguity" "MassageOrStarPlus";
lexical GlueKMassageOrStarX = @category="MetaAmbiguity" "MassageOrStarX";
lexical GlueKMassageOrXEps2Opt = @category="MetaAmbiguity" "MassageOrXEps2Opt";
lexical GlueKMassagePlus2SeqStarX = @category="MetaAmbiguity" "MassagePlus2SeqStarX";
lexical GlueKMassagePlus2SeqXStar = @category="MetaAmbiguity" "MassagePlus2SeqXStar";
lexical GlueKMassagePlusLabel2LabelPlus = @category="MetaAmbiguity" "MassagePlusLabel2LabelPlus";
lexical GlueKMassagePlusMark2MarkPlus = @category="MetaAmbiguity" "MassagePlusMark2MarkPlus";
lexical GlueKMassagePlusOpt2Star = @category="MetaAmbiguity" "MassagePlusOpt2Star";
lexical GlueKMassagePlusPlus = @category="MetaAmbiguity" "MassagePlusPlus";
lexical GlueKMassagePlusStar = @category="MetaAmbiguity" "MassagePlusStar";
lexical GlueKMassageSLPlus2SeqStarX = @category="MetaAmbiguity" "MassageSLPlus2SeqStarX";
lexical GlueKMassageSLPlus2SeqXStar = @category="MetaAmbiguity" "MassageSLPlus2SeqXStar";
lexical GlueKMassageSLStar2OptSLPlus = @category="MetaAmbiguity" "MassageSLStar2OptSLPlus";
lexical GlueKMassageSLStar2OptSeqStarX = @category="MetaAmbiguity" "MassageSLStar2OptSeqStarX";
lexical GlueKMassageSLStar2OptSeqXStar = @category="MetaAmbiguity" "MassageSLStar2OptSeqXStar";
lexical GlueKMassageSeqOptPlus = @category="MetaAmbiguity" "MassageSeqOptPlus";
lexical GlueKMassageSeqOptStar = @category="MetaAmbiguity" "MassageSeqOptStar";
lexical GlueKMassageSeqOptX2SeqXOpt = @category="MetaAmbiguity" "MassageSeqOptX2SeqXOpt";
lexical GlueKMassageSeqPlusOpt = @category="MetaAmbiguity" "MassageSeqPlusOpt";
lexical GlueKMassageSeqPlusStar = @category="MetaAmbiguity" "MassageSeqPlusStar";
lexical GlueKMassageSeqPlusX2SeqXPlus = @category="MetaAmbiguity" "MassageSeqPlusX2SeqXPlus";
lexical GlueKMassageSeqStarOpt = @category="MetaAmbiguity" "MassageSeqStarOpt";
lexical GlueKMassageSeqStarPlus = @category="MetaAmbiguity" "MassageSeqStarPlus";
lexical GlueKMassageSeqStarStar = @category="MetaAmbiguity" "MassageSeqStarStar";
lexical GlueKMassageSeqStarX2Plus = @category="MetaAmbiguity" "MassageSeqStarX2Plus";
lexical GlueKMassageSeqStarX2SLPlus = @category="MetaAmbiguity" "MassageSeqStarX2SLPlus";
lexical GlueKMassageSeqStarX2SeqXStar = @category="MetaAmbiguity" "MassageSeqStarX2SeqXStar";
lexical GlueKMassageSeqXOpt2SeqOptX = @category="MetaAmbiguity" "MassageSeqXOpt2SeqOptX";
lexical GlueKMassageSeqXPlus2SeqPlusX = @category="MetaAmbiguity" "MassageSeqXPlus2SeqPlusX";
lexical GlueKMassageSeqXStar2Plus = @category="MetaAmbiguity" "MassageSeqXStar2Plus";
lexical GlueKMassageSeqXStar2SLPlus = @category="MetaAmbiguity" "MassageSeqXStar2SLPlus";
lexical GlueKMassageSeqXStar2SeqStarX = @category="MetaAmbiguity" "MassageSeqXStar2SeqStarX";
lexical GlueKMassageStar2OptPlus = @category="MetaAmbiguity" "MassageStar2OptPlus";
lexical GlueKMassageStar2OrPlusEps = @category="MetaAmbiguity" "MassageStar2OrPlusEps";
lexical GlueKMassageStar2OrPlusOpt = @category="MetaAmbiguity" "MassageStar2OrPlusOpt";
lexical GlueKMassageStar2PlusOpt = @category="MetaAmbiguity" "MassageStar2PlusOpt";
lexical GlueKMassageStarLabel2LabelStar = @category="MetaAmbiguity" "MassageStarLabel2LabelStar";
lexical GlueKMassageStarMark2MarkStar = @category="MetaAmbiguity" "MassageStarMark2MarkStar";
lexical GlueKMassageStarOpt = @category="MetaAmbiguity" "MassageStarOpt";
lexical GlueKMassageStarPlus = @category="MetaAmbiguity" "MassageStarPlus";
lexical GlueKMassageStarStar = @category="MetaAmbiguity" "MassageStarStar";
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

keyword GlueKw = GlueKAbridgeAll | GlueKChainMixed | GlueKConcatAllT | GlueKDefineMin | GlueKDeyaccifyAll | GlueKDisappearEverywhere | GlueKDistributeAll | GlueKDropSuffixN | GlueKEliminateTop | GlueKEquateAll | GlueKFoldMax | GlueKHorizontalAll | GlueKInlineMax | GlueKInlinePlus | GlueKInsertLayout | GlueKIterateXX | GlueKIterateXYXLeft | GlueKIterateXYXRight | GlueKLAssocAll | GlueKLiftTopLabels | GlueKMassageAndNot2Except | GlueKMassageAndNot2NotOr | GlueKMassageExcept2AndNot | GlueKMassageLabelNot2NotLabel | GlueKMassageLabelOpt2OptLabel | GlueKMassageLabelPlus2PlusLabel | GlueKMassageLabelStar2StarLabel | GlueKMassageMarkNot2NotMark | GlueKMassageMarkOpt2OptMark | GlueKMassageMarkPlus2PlusMark | GlueKMassageMarkStar2StarMark | GlueKMassageNotAnd2OrNot | GlueKMassageNotLabel2LabelNot | GlueKMassageNotMark2MarkNot | GlueKMassageNotNot | GlueKMassageNotOr2AndNot | GlueKMassageOpt2OrEpsX | GlueKMassageOpt2OrXEps | GlueKMassageOptLabel2LabelOpt | GlueKMassageOptMark2MarkOpt | GlueKMassageOptOpt | GlueKMassageOptPlus2Star | GlueKMassageOptSLPlus2SLStar | GlueKMassageOptSeqStarX2SLStar | GlueKMassageOptSeqXStar2SLStar | GlueKMassageOptStar | GlueKMassageOrEpsX2Opt | GlueKMassageOrLabels2 | GlueKMassageOrLabels3 | GlueKMassageOrMarks2 | GlueKMassageOrMarks3 | GlueKMassageOrNot2NotAnd | GlueKMassageOrOptEps | GlueKMassageOrOptX | GlueKMassageOrPlusEps2Star | GlueKMassageOrPlusOpt2Star | GlueKMassageOrPlusX | GlueKMassageOrStarEps | GlueKMassageOrStarOpt | GlueKMassageOrStarPlus | GlueKMassageOrStarX | GlueKMassageOrXEps2Opt | GlueKMassagePlus2SeqStarX | GlueKMassagePlus2SeqXStar | GlueKMassagePlusLabel2LabelPlus | GlueKMassagePlusMark2MarkPlus | GlueKMassagePlusOpt2Star | GlueKMassagePlusPlus | GlueKMassagePlusStar | GlueKMassageSLPlus2SeqStarX | GlueKMassageSLPlus2SeqXStar | GlueKMassageSLStar2OptSLPlus | GlueKMassageSLStar2OptSeqStarX | GlueKMassageSLStar2OptSeqXStar | GlueKMassageSeqOptPlus | GlueKMassageSeqOptStar | GlueKMassageSeqOptX2SeqXOpt | GlueKMassageSeqPlusOpt | GlueKMassageSeqPlusStar | GlueKMassageSeqPlusX2SeqXPlus | GlueKMassageSeqStarOpt | GlueKMassageSeqStarPlus | GlueKMassageSeqStarStar | GlueKMassageSeqStarX2Plus | GlueKMassageSeqStarX2SLPlus | GlueKMassageSeqStarX2SeqXStar | GlueKMassageSeqXOpt2SeqOptX | GlueKMassageSeqXPlus2SeqPlusX | GlueKMassageSeqXStar2Plus | GlueKMassageSeqXStar2SLPlus | GlueKMassageSeqXStar2SeqStarX | GlueKMassageStar2OptPlus | GlueKMassageStar2OrPlusEps | GlueKMassageStar2OrPlusOpt | GlueKMassageStar2PlusOpt | GlueKMassageStarLabel2LabelStar | GlueKMassageStarMark2MarkStar | GlueKMassageStarOpt | GlueKMassageStarPlus | GlueKMassageStarStar | GlueKNarrowOpt2X | GlueKNarrowPlus2X | GlueKNarrowStar2Opt | GlueKNarrowStar2Plus | GlueKNarrowStar2X | GlueKParenthesizeAll | GlueKPermuteInfix2Postfix | GlueKPermuteInfix2Prefix | GlueKPermutePostfix2Infix | GlueKPermutePostfix2Prefix | GlueKPermutePrefix2Infix | GlueKPermutePrefix2Postfix | GlueKRAssocAll | GlueKRedefineAll | GlueKRenameAllN | GlueKRenameAllT | GlueKReroot2top | GlueKRetireLs | GlueKRetireMs | GlueKRetireTs | GlueKSplitAllT | GlueKUnchainAll | GlueKUndefineTrivial | GlueKUnfoldMax | GlueKUniteBySuffix | GlueKVerticalAll | GlueKWidenOpt2Star | GlueKWidenPlus2Star | GlueKYaccifyAllL | GlueKYaccifyAllR;

syntax GlueCommand
	= GlueKAbridgeAll "."
	| GlueKChainMixed "."
	| GlueKConcatAllT "."
	| GlueKDefineMin "."
	| GlueKDeyaccifyAll "."
	| GlueKDisappearEverywhere GlueSymbol e "."
	| GlueKDistributeAll "."
	| GlueKDropSuffixN GlueNonterminal pre "..." GlueNonterminal post "."
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
	| GlueKMassageAndNot2NotOr "."
	| GlueKMassageExcept2AndNot "."
	| GlueKMassageLabelNot2NotLabel "."
	| GlueKMassageLabelOpt2OptLabel "."
	| GlueKMassageLabelPlus2PlusLabel "."
	| GlueKMassageLabelStar2StarLabel "."
	| GlueKMassageMarkNot2NotMark "."
	| GlueKMassageMarkOpt2OptMark "."
	| GlueKMassageMarkPlus2PlusMark "."
	| GlueKMassageMarkStar2StarMark "."
	| GlueKMassageNotAnd2OrNot "."
	| GlueKMassageNotLabel2LabelNot "."
	| GlueKMassageNotMark2MarkNot "."
	| GlueKMassageNotNot "."
	| GlueKMassageNotOr2AndNot "."
	| GlueKMassageOpt2OrEpsX "."
	| GlueKMassageOpt2OrXEps "."
	| GlueKMassageOptLabel2LabelOpt "."
	| GlueKMassageOptMark2MarkOpt "."
	| GlueKMassageOptOpt "."
	| GlueKMassageOptPlus2Star "."
	| GlueKMassageOptSLPlus2SLStar "."
	| GlueKMassageOptSeqStarX2SLStar "."
	| GlueKMassageOptSeqXStar2SLStar "."
	| GlueKMassageOptStar "."
	| GlueKMassageOrEpsX2Opt "."
	| GlueKMassageOrLabels2 "."
	| GlueKMassageOrLabels3 "."
	| GlueKMassageOrMarks2 "."
	| GlueKMassageOrMarks3 "."
	| GlueKMassageOrNot2NotAnd "."
	| GlueKMassageOrOptEps "."
	| GlueKMassageOrOptX "."
	| GlueKMassageOrPlusEps2Star "."
	| GlueKMassageOrPlusOpt2Star "."
	| GlueKMassageOrPlusX "."
	| GlueKMassageOrStarEps "."
	| GlueKMassageOrStarOpt "."
	| GlueKMassageOrStarPlus "."
	| GlueKMassageOrStarX "."
	| GlueKMassageOrXEps2Opt "."
	| GlueKMassagePlus2SeqStarX "."
	| GlueKMassagePlus2SeqXStar "."
	| GlueKMassagePlusLabel2LabelPlus "."
	| GlueKMassagePlusMark2MarkPlus "."
	| GlueKMassagePlusOpt2Star "."
	| GlueKMassagePlusPlus "."
	| GlueKMassagePlusStar "."
	| GlueKMassageSLPlus2SeqStarX "."
	| GlueKMassageSLPlus2SeqXStar "."
	| GlueKMassageSLStar2OptSLPlus "."
	| GlueKMassageSLStar2OptSeqStarX "."
	| GlueKMassageSLStar2OptSeqXStar "."
	| GlueKMassageSeqOptPlus "."
	| GlueKMassageSeqOptStar "."
	| GlueKMassageSeqOptX2SeqXOpt "."
	| GlueKMassageSeqPlusOpt "."
	| GlueKMassageSeqPlusStar "."
	| GlueKMassageSeqPlusX2SeqXPlus "."
	| GlueKMassageSeqStarOpt "."
	| GlueKMassageSeqStarPlus "."
	| GlueKMassageSeqStarStar "."
	| GlueKMassageSeqStarX2Plus "."
	| GlueKMassageSeqStarX2SLPlus "."
	| GlueKMassageSeqStarX2SeqXStar "."
	| GlueKMassageSeqXOpt2SeqOptX "."
	| GlueKMassageSeqXPlus2SeqPlusX "."
	| GlueKMassageSeqXStar2Plus "."
	| GlueKMassageSeqXStar2SLPlus "."
	| GlueKMassageSeqXStar2SeqStarX "."
	| GlueKMassageStar2OptPlus "."
	| GlueKMassageStar2OrPlusEps "."
	| GlueKMassageStar2OrPlusOpt "."
	| GlueKMassageStar2PlusOpt "."
	| GlueKMassageStarLabel2LabelStar "."
	| GlueKMassageStarMark2MarkStar "."
	| GlueKMassageStarOpt "."
	| GlueKMassageStarPlus "."
	| GlueKMassageStarStar "."
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