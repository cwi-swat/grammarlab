@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::export::XBNF

import String;
import grammarlab::lib::RascalPlus;
import grammarlab::language::Grammar;
import grammarlab::language::X;
import grammarlab::language::XScope;
import grammarlab::export::Grammar;
import grammarlab::language::EBNF;
import grammarlab::lib::ebnf::Default;

str ppxt(GProd p, EBNF ebnf) = trim(ppx(p,ebnf));
str ppxt(GProdList ps, EBNF ebnf) = trim(ppx(ps,ebnf));
str ppxt(GExpr e, EBNF ebnf) = trim(ppx(e,ebnf));

public str ppxs(XSequence xs) = ppxs(xs, DefaultEBNF);
public str ppxs(XSequence xs, EBNF ebnf) = joinStrings([ppx(x,ebnf) | XCommand x <- xs], "\n");

public str ppx(XCommand xcmd) = ppx(xcmd, DefaultEBNF);

public str ppx(XCommand::abridge(GProd p), EBNF ebnf) = "abridge(<ppxt(p,ebnf)>)";
public str ppx(XCommand::abstractize(GProd p), EBNF ebnf) = "abstractize(<ppxt(p,ebnf)>)";
public str ppx(XCommand::addC(GProd p), EBNF ebnf) = "addC(<ppxt(p,ebnf)>)";
public str ppx(XCommand::addH(GProd p), EBNF ebnf) = "addH(<ppxt(p,ebnf)>)";
public str ppx(XCommand::addV(GProd p), EBNF ebnf) = "addV(<ppxt(p,ebnf)>)";
public str ppx(XCommand::anonymize(GProd p), EBNF ebnf) = "anonymize(<ppxt(p,ebnf)>)";
public str ppx(XCommand::appear(GProd p), EBNF ebnf) = "appear(<ppxt(p,ebnf)>)";
public str ppx(XCommand::bypass(), EBNF ebnf) = "bypass()";
public str ppx(XCommand::chain(GProd p), EBNF ebnf) = "chain(<ppxt(p,ebnf)>)";
public str ppx(XCommand::clone(str x, str y, XScope w), EBNF ebnf) = "clone(<x>,<y>,<pps(w,ebnf)>)";
public str ppx(XCommand::concatT(list[str] xs, str y, XScope w), EBNF ebnf)
	= "concatT(\"<joinStrings(xs,"\"+\"")>\",\"<y>\",<pps(w,ebnf)>)";
public str ppx(XCommand::concretize(GProd p), EBNF ebnf) = "concretize(<ppxt(p,ebnf)>)";
public str ppx(XCommand::deanonymize(GProd p), EBNF ebnf) = "deanonymize(<ppxt(p,ebnf)>)";
public str ppx(XCommand::define(GProdList ps), EBNF ebnf) = "define(<ppxt(ps,ebnf)>)";
public str ppx(XCommand::designate(GProd p), EBNF ebnf) = "designate(<ppxt(p,ebnf)>)";
public str ppx(XCommand::detour(GProd p), EBNF ebnf) = "detour(<ppxt(p,ebnf)>)";
public str ppx(XCommand::deyaccify(str x), EBNF ebnf) = "deyaccify(<x>)";
public str ppx(XCommand::disappear(GProd p), EBNF ebnf) = "disappear(<ppxt(p,ebnf)>)";
public str ppx(XCommand::distribute(XScope w), EBNF ebnf) = "distribute(<pps(w,ebnf)>)";
public str ppx(XCommand::downgrade(GProd p1, GProd p2), EBNF ebnf) = "downgrade(<ppxt(p1,ebnf)>,\n<ppxt(p2,ebnf)>)";
public str ppx(XCommand::eliminate(str x), EBNF ebnf) = "eliminate(<x>)";
public str ppx(XCommand::equate(str x, str y), EBNF ebnf) = "equate(<x>,<y>)";
public str ppx(XCommand::extract(GProd p, XScope w), EBNF ebnf) = "extract(<ppxt(p,ebnf)>,<pps(w,ebnf)>)";
public str ppx(XCommand::factor(GExpr e1, GExpr e2, XScope w), EBNF ebnf)
	= "factor(<ppxt(e1,ebnf)>,<ppxt(e2,ebnf)>,<pps(w,ebnf)>)";
public str ppx(XCommand::fold(str x, XScope w), EBNF ebnf) = "fold(<x>,<pps(w,ebnf)>)";
public str ppx(XCommand::horizontal(XScope w), EBNF ebnf) = "horizontal(<pps(w,ebnf)>)";
public str ppx(XCommand::importG(GProdList ps), EBNF ebnf) = "importG(<ppxt(ps,ebnf)>)";
public str ppx(XCommand::inject(GProd p), EBNF ebnf) = "inject(<ppxt(p,ebnf)>)";
public str ppx(XCommand::inline(str x), EBNF ebnf) = "inline(<x>)";
public str ppx(XCommand::introduce(GProdList ps), EBNF ebnf) = "introduce(<ppxt(ps,ebnf)>)";
public str ppx(XCommand::iterate(GProd p), EBNF ebnf) = "iterate(<ppxt(p,ebnf)>)";
public str ppx(XCommand::lassoc(GProd p), EBNF ebnf) = "lassoc(<ppxt(p,ebnf)>)";
public str ppx(XCommand::massage(GExpr e1, GExpr e2, XScope w), EBNF ebnf)
	= "massage(<ppxt(e1,ebnf)>, <ppxt(e2,ebnf)>, <pps(w,ebnf)>)";
public str ppx(XCommand::narrow(GExpr e1, GExpr e2, XScope w), EBNF ebnf)
	= "narrow(<ppxt(e1,ebnf)>, <ppxt(e2,ebnf)>, <pps(w,ebnf)>)";
public str ppx(XCommand::permute(GProd p), EBNF ebnf) = "permute(<ppxt(p,ebnf)>)";
public str ppx(XCommand::project(GProd p), EBNF ebnf) = "project(<ppxt(p,ebnf)>)";
public str ppx(XCommand::rassoc(GProd p), EBNF ebnf) = "rassoc(<ppxt(p,ebnf)>)";
public str ppx(XCommand::redefine(GProdList ps), EBNF ebnf) = "redefine(<ppxt(ps,ebnf)>)";
public str ppx(XCommand::removeH(GProd p), EBNF ebnf) = "removeH(<ppxt(p,ebnf)>)";
public str ppx(XCommand::removeV(GProd p), EBNF ebnf) = "removeV(<ppxt(p,ebnf)>)";
public str ppx(XCommand::renameL(str x, str y), EBNF ebnf) = "renameL(<x>,<y>)";
public str ppx(XCommand::renameN(str x, str y), EBNF ebnf) = "renameN(<x>,<y>)";
public str ppx(XCommand::renameS(str x, str y, XScope w), EBNF ebnf) = "renameS(<x>,<y>,<pps(w,ebnf)>)";
public str ppx(XCommand::renameT(str x, str y), EBNF ebnf) = "renameT(<x>,<y>)";
public str ppx(XCommand::replace(GExpr e1, GExpr e2, XScope w), EBNF ebnf)
	= "replace(<ppxt(e1,ebnf)>, <ppxt(e2,ebnf)>, <pps(w,ebnf)>)";
public str ppx(XCommand::reroot(list[str] xs), EBNF ebnf) = "reroot(<joinStrings(xs,",")>)";
public str ppx(XCommand::splitN(str x, GProdList ps, XScope w), EBNF ebnf) = "splitN(<x>,<ppxt(ps,ebnf)>,<pps(w,ebnf)>)";
public str ppx(XCommand::splitT(str x, list[str] ys, XScope w), EBNF ebnf)
	= "splitT(\"<x>\",\"<joinStrings(ys,"\"+\"")>\",<pps(w,ebnf)>)";
public str ppx(XCommand::unchain(GProd p), EBNF ebnf) = "unchain(<ppxt(p,ebnf)>)";
public str ppx(XCommand::undefine(list[str] xs), EBNF ebnf) = "undefine(<joinStrings(xs,",")>)";
public str ppx(XCommand::unfold(str x, XScope w), EBNF ebnf) = "unfold(<x>,<pps(w,ebnf)>)";
public str ppx(XCommand::unite(str x, str y), EBNF ebnf) = "unite(<x>,<y>)";
public str ppx(XCommand::unlabel(str x), EBNF ebnf) = "unlabel(<x>)";
public str ppx(XCommand::upgrade(GProd p1, GProd p2), EBNF ebnf) = "upgrade(<ppxt(p1,ebnf)>,\n<ppx(p2,ebnf)>)";
public str ppx(XCommand::vertical(XScope w), EBNF ebnf) = "vertical(<pps(w,ebnf)>)";
public str ppx(XCommand::widen(GExpr e1, GExpr e2, XScope w), EBNF ebnf)
	= "widen(<ppxt(e1,ebnf)>, <ppxt(e2,ebnf)>, <pps(w,ebnf)>)";
public str ppx(XCommand::yaccify(GProdList ps), EBNF ebnf) = "yaccify(<ppxt(ps,ebnf)>)";
//public str ppx(XCommand::atomic(list[XCommand] steps), EBNF ebnf) = "atomic(<pp(steps,ebnf)>)";
//public str ppx(XCommand::strip(str a), EBNF ebnf) = "strip(<a>)";
public default str ppx(XCommand smth, EBNF ebnf) = "??<smth>??";

str pps(XScope w) = pps(w, DefaultEBNF);

str pps(XScope::globally(), EBNF ebnf) = "in everywhere";
str pps(XScope::nowhere(), EBNF ebnf) = "in nowhere";
str pps(XScope::inlabel(str l), EBNF ebnf)
	= "in <getMeta(start_label_symbol(),ebnf)><l><getMeta(end_label_symbol(),ebnf)>";
str pps(XScope::notinlabel(str l), EBNF ebnf)
	= "not" + pps(XScope::inlabel(l), ebnf);
str pps(XScope::inmark(str l), EBNF ebnf)
	= "in <getMeta(start_mark_symbol(),ebnf)><l><getMeta(end_mark_symbol(),ebnf)>";
str pps(XScope::notinmark(str l), EBNF ebnf)
	= "not" + pps(XScope::inmark(l), ebnf);
str pps(XScope::innt(str x), EBNF ebnf)
	= "in <getMeta(start_nonterminal_symbol(),ebnf)><x><getMeta(end_nonterminal_symbol(),ebnf)>";
str pps(XScope::notinnt(str x), EBNF ebnf)
	= "not" + pps(XScope::innt(x), ebnf);
str pps(XScope::comboscope(XScope w1, XScope w2), EBNF ebnf) = "both <pps(w1)> and <pps(w2)>";
default str pps(XScope smth, EBNF ebnf) = "??<smth>??";

//str pp(list[str] ss) = joinStrings(ss,",");