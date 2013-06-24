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

public GGrammar RetireLs(GGrammar g)
{
	ps = visit(g.prods) {case labelled(_,GExpr e) => e};
	return grammar(g.nts, g.roots, normalise(ps));
}

public GProd RetireLs(GProd p) {return visit(p) {case labelled(_,GExpr e) => e};}