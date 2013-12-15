@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module grammarlab::transform::sleir::Naming

import List;
import String;
import grammarlab::lib::Sizes;

alias NamingConvention = tuple[NCCap cap, NCSep sep];
data NCCap
	= lowercase()
	| UPPERCASE()
	| Capitalcase()
	| CamelCase()
	| mixedCase()
	| noconvention()
;
alias NCSep = str;

// how to format the first word of an identifier?
NCCap whichFirst(lowercase()) = lowercase();
NCCap whichFirst(UPPERCASE()) = UPPERCASE();
NCCap whichFirst(Capitalcase()) = Capitalcase();
NCCap whichFirst(CamelCase()) = Capitalcase();
NCCap whichFirst(mixedCase()) = lowercase();
default NCCap whichFirst(NCCap _) = noconvention();
// how to format the next words of an identifier?
NCCap whichNext(lowercase()) = lowercase();
NCCap whichNext(UPPERCASE()) = UPPERCASE();
NCCap whichNext(Capitalcase()) = lowercase();
NCCap whichNext(CamelCase()) = Capitalcase();
NCCap whichNext(mixedCase()) = Capitalcase();
default NCCap whichNext(NCCap _) = noconvention();

public bool isAlpha(str s) = (true | it && isAlpha(c) | int c <- chars(s));
public bool isAlpha(int c) = isLower(c) || isUpper(c);
bool isLower(int c) = c >= 97 && c <= 122;
bool isUpper(int c) = c >= 65 && c <= 90;
bool isDigit(int c) = c >= 48 && c <= 57;

bool eqAll(list[str] xs, str y) = (true | it && x==y | x <- xs);

public NamingConvention inferConvention(str s)
{
	// a tiny parsing automaton
	int state = 0; // 0 - first char; 1 - second char; 2 - anything else
	list[str] seps = [], firsts = [], seconds = []; 
	for (int c <- chars(s), !isDigit(c))
		switch(state)
		{
			case 0:
				if (isLower(c))
					{firsts += "a"; state = 1;}
				elseif (isUpper(c))
					{firsts += "A"; state = 1;}
				else
					{seps += stringChars([c]); state = 0;}
			case 1:
				if (isLower(c))
					{seconds += "a"; state = 2;}
				elseif (isUpper(c))
					{seconds += "A"; state = 2;}
				else
					{seconds += ""; seps += stringChars([c]); state = 0;}
			case 2:
				if (!isLower(c) && !isUpper(c))
					{seps += stringChars([c]); state = 0;}
		}
	words = [];
	for (int i <- [0..len(firsts)])
	{
		if (i >= len(seconds)) break;
		if (firsts[i] == "a" && seconds[i] == "a") words += "L";
		if (firsts[i] == "A" && seconds[i] == "A") words += "U";
		if (firsts[i] == "A" && seconds[i] == "a") words += "C";
		if (firsts[i] == "a" && seconds[i] == "A") words += "M";
		// more relaxed rules
		if (firsts[i] == "a" && seconds[i] == "") words += "L";
		if (firsts[i] == "A" && seconds[i] == "") words += "U";
	}
	// no convention unless we see come clear commitment
	NCCap nc = noconvention();
	if (len(words)>1)
	{
		if (words[0]=="L" && eqAll(words[1..],"L")) nc = lowercase();
		if (words[0]=="U" && eqAll(words[1..],"U")) nc = UPPERCASE(); 
		if (words[0]=="C" && eqAll(words[1..],"L")) nc = Capitalcase();
		if (words[0]=="C" && eqAll(words[1..],"C")) nc = CamelCase();
		if (words[0]=="L" && eqAll(words[1..],"C")) nc = mixedCase();
		// TODO: need relaxed ones, but then the "words" abstraction is wrong
	}
	// leave separator empty if it is inconsistent
	sep = (len(seps)>0 && eqAll(seps,seps[0])) ? seps[0] : "";
	return <nc,sep>;
}

public bool confirmConvention(str s, NamingConvention nc)
	= nc.cap != noconvention()
	&& (inferConvention(s) == nc
	|| changeConvention(s,inferConvention(s),nc) == s)
	;

public str changeConvention(str s, NamingConvention nc1, NamingConvention nc2)
{
	if (inferConvention(s)!=nc1) return s;
	if (nc1.cap == nc2.cap) return replaceAll(s, nc1.sep, nc2.sep);
	ws = [forceConventionWord(w,whichNext(nc2.cap)) | w <- split(nc1.sep, s)];
	ws[0] = forceConventionWord(ws[0],whichFirst(nc2.cap)); 
	//if (isFirstUp(nc2.cap)) ws[0]
	return intercalate(nc2.sep, ws);
}

str forceConventionWord(str s, lowercase()) = toLowerCase(s);
str forceConventionWord(str s, UPPERCASE()) = toUpperCase(s);
default str forceConventionWord(str s, NCCap nc)
	= len(s)==1 ? toUpperCase(s) :
	toUpperCase(s[0]) + toLowerCase(s[1..]);
