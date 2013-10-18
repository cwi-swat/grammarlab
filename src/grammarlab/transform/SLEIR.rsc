@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::SLEIR

// TODO: not imported from SLPS yet, the file included for the sake of integrity

import grammarlab::language::Grammar;
import grammarlab::transform::Normal;

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
public GGrammar LiftTopLabels(GGrammar g) = normalise(grammar(g.N,mapper(LiftTopLabels,g.P),g.S));
default GProd LiftTopLabels(production(str lhs, label(str name, GExpr e))) = production(lhs,sequence(nonterminal(name),e));
default GProd LiftTopLabels(production(str lhs, choice(L))) = production(lhs,choice(mapper(LiftTopLabels,L)));
default GProd LiftTopLabels(GProd p) = p;
GExpr LiftTopLabels(label(str name, GExpr e)) = sequence(nonterminal(name),e);
default GExpr LiftTopLabels(GExpr e) = e;
