@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::SLEIR

//import grammarlab::language::Grammar;

alias MSequence = list[MCommand];

data MCommand
	// Type I first
	= AbridgeAll()
	| DeyaccifyAll()
	| DistributeAll()
	| EliminateTop()
	| EquateAll()
	| FoldMax()
	| HorizontalAll()
	| InlineMax()
	| UnchainAll()
	| UnfoldMax()
	| VerticalAll()
	// Type IV
	| DropPrefixN(str p)
	| DropPostfixN(str p)
	| RenameAllN(str n1, str n2) // TODO: perhaps better to define a proper ADT to make naming conventions first class entities
	// the rest
	| InlinePlus()
	| LiftTopLabels()
;

