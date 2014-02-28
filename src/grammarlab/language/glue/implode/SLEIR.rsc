@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
@contributor{Generated by meta::Glue, do not edit manually!}
module grammarlab::language::glue::implode::SLEIR

import grammarlab::language::glue::abstract::Top;
import grammarlab::language::glue::concrete::BGF;
import grammarlab::language::glue::concrete::XBGF;
import grammarlab::language::glue::concrete::SLEIR;
import grammarlab::language::Grammar;
import grammarlab::language::SLEIR;

GLUEA glimplode((GlueCommand)`<GlueKAbridgeAll _> .`) = sleir(AbridgeAll());
GLUEA glimplode((GlueCommand)`<GlueKChainMixed _> .`) = sleir(ChainMixed());
GLUEA glimplode((GlueCommand)`<GlueKConcatAllT _> .`) = sleir(ConcatAllT());
GLUEA glimplode((GlueCommand)`<GlueKDefineMin _> .`) = sleir(DefineMin());
GLUEA glimplode((GlueCommand)`<GlueKDeyaccifyAll _> .`) = sleir(DeyaccifyAll());
GLUEA glimplode((GlueCommand)`<GlueKDisappearEverywhere _> <GlueSymbol e> .`) = sleir(DisappearEverywhere(mapS(e)));
GLUEA glimplode((GlueCommand)`<GlueKDistributeAll _> .`) = sleir(DistributeAll());
GLUEA glimplode((GlueCommand)`<GlueKDropSuffixN _> <GlueNonterminal pre> ... <GlueNonterminal post> .`) = sleir(DropSuffixN("<pre.name>","<post.name>"));
GLUEA glimplode((GlueCommand)`<GlueKEliminateTop _> .`) = sleir(EliminateTop());
GLUEA glimplode((GlueCommand)`<GlueKEquateAll _> .`) = sleir(EquateAll());
GLUEA glimplode((GlueCommand)`<GlueKFoldMax _> .`) = sleir(FoldMax());
GLUEA glimplode((GlueCommand)`<GlueKHorizontalAll _> .`) = sleir(HorizontalAll());
GLUEA glimplode((GlueCommand)`<GlueKInlineMax _> .`) = sleir(InlineMax());
GLUEA glimplode((GlueCommand)`<GlueKInlinePlus _> .`) = sleir(InlinePlus());
GLUEA glimplode((GlueCommand)`<GlueKInsertLayout _> .`) = sleir(InsertLayout());
GLUEA glimplode((GlueCommand)`<GlueKIterateXX _> .`) = sleir(IterateXX());
GLUEA glimplode((GlueCommand)`<GlueKIterateXYXLeft _> .`) = sleir(IterateXYXLeft());
GLUEA glimplode((GlueCommand)`<GlueKIterateXYXRight _> .`) = sleir(IterateXYXRight());
GLUEA glimplode((GlueCommand)`<GlueKLAssocAll _> .`) = sleir(LAssocAll());
GLUEA glimplode((GlueCommand)`<GlueKLiftTopLabels _> .`) = sleir(LiftTopLabels());
GLUEA glimplode((GlueCommand)`<GlueKMassageAndNot2Except _> .`) = sleir(MassageAndNot2Except());
GLUEA glimplode((GlueCommand)`<GlueKMassageAndNot2NotOr _> .`) = sleir(MassageAndNot2NotOr());
GLUEA glimplode((GlueCommand)`<GlueKMassageExcept2AndNot _> .`) = sleir(MassageExcept2AndNot());
GLUEA glimplode((GlueCommand)`<GlueKMassageLabelNot2NotLabel _> .`) = sleir(MassageLabelNot2NotLabel());
GLUEA glimplode((GlueCommand)`<GlueKMassageLabelOpt2OptLabel _> .`) = sleir(MassageLabelOpt2OptLabel());
GLUEA glimplode((GlueCommand)`<GlueKMassageLabelPlus2PlusLabel _> .`) = sleir(MassageLabelPlus2PlusLabel());
GLUEA glimplode((GlueCommand)`<GlueKMassageLabelStar2StarLabel _> .`) = sleir(MassageLabelStar2StarLabel());
GLUEA glimplode((GlueCommand)`<GlueKMassageMarkNot2NotMark _> .`) = sleir(MassageMarkNot2NotMark());
GLUEA glimplode((GlueCommand)`<GlueKMassageMarkOpt2OptMark _> .`) = sleir(MassageMarkOpt2OptMark());
GLUEA glimplode((GlueCommand)`<GlueKMassageMarkPlus2PlusMark _> .`) = sleir(MassageMarkPlus2PlusMark());
GLUEA glimplode((GlueCommand)`<GlueKMassageMarkStar2StarMark _> .`) = sleir(MassageMarkStar2StarMark());
GLUEA glimplode((GlueCommand)`<GlueKMassageNotAnd2OrNot _> .`) = sleir(MassageNotAnd2OrNot());
GLUEA glimplode((GlueCommand)`<GlueKMassageNotLabel2LabelNot _> .`) = sleir(MassageNotLabel2LabelNot());
GLUEA glimplode((GlueCommand)`<GlueKMassageNotMark2MarkNot _> .`) = sleir(MassageNotMark2MarkNot());
GLUEA glimplode((GlueCommand)`<GlueKMassageNotNot _> .`) = sleir(MassageNotNot());
GLUEA glimplode((GlueCommand)`<GlueKMassageNotOr2AndNot _> .`) = sleir(MassageNotOr2AndNot());
GLUEA glimplode((GlueCommand)`<GlueKMassageOpt2OrEpsX _> .`) = sleir(MassageOpt2OrEpsX());
GLUEA glimplode((GlueCommand)`<GlueKMassageOpt2OrXEps _> .`) = sleir(MassageOpt2OrXEps());
GLUEA glimplode((GlueCommand)`<GlueKMassageOptLabel2LabelOpt _> .`) = sleir(MassageOptLabel2LabelOpt());
GLUEA glimplode((GlueCommand)`<GlueKMassageOptMark2MarkOpt _> .`) = sleir(MassageOptMark2MarkOpt());
GLUEA glimplode((GlueCommand)`<GlueKMassageOptOpt _> .`) = sleir(MassageOptOpt());
GLUEA glimplode((GlueCommand)`<GlueKMassageOptPlus2Star _> .`) = sleir(MassageOptPlus2Star());
GLUEA glimplode((GlueCommand)`<GlueKMassageOptSLPlus2SLStar _> .`) = sleir(MassageOptSLPlus2SLStar());
GLUEA glimplode((GlueCommand)`<GlueKMassageOptSeqStarX2SLStar _> .`) = sleir(MassageOptSeqStarX2SLStar());
GLUEA glimplode((GlueCommand)`<GlueKMassageOptSeqXStar2SLStar _> .`) = sleir(MassageOptSeqXStar2SLStar());
GLUEA glimplode((GlueCommand)`<GlueKMassageOptStar _> .`) = sleir(MassageOptStar());
GLUEA glimplode((GlueCommand)`<GlueKMassageOrEpsX2Opt _> .`) = sleir(MassageOrEpsX2Opt());
GLUEA glimplode((GlueCommand)`<GlueKMassageOrLabels2 _> .`) = sleir(MassageOrLabels2());
GLUEA glimplode((GlueCommand)`<GlueKMassageOrLabels3 _> .`) = sleir(MassageOrLabels3());
GLUEA glimplode((GlueCommand)`<GlueKMassageOrMarks2 _> .`) = sleir(MassageOrMarks2());
GLUEA glimplode((GlueCommand)`<GlueKMassageOrMarks3 _> .`) = sleir(MassageOrMarks3());
GLUEA glimplode((GlueCommand)`<GlueKMassageOrNot2NotAnd _> .`) = sleir(MassageOrNot2NotAnd());
GLUEA glimplode((GlueCommand)`<GlueKMassageOrOptEps _> .`) = sleir(MassageOrOptEps());
GLUEA glimplode((GlueCommand)`<GlueKMassageOrOptX _> .`) = sleir(MassageOrOptX());
GLUEA glimplode((GlueCommand)`<GlueKMassageOrPlusEps2Star _> .`) = sleir(MassageOrPlusEps2Star());
GLUEA glimplode((GlueCommand)`<GlueKMassageOrPlusOpt2Star _> .`) = sleir(MassageOrPlusOpt2Star());
GLUEA glimplode((GlueCommand)`<GlueKMassageOrPlusX _> .`) = sleir(MassageOrPlusX());
GLUEA glimplode((GlueCommand)`<GlueKMassageOrStarEps _> .`) = sleir(MassageOrStarEps());
GLUEA glimplode((GlueCommand)`<GlueKMassageOrStarOpt _> .`) = sleir(MassageOrStarOpt());
GLUEA glimplode((GlueCommand)`<GlueKMassageOrStarPlus _> .`) = sleir(MassageOrStarPlus());
GLUEA glimplode((GlueCommand)`<GlueKMassageOrStarX _> .`) = sleir(MassageOrStarX());
GLUEA glimplode((GlueCommand)`<GlueKMassageOrXEps2Opt _> .`) = sleir(MassageOrXEps2Opt());
GLUEA glimplode((GlueCommand)`<GlueKMassagePlus2SeqStarX _> .`) = sleir(MassagePlus2SeqStarX());
GLUEA glimplode((GlueCommand)`<GlueKMassagePlus2SeqXStar _> .`) = sleir(MassagePlus2SeqXStar());
GLUEA glimplode((GlueCommand)`<GlueKMassagePlusLabel2LabelPlus _> .`) = sleir(MassagePlusLabel2LabelPlus());
GLUEA glimplode((GlueCommand)`<GlueKMassagePlusMark2MarkPlus _> .`) = sleir(MassagePlusMark2MarkPlus());
GLUEA glimplode((GlueCommand)`<GlueKMassagePlusOpt2Star _> .`) = sleir(MassagePlusOpt2Star());
GLUEA glimplode((GlueCommand)`<GlueKMassagePlusPlus _> .`) = sleir(MassagePlusPlus());
GLUEA glimplode((GlueCommand)`<GlueKMassagePlusStar _> .`) = sleir(MassagePlusStar());
GLUEA glimplode((GlueCommand)`<GlueKMassageSLPlus2SeqStarX _> .`) = sleir(MassageSLPlus2SeqStarX());
GLUEA glimplode((GlueCommand)`<GlueKMassageSLPlus2SeqXStar _> .`) = sleir(MassageSLPlus2SeqXStar());
GLUEA glimplode((GlueCommand)`<GlueKMassageSLStar2OptSLPlus _> .`) = sleir(MassageSLStar2OptSLPlus());
GLUEA glimplode((GlueCommand)`<GlueKMassageSLStar2OptSeqStarX _> .`) = sleir(MassageSLStar2OptSeqStarX());
GLUEA glimplode((GlueCommand)`<GlueKMassageSLStar2OptSeqXStar _> .`) = sleir(MassageSLStar2OptSeqXStar());
GLUEA glimplode((GlueCommand)`<GlueKMassageSeqOptPlus _> .`) = sleir(MassageSeqOptPlus());
GLUEA glimplode((GlueCommand)`<GlueKMassageSeqOptStar _> .`) = sleir(MassageSeqOptStar());
GLUEA glimplode((GlueCommand)`<GlueKMassageSeqOptX2SeqXOpt _> .`) = sleir(MassageSeqOptX2SeqXOpt());
GLUEA glimplode((GlueCommand)`<GlueKMassageSeqPlusOpt _> .`) = sleir(MassageSeqPlusOpt());
GLUEA glimplode((GlueCommand)`<GlueKMassageSeqPlusStar _> .`) = sleir(MassageSeqPlusStar());
GLUEA glimplode((GlueCommand)`<GlueKMassageSeqPlusX2SeqXPlus _> .`) = sleir(MassageSeqPlusX2SeqXPlus());
GLUEA glimplode((GlueCommand)`<GlueKMassageSeqStarOpt _> .`) = sleir(MassageSeqStarOpt());
GLUEA glimplode((GlueCommand)`<GlueKMassageSeqStarPlus _> .`) = sleir(MassageSeqStarPlus());
GLUEA glimplode((GlueCommand)`<GlueKMassageSeqStarStar _> .`) = sleir(MassageSeqStarStar());
GLUEA glimplode((GlueCommand)`<GlueKMassageSeqStarX2Plus _> .`) = sleir(MassageSeqStarX2Plus());
GLUEA glimplode((GlueCommand)`<GlueKMassageSeqStarX2SLPlus _> .`) = sleir(MassageSeqStarX2SLPlus());
GLUEA glimplode((GlueCommand)`<GlueKMassageSeqStarX2SeqXStar _> .`) = sleir(MassageSeqStarX2SeqXStar());
GLUEA glimplode((GlueCommand)`<GlueKMassageSeqXOpt2SeqOptX _> .`) = sleir(MassageSeqXOpt2SeqOptX());
GLUEA glimplode((GlueCommand)`<GlueKMassageSeqXPlus2SeqPlusX _> .`) = sleir(MassageSeqXPlus2SeqPlusX());
GLUEA glimplode((GlueCommand)`<GlueKMassageSeqXStar2Plus _> .`) = sleir(MassageSeqXStar2Plus());
GLUEA glimplode((GlueCommand)`<GlueKMassageSeqXStar2SLPlus _> .`) = sleir(MassageSeqXStar2SLPlus());
GLUEA glimplode((GlueCommand)`<GlueKMassageSeqXStar2SeqStarX _> .`) = sleir(MassageSeqXStar2SeqStarX());
GLUEA glimplode((GlueCommand)`<GlueKMassageStar2OptPlus _> .`) = sleir(MassageStar2OptPlus());
GLUEA glimplode((GlueCommand)`<GlueKMassageStar2OrPlusEps _> .`) = sleir(MassageStar2OrPlusEps());
GLUEA glimplode((GlueCommand)`<GlueKMassageStar2OrPlusOpt _> .`) = sleir(MassageStar2OrPlusOpt());
GLUEA glimplode((GlueCommand)`<GlueKMassageStar2PlusOpt _> .`) = sleir(MassageStar2PlusOpt());
GLUEA glimplode((GlueCommand)`<GlueKMassageStarLabel2LabelStar _> .`) = sleir(MassageStarLabel2LabelStar());
GLUEA glimplode((GlueCommand)`<GlueKMassageStarMark2MarkStar _> .`) = sleir(MassageStarMark2MarkStar());
GLUEA glimplode((GlueCommand)`<GlueKMassageStarOpt _> .`) = sleir(MassageStarOpt());
GLUEA glimplode((GlueCommand)`<GlueKMassageStarPlus _> .`) = sleir(MassageStarPlus());
GLUEA glimplode((GlueCommand)`<GlueKMassageStarStar _> .`) = sleir(MassageStarStar());
GLUEA glimplode((GlueCommand)`<GlueKNarrowOpt2X _> .`) = sleir(NarrowOpt2X());
GLUEA glimplode((GlueCommand)`<GlueKNarrowPlus2X _> .`) = sleir(NarrowPlus2X());
GLUEA glimplode((GlueCommand)`<GlueKNarrowStar2Opt _> .`) = sleir(NarrowStar2Opt());
GLUEA glimplode((GlueCommand)`<GlueKNarrowStar2Plus _> .`) = sleir(NarrowStar2Plus());
GLUEA glimplode((GlueCommand)`<GlueKNarrowStar2X _> .`) = sleir(NarrowStar2X());
GLUEA glimplode((GlueCommand)`<GlueKParenthesizeAll _> .`) = sleir(ParenthesizeAll());
GLUEA glimplode((GlueCommand)`<GlueKPermuteInfix2Postfix _> .`) = sleir(PermuteInfix2Postfix());
GLUEA glimplode((GlueCommand)`<GlueKPermuteInfix2Prefix _> .`) = sleir(PermuteInfix2Prefix());
GLUEA glimplode((GlueCommand)`<GlueKPermutePostfix2Infix _> .`) = sleir(PermutePostfix2Infix());
GLUEA glimplode((GlueCommand)`<GlueKPermutePostfix2Prefix _> .`) = sleir(PermutePostfix2Prefix());
GLUEA glimplode((GlueCommand)`<GlueKPermutePrefix2Infix _> .`) = sleir(PermutePrefix2Infix());
GLUEA glimplode((GlueCommand)`<GlueKPermutePrefix2Postfix _> .`) = sleir(PermutePrefix2Postfix());
GLUEA glimplode((GlueCommand)`<GlueKRAssocAll _> .`) = sleir(RAssocAll());
GLUEA glimplode((GlueCommand)`<GlueKRedefineAll _> <GlueProduction+ ps> .`) = sleir(RedefineAll(mapPs(ps)));
GLUEA glimplode((GlueCommand)`<GlueKRenameAllN _> <GlueKwFrom _> <GlueNonterminal x> <GlueKwTo _> <GlueNonterminal y> .`) = sleir(RenameAllN("<x.name>","<y.name>"));
GLUEA glimplode((GlueCommand)`<GlueKRenameAllT _> <GlueKwFrom _> <GlueTerminal x> <GlueKwTo _> <GlueTerminal y> .`) = sleir(RenameAllT("<x.name>","<y.name>"));
GLUEA glimplode((GlueCommand)`<GlueKReroot2top _> .`) = sleir(Reroot2top());
GLUEA glimplode((GlueCommand)`<GlueKRetireLs _> .`) = sleir(RetireLs());
GLUEA glimplode((GlueCommand)`<GlueKRetireMs _> .`) = sleir(RetireMs());
GLUEA glimplode((GlueCommand)`<GlueKRetireTs _> .`) = sleir(RetireTs());
GLUEA glimplode((GlueCommand)`<GlueKSplitAllT _> .`) = sleir(SplitAllT());
GLUEA glimplode((GlueCommand)`<GlueKUnchainAll _> .`) = sleir(UnchainAll());
GLUEA glimplode((GlueCommand)`<GlueKUndefineTrivial _> .`) = sleir(UndefineTrivial());
GLUEA glimplode((GlueCommand)`<GlueKUnfoldMax _> .`) = sleir(UnfoldMax());
GLUEA glimplode((GlueCommand)`<GlueKUniteBySuffix _> <GlueNonterminal pre> <GlueNonterminal post> .`) = sleir(UniteBySuffix("<pre.name>","<post.name>"));
GLUEA glimplode((GlueCommand)`<GlueKVerticalAll _> .`) = sleir(VerticalAll());
GLUEA glimplode((GlueCommand)`<GlueKWidenOpt2Star _> .`) = sleir(WidenOpt2Star());
GLUEA glimplode((GlueCommand)`<GlueKWidenPlus2Star _> .`) = sleir(WidenPlus2Star());
GLUEA glimplode((GlueCommand)`<GlueKYaccifyAllL _> .`) = sleir(YaccifyAllL());
GLUEA glimplode((GlueCommand)`<GlueKYaccifyAllR _> .`) = sleir(YaccifyAllR());