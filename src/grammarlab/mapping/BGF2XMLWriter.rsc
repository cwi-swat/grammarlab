@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module grammarlab::mapping::BGF2XMLWriter

alias Attrs = map[str,str];
data HTML = html(Attrs attr, DocType dt, Head h, Body b);
data DocType = doctype(str name, str dtd);
data Head = head(list[HeadElement] es);
data HeadElement
	= meta(Attrs attr)
	| title(str t)
	| link(Attrs attr)
	;
data Body = body(list[BodyElement] es);
data BodyElement
	= div(Attrs attr, BodyElement e)
	| a(Attrs attr, BodyElement e)
	| _seq(list[BodyElement] es)
	| _text(str t)
	;

HTML example
	= html(
		("xmlns":"http://www.w3.org/1999/xhtml"),
		//doctype("-//W3C//DTD XHTML 1.0 Strict//EN","http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"),
		head(
			meta( ("http-equiv":"content-type", "content":"text/html; charset=utf-8") ),
			title( (), "Dr. Vadim Zaytsev"),
			link( ("href":"spider.css", "rel":"stylesheet", "type":"text/css") ),
			link( ("rel":"shortcut icon", "href":"favicon.ico") ),
			link( ("rel":"icon", "type":"image/png", "href":"favicon.png") )
		),
		body(
			div(
				("class":"container"),
				div(
					("class":"links"),
					_seq([
						_text(" ["),
						a( ("href":"/"), text("V. Zaytsev")),
						_text(" ::= ["),
						a( ("href":"http://uva.academia.edu/VadimZaytsev/CurriculumVitae"), text("CV")),
						_text("] ["),
						a( ("href":"is"), text("Bio")),
						_text("] ["),
						a( ("href":"goes"), text("Events")),
						_text("] ["),
						a( ("href":"writes"), text("Publications")),
						_text("] ;")
					])
				)
			)
		)
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
 //element(namespace("bgf","http://planet-sl.org/bgf"),"grammar",
	//	[comment(joinStrings(bgf.N)), charData("\n")] +
	//	[element(none(),"root",[charData(s)]) | str s <- bgf.S] + charData("\n") +
	//	[prod2xml(p) | GProd p <- bgf.P])

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
Node headelement2xml(meta(Attrs attr))
	= element(
 		none(),
 		"meta",
 		[attribute(name, attrs[name]) | name <- attrs]
 	);
Node headelement2xml(title(str t))
	= element(none(),"title",[charData(t)]);
Node headelement2xml(link(Attrs attr))
	= element(
 		none(),
 		"link",
 		[attribute(name, attrs[name]) | name <- attrs]
 	);

//data Body = body(list[BodyElement] es);
Node body2xml(Body r)
{
	list[BodyElement] res = [];
	for (BodyElement e <- es)
		if (_seq(_) := e)
			res += [bodyelement(ie) | ie <- e.es];
		else
			res += bodyelement(ie);
	return element( none(), "body", res);
}
//data BodyElement
//	= div(Attrs attr, BodyElement e)
//	| a(Attrs attr, BodyElement e)
//	| _seq(list[BodyElement] es)
//	| _text(str t)
//	;
Node bodyelement2xml(div(Attrs attr, BodyElement e))
	= element(
 		none(),
 		"div",
 		[attribute(name, attrs[name]) | name <- attrs] +
 		[bodyelement2xml(e)]
 	);
Node bodyelement2xml(a(Attrs attr, BodyElement e))
	= element(
 		none(),
 		"a",
 		[attribute(name, attrs[name]) | name <- attrs] +
 		[bodyelement2xml(e)]
 	);
Node bodyelement2xml(_text(str t)) = charData(t);

/*
	problem 1: get the standard Grammar of XHTML
	problem 2: generate/design good ADT for HTML
->	problem 3: map XHTML ADT to XML DOM
	problem 4: read XML as XHTML ADT
*/