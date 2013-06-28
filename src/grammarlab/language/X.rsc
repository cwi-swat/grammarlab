@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module language::X

import language::Grammar;
import language::XScope;

alias XSequence = list[XCommand];

data XCommand =
	  abridge(GProd p)
	| abstractize(GProd p) // marked
	| addH(GProd p) // marked
	| addV(GProd p)
	| addC(GProd p) // conjunctive extension
	| anonymize(GProd p) // marked
	| appear(GProd p) // marked
	| bypass()
	| chain(GProd p)
	| clone(str x, str y, XScope w)
	| concatT(list[str] xs, str y, XScope w)
	| concretize(GProd p) // marked
	| deanonymize(GProd p)
	| define(GProdList ps)
	| designate(GProd p)
	| detour(GProd p)
	| deyaccify(str x)
	| disappear(GProd p) // marked
	| distribute(XScope w)
	| downgrade(GProd p1,GProd p2) // p1 is marked
	| eliminate(str x)
	| equate(str x, str y)
	| extract(GProd p, XScope w)
	| factor(GExpr e1, GExpr e2, XScope w)
	| fold(str x, XScope w)
	| horizontal(XScope w)
	| importG(GProdList ps)
	| inject(GProd p) // marked
	| inline(str x)
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
	| renameL(str x, str y)
	| renameN(str x, str y)
	| renameS(str x, str y, XScope w) // only inlabel(z)
	| renameT(str x, str y)
	| replace(GExpr e1, GExpr e2, XScope w)
	| reroot(list[str] xs)
	| splitN(str x, GProdList ps, XScope w)
	| splitT(str x, list[str] ys, XScope w)
	| unchain(GProd p)
	| undefine(list[str] xs)
	| unfold(str x, XScope w)
	| unite(str x, str y)
	| unlabel(str x) // ???
	| upgrade(GProd p1, GProd p2) // p1 is marked
	| vertical(XScope w)
	| widen(GExpr e1, GExpr e2, XScope w)
	| yaccify(GProdList ps)
;

