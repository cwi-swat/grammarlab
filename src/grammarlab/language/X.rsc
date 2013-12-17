@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::X

import grammarlab::language::Grammar;
import grammarlab::language::XScope;

alias XSequence = list[XCommand];

data XCommand
	= abridge(GProd p)
	| abstractize(GProd p) // marked
	| addH(GProd p) // marked
	| addV(GProd p)
	| addC(GProd p) // conjunctive extension
	| anonymize(GProd p) // marked
	| appear(GProd p) // marked
	| bypass()
	| chain(GProd p)
	| clone(GNonTerm x, GNonTerm y, XScope w)
	| concatT(list[GTerm] xs, GTerm y, XScope w)
	| concretize(GProd p) // marked
	| deanonymize(GProd p)
	| define(GProdList ps)
	| designate(GProd p)
	| detour(GProd p)
	| deyaccify(GNonTerm x)
	| disappear(GProd p) // marked
	| distribute(XScope w)
	| downgrade(GProd p1,GProd p2) // p1 is marked
	| eliminate(GNonTerm x)
	| equate(GNonTerm x, GNonTerm y)
	| extract(GProd p, XScope w)
	| factor(GExpr e1, GExpr e2, XScope w)
	| fold(GNonTerm x, XScope w)
	| horizontal(XScope w)
	| importG(GProdList ps)
	| inject(GProd p) // marked
	| inline(GNonTerm x)
	| introduce(GProdList ps)
	| iterate(GProd p)
	| lassoc(GProd p)
	| massage(GExpr e1, GExpr e2, XScope w)
	| narrow(GExpr e1, GExpr e2, XScope w)
	| permute(GProd p)
	| project(GProd p) // marked
	| rassoc(GProd p)
	| redefine(GProdList ps)
	| removeH(GProd p) // marked
	| removeV(GProd p)
	| renameL(GLabel x, GLabel y)
	| renameN(GNonTerm x, GNonTerm y)
	| renameS(GMark x, GMark y, XScope w) // only inlabel(z) TODO coevolve with marks
	| renameT(GTerm x, GTerm y)
	| replace(GExpr e1, GExpr e2, XScope w)
	| reroot(list[GNonTerm] xs)
	| splitN(GNonTerm x, GProdList ps, XScope w)
	| splitT(GTerm x, list[GTerm] ys, XScope w)
	| unchain(GProd p)
	| undefine(list[GNonTerm] xs) // TODO: make it legacy
	| undefineNew(GNonTerm x)
	| unfold(GNonTerm x, XScope w)
	| unite(GNonTerm x, GNonTerm y)
	| unlabel(GLabel x) // ???
	| upgrade(GProd p1, GProd p2) // p1 is marked
	| vertical(XScope w)
	| widen(GExpr e1, GExpr e2, XScope w)
	| yaccify(GProdList ps)
;

