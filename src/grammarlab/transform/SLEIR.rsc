@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::SLEIR

// TODO: not imported from SLPS yet, the file included for the sake of integrity
// UPDATE: in the process of being imported/reengineered

import grammarlab::language::Grammar;
import grammarlab::language::SLEIR;
import grammarlab::transform::Normal;
import grammarlab::transform::sleir::TypeI;

public GGrammar mutate(MSequence ms, GGrammar g)
	= (g | normalise(mutate(m,it)) | MCommand m <- ms);

public GGrammar mutate(AbridgeAll(), GGrammar g)
	= grammarlab::transform::sleir::TypeI::runAbridgeAll(g);
public GGrammar mutate(DeyaccifyAll(), GGrammar g)
	= grammarlab::transform::sleir::TypeI::runDeyaccifyAll(g);
public GGrammar mutate(DistributeAll(), GGrammar g) = runDistributeAll(g);
public GGrammar mutate(EliminateTop(), GGrammar g) = runEliminateTop(g);
public GGrammar mutate(EquateAll(), GGrammar g) = runEquateAll(g);
public GGrammar mutate(FoldMax(), GGrammar g) = runFoldMax(g);
public GGrammar mutate(HorizontalAll(), GGrammar g) = runHorizontalAll(g);
public GGrammar mutate(InlineMax(), GGrammar g) = runInlineMax(g);
public GGrammar mutate(LiftTopLabels(), GGrammar g) = runLiftTopLabels(g);
public GGrammar mutate(UnchainAll(), GGrammar g) = runUnchainAll(g);
public GGrammar mutate(UnfoldMax(), GGrammar g) = runUnfoldMax(g);
public GGrammar mutate(VerticalAll(), GGrammar g) = runVerticalAll(g);
public default GGrammar mutate(MCommand m, GGrammar g)
{
	println("Don’t know how to mutate with <m>.");
	return g;
}

///////////////////////////////////////////////////////////////////////////
// TODO: get rid of the rest of the file
public GGrammar RetireSs(GGrammar g)
{
	ps = visit(g.prods) {case selectable(_,GExpr e) => e};
	return grammar(g.nts, g.roots, normalise(ps));
}
public GProd RetireSs(GProd p) {return visit(p) {case selectable(_,GExpr e) => e};}
public GExpr RetireSs(GExpr x) {return visit(x) {case selectable(_,GExpr e) => e};}

public GGrammar RetireLs(GGrammar g)
{
	ps = visit(g.prods) {case labelled(_,GExpr e) => e};
	return grammar(g.nts, g.roots, normalise(ps));
}

public GProd RetireLs(GProd p) {return visit(p) {case labelled(_,GExpr e) => e};}
public GExpr RetireLs(GExpr x) {return visit(x) {case labelled(_,GExpr e) => e};}

// TODO: turn into a proper mutation later!
public GGrammar runLiftTopLabels(GGrammar g) = normalise(grammar(g.N,mapper(LiftTopLabels,g.P),g.S));
default GProd runLiftTopLabels(production(str lhs, label(str name, GExpr e))) =
	production(lhs,sequence(nonterminal(name),e));
default GProd runLiftTopLabels(production(str lhs, choice(L))) = production(lhs,choice(mapper(LiftTopLabels,L)));
default GProd runLiftTopLabels(GProd p) = p;
GExpr runLiftTopLabels(label(str name, GExpr e)) = sequence(nonterminal(name),e);
default GExpr runLiftTopLabels(GExpr e) = e;
