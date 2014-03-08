@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module grammarlab::io::write::XHTML

import grammarlab::language::XHTML;
import lang::xml::DOM;
import IO;

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
Node head2xml(Head r)
 = element(
 		none(),
 		"head",
 		[headelement2xml(e) | e <- r.es]
 	);
 
//data HeadElement
//	= meta(Attrs attr)
//	| title(str t)
//	| link(Attrs attr)
//	;
Node headelement2xml(meta(Attrs attrs))
	= element(
 		none(),
 		"meta",
 		[attribute(name, attrs[name]) | name <- attrs]
 	);
Node headelement2xml(title(str t))
	= element(none(),"title",[charData(t)]);
Node headelement2xml(link(Attrs attrs))
	= element(
 		none(),
 		"link",
 		[attribute(name, attrs[name]) | name <- attrs]
 	);

//data Body = body(list[BodyElement] es);
Node body2xml(Body r) = element( none(), "body",
	[attribute(name, r.attrs[name]) | name <- r.attrs] +
	[*bodyelement2xml(ie) | ie <- r.es]);

//data BodyElement
//	= div(Attrs attr, BodyElement e)
//	| ahref(Attrs attr, BodyElement e)
//	| _seq(list[BodyElement] es)
//	| _text(str t)
//	;
list[Node] bodyelement2xml(div(Attrs attrs, BodyElement e))
	= [element(
 		none(),
 		"div",
 		[attribute(name, attrs[name]) | name <- attrs] +
 		bodyelement2xml(e)
 	)];
list[Node] bodyelement2xml(hr())
	= [element(none(),"hr",[])];
list[Node] bodyelement2xml(heading(int n, Attrs attrs, BodyElement e))
	//= [element(none(),"h<n>",[attribute(name, attrs[name]) | name <- attrs] + ((aname!="")?[element(none(), "a", [attribute("name", aname),charData(" ")])]:[]) + [charData(t)])];
	= [element(none(),"h<n>",[attribute(name, attrs[name]) | name <- attrs] + bodyelement2xml(e))];
list[Node] bodyelement2xml(ul(Attrs attrs, list[BodyElement] es))
	= [element(	none(),
		"ul",
		[attribute(name, attrs[name]) | name <- attrs] +
		[*bodyelement2xml(e) | e <- es]
	)];
list[Node] bodyelement2xml(li(Attrs attrs, BodyElement e))
	= [element(	none(),
		"li",
		[attribute(name, attrs[name]) | name <- attrs] +
		bodyelement2xml(e)
	)];
list[Node] bodyelement2xml(ahref(Attrs attrs, BodyElement e))
	= [element(	none(),
 		"a",
 		[attribute(name, attrs[name]) | name <- attrs] +
 		bodyelement2xml(e)
	)];
list[Node] bodyelement2xml(aname(str name))
	= [element(	none(), "a", [attribute("name", name), charData("")])];
list[Node] bodyelement2xml(em(Attrs attrs, BodyElement e))
	= [element(	none(),
 		"em",
 		[attribute(name, attrs[name]) | name <- attrs] +
 		bodyelement2xml(e)
 	)];
list[Node] bodyelement2xml(span(Attrs attrs, BodyElement e))
	= [element(	none(),
 		"span",
 		[attribute(name, attrs[name]) | name <- attrs] +
 		bodyelement2xml(e)
 	)];
list[Node] bodyelement2xml(_text(str t)) = [charData(t)];
list[Node] bodyelement2xml(_seq(list[BodyElement] es)) = [*bodyelement2xml(ie) | ie <- es];
default list[Node] bodyelement2xml(BodyElement e)
{
	println("Unable to process <e>");
	return [charData("<e>")];
}

public str html2str(HTML r) = xmlRaw(html2xml(r));

public void writeHTML(HTML r, loc f) = writeFile(f,html2str(r));
