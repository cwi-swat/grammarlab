@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::extract::RascalGrammar

import lang::rascal::\syntax::Rascal;
import Grammar;
import ParseTree;
import IO;

import grammarlab::language::Grammar;
import grammarlab::lib::Squeeze;

GGrammar grammar2grammar(Grammar::\grammar(set[Symbol] starts, map[Symbol sort, Production def] rules))
{
	ps = [*rule2prods(rules[s]) | s <- rules, sort(_) := s];
	return grammarlab::language::Grammar::grammar(squeeze([p.lhs | p <- ps]), ps, [symbol2str(s) | s <- starts]); 
}

str symbol2str(ParseTree::\start(ParseTree::\sort(str name))) = "<name>";
//str symbol2str(ParseTree::\lex(str s)) = "<s>"; 
//str symbol2str(ParseTree::\sort(str s)) = "<s>";
str symbol2str(ParseTree::\layouts(_)) = "";
str symbol2str(ParseTree::\keywords(_)) = "";
default str symbol2str(Symbol s) = "<s.name>";

list[GProd] rule2prods(ParseTree::choice(lex(str s), _)) = [];
list[GProd] rule2prods(ParseTree::choice(sort(str s), set[Production] ps))
	= [mappedProd | /Production p <- ps, GProd mappedProd := prod2prod(p), production("?",_) !:= mappedProd];
// ^^^^^^^^^^^ a little bit hacky to avoid the hassle of defining the real constraint, which is:
// “map all production rules, except for those inside of a choice”

default list[GProd] rule2prods(Production def)
	= [production("UNKNOWN", grammarlab::language::Grammar::terminal("<def>"))];

GProd prod2prod(prod(label(str lab, sort(str nt)), list[Symbol] rhs, _))
	= production(nt, label(lab,rhs2expr(rhs)));

GProd prod2prod(prod(sort(str nt), list[Symbol] rhs, _))
	= production(nt, rhs2expr(rhs));

default GProd prod2prod(Production def) = production("?", grammarlab::language::Grammar::epsilon());

GExpr rhs2expr([Symbol s]) = symbol2expr(s);
GExpr rhs2expr(list[Symbol] ss) = grammarlab::language::Grammar::sequence([symbol2expr(s) | s <- ss, layouts(_) !:= s]);

GExpr symbol2expr(ParseTree::label(str x, Symbol s)) = grammarlab::language::Grammar::mark(x,symbol2expr(s));
//GExpr symbol2expr(ParseTree::\sort(str name)) = grammarlab::language::Grammar::nonterminal(name);
// TODO: test if it actually works
GExpr symbol2expr(conditional(\sort(str x),{except(ee)})) =
	grammarlab::language::Grammar::except(grammarlab::language::Grammar::nonterminal(x), terminal("<ee>"));
GExpr symbol2expr(\lex(str x)) = grammarlab::language::Grammar::nonterminal(x);
GExpr symbol2expr(ParseTree::\lit("\n")) = grammarlab::language::Grammar::terminal("\\n"); //hack?
GExpr symbol2expr(ParseTree::\lit(str x)) = grammarlab::language::Grammar::terminal(x);
GExpr symbol2expr(\opt(Symbol s)) = grammarlab::language::Grammar::optional(symbol2expr(s));
GExpr symbol2expr(\iter-seps(Symbol item, list[Symbol] seps)) = iterplusseps2expr(item,[s | s <- seps, layouts(_) !:= s]);
GExpr symbol2expr(\iter-star-seps(Symbol item, list[Symbol] seps)) = iterstarseps2expr(item,[s | s <- seps, layouts(_) !:= s]);
GExpr symbol2expr(\seq(list[Symbol] ss)) = rhs2expr(ss);
default GExpr symbol2expr(Symbol s)
{
	// TODO: Rascal bug/feature? This did not work as a dispatch case
	if (ParseTree::\sort(str name) := s)
		return grammarlab::language::Grammar::nonterminal(name);
	println("Problem mapping this symbol to expression:\n\t<s>");
	return grammarlab::language::Grammar::epsilon();
}

GExpr iterplusseps2expr(Symbol item, []) = grammarlab::language::Grammar::plus(symbol2expr(item));
GExpr iterplusseps2expr(Symbol item, [Symbol sep]) = seplistplus(symbol2expr(item), symbol2expr(sep));
default GExpr iterplusseps2expr(Symbol item, list[Symbol] seps) = seplistplus(symbol2expr(item), grammarlab::language::Grammar::sequence([symbol2expr(sep) | sep <- seps]));

GExpr iterstarseps2expr(Symbol item, []) = grammarlab::language::Grammar::star(symbol2expr(item));
GExpr iterstarseps2expr(Symbol item, [Symbol sep]) = sepliststar(symbol2expr(item), symbol2expr(sep));
default GExpr iterstarseps2expr(Symbol item, list[Symbol] seps) = sepliststar(symbol2expr(item), grammarlab::language::Grammar::sequence([symbol2expr(sep) | sep <- seps]));
