@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::SLEIR

//import grammarlab::language::Grammar;

alias MSequence = list[MCommand];

data MCommand
	// Type I first
	= AbridgeAll()
	| DeYaccifyAll()
	| DistributeAll()
	| EliminateTop()
	| EquateAll()
	| FoldMax()
	| HorizontalAll()
	| InlineMax()
	| UnchainAll()
	| UnfoldMax()
	| VerticalAll()
	// the rest
	| InlinePlus()
	| LiftTopLabels()
;

