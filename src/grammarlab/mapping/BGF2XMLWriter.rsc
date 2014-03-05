@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module grammarlab::mapping::BGF2XMLWriter

import lang::xml::DOM;
import IO;
 
alias Attrs = map[str,str];
data HTML = html(Attrs attrs, DocType dt, Head h, Body b);
data DocType = doctype(str name, str dtd);
data Head = head(list[HeadElement] es);
data HeadElement
	= meta(Attrs attrs)
	| title(str t)
	| link(Attrs attrs)
	;
data Body = body(list[BodyElement] es);
data BodyElement
	= div(Attrs attrs, BodyElement e)
	| a(Attrs attrs, BodyElement e)
	| _seq(list[BodyElement] es)
	| _text(str t)
	;

HTML example
	= html(
		//("xmlns":"http://www.w3.org/1999/xhtml"),
		(),
		doctype("-//W3C//DTD XHTML 1.0 Strict//EN","http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"),
		head([
			meta( ("http-equiv":"content-type", "content":"text/html; charset=utf-8") ),
			title( "Dr. Vadim Zaytsev"),
			link( ("href":"spider.css", "rel":"stylesheet", "type":"text/css") ),
			link( ("rel":"shortcut icon", "href":"favicon.ico") ),
			link( ("rel":"icon", "type":"image/png", "href":"favicon.png") )
		]),
		body([
			div(
				("class":"container"),
				div(
					("class":"links"),
					_seq([
						_text(" ["),
						a( ("href":"/"), _text("V. Zaytsev")),
						_text(" ::= ["),
						a( ("href":"http://uva.academia.edu/VadimZaytsev/CurriculumVitae"), _text("CV")),
						_text("] ["),
						a( ("href":"is"), _text("Bio")),
						_text("] ["),
						a( ("href":"goes"), _text("Events")),
						_text("] ["),
						a( ("href":"writes"), _text("Publications")),
						_text("] ;")
					])
				)
			)
		])
	);

//data HTML = html(Attrs attr, DocType dt, Head h, Body b);
Node html2xml(HTML r)
 = document(
 	element(
 		none(),
 		"html",
 		[attribute(name,r.attrs[name]) | name <- r.attrs] +
 		[head2xml(r.h), body2xml(r.b)]
 	));

//data Head = head(list[HeadElement] es);
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
Node body2xml(Body r) = element( none(), "body", [*bodyelement2xml(ie) | ie <- r.es]);

//data BodyElement
//	= div(Attrs attr, BodyElement e)
//	| a(Attrs attr, BodyElement e)
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
list[Node] bodyelement2xml(a(Attrs attrs, BodyElement e))
	= [element(
 		none(),
 		"a",
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
/*
	problem 1: get the standard Grammar of XHTML
	problem 2: generate/design good ADT for HTML
->	problem 3: map XHTML ADT to XML DOM
	problem 4: read XML as XHTML ADT
*/

public void main()
{
	writeFile(|project://grammarlab/data/index.html|,xmlRaw(html2xml(example)));
}