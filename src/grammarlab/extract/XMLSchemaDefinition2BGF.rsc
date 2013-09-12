@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::extract::XMLSchemaDefinition2BGF

import IO;
import String;
import lang::xml::DOM;
import grammarlab::language::Grammar;
import grammarlab::transform::Normal;
import grammarlab::export::Grammar;
import grammarlab::lib::Squeeze;
import grammarlab::lib::Sizes;
import grammarlab::lib::Location; // code moved to Rascal, remove this once the plugin updates

import grammarlab::transform::Merge;

GGrammar extractG(loc f)
{
	if (document(element(namespace(_,"http://www.w3.org/2001/XMLSchema"),"schema",L)) := parseXMLDOMTrim(readFile(f)))
	{
		list[str] S = [getName(e) | e:element(namespace(_,"http://www.w3.org/2001/XMLSchema"),"element",_) <- L];
		println("Roots: <S>");
		GProdList ps = [mapprod(p,L) | p <- L,
			element(_,"element",_) := p ||
			element(_,"group",_) := p ||
			element(_,"complexType",_) := p ||
			element(_,"simpleType",_) := p];
		list[GGrammar] gs = [grammar(squeeze([p.lhs | p <- ps]), ps, S)];
		for (xsd <- [getAttr(d,"schemaLocation") | d:element(namespace(_,"http://www.w3.org/2001/XMLSchema"),"import",_) <- L])
		{
			println("Warning: importing <xsd>...");
			if (contains(xsd,"://"))
				// TODO: this function does not exist!!!
				gs += extractG(toLocation(xsd));
			else
				gs += extractG(f[file=xsd]);
		}
		return mergeGs(gs);
	}
	else
		throw "<f> is not a proper XML Schema Definition file";
}

GProd mapprod(e:element(_,"element",_),_) = production(getName(e),getContentType(e));
GProd mapprod(e:element(_,"group",_),L) = production(getName(e),mapComplexType(e,L));
GProd mapprod(e:element(_,"complexType",_),L) = production(getName(e),mapComplexType(e,L));
GProd mapprod(e:element(_,"simpleType",_),_) = production(getName(e),mapSimpleType(e));

default GProd mapprod(Node n)
{
	println("Unmapped node:");
	iprintln(n);
}

GExpr mapSimpleType(Node n)
{
	ns = getPure(n);
	if ([r:element(_,"restriction",L)] := ns)
	{
		es = [v | element(_,"enumeration",[attribute(_,"value",str v)]) <- L];
		if (isEmpty(es))
			return type2nt(getBase(r));
		else
			return choice([mark(v,epsilon()) | v <- es]);
	}
	println("Error: unmapped simple type:");
	iprintln(n);
	return empty();
}

GExpr getContentType(Node n)
{
	if ( attribute(none(),"type",str name) <- n.children)
		return type2nt(name);
	elseif ( e:element(_,"complexType",L) <- n.children)
		return mapComplexType(e,[]);
	else
	{
		println("Unknown element type:");
		iprintln(n);
		return empty();
	}
}

list[Node] getPure(Node n)
	= [e | e <- n.children,
	element(namespace(_,"http://www.w3.org/2001/XMLSchema"),str t,_) := e,
	t notin ["documentation", "annotation"]];

GExpr mapComplexType(Node n, list[Node] context)
{
	str mino = getMin(n), maxo = getMax(n);
	ns = getPure(n);
	if (isEmpty(ns) && isAbstract(n))
		return choice([type2nt(getName(t)) |
			/t:element(_,"complexType",L) := context,
			/x:element(_,"extension",L2) := L,
			getBase(x) == getName(n)
		]);
	if (isEmpty(ns)) return epsilon();
	if ([element(_,"complexContent",[element(_,"extension",L)])] := ns)
		ns = [e | e <- L, element(_,_,_) := e];

	if ([ge:element(_,"sequence",L)] := ns)
		return wrap(sequence([mapElement(e) | e <- getPure(ge)]),mino,maxo);
	elseif ([ge:element(_,"sequence",L),AS*] := ns, allattributes(AS))
		return wrap(sequence([mapElement(e) | e <- getPure(ge)]+[mapElement(e) | e <- AS]),mino,maxo);
		// TODO: double check what is minOccurs default for attributes
	elseif ([ge:element(_,"choice",L)] := ns)
		return wrap(choice([mapElement(e) | e <- getPure(ge)]),getMin(ge),getMax(ge));
	elseif ([ge:element(_,"choice",L),AS*] := ns, allattributes(AS))
		return wrap(sequence([choice([mapElement(e) | e <- getPure(ge)])]+[mapElement(e) | e <- AS]),mino,maxo);
		// TODO: double check what is minOccurs default for attributes
	elseif ([ge:element(_,"group",L)] := ns)
		return wrap(type2nt(getRef(ge)),getMin(ge),getMax(ge));
	else
	{
		println("Do not know what to do in <n.name> with:");
		iprintln(ns);
		return empty();
	}
}

bool allattributes([]) = true;
bool allattributes([element(_,"attribute",_)]) = true;
bool allattributes([element(_,"attribute",_),L*]) = allattributes(L);
default bool allattributes(list[Node] nodes) = false;

GExpr mapElement(Node n)
{
	str name = getName(n), tip = getType(n), ref = getRef(n);
	str mino = getMin(n), maxo = getMax(n);
	// TODO: if tip is "", we need to go deeper
	// TODO: mark should be label after testing!
	if (!isEmpty(name))
	{
		if (!isEmpty(tip))
			return wrap(mark(name,type2nt(tip)), mino,maxo);
		elseif (isEmpty(tip) && isEmpty(n.children))
			return wrap(mark(name,epsilon()), mino,maxo);
		cts = [ct | ct:element(_,"complexType",_) <- n.children];
		if (isTrivial(cts))
			return wrap(mark(name,mapComplexType(cts[0],[])), mino,maxo);
		//else
		//	println("WTF multiple complex types??");
	}
	if (!isEmpty(ref))
		return wrap(type2nt(ref), mino,maxo);
	println("Name <name>, type <tip>, min <mino>, max <maxo>");
	return empty();
}

bool isAbstract(Node n) = [_*,attribute(none(),"abstract","true"),_*] := n.children;

str getName(Node n)
{
	if ( attribute(none(),"name",str name) <- n.children)
		return name;
	else
	{
		//println("Cannot determine name of:");
		//iprintln(n);
		return "";
	}
}

str getType(Node n) = getAttr(n,"type");
str getBase(Node n) = getAttr(n,"base");
str getRef(Node n) = getAttr(n,"ref");

str getAttr(Node n, str aname)
{
	if ( attribute(none(),aname,str name) <- n.children)
		return name;
	else
		return "";
}

str getMin(Node n) = [_*,attribute(none(),"minOccurs",str name),_*] := n.children ? name : "1";

str getMax(Node n) = [_*,attribute(none(),"maxOccurs",str name),_*] := n.children ? name : "1";

GExpr type2nt(str nsn) = type2nt2(dropNs(nsn));

str dropNs(str nsn) = contains(nsn,":") ? split(":",nsn)[1] : nsn;

// TODO: could possibly make this more reliable, but the abstraction is reasonable as it is
GExpr type2nt2("int") = val(integer());
GExpr type2nt2("integer") = val(integer());
GExpr type2nt2("decimal") = val(integer());
GExpr type2nt2("nonNegativeInteger") = val(integer());
GExpr type2nt2("positiveInteger") = val(integer());
GExpr type2nt2("string") = val(string());
GExpr type2nt2("normalizedString") = val(string());
GExpr type2nt2("boolean") = val(boolean());
default GExpr type2nt2(str s) = nonterminal(s);

GExpr wrap(GExpr e, "1", "1") = e;
GExpr wrap(GExpr e, "0", "1") = optional(e);
GExpr wrap(GExpr e, "0", "unbounded") = star(e);
GExpr wrap(GExpr e, "1", "unbounded") = plus(e);
default GExpr wrap(GExpr e, str mino, str maxo)
{
	println("Warning: cannot properly model repetition of <mino>..<maxo>");
	return e;
}

void main()
{
	GGrammar g;
	g = extractG(|home:///projects/slps/shared/xsd/bgf.xsd|);
	println(ppx(g));
	println("XSD Ok!");
}
