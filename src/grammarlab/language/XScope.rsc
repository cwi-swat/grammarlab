@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module language::XScope

data XScope =
	globally()
	| nowhere()
	| inlabel(str l)
	| notinlabel(str l)
	| innt(str x)
	| notinnt(str x)
	| comboscope(XScope w1, XScope w2)
;
