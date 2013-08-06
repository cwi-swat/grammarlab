@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::XOutcome

import grammarlab::language::Grammar;
import grammarlab::language::X;
import grammarlab::language::XScope;

import IO;

data XOutcome
	= ok()
	| problem(str msg)
	| problemXBGF(str msg, XCommand xbgf)
	| problemProd(str msg, GProd p)
	| problemProd2(str msg, GProd p1, GProd p2)
	| problemPinProds(str msg, GProd p, GProdList ps)
	| problemProds(str msg, GProdList ps)
	| problemProds2(str msg, GProdList ps1, GProdList ps2)
	| problemExpr(str msg, GExpr e)
	| problemExpr2(str msg, GExpr e1, GExpr e2)
	| problemStr(str msg, str x)
	| problemStr2(str msg, str x, str y)
	| problemStrs(str msg, list[str] xs)
	| problemScope(str msg, XScope w)
	;

alias XResult = tuple[XOutcome r,GGrammar g];

// basic operations on outcomes
public void thw(ok()) {}
public default void thw(XOutcome x) {throw outcome2str(x);}

public void report(ok()) {println("No problems.");}
public default void report(XOutcome x) {println(outcome2str(x)+"!");}

public str outcome2str(ok()) = "";
public str outcome2str(problem(str msg)) = msg;
public str outcome2str(problemXBGF(str msg, XCommand xbgf)) = "<msg>:\n<xbgf>";
public str outcome2str(problemProd(str msg, GProd p)) = "<msg>:\n<p>";
public str outcome2str(problemProd2(str msg, GProd p1, GProd p2)) = "<msg>:\n\t<p1>\nand\n\t<p2>";
public str outcome2str(problemPinProds(str msg, GProd p, GProdList ps)) = "<msg>\n\t<p>\nin\n\t<ps>";
public str outcome2str(problemProds(str msg, GProdList ps)) = "<msg>:\n<ps>";
public str outcome2str(problemProds2(str msg, GProdList ps1, GProdList ps2)) = "<msg>:\n<ps1>\nvs\n<ps2>";
public str outcome2str(problemStr(str msg, str x)) = "<msg>: <x>";
public str outcome2str(problemStr2(str msg, str x, str y)) = "<msg>: <x> and <y>";
public str outcome2str(problemStrs(str msg, list[str] xs)) = "<msg>:\n\t<xs>";
public str outcome2str(problemExpr(str msg, GExpr e)) = "<msg>:\n\t<e>";
public str outcome2str(problemExpr2(str msg, GExpr e1, GExpr e2)) = "<msg>:\n<e1> and <e2>";
public str outcome2str(problemScope(str msg, XScope w)) = "<msg> in <w>";
public default str outcome2str(XOutcome x) = "Outcome not implemented: <x>";
