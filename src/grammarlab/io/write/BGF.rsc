@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::io::write::BGF

import IO;
import lang::xml::DOM;
import grammarlab::language::Grammar;
import grammarlab::lib::Squeeze;
import grammarlab::lib::Sizes;

public void writeBGF(GGrammar bgf, loc f)
{
	list[Node] xml1 = [element(none(),"root",[charData(s)]) | str s <- bgf.roots];
	list[Node] xml2 = [prod2xml(p) | str n <- bgf.nts, GProd p <- bgf.prods[n]];
	writeFile(f,xmlRaw(document(element(namespace("bgf","http://planet-sl.org/bgf"),"grammar",xml1+xml2))));
}

Node prod2xml(GProd p)
{
	list[Node] kids = [];
	GExpr rhs;
	// TODO: remove the backward-compatibility bit?
	if (labelled(str label, GExpr e) := p.rhs)
	{
		kids += element(none(),"label",[charData(label)]);
		rhs = e;
	}
	else
		rhs = p.rhs
	kids += element(none(),"nonterminal",[charData(p.lhs)]);
	kids += expr2xml(rhs);
	return element(namespace("bgf","http://planet-sl.org/bgf"),"production",kids);
}

Node expr2xml(GExpr ex)
{
	Node e;
	switch(ex)
	{
		case epsilon(): e = element(none(),"epsilon",[]);
		case empty(): e = element(none(),"empty",[]);
		case val(boolean()): e = element(none(),"value",[charData("boolean")]);
		case val(string()): e = element(none(),"value",[charData("string")]);
		case val(integer()): e = element(none(),"value",[charData("int")]);
		case anything(): e = element(none(),"any",[]);
		case terminal(str s): e = element(none(),"terminal",[charData(s)]);
		case nonterminal(str s): e = element(none(),"nonterminal",[charData(s)]);
		case labelled(s,expr): e = element(none(),"labelled",[element(none(),"label",[charData(s)]),expr2xml(expr)]);
		case selectable(s,expr): e = element(none(),"selectable",[element(none(),"selector",[charData(s)]),expr2xml(expr)]);
		case sequence(L): e = element(none(),"sequence",[expr2xml(expr) | expr <- L]);
		case choice(L): e = element(none(),"choice",[expr2xml(expr) | expr <- L]);
		case allof(L): e = element(none(),"allof",[expr2xml(expr) | expr <- L]);
		case marked(expr): e = element(none(),"marked",[expr2xml(expr)]);
		case optional(expr): e = element(none(),"optional",[expr2xml(expr)]);
		case not(expr): e = element(none(),"not",[expr2xml(expr)]);
		case plus(expr): e = element(none(),"plus",[expr2xml(expr)]);
		case star(expr): e = element(none(),"star",[expr2xml(expr)]);
		case seplistplus(e1,e2): e = element(none(),"seplistplus",[expr2xml(e1),expr2xml(e2)]);
		case sepliststar(e1,e2): e = element(none(),"sepliststar",[expr2xml(e1),expr2xml(e2)]);
		default: throw "ERROR: expression expected in place of <ex>";
	}
	return element(namespace("bgf","http://planet-sl.org/bgf"),"expression",[e]);
}
