@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::extract::RascalType

import lang::rascal::\syntax::Rascal;
import grammarlab::language::Grammar;
import String;
import IO;

// This maps all abstract syntax declarations to production rules of a grammar in a broad sense
public list[GProd] mapDecl((Declaration)`<Tags _><Visibility _>alias<UserType user> = <Type base>;`)
	= [production("<user>",type2expr(base))];
public list[GProd] mapDecl((Declaration)`<Tags _><Visibility _>data <UserType user> = <{Variant "|"}+ variants> ;`)
	= [production("<user>",variants2expr(variants))];
public default list[GProd] mapDecl(Declaration d) = [];

// This maps only type aliases to production rules of a grammar in a broad sense
public list[GProd] mapAlias((Declaration)`<Tags _><Visibility _>alias<UserType user> = <Type base>;`)
	= [production("<user>",type2expr(base))];
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
	= grammarlab::language::Grammar::label(name2string("<name>"),epsilon());
default GExpr variant2expr((Variant)`<Name name> ( <{TypeArg ","}+ arguments> )`)
	= grammarlab::language::Grammar::label(name2string("<name>"),typeargs2seq(arguments));
/*
syntax Type
	= bracket \bracket: "(" Type type ")" 
	| user: UserType user \ HeaderKeyword
	| function: FunctionType function 
	| structured: StructuredType structured 
	| basic: BasicType basic 
	| selector: DataTypeSelector selector 
	| variable: TypeVar typeVar 
	| symbol: Sym!nonterminal!labeled!parametrized!parameter symbol
	;
syntax FunctionType
	= typeArguments: Type type "(" {TypeArg ","}* arguments ")" ;
syntax StructuredType
	= \default: BasicType basicType "[" {TypeArg ","}+ arguments "]" ;
syntax BasicType
	= \value: "value" 
	| \loc: "loc" 
	| \node: "node" 
	| \num: "num" 
	| \type: "type" 
	| \bag: "bag" 
	| \int: "int"
	| rational: "rat" 
	| relation: "rel" 
	| \real: "real" 
	| \tuple: "tuple" 
	| string: "str" 
	| \bool: "bool" 
	| \void: "void" 
	| dateTime: "datetime" 
	| \set: "set" 
	| \map: "map" 
	| \list: "list" 
	;
syntax DataTypeSelector
	= selector: QualifiedName sort "." Name production ;
*/

// NOT MAPPED (too tricky): type; list (w/o params), set, ...
GExpr type2expr((Type)`<UserType ut>`) = grammarlab::language::Grammar::nonterminal(name2string("<ut>"));
GExpr type2expr((Type)`(<Type t>)`) = type2expr(t);
GExpr type2expr((Type)`value`) = grammarlab::language::Grammar::anything();
GExpr type2expr((Type)`loc`) = grammarlab::language::Grammar::val(grammarlab::language::Grammar::string()); // abstraction
GExpr type2expr((Type)`node`)
	= grammarlab::language::Grammar::sequence([grammarlab::language::Grammar::string(),grammarlab::language::Grammar::star(grammarlab::language::Grammar::anything())]);
GExpr type2expr((Type)`num`) = grammarlab::language::Grammar::val(grammarlab::language::Grammar::integer());
GExpr type2expr((Type)`bag[<Type t>]`) = grammarlab::language::Grammar::star(type2expr(t));
GExpr type2expr((Type)`int`) = grammarlab::language::Grammar::val(grammarlab::language::Grammar::integer());
GExpr type2expr((Type)`rat`) = grammarlab::language::Grammar::val(grammarlab::language::Grammar::integer()); // not entirely true!
GExpr type2expr((Type)`rel[<{TypeArg ","}+ arguments>]`)
	= grammarlab::language::Grammar::star(typeargs2seq(arguments));
GExpr type2expr((Type)`real`) = grammarlab::language::Grammar::val(grammarlab::language::Grammar::integer()); // not entirely true!
GExpr type2expr((Type)`tuple[<{TypeArg ","}+ arguments>]`) = typeargs2seq(arguments);
GExpr type2expr((Type)`str`) = grammarlab::language::Grammar::val(grammarlab::language::Grammar::string());
GExpr type2expr((Type)`bool`)
	= grammarlab::language::Grammar::choice([grammarlab::language::Grammar::terminal("true"),grammarlab::language::Grammar::terminal("false")]);
GExpr type2expr((Type)`void`) = grammarlab::language::Grammar::empty();
GExpr type2expr((Type)`datetime`) = grammarlab::language::Grammar::val(grammarlab::language::Grammar::string()); // abstraction
GExpr type2expr((Type)`set[<Type t>]`) = grammarlab::language::Grammar::star(type2expr(t));
GExpr type2expr((Type)`map[<{TypeArg ","}+ arguments>]`)
	= grammarlab::language::Grammar::star(typeargs2seq(arguments));
GExpr type2expr((Type)`list[<Type t>]`) = grammarlab::language::Grammar::star(type2expr(t));
GExpr type2expr((Type)`set[<TypeArg ta>]`) = grammarlab::language::Grammar::star(typearg2expr(ta));
GExpr type2expr((Type)`list[<TypeArg ta>]`) = grammarlab::language::Grammar::star(typearg2expr(ta));

// TODO: FunctionType (arguable!)
default GExpr type2expr(Type t)// = grammarlab::language::Grammar::empty();
{
	println("Failure or ambiguity in type2expr(<t>).");
	// iprintln(t);
	return grammarlab::language::Grammar::empty();
}

GExpr typearg2expr((TypeArg)`<Type t>`) = type2expr(t);
GExpr typearg2expr((TypeArg)`<Type t><Name n>`) = grammarlab::language::Grammar::mark(name2string("<n>"),type2expr(t));
default GExpr typearg2expr(TypeArg ta) //= empty();
{
	println("Failure or ambiguity in typearg2expr(<ta>).");
	// iprintln(ta);
	return grammarlab::language::Grammar::nonterminal(name2string("<ta>"));
}

//GExpr typeargs2seq(({TypeArg ","}*)``) = epsilon();
GExpr typeargs2seq({TypeArg ","}+ args) = grammarlab::language::Grammar::sequence([typearg2expr(argt) | TypeArg argt <- args]);
// TODO: fails at ambiguities

str name2string(str s)
{
	if (startsWith(s,"\\"))
		return substring(s,1);
	else
		return s;
}
