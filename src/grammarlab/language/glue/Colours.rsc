@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::glue::Colours

import vis::Figure;
import util::IDE;

Color colNonterminal = rgb(0x48,0x5A,0xCC);
Color colTerminal    = rgb(0x00,0x99,0x00);
Color colCommand     = rgb(0xCC,0x00,0x00);
Color colNonXBGF     = rgb(0xFF,0xFF,0xCC);
Color colComment     = gray(0xCC);
Color colLabel       = gray(0x99);

public set[Contribution] getGLColours()
= {categories((
	"NonterminalLabel":	{foregroundColor(colLabel),italic()},
	"MetaVariable":		{foregroundColor(colCommand),bold()},
	"MetaKeyword":		{foregroundColor(colCommand),backgroundColor(colNonXBGF),bold()},
	"Identifier":		{foregroundColor(colNonterminal)},
	"Constant":			{foregroundColor(colTerminal)},
	"Comment":			{foregroundColor(colComment),italic()}
	//"StringLiteral":	{foregroundColor(rgb(0x2A,0xA1,0x98))},
	//"Variable":		{foregroundColor(rgb(0x26,0x8B,0xD2))},
	//"Type":			{foregroundColor(rgb(0x74,0x8B,0x00))},
	//"MetaAmbiguity":	{foregroundColor(rgb(0xaf,0x00,0x00)),
	//	bold(), italic()},
	//"Todo":			{foregroundColor(rgb(0xaf,0x00,0x00)),
	//	bold()},
	//"MetaKeyword":	{foregroundColor(rgb(0x85,0x99,0x00))}//,
  ))};

