@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
@contributor{Generated by meta::Glue, do not edit manually!}
module grammarlab::language::glue::concrete::SLEIR

import grammarlab::language::glue::concrete::BGF;
import grammarlab::language::glue::concrete::XBGF;

lexical GlueKAbridgeAll = @category="MetaAmbiguity" "AbridgeAll";
lexical GlueKDeyaccifyAll = @category="MetaAmbiguity" "DeyaccifyAll";
lexical GlueKDistributeAll = @category="MetaAmbiguity" "DistributeAll";
lexical GlueKDropPostfixN = @category="MetaAmbiguity" "DropPostfixN";
lexical GlueKDropPrefixN = @category="MetaAmbiguity" "DropPrefixN";
lexical GlueKEliminateTop = @category="MetaAmbiguity" "EliminateTop";
lexical GlueKEquateAll = @category="MetaAmbiguity" "EquateAll";
lexical GlueKFoldMax = @category="MetaAmbiguity" "FoldMax";
lexical GlueKHorizontalAll = @category="MetaAmbiguity" "HorizontalAll";
lexical GlueKInlineMax = @category="MetaAmbiguity" "InlineMax";
lexical GlueKInlinePlus = @category="MetaAmbiguity" "InlinePlus";
lexical GlueKLiftTopLabels = @category="MetaAmbiguity" "LiftTopLabels";
lexical GlueKRenameAllN = @category="MetaAmbiguity" "RenameAllN";
lexical GlueKUnchainAll = @category="MetaAmbiguity" "UnchainAll";
lexical GlueKUnfoldMax = @category="MetaAmbiguity" "UnfoldMax";
lexical GlueKVerticalAll = @category="MetaAmbiguity" "VerticalAll";

keyword GlueKw = GlueKAbridgeAll | GlueKDeyaccifyAll | GlueKDistributeAll | GlueKDropPostfixN | GlueKDropPrefixN | GlueKEliminateTop | GlueKEquateAll | GlueKFoldMax | GlueKHorizontalAll | GlueKInlineMax | GlueKInlinePlus | GlueKLiftTopLabels | GlueKRenameAllN | GlueKUnchainAll | GlueKUnfoldMax | GlueKVerticalAll;

syntax GlueCommand
	= GlueKAbridgeAll "."
	| GlueKDeyaccifyAll "."
	| GlueKDistributeAll "."
	| GlueKDropPostfixN GlueTerminal p "."
	| GlueKDropPrefixN GlueTerminal p "."
	| GlueKEliminateTop "."
	| GlueKEquateAll "."
	| GlueKFoldMax "."
	| GlueKHorizontalAll "."
	| GlueKInlineMax "."
	| GlueKInlinePlus "."
	| GlueKLiftTopLabels "."
	| GlueKRenameAllN GlueKwFrom GlueNonterminal n1 GlueKwTo GlueNonterminal n2 "."
	| GlueKUnchainAll "."
	| GlueKUnfoldMax "."
	| GlueKVerticalAll "."
	;