@contributor{ADT2PP: automatically transformed the language definition (ADT) into the pretty-printer}
@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::export::GrammarLab

import grammarlab::language::Grammar;
import grammarlab::language::X;
import grammarlab::language::XScope;
import grammarlab::lib::RascalPlus;

public str ppgl(GGrammar g) = ppgl(0,0,g);
public str ppgl(int i, int j, GGrammar g) = "<ind(i)>grammar(<g.N>,\n<ind(j+1)>[<ppgl(0,j+1,g.P)>],\n<ind(j+1)><g.S>)";

public str ppgl(GProdList ps) = ppgl(0,0,ps);
public str ppgl(int i, int j, GProdList ps) = ind(i) + joinStrings([ppgl(0,j+1,p) | GProd p <- ps], ",\n<ind(j)>"); 

public str ppgl(GProd p) = ppgl(0,0,p);
public str ppgl(int i, int j, GProd p) = "<ind(i)>production(<pps(p.lhs)>,\n<ppgl(j,j+1,p.rhs)>)";

public str ppgl(GExpr e) = ppgl(0,0,e);
public str ppgl(int i, int j, GExpr::epsilon()) = "<ind(i)>epsilon()";
public str ppgl(int i, int j, GExpr::empty()) = "<ind(i)>empty()";
public str ppgl(int i, int j, GExpr::anything()) = "<ind(i)>anything()";
public str ppgl(int i, int j, GExpr::val(GValue v)) = "<ind(i)>val(<ppgl(v)>)";
public str ppgl(int i, int j, GExpr::nonterminal(str t)) = "<ind(i)>nonterminal(<pps(t)>)";
public str ppgl(int i, int j, GExpr::terminal(str t)) = "<ind(i)>terminal(<pps(t)>)";
public str ppgl(int i, int j, GExpr::label(str name, GExpr expr)) = "<ind(i)>label(<pps(name)>,\n<ppgl(j,j+1,expr)>)";
public str ppgl(int i, int j, GExpr::mark(str name, GExpr expr)) = "<ind(i)>mark(<pps(name)>,<ppgl(0,j,expr)>)";
public str ppgl(int i, int j, GExpr::sequence(GExprList exprs)) = "<ind(i)>sequence([\n<ppgl(j,j+1,exprs)>])";
public str ppgl(int i, int j, GExpr::choice(GExprList exprs)) = "<ind(i)>choice([\n<ppgl(j,j+1,exprs)>])";
public str ppgl(int i, int j, GExpr::allof(GExprList exprs)) = "<ind(i)>allof([\n<ppgl(j,j+1,exprs)>])";
public str ppgl(int i, int j, GExpr::not(GExpr expr)) = "<ind(i)>not(<ppgl(0,j,expr)>)";
public str ppgl(int i, int j, GExpr::except(GExpr expr1, GExpr expr2)) = "<ind(i)>except(\n<ppgl(j,j+1,expr1)>,\n<ppgl(j,j+1,expr2)>)";
public str ppgl(int i, int j, GExpr::optional(GExpr expr)) = "<ind(i)>optional(<ppgl(0,j,expr)>)";
public str ppgl(int i, int j, GExpr::star(GExpr expr)) = "<ind(i)>star(<ppgl(0,j,expr)>)";
public str ppgl(int i, int j, GExpr::plus(GExpr expr)) = "<ind(i)>plus(<ppgl(0,j,expr)>)";
public str ppgl(int i, int j, GExpr::sepliststar(GExpr expr, GExpr sep)) = "<ind(i)>sepliststar(<ppgl(0,j,expr)>,<ppgl(0,j,sep)>)";
public str ppgl(int i, int j, GExpr::seplistplus(GExpr expr, GExpr sep)) = "<ind(i)>seplistplus(<ppgl(0,j,expr)>,<ppgl(0,j,sep)>)";
public default str ppgl(int i, int j, GExpr smth) = "<smth>";

public str ppgl(int i, int j, GExprList exprs) = joinStrings([ppgl(i,j,e) | GExpr e <- exprs], ",\n");
//str ppglnoi(GExprList exprs) = joinStrings([ppgl(0,e) | GExpr e <- es], ",\n");

public str ppgl(GValue::string()) = "string()";
public str ppgl(GValue::integer()) = "integer()";
public str ppgl(GValue::boolean()) = "boolean()";
public default str ppgl(GValue smth) = "<smth>";

str ind(0) = "";
default str ind(int x) = "\t"+ind(x-1);

str pps(str s) = "\"" + s + "\"";

public str ppgl(XSequence smth) = ppgl(0,0,smth);
public str ppgl(int i, int j, XSequence xbgf) = "<ind(i)>[<joinStrings([ppgl(0,j,x) | XCommand x <- xbgf], ",\n<ind(i)>")>]";

public str ppgl(XCommand smth) = ppgl(0,0,smth);
public str ppgl(int i, int j, XCommand::abridge(GProd p)) = "<ind(i)>abridge(<ppgl(0,j+1,p)>)";
public str ppgl(int i, int j, XCommand::abstractize(GProd p)) = "<ind(i)>abstractize(<ppgl(0,j+1,p)>)";
public str ppgl(int i, int j, XCommand::addH(GProd p)) = "<ind(i)>addH(<ppgl(0,j+1,p)>)";
public str ppgl(int i, int j, XCommand::addV(GProd p)) = "<ind(i)>addV(<ppgl(0,j+1,p)>)";
public str ppgl(int i, int j, XCommand::addC(GProd p)) = "<ind(i)>addC(<ppgl(0,j+1,p)>)";
public str ppgl(int i, int j, XCommand::anonymize(GProd p)) = "<ind(i)>anonymize(<ppgl(0,j+1,p)>)";
public str ppgl(int i, int j, XCommand::appear(GProd p)) = "<ind(i)>appear(<ppgl(0,j+1,p)>)";
public str ppgl(int i, int j, XCommand::bypass()) = "<ind(i)>bypass()";
public str ppgl(int i, int j, XCommand::chain(GProd p)) = "<ind(i)>chain(<ppgl(0,j+1,p)>)";
public str ppgl(int i, int j, XCommand::clone(str x, str y, XScope w)) = "<ind(i)>clone(<pps(x)>,<pps(y)>,<ppgl(0,j+1,w)>)";
public str ppgl(int i, int j, XCommand::concatT(list[str] xs, str y, XScope w)) = "<ind(i)>concatT(<xs>,<pps(y)>,<ppgl(0,j+1,w)>)";
public str ppgl(int i, int j, XCommand::concretize(GProd p)) = "<ind(i)>concretize(<ppgl(0,j+1,p)>)";
public str ppgl(int i, int j, XCommand::deanonymize(GProd p)) = "<ind(i)>deanonymize(<ppgl(0,j+1,p)>)";
public str ppgl(int i, int j, XCommand::define(GProdList ps)) = "<ind(i)>define([<ppgl(0,j+1,ps)>])";
public str ppgl(int i, int j, XCommand::designate(GProd p)) = "<ind(i)>designate(<ppgl(0,j+1,p)>)";
public str ppgl(int i, int j, XCommand::detour(GProd p)) = "<ind(i)>detour(<ppgl(0,j+1,p)>)";
public str ppgl(int i, int j, XCommand::deyaccify(str x)) = "<ind(i)>deyaccify(<pps(x)>)";
public str ppgl(int i, int j, XCommand::disappear(GProd p)) = "<ind(i)>disappear(<ppgl(0,j+1,p)>)";
public str ppgl(int i, int j, XCommand::distribute(XScope w)) = "<ind(i)>distribute(<ppgl(0,j+1,w)>)";
public str ppgl(int i, int j, XCommand::downgrade(GProd p1, GProd p2)) = "<ind(i)>downgrade(\n<ppgl(j,j+1,p1)>,\n<ppgl(j,j+1,p2)>)";
public str ppgl(int i, int j, XCommand::eliminate(str x)) = "<ind(i)>eliminate(<pps(x)>)";
public str ppgl(int i, int j, XCommand::equate(str x, str y)) = "<ind(i)>equate(<pps(x)>,<pps(y)>)";
public str ppgl(int i, int j, XCommand::extract(GProd p, XScope w)) = "<ind(i)>extract(<ppgl(0,j,p)>,\n<ppgl(j,j+1,w)>)";
public str ppgl(int i, int j, XCommand::factor(GExpr e1, GExpr e2, XScope w)) = "<ind(i)>factor(\n<ppgl(j,j+1,e1)>,\n<ppgl(j,j+1,e2)>,\n<ppgl(j,j+1,w)>)";
public str ppgl(int i, int j, XCommand::fold(str x, XScope w)) = "<ind(i)>fold(<pps(x)>,<ppgl(0,j+1,w)>)";
public str ppgl(int i, int j, XCommand::horizontal(XScope w)) = "<ind(i)>horizontal(<ppgl(0,j+1,w)>)";
public str ppgl(int i, int j, XCommand::importG(GProdList ps)) = "<ind(i)>importG([<ppgl(0,j+1,ps)>])";
public str ppgl(int i, int j, XCommand::inject(GProd p)) = "<ind(i)>inject(<ppgl(0,j+1,p)>)";
public str ppgl(int i, int j, XCommand::inline(str x)) = "<ind(i)>inline(<pps(x)>)";
public str ppgl(int i, int j, XCommand::introduce(GProdList ps)) = "<ind(i)>introduce([<ppgl(0,j+1,ps)>])";
public str ppgl(int i, int j, XCommand::iterate(GProd p)) = "<ind(i)>iterate(<ppgl(0,j+1,p)>)";
public str ppgl(int i, int j, XCommand::lassoc(GProd p)) = "<ind(i)>lassoc(<ppgl(0,j+1,p)>)";
public str ppgl(int i, int j, XCommand::massage(GExpr e1, GExpr e2, XScope w)) = "<ind(i)>massage(\n<ppgl(j,j+1,e1)>,\n<ppgl(j,j+1,e2)>,\n<ppgl(j,j,w)>)";
public str ppgl(int i, int j, XCommand::narrow(GExpr e1, GExpr e2, XScope w)) = "<ind(i)>narrow(\n<ppgl(j,j+1,e1)>,\n<ppgl(j,j+1,e2)>,\n<ppgl(j,j,w)>)";
public str ppgl(int i, int j, XCommand::permute(GProd p)) = "<ind(i)>permute(<ppgl(0,j+1,p)>)";
public str ppgl(int i, int j, XCommand::project(GProd p)) = "<ind(i)>project(<ppgl(0,j+1,p)>)";
public str ppgl(int i, int j, XCommand::rassoc(GProd p)) = "<ind(i)>rassoc(<ppgl(0,j+1,p)>)";
public str ppgl(int i, int j, XCommand::redefine(GProdList ps)) = "<ind(i)>redefine([<ppgl(0,j+1,ps)>])";
public str ppgl(int i, int j, XCommand::removeH(GProd p)) = "<ind(i)>removeH(<ppgl(0,j+1,p)>)";
public str ppgl(int i, int j, XCommand::removeV(GProd p)) = "<ind(i)>removeV(<ppgl(0,j+1,p)>)";
public str ppgl(int i, int j, XCommand::renameL(str x, str y)) = "<ind(i)>renameL(<pps(x)>,<pps(y)>)";
public str ppgl(int i, int j, XCommand::renameN(str x, str y)) = "<ind(i)>renameN(<pps(x)>,<pps(y)>)";
public str ppgl(int i, int j, XCommand::renameS(str x, str y, XScope w)) = "<ind(i)>renameS(<pps(x)>,<pps(y)>,<ppgl(0,j+1,w)>)";
public str ppgl(int i, int j, XCommand::renameT(str x, str y)) = "<ind(i)>renameT(<pps(x)>,<pps(y)>)";
public str ppgl(int i, int j, XCommand::replace(GExpr e1, GExpr e2, XScope w)) = "<ind(i)>replace(\n<ppgl(j,j+1,e1)>,\n<ppgl(j,j+1,e2)>,\n<ppgl(j,j+1,w)>)";
public str ppgl(int i, int j, XCommand::reroot(list[str] xs)) = "<ind(i)>reroot(<xs>)";
public str ppgl(int i, int j, XCommand::splitN(str x, GProdList ps, XScope w)) = "<ind(i)>splitN(<pps(x)>,\n<ind(j)>[<ppgl(0,j+1,ps)>],\n<ppgl(j,j+1,w)>)";
public str ppgl(int i, int j, XCommand::splitT(str x, list[str] ys, XScope w)) = "<ind(i)>splitT(<pps(x)>,<ys>,<ppgl(0,j+1,w)>)";
public str ppgl(int i, int j, XCommand::unchain(GProd p)) = "<ind(i)>unchain(<ppgl(0,j+1,p)>)";
public str ppgl(int i, int j, XCommand::undefine(list[str] xs)) = "<ind(i)>undefine(<xs>)";
public str ppgl(int i, int j, XCommand::undefineNew(str x)) = "<ind(i)>undefineNew(<pps(x)>)";
public str ppgl(int i, int j, XCommand::unfold(str x, XScope w)) = "<ind(i)>unfold(<pps(x)>,<ppgl(0,j+1,w)>)";
public str ppgl(int i, int j, XCommand::unite(str x, str y)) = "<ind(i)>unite(<pps(x)>,<pps(y)>)";
public str ppgl(int i, int j, XCommand::unlabel(str x)) = "<ind(i)>unlabel(<pps(x)>)";
public str ppgl(int i, int j, XCommand::upgrade(GProd p1, GProd p2)) = "<ind(i)>upgrade(\n<ppgl(j,j+1,p1)>,\n<ppgl(j,j+1,p2)>)";
public str ppgl(int i, int j, XCommand::vertical(XScope w)) = "<ind(i)>vertical(<ppgl(0,j+1,w)>)";
public str ppgl(int i, int j, XCommand::widen(GExpr e1, GExpr e2, XScope w)) = "<ind(i)>widen(\n<ppgl(j,j+1,e1)>,\n<ppgl(j,j+1,e2)>,\n<ppgl(j,j+1,w)>)";
public str ppgl(int i, int j, XCommand::yaccify(GProdList ps)) = "<ind(i)>yaccify(\n<ind(j)>[<ppgl(0,j+1,ps)>])";
public default str ppgl(int i, int j, XCommand smth) = "<smth>";

public str ppgl(XScope smth) = ppgl(0,0,smth);
public str ppgl(int i, _, XScope::globally()) = "<ind(i)>globally()";
public str ppgl(int i, _, XScope::nowhere()) = "<ind(i)>nowhere()";
public str ppgl(int i, _, XScope::inlabel(str x)) = "<ind(i)>inlabel(<pps(x)>)";
public str ppgl(int i, _, XScope::notinlabel(str x)) = "<ind(i)>notinlabel(<pps(x)>)";
public str ppgl(int i, _, XScope::inmark(str x)) = "<ind(i)>inmark(<pps(x)>)";
public str ppgl(int i, _, XScope::notinmark(str x)) = "<ind(i)>notinmark(<pps(x)>)";
public str ppgl(int i, _, XScope::innt(str x)) = "<ind(i)>innt(<pps(x)>)";
public str ppgl(int i, _, XScope::notinnt(str x)) = "<ind(i)>notinnt(<pps(x)>)";
public str ppgl(int i, _, XScope::comboscope(XScope w1, XScope w2)) = "<ind(i)>comboscope(<ppgl(w1)>,<ppgl(w2)>)";
public default str ppgl(int i, int j, XScope smth) = "<smth>";

