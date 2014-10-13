@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@todo{Eventually should be generated from an XHTML grammar}
module grammarlab::language::XHTML

import lang::xml::DOM;
import IO;
 
alias Attrs = map[str,str];
data DocType = doctype(str name, str dtd);
data HTML = html(Attrs attrs, DocType dt, Head h, Body b);
data Head = hhead(list[HeadElement] es);		// NB: to avoid confusion with List::head
data HeadElement
	= meta(Attrs attrs)
	| title(str t)
	| link(Attrs attrs)
	;
data Body = body(Attrs attrs, list[BodyElement] es);
data BodyElement
	= div(Attrs attrs, BodyElement e)
	| span(Attrs attrs, BodyElement e)
	| para(Attrs attrs, BodyElement e)
	| ahref(Attrs attrs, BodyElement e)			// NB: <a> is called ahref() in order to avoid name conflicts
	| aname(str name)
	| heading(int n, Attrs attrs, BodyElement e) // NB: quite far from the standard, one heading to rule them all
	| img(str src, str alt, str title)
	| ul(Attrs attrs, list[BodyElement] es)
	| dl(Attrs attrs, list[BodyElement] es)
	| ol(Attrs attrs, list[BodyElement] es)
	| li(Attrs attrs, BodyElement e)
	| dt(Attrs attrs, BodyElement e)
	| dd(Attrs attrs, BodyElement e)
	| em(Attrs attrs, BodyElement e)
	| code(Attrs attrs, BodyElement e)
	| pre(Attrs attrs, BodyElement e)
	| strong(Attrs attrs, BodyElement e)
	| sub(Attrs attrs, BodyElement e)
	| sup(Attrs attrs, BodyElement e)
	| hr()
	| br()
	| _seq(list[BodyElement] es)
	| _text(str t)
	| _tab()
	;

HTML example
	= html(
		//("xmlns":"http://www.w3.org/1999/xhtml"),
		(),
		doctype("-//W3C//DTD XHTML 1.0 Strict//EN","http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"),
		hhead([
			meta( ("http-equiv":"content-type", "content":"text/html; charset=utf-8") ),
			title( "Dr. Vadim Zaytsev"),
			link( ("href":"spider.css", "rel":"stylesheet", "type":"text/css") ),
			link( ("rel":"shortcut icon", "href":"favicon.ico") ),
			link( ("rel":"icon", "type":"image/png", "href":"favicon.png") )
		]),
		body( (), [
			div(
				("class":"container"),
				div(
					("class":"links"),
					_seq([
						_text(" ["), ahref( ("href":"/"), _text("V. Zaytsev")),
						_text(" ::= ["), ahref( ("href":"http://uva.academia.edu/VadimZaytsev/CurriculumVitae"), _text("CV")),
						_text("] ["), ahref( ("href":"is"), _text("Bio")),
						_text("] ["), ahref( ("href":"goes"), _text("Events")),
						_text("] ["), ahref( ("href":"writes"), _text("Publications")),
						_text("] ["), ahref( ("href":"talks"), _text("Presentations")),
						_text("] ["), ahref( ("href":"teaches"), _text("Courses")),
						_text("] ["), ahref( ("href":"works"), _text("Affiliations")),
						_text("] ["), ahref( ("href":"likes"), _text("Hobbies")),
						_text("] ["), ahref( ("href":"lives"), _text("Contact")),
						_text("] ;")
					])
				)
			)
		])
	);
