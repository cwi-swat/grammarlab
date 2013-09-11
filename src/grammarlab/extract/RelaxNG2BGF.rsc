@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::extract::RelaxNG2BGF

import IO;
import lang::xml::DOM;
import grammarlab::language::Grammar;
import grammarlab::transform::Normal;
import grammarlab::export::Grammar;
import grammarlab::lib::Squeeze;
import grammarlab::lib::Sizes;

import grammarlab::transform::Merge;

GGrammar extractG(loc f)
{
	if (document(element(namespace(_,"http://relaxng.org/ns/structure/1.0"),"grammar",L)) := parseXMLDOMTrim(readFile(f)))
	{
		list[str] S = maproots(L);
		//println("Roots: <S>");
		list[Node] defines = [d | /d:element(namespace(_,"http://relaxng.org/ns/structure/1.0"),"define",_) := L];
		list[Node] includes = [d | d:element(namespace(_,"http://relaxng.org/ns/structure/1.0"),"include",_) <- L];
		list[Node] others = [e | e:element(namespace(_,"http://relaxng.org/ns/structure/1.0"),str t,_) <- L, t notin ["start", "define", "include"]];
		// TODO: change the semantics of <include>!
		for (inc <- includes)
			println("Warning: merge this grammar with the one extracted from <getAttr(inc.children,"href")>!");
		if (!isEmpty(others))
			println("Warning: unexpected nodes in RNG: <[n | element(_,str n,_) <- others]>");
		GProdList ps = [mapprod(p) | p <- defines];
		return normalise(grammar(
			squeeze([p.lhs | p <- ps]),
			ps,
			S
		));
	}
	else
		throw "<f> is not a proper Relax NG file";
}

list[str] maproots(list[Node] L) = [s | element(_,"start",L2) <- L, /element(_,"ref",[attribute(none(),"name",str s)]) <- L2];
			
GProd mapprod(element(_,"define",attrs))
{
	str name = getName(attrs);
	GExpr rhs;
	list[Node] subgs = [g | element(_,"element",ie) <- attrs, g:element(_,"grammar",_) <- ie]; 
	if (!isEmpty(subgs))
		rhs = choice([nonterminal(x) | g <- subgs, str x <- maproots(g.children)]);
	else
		rhs = mapexprs(getTrimmedNameless(attrs));
	return production("<name>",rhs);
}

default GProd mapprod(Node n)
{
	println("Error: unmapped production rule");
	iprintln(n);
	return production("?",empty());
}

GExpr mapexprs(list[Node] nodes)
{
	// Filter out attributes, comments and other stuff
	ns = getTrimmed(nodes);
	if (isTrivial(ns))
		return mapexpr(ns[0]);
	else
		return sequence([me | e <- ns, GExpr me := mapexpr(e), me != nothing()]);
}

GExpr mapexpr(element(_,"element",attrs))
{
	str name = getName(attrs);
	if (!isEmpty(name))
		return mark(name,mapexprs(getTrimmedNameless(attrs)));
	list[str] manynames = getManyNames(attrs);
	if (!isEmpty(manynames))
	{
		GExpr e = mapexprs([e | e:element(_,_,_) <- attrs, e.name != "name", e.name != "choice"]);
		return choice([mark(eachname,e) | eachname <- manynames]);
	}
	return mapexprs(getTrimmedNameless(attrs));
}

// NB: ignore all annotations
GExpr mapexpr(element(namespace(_,"http://relaxng.org/ns/compatibility/annotations/1.0"),_,_)) = nothing();
GExpr mapexpr(attribute(namespace(_,"http://relaxng.org/ns/compatibility/annotations/1.0"),_,_)) = nothing();
GExpr mapexpr(element(namespace(_,"http://purl.org/dc/elements/1.1/"),_,_)) = nothing();
GExpr mapexpr(element(namespace(_,"http://www.jenitennison.com/doc"),_,_)) = nothing();

// NB: ignore all assertion rules [kind of static semantics]
GExpr mapexpr(element(namespace(_,"http://www.ascc.net/xml/schematron"),_,_)) = nothing();

// NB: not entirely correct, but good for mapping abstract syntaxes (see also xbgf:permute operator)
GExpr mapexpr(element(_,"interleave",attrs)) = mapexprs(attrs);

// NB: this mapping is correct, but it is an abstraction
GExpr mapexpr(element(_,"list",attrs)) = mapexprs(attrs);

// NB: groups only make sense inside interleaved constructs
GExpr mapexpr(element(_,"group",attrs)) = mapexprs(attrs);

// NB: "any name" means "any selector", which is the default option in BGF anyway
GExpr mapexpr(element(_,"anyName",attrs)) = nothing();

// NB: no advanced namespace support in BGF
GExpr mapexpr(element(_,"nsName",attrs)) = nothing();

GExpr mapexpr(element(_,"empty",attrs)) = epsilon();
GExpr mapexpr(element(_,"notAllowed",attrs)) = empty();
GExpr mapexpr(element(_,"ref",attrs)) = nonterminal(getName(attrs));

GExpr mapexpr(element(_,"mixed",attrs))
{
	GExpr e = mapexprs(attrs);
	if (plus(choice(L)) := e)
		return plus(choice(L + val(string())));
	elseif (plus(x) := e)
		return plus(choice([x, val(string())]));
	elseif (star(choice(L)) := e)
		return star(choice(L + val(string())));
	elseif (star(x) := e)
		return star(choice([x, val(string())]));
	else
		return sequence([optional(val(string())),e,optional(val(string()))]);
	// TODO: any other kinds of mixed? never heard of.
}

GExpr mapexpr(element(_,"text",_)) = val(string());
GExpr mapexpr(element(_,"value",attrs)) = mapTorV(attrs);
GExpr mapexpr(element(_,"data",attrs)) = mapTorV(attrs);

GExpr mapTorV(list[Node] attrs)
{
	list[Node] es = getTrimmed(attrs);
	if ([charData(str txt)] := es)
		return terminal(txt);
	str tip = getAttr(attrs,"type");
	if (tip in ["string", "ID", "IDREF", "IDREFS", "QName", "NCName", "normalizedString"])
		return val(string());
	elseif (tip in ["language", "anyURI", "token", "date", "time", "dateTime", "base64Binary", "duration", "gYearMonth", "gYear", "gMonthDay", "gMonth", "gDay"])
		// NB: BGF does not have these built-in, but they are [restricted] strings anyway
		// PS: this is not as horrible as it sounds: e.g., the RELAX NG grammar of XHTML models FPI, Content Types and Datetime as strings as well
		return val(string());
	elseif (tip in ["ENTITY", "NMTOKEN", "NMTOKENS"])
		// NB: could possibly be contemplated to be replaced with a list of entities
		return val(string());
	elseif (tip in ["decimal", "integer", "nonNegativeInteger", "positiveInteger"])
		// NB: details (total digits, fraction digits, etc) are abstracted
		return val(integer());
	elseif (tip in ["float", "double"])
		// NB: floats could possibly be considered as some combinations of integers and dots
		return val(string());
	elseif (tip == "boolean")
		// NB: was done differently in the XSLT variant
		return val(boolean());
	else
		// TODO: any other kind of value?
		println("Value of unknown type <tip>!");
}

GExpr mapexpr(element(_,"oneOrMore",attrs)) = plus(mapexprs(attrs));
GExpr mapexpr(element(_,"zeroOrMore",attrs)) = star(mapexprs(attrs));
GExpr mapexpr(element(_,"optional",attrs)) = optional(mapexprs(attrs));
GExpr mapexpr(element(_,"choice",attrs)) = choice([mapexpr(e) | e <- getTrimmedNameless(attrs)]);

GExpr mapexpr(element(_,"attribute",attrs))
{
	// NB: if the only known thing is that it can have any name, then it can be anything
	if ([element(_,"anyName",_)] := attrs)
		return anything();
	str name = getName(attrs);
	if (!isEmpty(name))
	{
		// with this we filter out all attributes
		es = getTrimmedNameless(attrs);
		// NB: the logic is simple: if no type is given, the attribute is a string!
		// TODO: does not work for elements
		if (isEmpty(es))
			return mark(name,val(string()));
		else
			return mark(name,mapexprs(es));
	}
	list[str] manynames = getManyNames(attrs);
	if (!isEmpty(manynames))
	{
		GExpr e = mapexprs([e | e <- getTrimmedNameless(attrs), e.name != "choice"]);
		return choice([mark(name,e) | name <- manynames]);
	}
	// TODO: the default case possibly needs debugging
	return mapexprs(attrs);
}

// NB: any @combine modifiers are ignored here
GExpr mapexpr(attribute(_,"combine",_)) = nothing();

GExpr mapexpr(comment(_)) = nothing();

default GExpr mapexpr(Node n)
{
	if (attribute(_,_,_) := n)
		println("Warning: unmapped attribute <n.name>");
	elseif (element(_,_,_) := n)
		println("Warning: unmapped element <n.name>");
	else
		println("Warning: unmapped node");
	iprintln(n);
	return nothing();
}

// NB: this nicely cleans up attributes and comments, but perhaps treats entities to harshly
list[Node] getTrimmed(list[Node] ns) = [n | Node n <- ns, element(_,_,_) := n || charData(_) := n];
list[Node] getTrimmedNameless(list[Node] ns) = [n | Node n <- ns, element(_,_,_) := n, n.name != "name"];

str getName(list[Node] ns) = getAttr2([av | attribute(_,"name",str av) <- ns] + [ev | element(_,"name",[charData(str ev)]) <- ns]);
list[str] getManyNames(list[Node] ns) = [n | element(_,"choice",L) <- ns, element(_,"name",[charData(str n)]) <- L];

str getAttr(list[Node] ns, str name) = getAttr2([v | attribute(_,name,str v) <- ns]);
str getAttr2([str v]) = v;
str getAttr2([]) = "";
default str getAttr2(list[str] vs)
{
	println("Warning: multiple values of the attribute: <vs>");
	return vs[0];
}
