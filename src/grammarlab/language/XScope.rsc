@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::XScope

data XScope =
	globally()
	| nowhere()
	| inlabel(str x)
	| notinlabel(str x)
	| inmark(str x)
	| notinmark(str x)
	| innt(str x)
	| notinnt(str x)
	| comboscope(XScope w1, XScope w2)
;
