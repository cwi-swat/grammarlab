@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::extract::RelaxNG2BGF

import IO;
import lang::xml::DOM;
import grammarlab::language::Grammar;
import grammarlab::export::Grammar;
import grammarlab::lib::Squeeze;
import grammarlab::lib::Sizes;

GGrammar extractG(loc f)
{
	if (document(element(namespace(_,"http://relaxng.org/ns/structure/1.0"),"grammar",L)) := parseXMLDOMTrim(readFile(f)))
	{
		list[str] S = maproots(L);
		//println("Roots: <S>");
		list[Node] defines = [d | d:element(namespace(_,"http://relaxng.org/ns/structure/1.0"),"define",_) <- L];
		list[Node] includes = [d | d:element(namespace(_,"http://relaxng.org/ns/structure/1.0"),"include",_) <- L];
		list[Node] others = [e | e:element(namespace(_,"http://relaxng.org/ns/structure/1.0"),str t,_) <- L, t notin ["start", "define", "include"]];
		for (inc <- includes)
			println("Warning: merge this grammar with the one extracted from <getAttr(inc.children,"href")>!");
		if (!isEmpty(others))
			println("Warning: unexpected nodes in RNG: <[n | element(_,str n,_) <- others]>");
		GProdList ps
			= [mapprod(p)  |  p <- defines]
			+ [mapprod(ip) | op <- defines, element(_,"element",list[Node] ec) <- op.children, element(_,"grammar",list[Node] gc) <- ec, ip:element(_,"define",_) <- gc];
		return grammar(
			squeeze([p.lhs | p <- ps]),
			ps,
			S
		);
	}
	else
		throw "<f> is not a proper BGF file";
}

list[str] maproots(list[Node] L)
	= [s | element(_,"start",L2) <- L, element(_,"ref",[attribute(none(),"name",str s)]) <- L2]
	+ [s | element(_,"start",[element(_,"choice",L2)]) <- L, element(_,"ref",[attribute(none(),"name",str s)]) <- L2];
			
GProd mapprod(element(_,"define",attrs))
{
	str name = getName(attrs);
	GExpr rhs;
	// case 1: subgrammar
	list[Node] subgs = [g | element(_,"element",ie) <- attrs && g:element(_,"grammar",_) <- ie]; 
	if (!isEmpty(subgs))
		rhs = choice([nonterminal(x) | Node g <- subgs, str x <- maproots(g)]);
	else
		rhs = mapexprs([a | a <- attrs, a.name != "name"]);
	
	//println("<name> ::= <ppx(rhs)>");
	//iprintln(n);
	return production("<name>",rhs);
}

default GProd mapprod(Node n)
{
	println("Bad:");
	iprintln(n);
	//return production("a",empty());
}

GExpr mapexprs(list[Node] ns)
{
	if (isTrivial(ns))
		return mapexpr(ns[0]);
	else
		return sequence([mapexpr(e) | e <- ns]);
}

GExpr mapexpr(element(_,"element",attrs))
{
	str name = getName(attrs);
	if (!isEmpty(name))
		return mark(name,mapexprs([e | e <- attrs, e.name != "name"]));
	list[str] manynames = [n | element(_,"choice",L) <- attrs, element(_,"name",n) <- L];
	if (!isEmpty(manynames))
	{
		GExpr e = mapexprs([e | e <- attrs, e.name != "name", e.name != "choice"]);
		return choice([mark(name,e) | name <- manynames]);
	}
	return mapexprs([e | e <- attrs, e.name != "name"]);
}

// NB: ignore all annotations
GExpr mapexpr(element(namespace(_,"http://relaxng.org/ns/compatibility/annotations/1.0"),_,_)) = epsilon();
GExpr mapexpr(attribute(namespace(_,"http://relaxng.org/ns/compatibility/annotations/1.0"),_,_)) = epsilon();

// NB: ignore all assertion rules [kind of static semantics]
GExpr mapexpr(element(namespace(_,"http://www.ascc.net/xml/schematron"),_,_)) = epsilon();

// NB: not entirely correct, but good for mapping abstract syntaxes (see also xbgf:permute operator)
GExpr mapexpr(element(_,"interleave",attrs)) = mapexprs(attrs);

// NB: this mapping is correct, but it is an abstraction
GExpr mapexpr(element(_,"list",attrs)) = mapexprs(attrs);

// NB: groups only make sense inside interleaved constructs
GExpr mapexpr(element(_,"group",attrs)) = mapexprs(attrs);

// NB: "any name" means "any selector", which is the default option in BGF anyway
GExpr mapexpr(element(_,"anyName",attrs)) = epsilon();

// NB: no advanced namespace support in BGF
GExpr mapexpr(element(_,"nsName",attrs)) = epsilon();

GExpr mapexpr(element(_,"empty",attrs)) = epsilon();
GExpr mapexpr(element(_,"notAllowed",attrs)) = empty();
GExpr mapexpr(element(_,"ref",attrs)) = nonterminal(getName(attrs));
GExpr mapexpr(element(_,"value",[charData(str txt)])) = terminal(txt);

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

GExpr mapexpr(element(_,"text",attrs)) = val(string());
GExpr mapexpr(element(_,"data",attrs))
{
	str tip = getAttr(attrs,"type");
	if (tip in ["string", "ID", "IDREF", "IDREFS", "QName", "NCName", "normalizedString"])
		return val(string());
	elseif (tip in ["language", "anyURI", "token", "date", "time", "dateTime", "base64Binary", "duration"])
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
	// TODO: any other kind of value?
}

GExpr mapexpr(element(_,"oneOrMore",attrs)) = plus(mapexprs(attrs));
GExpr mapexpr(element(_,"zeroOrMore",attrs)) = star(mapexprs(attrs));
GExpr mapexpr(element(_,"optional",attrs)) = optional(mapexprs(attrs));
GExpr mapexpr(element(_,"choice",attrs)) = choice([mapexpr(e) | e <- attrs]);

GExpr mapexpr(element(_,"attribute",attrs))
{
	// NB: if the only known thing is that it can have any name, then it can be anything
	if ([element(_,"anyName",_)] := attrs)
		return anything();
	str name = getName(attrs);
	if (!isEmpty(name))
	{
		es = [e | e <- attrs, e.name != "name"];
		// NB: the logic is simple: if no type is given, the attribute is a string!
		// TODO: does not work for elements
		if (isEmpty(es))
			return mark(name,val(string()));
		else
			return mark(name,mapexprs(es));
	}
	list[str] manynames = [n | element(_,"choice",L) <- attrs, element(_,"name",n) <- L];
	if (!isEmpty(manynames))
	{
		GExpr e = mapexprs([e | e <- attrs, e.name != "name", e.name != "choice"]);
		return choice([mark(name,e) | name <- manynames]);
	}
	// TODO: the default case possibly needs debugging
	return mapexprs(attrs);
}

// NB: any @combine modifiers are ignored here
GExpr mapexpr(attribute(_,"combine",_)) = epsilon();

default GExpr mapexpr(Node n)
{
	if (attribute(_,_,_) := n)
		println("Warning: unmapped attribute <n.name>");
	else
		println("Warning: unmapped element <n.name>");
	return epsilon();
}

str getName(list[Node] ns) = getAttr2([av | attribute(_,"name",str av) <- ns] + [ev | element(_,"name",str ev) <- ns]);

str getAttr(list[Node] ns, str name) = getAttr2([v | attribute(_,name,str v) <- ns]);
str getAttr2([str v]) = v;
str getAttr2([]) = "";
default str getAttr2(list[str] vs)
{
	println("Warning: multiple values of the attribute: <vs>");
	return vs[0];
}

void main()
{
	GGrammar g;
	
	g = extractG(|home:///projects/slps/topics/grammars/atom/dettrick/atom.rng.xml|);
	//println(ppx(g));
	println("ATOM Ok!");
	g = extractG(|home:///projects/slps/topics/grammars/svg/furubayashi/svg11/svg-basic-structure.rng|);
	//println(ppx(g));
	println("SVG Ok!");
}
