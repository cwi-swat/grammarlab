@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::extract::rascal::AbstractType

import lang::rascal::\syntax::Rascal;
import grammarlab::extract::rascal::Name;
import grammarlab::extract::rascal::Type;
import grammarlab::language::Grammar;
import String;
import IO;

// This maps all abstract syntax declarations to production rules of a grammar in a broad sense
public list[GProd] mapDecl((Declaration)`<Tags _><Visibility _>alias<UserType user> = <Type base>;`)
	= [production("<user>",grammarlab::extract::rascal::Type::type2expr(base))];
public list[GProd] mapDecl((Declaration)`<Tags _><Visibility _>data <UserType user> = <{Variant "|"}+ variants> ;`)
	= [production("<user>",variants2expr(variants))];
public default list[GProd] mapDecl(Declaration d) = [];

// This maps only type aliases to production rules of a grammar in a broad sense
public list[GProd] mapAlias((Declaration)`<Tags _><Visibility _>alias<UserType user> = <Type base>;`)
	= [production("<user>",grammarlab::extract::rascal::Type::type2expr(base))];
public default list[GProd] mapAlias(Declaration d) = [];

// This maps only user type declarations to production rules of a grammar in a broad sense
public list[GProd] mapData((Declaration)`<Tags _><Visibility _>data <UserType user> = <{Variant "|"}+ variants> ;`)
	= [production("<user>",variants2expr(variants))];
public default list[GProd] mapData(Declaration d) = [];

/*
syntax Variant
	= nAryConstructor: Name name "(" {TypeArg ","}* arguments ")" ;
*/

GExpr variants2expr({Variant "|"}+ variants)
 = grammarlab::language::Grammar::choice([variant2expr(v) | Variant v <- variants]);

GExpr variant2expr((Variant)`<Name name> ()`)
	= grammarlab::language::Grammar::label(
		grammarlab::extract::rascal::Name::name2string("<name>"),
		epsilon());
default GExpr variant2expr((Variant)`<Name name> ( <{TypeArg ","}+ arguments> )`)
	= grammarlab::language::Grammar::label(
		grammarlab::extract::rascal::Name::name2string("<name>"),
		grammarlab::extract::rascal::Type::typeargs2seq(arguments));
