@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module grammarlab::io::write::XHTML

import grammarlab::language::XHTML;
import lang::xml::DOM;
import IO;
import String;

// As it turns out, most xml-unparsing can be done with these two functions
list[Node] universalxml(str tagname, Attrs attrs, BodyElement e) = [element( none(), tagname, [attribute(name, attrs[name]) | name <- attrs] + bodyelement2xml(e) )];
Node universalemptyxml(str tagname, Attrs attrs) = element( none(), tagname, [attribute(name, attrs[name]) | name <- attrs] );

//data HTML = html(Attrs attr, DocType dt, Head h, Body b);
public Node html2xml(HTML r)
 = document(
 	element(
 		none(),
 		"html",
 		[attribute(name,r.attrs[name]) | name <- r.attrs] +
 		[head2xml(r.h), body2xml(r.b)]
 	));

//data Head = hhead(list[HeadElement] es);
Node head2xml(Head r) = element( none(), "head", [headelement2xml(e) | e <- r.es] );
 
//data HeadElement
//	= meta(Attrs attr)
//	| title(str t)
//	| link(Attrs attr)
//	;
Node headelement2xml(title(str t)) = element(none(),"title",[charData(t)]);
Node headelement2xml(meta(Attrs attrs)) = universalemptyxml("meta",attrs);
Node headelement2xml(link(Attrs attrs)) = universalemptyxml("link",attrs);

//data Body = body(list[BodyElement] es);
Node body2xml(Body r) = universalxml("body",r.attrs,_seq(r.es))[0]; 

//data BodyElement
//	= div(Attrs attr, BodyElement e)
//	| ahref(Attrs attr, BodyElement e)
//	| _seq(list[BodyElement] es)
//	| _text(str t)
//	;
list[Node] bodyelement2xml(div(Attrs attrs, BodyElement e)) = universalxml("div",attrs,e);
list[Node] bodyelement2xml(hr()) = [element(none(),"hr",[])];
list[Node] bodyelement2xml(br()) = [element(none(),"br",[])];
list[Node] bodyelement2xml(heading(int n, Attrs attrs, BodyElement e)) = universalxml("h<n>",attrs,e);
list[Node] bodyelement2xml(ul(Attrs attrs, list[BodyElement] es)) = universalxml("ul",attrs,_seq(es));
list[Node] bodyelement2xml(dl(Attrs attrs, list[BodyElement] es)) = universalxml("dl",attrs,_seq(es));
list[Node] bodyelement2xml(ol(Attrs attrs, list[BodyElement] es)) = universalxml("ol",attrs,_seq(es));
list[Node] bodyelement2xml(li(Attrs attrs, BodyElement e)) = universalxml("li",attrs,e);
list[Node] bodyelement2xml(dd(Attrs attrs, BodyElement e)) = universalxml("dd",attrs,e);
list[Node] bodyelement2xml(dt(Attrs attrs, BodyElement e)) = universalxml("dt",attrs,e);
list[Node] bodyelement2xml(ahref(Attrs attrs, BodyElement e)) = universalxml("a",attrs,e);
list[Node] bodyelement2xml(aname(str name)) = [element( none(), "a", [attribute("name", name), charData("")])];
list[Node] bodyelement2xml(img(str src, str alt, ""))
	= [element(	none(), "img", [attribute("src", src), attribute("alt", alt), charData("")])];
list[Node] bodyelement2xml(img(str src, str alt, str title))
	= [element(	none(), "img", [attribute("src", src), attribute("alt", alt), attribute("title", title), charData("")])];
list[Node] bodyelement2xml(em(Attrs attrs, BodyElement e)) = universalxml("em",attrs,e);
list[Node] bodyelement2xml(code(Attrs attrs, BodyElement e)) = universalxml("code",attrs,e);
list[Node] bodyelement2xml(strong(Attrs attrs, BodyElement e)) = universalxml("strong",attrs,e);
list[Node] bodyelement2xml(span(Attrs attrs, BodyElement e)) = universalxml("span",attrs,e);
list[Node] bodyelement2xml(sub(Attrs attrs, BodyElement e)) = universalxml("sub",attrs,e);
list[Node] bodyelement2xml(sup(Attrs attrs, BodyElement e)) = universalxml("sup",attrs,e);
list[Node] bodyelement2xml(para(Attrs attrs, BodyElement e)) = universalxml("p",attrs,e);
list[Node] bodyelement2xml(pre(Attrs attrs, BodyElement e)) = universalxml("pre",attrs,e);
list[Node] bodyelement2xml(_text(str t)) = [charData(t)];
list[Node] bodyelement2xml(_tab()) = [charRef(9)];
list[Node] bodyelement2xml(_seq(list[BodyElement] es)) = [*bodyelement2xml(ie) | ie <- es];
default list[Node] bodyelement2xml(BodyElement e)
{
	println("Unable to process <e>");
	return [charData("<e>")];
}

public str html2str(HTML r)
	= replaceFirst(replaceFirst(xmlRaw(html2xml(r)),
	"\<?xml version=\"1.0\" encoding=\"UTF-8\"?\>",
	"\<!DOCTYPE html PUBLIC \"<r.dt.name>\" \"<r.dt.dtd>\"\>"
	), "\<html\>","\<html xmlns=\"http://www.w3.org/1999/xhtml\"\>"
	);

public void writeHTML(HTML r, loc f) = writeFile(f,html2str(r));
