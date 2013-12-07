@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::SLEIR

//import grammarlab::language::Grammar;
import grammarlab::language::X;

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
	| DropPrefixN(GTerm p) // TODO: is fake terminal ok?
	| DropPostfixN(GTerm p) // TODO: is fake terminal ok?
	| RenameAllN(GNonTerm n1, GNonTerm n2) // TODO: perhaps better to define a proper ADT to make naming conventions first class entities
	// the rest
	| InlinePlus()
	| LiftTopLabels()
;

