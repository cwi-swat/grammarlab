@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::extract::rascal::Type

import lang::rascal::\syntax::Rascal;
import grammarlab::language::Grammar;
import grammarlab::lib::Sizes;
import grammarlab::extract::rascal::Name;
import String;
import IO;

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
GExpr type2expr((Type)`(<Type t>)`) = type2expr(t);
GExpr type2expr((Type)`<UserType ut>`)
	= grammarlab::language::Grammar::nonterminal(grammarlab::extract::rascal::Name::name2string("<ut>"));
GExpr type2expr((Type)`value`)
	= grammarlab::language::Grammar::anything();
GExpr type2expr((Type)`loc`)
	= grammarlab::language::Grammar::val(grammarlab::language::Grammar::string()); // abstraction
GExpr type2expr((Type)`node`)
	= grammarlab::language::Grammar::sequence([grammarlab::language::Grammar::string(),grammarlab::language::Grammar::star(grammarlab::language::Grammar::anything())]);
GExpr type2expr((Type)`num`)
	= grammarlab::language::Grammar::val(grammarlab::language::Grammar::integer());
GExpr type2expr((Type)`bag[<Type t>]`)
	= grammarlab::language::Grammar::star(type2expr(t));
GExpr type2expr((Type)`int`)
	= grammarlab::language::Grammar::val(grammarlab::language::Grammar::integer());
GExpr type2expr((Type)`rat`)
	= grammarlab::language::Grammar::val(grammarlab::language::Grammar::integer()); // not entirely true!
GExpr type2expr((Type)`rel[<{TypeArg ","}+ arguments>]`)
	= grammarlab::language::Grammar::star(typeargs2seq(arguments));
GExpr type2expr((Type)`real`)
	= grammarlab::language::Grammar::val(grammarlab::language::Grammar::integer()); // not entirely true!
GExpr type2expr((Type)`tuple[<{TypeArg ","}+ arguments>]`)
	= typeargs2seq(arguments);
GExpr type2expr((Type)`str`)
	= grammarlab::language::Grammar::val(grammarlab::language::Grammar::string());
GExpr type2expr((Type)`bool`)
	//= grammarlab::language::Grammar::choice([grammarlab::language::Grammar::terminal("true"),grammarlab::language::Grammar::terminal("false")]);
	= grammarlab::language::Grammar::val(grammarlab::language::Grammar::boolean());
GExpr type2expr((Type)`void`)
	= grammarlab::language::Grammar::epsilon();
GExpr type2expr((Type)`datetime`)
	= grammarlab::language::Grammar::val(grammarlab::language::Grammar::string()); // abstraction
GExpr type2expr((Type)`set[<Type t>]`) = grammarlab::language::Grammar::star(type2expr(t));
GExpr type2expr((Type)`map[<{TypeArg ","}+ arguments>]`)
	= grammarlab::language::Grammar::star(typeargs2seq(arguments));
GExpr type2expr((Type)`list[<Type t>]`)
	= grammarlab::language::Grammar::star(type2expr(t));
GExpr type2expr((Type)`set[<TypeArg ta>]`)
	= grammarlab::language::Grammar::star(typearg2expr(ta));
GExpr type2expr((Type)`list[<TypeArg ta>]`)
	= grammarlab::language::Grammar::star(typearg2expr(ta));
GExpr type2expr((Type)`void()`)
	= grammarlab::language::Grammar::epsilon();
// Arguable. Motivation: a TypeArg is still needed to construct the value
GExpr type2expr((Type)`void(<{TypeArg ","}+ tas>)`) = typeargs2seq(tas);
// Arguable. Motivation: a Type is produced during construction
GExpr type2expr((Type)`<Type t>()`) = type2expr(t);
// Arguable. Motivation: a TypeArg is required to construct the value; we lose some info here
// (What is actually happening is referring to a specific production rule instead of a nonterminal
GExpr type2expr((Type)`<Type _>(<{TypeArg ","}+ tas>)`) = typeargs2seq(tas);

// TODO: FunctionType (arguable!)
default GExpr type2expr(Type t)// = grammarlab::language::Grammar::empty();
{
	println("Failure or ambiguity in type2expr(<t>).");
	// iprintln(t);
	return grammarlab::language::Grammar::empty();
}

GExpr typearg2expr((TypeArg)`<Type t>`) = type2expr(t);
GExpr typearg2expr((TypeArg)`void()`) = grammarlab::language::Grammar::epsilon();
// Arguable. Motivation: a TypeArg is still needed to construct the value
GExpr typearg2expr((TypeArg)`void(<{TypeArg ","}+ tas>)`) = typeargs2seq(tas);
// Arguable. Motivation: a Type is produced during construction
GExpr typearg2expr((TypeArg)`<Type t>()`) = type2expr(t);
// Arguable. Motivation: a TypeArg is required to construct the value; we lose some info here
// (What is actually happening is referring to a specific production rule instead of a nonterminal 
GExpr typearg2expr((TypeArg)`<Type _>(<{TypeArg ","}+ tas>)`) = typeargs2seq(tas);
GExpr typearg2expr((TypeArg)`<Type t><Name n>`) = grammarlab::language::Grammar::mark(grammarlab::extract::rascal::Name::name2string("<n>"),type2expr(t));
default GExpr typearg2expr(TypeArg ta) //= empty();
{
	println("Failure or ambiguity in typearg2expr(<ta>).");
	// iprintln(ta);
	return grammarlab::language::Grammar::nonterminal(grammarlab::extract::rascal::Name::name2string("<ta>"));
}

//GExpr typeargs2seq(({TypeArg ","}*)``) = epsilon();
GExpr typeargs2seq({TypeArg ","}+ args)
{
	res = [typearg2expr(argt) | TypeArg argt <- args];
	return (len(res)==1) ? res[0] : grammarlab::language::Grammar::sequence(res); 
}
// TODO: fails at ambiguities
