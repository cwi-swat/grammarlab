@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::extract::DTD

import ParseTree;
//import lang::std::Whitespace;

//<!ELEMENT html (head, body)>
//<!ATTLIST html
//  %i18n;
//  id          ID             #IMPLIED
//  xmlns       %URI;          #FIXED 'http://www.w3.org/1999/xhtml'
//  <!-- HTML 5 attributes -->
//  manifest    %URI;          #IMPLIED
//  >


layout Standard 
	= WhitespaceOrComment* !>> [\u0009-\u000D \u0020 \u0085 \u00A0 \u1680 \u180E \u2000-\u200A \u2028 \u2029 \u202F \u205F \u3000] !>> "//";
  
lexical WhitespaceOrComment = Whitespace | Comment;
lexical Whitespace 
  = [\u0009-\u000D \u0020 \u0085 \u00A0 \u1680 \u180E \u2000-\u200A \u2028 \u2029 \u202F \u205F \u3000]
  ; 

lexical Comment = @category="Comment" "\<!--" CommentElement* "--\>";
lexical CommentElement = ![\-] | [\-] !>> [\-] | [\-][\-] !>> [\>];

start syntax Elements = Element+; 
syntax Element = "\<!ELEMENT" Name name ContentList "\>";

syntax ContentList
	= "(" {ContentList ","}+ ")" Modifier m
	| Content
	;

syntax Modifier = "+" | "*" | "?" | ();

syntax Content
	= [#] "PCDATA"
	| "EMPTY"
	| Name n Modifier m
	| left ContentList "|" ContentList
	//| bracket "(" Content ")"
	;

lexical Name
	= SimpleName n
	| [%] SimpleName n [;]
	;

lexical SimpleName = [a-zA-Z01-9.\-]+ !>> [a-zA-Z01-9.\-] \ Keyword;
keyword Keyword = "EMPTY" | "PCDATA";

void main()
{
	parse(#start[Elements], |home:///projects/slps/topics/grammars/html/openkomodo/elements.dtd|);
}
