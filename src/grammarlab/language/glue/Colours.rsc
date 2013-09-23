@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::glue::Colours

import vis::Figure;
import util::IDE;

public set[Contribution] getGLColours()
= {categories((
	"GlueCommand":{foregroundColor(rgb(0x33,0x66,0x99)),
		italic(), bold()},
		
	"Comment":		{foregroundColor(rgb(0x8a,0x8a,0x8a)),
		italic()},
	"StringLiteral":	{foregroundColor(rgb(0x2A,0xA1,0x98))},
	"Variable":		{foregroundColor(rgb(0x26,0x8B,0xD2))},
	"Type":			{foregroundColor(rgb(0x74,0x8B,0x00))},
	"Identifier":	{foregroundColor(rgb(0x48,0x5A,0x62))}, //nonterminal
	"MetaAmbiguity":	{foregroundColor(rgb(0xaf,0x00,0x00)),
		bold(), italic()},
	"Todo":			{foregroundColor(rgb(0xaf,0x00,0x00)),
		bold()},
	"Constant":		{foregroundColor(rgb(0xCB,0x4B,0x16))}, //terminal
	"MetaKeyword":	{foregroundColor(rgb(0x85,0x99,0x00))},
	"MetaVariable":	{foregroundColor(rgb(0x00,0x87,0xff))}
  ))};

