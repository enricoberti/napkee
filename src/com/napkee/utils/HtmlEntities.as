package com.napkee.utils 
{
	/**
	 * ...
	 * @author Adrian Parr
	 */
	public class HtmlEntities
	{
		
		public static function encode($str:String):String {
			var regExp:RegExp;
			
			///////////////////////////////////////////////////////////////////////
			// Reserved Characters in HTML
			// http://www.w3schools.com/tags/ref_entities.asp
			///////////////////////////////////////////////////////////////////////
			
			// http://www.fileformat.info/info/unicode/char/0026/index.htm
			// ampersand (Entity Number: &#38;)
//			regExp = /&/g;
//			$str = $str.replace(regExp, "&amp;");
			
			// http://www.fileformat.info/info/unicode/char/0022/index.htm
			// double quotation mark (Entity Number: &#34;)
			regExp = /"/g;
			$str = $str.replace(regExp, "&quot;");
			
			// http://www.fileformat.info/info/unicode/char/0027/index.htm
			// apostrophe (Entity Number: &#39;)
			regExp = /'/g;
			$str = $str.replace(regExp, "&apos;");
			
			// http://www.fileformat.info/info/unicode/char/003c/index.htm
			// less-than sign (Entity Number: &#60;)
//			regExp = /</g;
//			$str = $str.replace(regExp, "&lt;");
			
			// http://www.fileformat.info/info/unicode/char/003e/index.htm
			// greater-than sign (Entity Number: &#62;)
//			regExp = />/g;
//			$str = $str.replace(regExp, "&gt;");
			
			///////////////////////////////////////////////////////////////////////
			// ISO 8859-1 Symbols
			// http://www.w3schools.com/tags/ref_entities.asp
			///////////////////////////////////////////////////////////////////////
			
			// http://www.fileformat.info/info/unicode/char/00a0/index.htm
			// non-breaking space (Entity Number: &#160;)
//			regExp = / /g;
//			$str = $str.replace(regExp, "&nbsp;");
			
			// http://www.fileformat.info/info/unicode/char/00a1/index.htm
			// inverted exclamation (Entity Number: &#161;)
			regExp = /¡/g;
			$str = $str.replace(regExp, "&iexcl;");
			
			// http://www.fileformat.info/info/unicode/char/00a2/index.htm
			// cent sign (Entity Number: &#162;)
			regExp = /¢/g;
			$str = $str.replace(regExp, "&cent;");
			
			// http://www.fileformat.info/info/unicode/char/00a3/index.htm
			// pound sterling (Entity Number: &#163;)
			regExp = /£/g;
			$str = $str.replace(regExp, "&pound;");
			
			// http://www.fileformat.info/info/unicode/char/00a4/index.htm
			// general currency sign (Entity Number: &#164;)
			regExp = /¤/g;
			$str = $str.replace(regExp, "&curren;");
			
			// http://www.fileformat.info/info/unicode/char/00a5/index.htm
			// yen sign (Entity Number: &#165;)
			regExp = /¥/g;
			$str = $str.replace(regExp, "&yen;");
			
			// http://www.fileformat.info/info/unicode/char/00a6/index.htm
			// broken vertical bar (Entity Number: &#166;)
			regExp = /¦/g;
			$str = $str.replace(regExp, "&brvbar;");
			
			// http://www.fileformat.info/info/unicode/char/00a7/index.htm
			// section sign (Entity Number: &#167;)
			regExp = /§/g;
			$str = $str.replace(regExp, "&sect;");
			
			// http://www.fileformat.info/info/unicode/char/00a8/index.htm
			// umlaut (Entity Number: &#168;)
			regExp = /¨/g;
			$str = $str.replace(regExp, "&uml;");
			
			// http://www.fileformat.info/info/unicode/char/00a9/index.htm
			// copyright (Entity Number: &#169;)
			regExp = /©/g;
			$str = $str.replace(regExp, "&copy;");
			
			// http://www.fileformat.info/info/unicode/char/00aa/index.htm
			// feminine ordinal (Entity Number: &#170;)
			regExp = /ª/g;
			$str = $str.replace(regExp, "&ordf;");
			
			// http://www.fileformat.info/info/unicode/char/00ab/index.htm
			// left angle quote (Entity Number: &#171;)
			regExp = /«/g;
			$str = $str.replace(regExp, "&laquo;");
			
			// http://www.fileformat.info/info/unicode/char/00ac/index.htm
			// not sign (Entity Number: &#172;)
			regExp = /¬/g;
			$str = $str.replace(regExp, "&not;");
			
			// http://www.fileformat.info/info/unicode/char/00ad/index.htm
			// soft hyphen (Entity Number: &#173;)
			//regExp = //g;
			//$str = $str.replace(regExp, "&shy;");
			
			// http://www.fileformat.info/info/unicode/char/00ae/index.htm
			// registered trademark (Entity Number: &#174;)
			regExp = /®/g;
			$str = $str.replace(regExp, "&reg;");
			
			// http://www.fileformat.info/info/unicode/char/00af/index.htm
			// macron accent (Entity Number: &#175;)
			regExp = /¯/g;
			$str = $str.replace(regExp, "&macr;");
			
			// http://www.fileformat.info/info/unicode/char/00b0/index.htm
			// degree sign (Entity Number: &#176;)
			regExp = /°/g;
			$str = $str.replace(regExp, "&deg;");
			
			// http://www.fileformat.info/info/unicode/char/00b1/index.htm
			// plus or minus (Entity Number: &#177;)
			regExp = /±/g;
			$str = $str.replace(regExp, "&plusmn;");
			
			// http://www.fileformat.info/info/unicode/char/00b2/index.htm
			// superscript two (Entity Number: &#178;)
			regExp = /²/g;
			$str = $str.replace(regExp, "&sup2;");
			
			// http://www.fileformat.info/info/unicode/char/00b3/index.htm
			// superscript three (Entity Number: &#179;)
			regExp = /³/g;
			$str = $str.replace(regExp, "&sup3;");
			
			// http://www.fileformat.info/info/unicode/char/00b4/index.htm
			// acute accent (Entity Number: &#180;)
			regExp = /´/g;
			$str = $str.replace(regExp, "&acute;");
			
			// http://www.fileformat.info/info/unicode/char/00b5/index.htm
			// micro sign (Entity Number: &#181;)
			regExp = /µ/g;
			$str = $str.replace(regExp, "&micro;");
			
			// http://www.fileformat.info/info/unicode/char/00b6/index.htm
			// paragraph sign (Entity Number: &#182;)
			regExp = /¶/g;
			$str = $str.replace(regExp, "&para;");
			
			// http://www.fileformat.info/info/unicode/char/00b7/index.htm
			// middle dot (Entity Number: &#183;)
			regExp = /·/g;
			$str = $str.replace(regExp, "&middot;");
			
			// http://www.fileformat.info/info/unicode/char/00b8/index.htm
			// cedilla (Entity Number: &#184;)
			regExp = /¸/g;
			$str = $str.replace(regExp, "&cedil;");
			
			// http://www.fileformat.info/info/unicode/char/00b9/index.htm
			// superscript one (Entity Number: &#185;)
			regExp = /¹/g;
			$str = $str.replace(regExp, "&sup1;");
			
			// http://www.fileformat.info/info/unicode/char/00ba/index.htm
			// masculine ordinal (Entity Number: &#186;)
			regExp = /º/g;
			$str = $str.replace(regExp, "&ordm;");
			
			// http://www.fileformat.info/info/unicode/char/00bb/index.htm
			// right angle quote (Entity Number: &#187;)
			regExp = /»/g;
			$str = $str.replace(regExp, "&raquo;");
			
			// http://www.fileformat.info/info/unicode/char/00bc/index.htm
			// one-fourth (Entity Number: &#188;)
			regExp = /¼/g;
			$str = $str.replace(regExp, "&frac14;");
			
			// http://www.fileformat.info/info/unicode/char/00bd/index.htm
			// one-half (Entity Number: &#189;)
			regExp = /½/g;
			$str = $str.replace(regExp, "&frac12;");
			
			// http://www.fileformat.info/info/unicode/char/00be/index.htm
			// three-fourths (Entity Number: &#190;)
			regExp = /¾/g;
			$str = $str.replace(regExp, "&frac34;");
			
			// http://www.fileformat.info/info/unicode/char/00bf/index.htm
			// inverted question mark (Entity Number: &#191;)
			regExp = /¿/g;
			$str = $str.replace(regExp, "&iquest;");
			
			// http://www.fileformat.info/info/unicode/char/00d7/index.htm
			// multiplication sign (Entity Number: &#215;)
			regExp = /×/g;
			$str = $str.replace(regExp, "&times;");
			
			// http://www.fileformat.info/info/unicode/char/00f7/index.htm
			// division sign (Entity Number: &#247;)
			regExp = /÷/g;
			$str = $str.replace(regExp, "&divide;");
			
			///////////////////////////////////////////////////////////////////////
			// ISO 8859-1 Characters
			// http://www.w3schools.com/tags/ref_entities.asp
			///////////////////////////////////////////////////////////////////////
			
			// http://www.fileformat.info/info/unicode/char/00c0/index.htm
			// uppercase A, grave accent (Entity Number: &#192;)
			regExp = /À/g;
			$str = $str.replace(regExp, "&Agrave;");
			
			// http://www.fileformat.info/info/unicode/char/00c1/index.htm
			// uppercase A, acute accent (Entity Number: &#193;)
			regExp = /Á/g;
			$str = $str.replace(regExp, "&Aacute;");
			
			// http://www.fileformat.info/info/unicode/char/00c2/index.htm
			// uppercase A, circumflex accent (Entity Number: &#194;)
			regExp = /Â/g;
			$str = $str.replace(regExp, "&Acirc;");
			
			// http://www.fileformat.info/info/unicode/char/00c3/index.htm
			// uppercase A, tilde (Entity Number: &#195;)
			regExp = /Ã/g;
			$str = $str.replace(regExp, "&Atilde;");
			
			// http://www.fileformat.info/info/unicode/char/00c4/index.htm
			// uppercase A, umlaut (Entity Number: &#196;)
			regExp = /Ä/g;
			$str = $str.replace(regExp, "&Auml;");
			
			// http://www.fileformat.info/info/unicode/char/00c5/index.htm
			// uppercase A, ring (Entity Number: &#197;)
			regExp = /Å/g;
			$str = $str.replace(regExp, "&Aring;");
			
			// http://www.fileformat.info/info/unicode/char/00c6/index.htm
			// uppercase AE (Entity Number: &#198;)
			regExp = /Æ/g;
			$str = $str.replace(regExp, "&AElig;");
			
			// http://www.fileformat.info/info/unicode/char/00c7/index.htm
			// uppercase C, cedilla (Entity Number: &#199;)
			regExp = /Ç/g;
			$str = $str.replace(regExp, "&Ccedil;");
			
			// http://www.fileformat.info/info/unicode/char/00c8/index.htm
			// uppercase E, grave accent (Entity Number: &#200;)
			regExp = /È/g;
			$str = $str.replace(regExp, "&Egrave;");
			
			// http://www.fileformat.info/info/unicode/char/00c9/index.htm
			// uppercase E, acute accent (Entity Number: &#201;)
			regExp = /É/g;
			$str = $str.replace(regExp, "&Eacute;");
			
			// http://www.fileformat.info/info/unicode/char/00ca/index.htm
			// uppercase E, circumflex accent (Entity Number: &#202;)
			regExp = /Ê/g;
			$str = $str.replace(regExp, "&Ecirc;");
			
			// http://www.fileformat.info/info/unicode/char/00cb/index.htm
			// uppercase E, umlaut (Entity Number: &#203;)
			regExp = /Ë/g;
			$str = $str.replace(regExp, "&Euml;");
			
			// http://www.fileformat.info/info/unicode/char/00cc/index.htm
			// uppercase I, grave accent (Entity Number: &#204;)
			regExp = /Ì/g;
			$str = $str.replace(regExp, "&Igrave;");
			
			// http://www.fileformat.info/info/unicode/char/00cd/index.htm
			// uppercase I, acute accent (Entity Number: &#205;)
			regExp = /Í/g;
			$str = $str.replace(regExp, "&Iacute;");
			
			// http://www.fileformat.info/info/unicode/char/00ce/index.htm
			// uppercase I, circumflex accent (Entity Number: &#206;)
			regExp = /Î/g;
			$str = $str.replace(regExp, "&Icirc;");
			
			// http://www.fileformat.info/info/unicode/char/00cf/index.htm
			// uppercase I, umlaut (Entity Number: &#207;)
			regExp = /Ï/g;
			$str = $str.replace(regExp, "&Iuml;");
			
			// http://www.fileformat.info/info/unicode/char/00d0/index.htm
			// uppercase Eth, Icelandic (Entity Number: &#208;)
			regExp = /Ð/g;
			$str = $str.replace(regExp, "&ETH;");
			
			// http://www.fileformat.info/info/unicode/char/00d1/index.htm
			// uppercase N, tilde (Entity Number: &#209;)
			regExp = /Ñ/g;
			$str = $str.replace(regExp, "&Ntilde;");
			
			// http://www.fileformat.info/info/unicode/char/00d2/index.htm
			// uppercase O, grave accent (Entity Number: &#210;)
			regExp = /Ò/g;
			$str = $str.replace(regExp, "&Ograve;");
			
			// http://www.fileformat.info/info/unicode/char/00d3/index.htm
			// uppercase O, acute accent (Entity Number: &#211;)
			regExp = /Ó/g;
			$str = $str.replace(regExp, "&Oacute;");
			
			// http://www.fileformat.info/info/unicode/char/00d4/index.htm
			// uppercase O, circumflex accent (Entity Number: &#212;)
			regExp = /Ô/g;
			$str = $str.replace(regExp, "&Ocirc;");
			
			// http://www.fileformat.info/info/unicode/char/00d5/index.htm
			// uppercase O, tilde (Entity Number: &#213;)
			regExp = /Õ/g;
			$str = $str.replace(regExp, "&Otilde;");
			
			// http://www.fileformat.info/info/unicode/char/00d6/index.htm
			// uppercase O, umlaut (Entity Number: &#214;)
			regExp = /Ö/g;
			$str = $str.replace(regExp, "&Ouml;");
			
			// http://www.fileformat.info/info/unicode/char/00d8/index.htm
			// uppercase O, slash (Entity Number: &#216;)
			regExp = /Ø/g;
			$str = $str.replace(regExp, "&Oslash;");
			
			// http://www.fileformat.info/info/unicode/char/00d9/index.htm
			// uppercase U, grave accent (Entity Number: &#217;)
			regExp = /Ù/g;
			$str = $str.replace(regExp, "&Ugrave;");
			
			// http://www.fileformat.info/info/unicode/char/00da/index.htm
			// uppercase U, acute accent (Entity Number: &#218;)
			regExp = /Ú/g;
			$str = $str.replace(regExp, "&Uacute;");
			
			// http://www.fileformat.info/info/unicode/char/00db/index.htm
			// uppercase U, circumflex accent (Entity Number: &#219;)
			regExp = /Û/g;
			$str = $str.replace(regExp, "&Ucirc;");
			
			// http://www.fileformat.info/info/unicode/char/00dc/index.htm
			// uppercase U, umlaut (Entity Number: &#220;)
			regExp = /Ü/g;
			$str = $str.replace(regExp, "&Uuml;");
			
			// http://www.fileformat.info/info/unicode/char/00dd/index.htm
			// uppercase Y, acute accent (Entity Number: &#221;)
			regExp = /Ý/g;
			$str = $str.replace(regExp, "&Yacute;");
			
			// http://www.fileformat.info/info/unicode/char/00de/index.htm
			// uppercase THORN, Icelandic (Entity Number: &#222;)
			regExp = /Þ/g;
			$str = $str.replace(regExp, "&THORN;");
			
			// http://www.fileformat.info/info/unicode/char/00df/index.htm
			// lowercase sharps, German (Entity Number: &#223;)
			regExp = /ß/g;
			$str = $str.replace(regExp, "&szlig;");
			
			// http://www.fileformat.info/info/unicode/char/00e0/index.htm
			// lowercase a, grave accent (Entity Number: &#224;)
			regExp = /à/g;
			$str = $str.replace(regExp, "&agrave;");
			
			// http://www.fileformat.info/info/unicode/char/00e1/index.htm
			// lowercase a, acute accent (Entity Number: &#225;)
			regExp = /á/g;
			$str = $str.replace(regExp, "&aacute;");
			
			// http://www.fileformat.info/info/unicode/char/00e2/index.htm
			// lowercase a, circumflex accent (Entity Number: &#226;)
			regExp = /â/g;
			$str = $str.replace(regExp, "&acirc;");
			
			// http://www.fileformat.info/info/unicode/char/00e3/index.htm
			// lowercase a, tilde (Entity Number: &#227;)
			regExp = /ã/g;
			$str = $str.replace(regExp, "&atilde;");
			
			// http://www.fileformat.info/info/unicode/char/00e4/index.htm
			// lowercase a, umlaut (Entity Number: &#228;)
			regExp = /ä/g;
			$str = $str.replace(regExp, "&auml;");
			
			// http://www.fileformat.info/info/unicode/char/00e5/index.htm
			// lowercase a, ring (Entity Number: &#229;)
			regExp = /å/g;
			$str = $str.replace(regExp, "&aring;");
			
			// http://www.fileformat.info/info/unicode/char/00e6/index.htm
			// lowercase ae (Entity Number: &#230;)
			regExp = /æ/g;
			$str = $str.replace(regExp, "&aelig;");
			
			// http://www.fileformat.info/info/unicode/char/00e7/index.htm
			// lowercase c, cedilla (Entity Number: &#231;)
			regExp = /ç/g;
			$str = $str.replace(regExp, "&ccedil;");
			
			// http://www.fileformat.info/info/unicode/char/00e8/index.htm
			// lowercase e, grave accent (Entity Number: &#232;)
			regExp = /è/g;
			$str = $str.replace(regExp, "&egrave;");
			
			// http://www.fileformat.info/info/unicode/char/00e9/index.htm
			// lowercase e, acute accent (Entity Number: &#233;)
			regExp = /é/g;
			$str = $str.replace(regExp, "&eacute;");
			
			// http://www.fileformat.info/info/unicode/char/00ea/index.htm
			// lowercase e, circumflex accent (Entity Number: &#234;)
			regExp = /ê/g;
			$str = $str.replace(regExp, "&ecirc;");
			
			// http://www.fileformat.info/info/unicode/char/00eb/index.htm
			// lowercase e, umlaut (Entity Number: &#235;)
			regExp = /ë/g;
			$str = $str.replace(regExp, "&euml;");
			
			// http://www.fileformat.info/info/unicode/char/00ec/index.htm
			// lowercase i, grave accent (Entity Number: &#236;)
			regExp = /ì/g;
			$str = $str.replace(regExp, "&igrave;");
			
			// http://www.fileformat.info/info/unicode/char/00ed/index.htm
			// lowercase i, acute accent (Entity Number: &#237;)
			regExp = /í/g;
			$str = $str.replace(regExp, "&iacute;");
			
			// http://www.fileformat.info/info/unicode/char/00ee/index.htm
			// lowercase i, circumflex accent (Entity Number: &#238;)
			regExp = /î/g;
			$str = $str.replace(regExp, "&icirc;");
			
			// http://www.fileformat.info/info/unicode/char/00ef/index.htm
			// lowercase i, umlaut (Entity Number: &#239;)
			regExp = /ï/g;
			$str = $str.replace(regExp, "&iuml;");
			
			// http://www.fileformat.info/info/unicode/char/00f0/index.htm
			// lowercase eth, Icelandic (Entity Number: &#240;)
			regExp = /ð/g;
			$str = $str.replace(regExp, "&eth;");
			
			// http://www.fileformat.info/info/unicode/char/00f1/index.htm
			// lowercase n, tilde (Entity Number: &#241;)
			regExp = /ñ/g;
			$str = $str.replace(regExp, "&ntilde;");
			
			// http://www.fileformat.info/info/unicode/char/00f2/index.htm
			// lowercase o, grave accent (Entity Number: &#242;)
			regExp = /ò/g;
			$str = $str.replace(regExp, "&ograve;");
			
			// http://www.fileformat.info/info/unicode/char/00f3/index.htm
			// lowercase o, acute accent (Entity Number: &#243;)
			regExp = /ó/g;
			$str = $str.replace(regExp, "&oacute;");
			
			// http://www.fileformat.info/info/unicode/char/00f4/index.htm
			// lowercase o, circumflex accent (Entity Number: &#244;)
			regExp = /ô/g;
			$str = $str.replace(regExp, "&ocirc;");
			
			// http://www.fileformat.info/info/unicode/char/00f5/index.htm
			// lowercase o, tilde (Entity Number: &#245;)
			regExp = /õ/g;
			$str = $str.replace(regExp, "&otilde;");
			
			// http://www.fileformat.info/info/unicode/char/00f6/index.htm
			// lowercase o, umlaut (Entity Number: &#246;)
			regExp = /ö/g;
			$str = $str.replace(regExp, "&ouml;");
			
			// http://www.fileformat.info/info/unicode/char/00f8/index.htm
			// lowercase o, slash (Entity Number: &#248;)
			regExp = /ø/g;
			$str = $str.replace(regExp, "&oslash;");
			
			// http://www.fileformat.info/info/unicode/char/00f9/index.htm
			// lowercase u, grave accent (Entity Number: &#249;)
			regExp = /ù/g;
			$str = $str.replace(regExp, "&ugrave;");
			
			// http://www.fileformat.info/info/unicode/char/00fa/index.htm
			// lowercase u, acute accent (Entity Number: &#250;)
			regExp = /ú/g;
			$str = $str.replace(regExp, "&uacute;");
			
			// http://www.fileformat.info/info/unicode/char/00fb/index.htm
			// lowercase u, circumflex accent (Entity Number: &#251;)
			regExp = /û/g;
			$str = $str.replace(regExp, "&ucirc;");
			
			// http://www.fileformat.info/info/unicode/char/00fc/index.htm
			// lowercase u, umlaut (Entity Number: &#252;)
			regExp = /ü/g;
			$str = $str.replace(regExp, "&uuml;");
			
			// http://www.fileformat.info/info/unicode/char/00fd/index.htm
			// lowercase y, acute accent (Entity Number: &#253;)
			regExp = /ý/g;
			$str = $str.replace(regExp, "&yacute;");
			
			// http://www.fileformat.info/info/unicode/char/00fe/index.htm
			// lowercase thorn, Icelandic (Entity Number: &#254;)
			regExp = /þ/g;
			$str = $str.replace(regExp, "&thorn;");
			
			// http://www.fileformat.info/info/unicode/char/00ff/index.htm
			// lowercase y, umlaut (Entity Number: &#255;)
			regExp = /ÿ/g;
			$str = $str.replace(regExp, "&yuml;");
			
			///////////////////////////////////////////////////////////////////////
			//  Math Symbols Supported by HTML
			//  http://www.w3schools.com/tags/ref_symbols.asp
			///////////////////////////////////////////////////////////////////////
			
			// http://www.fileformat.info/info/unicode/char/2200/index.htm
			// for all (Entity Number: &#8704;)
			regExp = /∀/g;
			$str = $str.replace(regExp, "&forall;");
			
			// http://www.fileformat.info/info/unicode/char/2202/index.htm
			// part (Entity Number: &#8706;)
			regExp = /∂/g;
			$str = $str.replace(regExp, "&part;");
			
			// http://www.fileformat.info/info/unicode/char/2203/index.htm
			// exists (Entity Number: &#8707;)
			regExp = /∃/g;
			$str = $str.replace(regExp, "&exist;");
			
			// http://www.fileformat.info/info/unicode/char/2205/index.htm
			// empty (Entity Number: &#8709;)
			regExp = /∅/g;
			$str = $str.replace(regExp, "&empty;");
			
			// http://www.fileformat.info/info/unicode/char/2207/index.htm
			// nabla (Entity Number: &#8711;)
			regExp = /∇/g;
			$str = $str.replace(regExp, "&nabla;");
			
			// http://www.fileformat.info/info/unicode/char/2208/index.htm
			// isin (Entity Number: &#8712;)
			regExp = /∈/g;
			$str = $str.replace(regExp, "&isin;");
			
			// http://www.fileformat.info/info/unicode/char/2209/index.htm
			// notin (Entity Number: &#8713;)
			regExp = /∉/g;
			$str = $str.replace(regExp, "&notin;");
			
			// http://www.fileformat.info/info/unicode/char/220b/index.htm
			// ni (Entity Number: &#8715;)
			regExp = /∋/g;
			$str = $str.replace(regExp, "&ni;");
			
			// http://www.fileformat.info/info/unicode/char/220f/index.htm
			// prod (Entity Number: &#8719;)
			regExp = /∏/g;
			$str = $str.replace(regExp, "&prod;");
			
			// http://www.fileformat.info/info/unicode/char/2211/index.htm
			// sum (Entity Number: &#8721;)
			regExp = /∑/g;
			$str = $str.replace(regExp, "&sum;");
			
			// http://www.fileformat.info/info/unicode/char/2212/index.htm
			// minus (Entity Number: &#8722;)
			regExp = /−/g;
			$str = $str.replace(regExp, "&minus;");
			
			// http://www.fileformat.info/info/unicode/char/2217/index.htm
			// lowast (Entity Number: &#8727;)
			regExp = /∗/g;
			$str = $str.replace(regExp, "&lowast;");
			
			// http://www.fileformat.info/info/unicode/char/221a/index.htm
			// square root (Entity Number: &#8730;)
			regExp = /√/g;
			$str = $str.replace(regExp, "&radic;");
			
			// http://www.fileformat.info/info/unicode/char/221d/index.htm
			// proportional to (Entity Number: &#8733;)
			regExp = /∝/g;
			$str = $str.replace(regExp, "&prop;");
			
			// http://www.fileformat.info/info/unicode/char/221e/index.htm
			// infinity (Entity Number: &#8734;)
			regExp = /∞/g;
			$str = $str.replace(regExp, "&infin;");
			
			// http://www.fileformat.info/info/unicode/char/2220/index.htm
			// angle (Entity Number: &#8736;)
			regExp = /∠/g;
			$str = $str.replace(regExp, "&ang;");
			
			// http://www.fileformat.info/info/unicode/char/2227/index.htm
			// and (Entity Number: &#8743;)
			regExp = /∧/g;
			$str = $str.replace(regExp, "&and;");
			
			// http://www.fileformat.info/info/unicode/char/2228/index.htm
			// or (Entity Number: &#8744;)
			regExp = /∨/g;
			$str = $str.replace(regExp, "&or;");
			
			// http://www.fileformat.info/info/unicode/char/2229/index.htm
			// cap (Entity Number: &#8745;)
			regExp = /∩/g;
			$str = $str.replace(regExp, "&cap;");
			
			// http://www.fileformat.info/info/unicode/char/222a/index.htm
			// cup (Entity Number: &#8746;)
			regExp = /∪/g;
			$str = $str.replace(regExp, "&cup;");
			
			// http://www.fileformat.info/info/unicode/char/222b/index.htm
			// integral (Entity Number: &#8747;)
			regExp = /∫/g;
			$str = $str.replace(regExp, "&int;");
			
			// http://www.fileformat.info/info/unicode/char/2234/index.htm
			// therefore (Entity Number: &#8756;)
			regExp = /∴/g;
			$str = $str.replace(regExp, "&there4;");
			
			// http://www.fileformat.info/info/unicode/char/223c/index.htm
			// similar to (Entity Number: &#8764;)
			regExp = /∼/g;
			$str = $str.replace(regExp, "&sim;");
			
			// http://www.fileformat.info/info/unicode/char/2245/index.htm
			// congruent to (Entity Number: &#8773;)
			regExp = /≅/g;
			$str = $str.replace(regExp, "&cong;");
			
			// http://www.fileformat.info/info/unicode/char/2248/index.htm
			// almost equal (Entity Number: &#8776;)
			regExp = /≈/g;
			$str = $str.replace(regExp, "&asymp;");
			
			// http://www.fileformat.info/info/unicode/char/2260/index.htm
			// not equal (Entity Number: &#8800;)
			regExp = /≠/g;
			$str = $str.replace(regExp, "&ne;");
			
			// http://www.fileformat.info/info/unicode/char/2261/index.htm
			// equivalent (Entity Number: &#8801;)
			regExp = /≡/g;
			$str = $str.replace(regExp, "&equiv;");
			
			// http://www.fileformat.info/info/unicode/char/2264/index.htm
			// less or equal (Entity Number: &#8804;)
			regExp = /≤/g;
			$str = $str.replace(regExp, "&le;");
			
			// http://www.fileformat.info/info/unicode/char/2265/index.htm
			// greater or equal (Entity Number: &#8805;)
			regExp = /≥/g;
			$str = $str.replace(regExp, "&ge;");
			
			// http://www.fileformat.info/info/unicode/char/2282/index.htm
			// subset of (Entity Number: &#8834;)
			regExp = /⊂/g;
			$str = $str.replace(regExp, "&sub;");
			
			// http://www.fileformat.info/info/unicode/char/2283/index.htm
			// superset of (Entity Number: &#8835;)
			regExp = /⊃/g;
			$str = $str.replace(regExp, "&sup;");
			
			// http://www.fileformat.info/info/unicode/char/2284/index.htm
			// not subset of (Entity Number: &#8836;)
			regExp = /⊄/g;
			$str = $str.replace(regExp, "&nsub;");
			
			// http://www.fileformat.info/info/unicode/char/2286/index.htm
			// subset or equal (Entity Number: &#8838;)
			regExp = /⊆/g;
			$str = $str.replace(regExp, "&sube;");
			
			// http://www.fileformat.info/info/unicode/char/2287/index.htm
			// superset or equal (Entity Number: &#8839;)
			regExp = /⊇/g;
			$str = $str.replace(regExp, "&supe;");
			
			// http://www.fileformat.info/info/unicode/char/2295/index.htm
			// circled plus (Entity Number: &#8853;)
			regExp = /⊕/g;
			$str = $str.replace(regExp, "&oplus;");
			
			// http://www.fileformat.info/info/unicode/char/2297/index.htm
			// cirled times (Entity Number: &#8855;)
			regExp = /⊗/g;
			$str = $str.replace(regExp, "&otimes;");
			
			// http://www.fileformat.info/info/unicode/char/22a5/index.htm
			// perpendicular (Entity Number: &#8869;)
			regExp = /⊥/g;
			$str = $str.replace(regExp, "&perp;");
			
			// http://www.fileformat.info/info/unicode/char/22c5/index.htm
			// dot operator (Entity Number: &#8901;)
			regExp = /⋅/g;
			$str = $str.replace(regExp, "&sdot;");

			///////////////////////////////////////////////////////////////////////
			//  Greek Letters Supported by HTML
			//  http://www.w3schools.com/tags/ref_symbols.asp
			///////////////////////////////////////////////////////////////////////
			
			// http://www.fileformat.info/info/unicode/char/0391/index.htm
			// Alpha (Entity Number: &#913;)
			regExp = /Α/g;
			$str = $str.replace(regExp, "&Alpha;");
			
			// http://www.fileformat.info/info/unicode/char/0392/index.htm
			// Beta (Entity Number: &#914;)
			regExp = /Β/g;
			$str = $str.replace(regExp, "&Beta;");
			
			// http://www.fileformat.info/info/unicode/char/0393/index.htm
			// Gamma (Entity Number: &#915;)
			regExp = /Γ/g;
			$str = $str.replace(regExp, "&Gamma;");
			
			// http://www.fileformat.info/info/unicode/char/0394/index.htm
			// Delta (Entity Number: &#916;)
			regExp = /Δ/g;
			$str = $str.replace(regExp, "&Delta;");
			
			// http://www.fileformat.info/info/unicode/char/0395/index.htm
			// Epsilon (Entity Number: &#917;)
			regExp = /Ε/g;
			$str = $str.replace(regExp, "&Epsilon;");
			
			// http://www.fileformat.info/info/unicode/char/0396/index.htm
			// Zeta (Entity Number: &#918;)
			regExp = /Ζ/g;
			$str = $str.replace(regExp, "&Zeta;");
			
			// http://www.fileformat.info/info/unicode/char/0397/index.htm
			// Eta (Entity Number: &#919;)
			regExp = /Η/g;
			$str = $str.replace(regExp, "&Eta;");
			
			// http://www.fileformat.info/info/unicode/char/0398/index.htm
			// Theta (Entity Number: &#920;)
			regExp = /Θ/g;
			$str = $str.replace(regExp, "&Theta;");
			
			// http://www.fileformat.info/info/unicode/char/0399/index.htm
			// Iota (Entity Number: &#921;)
			regExp = /Ι/g;
			$str = $str.replace(regExp, "&Iota;");
			
			// http://www.fileformat.info/info/unicode/char/039a/index.htm
			// Kappa (Entity Number: &#922;)
			regExp = /Κ/g;
			$str = $str.replace(regExp, "&Kappa;");
			
			// http://www.fileformat.info/info/unicode/char/039b/index.htm
			// Lambda (Entity Number: &#923;)
			regExp = /Λ/g;
			$str = $str.replace(regExp, "&Lambda;");
			
			// http://www.fileformat.info/info/unicode/char/039c/index.htm
			// Mu (Entity Number: &#924;)
			regExp = /Μ/g;
			$str = $str.replace(regExp, "&Mu;");
			
			// http://www.fileformat.info/info/unicode/char/039d/index.htm	
			// Nu (Entity Number: &#925;)
			regExp = /Ν/g;
			$str = $str.replace(regExp, "&Nu;");
			
			// http://www.fileformat.info/info/unicode/char/039e/index.htm
			// Xi (Entity Number: &#926;)
			regExp = /Ξ/g;
			$str = $str.replace(regExp, "&Xi;");
			
			// http://www.fileformat.info/info/unicode/char/039f/index.htm
			// Omicron (Entity Number: &#927;)
			regExp = /Ο/g;
			$str = $str.replace(regExp, "&Omicron;");
			
			// http://www.fileformat.info/info/unicode/char/03a0/index.htm
			// Pi (Entity Number: &#928;)
			regExp = /Π/g;
			$str = $str.replace(regExp, "&Pi;");
			
			// http://www.fileformat.info/info/unicode/char/03a1/index.htm
			// Rho (Entity Number: &#929;)
			regExp = /Ρ/g;
			$str = $str.replace(regExp, "&Rho;");
				
			// http://www.fileformat.info/info/unicode/char/03a3/index.htm
			// Sigma (Entity Number: &#931;)
			regExp = /Σ/g;
			$str = $str.replace(regExp, "&Sigma;");
			
			// http://www.fileformat.info/info/unicode/char/03a4/index.htm
			// Tau (Entity Number: &#932;)
			regExp = /Τ/g;
			$str = $str.replace(regExp, "&Tau;");
			
			// http://www.fileformat.info/info/unicode/char/03a5/index.htm
			// Upsilon (Entity Number: &#933;)
			regExp = /Υ/g;
			$str = $str.replace(regExp, "&Upsilon;");
			
			// http://www.fileformat.info/info/unicode/char/03a6/index.htm
			// Phi (Entity Number: &#934;)
			regExp = /Φ/g;
			$str = $str.replace(regExp, "&Phi;");
			
			// http://www.fileformat.info/info/unicode/char/03a7/index.htm
			// Chi (Entity Number: &#935;)
			regExp = /Χ/g;
			$str = $str.replace(regExp, "&Chi;");
			
			// http://www.fileformat.info/info/unicode/char/03a8/index.htm
			// Psi (Entity Number: &#936;)
			regExp = /Ψ/g;
			$str = $str.replace(regExp, "&Psi;");
			
			// http://www.fileformat.info/info/unicode/char/03a9/index.htm
			// Omega (Entity Number: &#937;)
			regExp = /Ω/g;
			$str = $str.replace(regExp, "&Omega;");
						
			// http://www.fileformat.info/info/unicode/char/03b1/index.htm
			// alpha (Entity Number: &#945;)
			regExp = /α/g;
			$str = $str.replace(regExp, "&alpha;");
			
			// http://www.fileformat.info/info/unicode/char/03b2/index.htm
			// beta (Entity Number: &#946;)
			regExp = /β/g;
			$str = $str.replace(regExp, "&beta;");
			
			// http://www.fileformat.info/info/unicode/char/03b3/index.htm
			// gamma (Entity Number: &#947;)
			regExp = /γ/g;
			$str = $str.replace(regExp, "&gamma;");
			
			// http://www.fileformat.info/info/unicode/char/03b4/index.htm
			// delta (Entity Number: &#948;)
			regExp = /δ/g;
			$str = $str.replace(regExp, "&delta;");
			
			// http://www.fileformat.info/info/unicode/char/03b5/index.htm
			// epsilon (Entity Number: &#949;)
			regExp = /ε/g;
			$str = $str.replace(regExp, "&epsilon;");
			
			// http://www.fileformat.info/info/unicode/char/03b6/index.htm
			// zeta (Entity Number: &#950;)
			regExp = /ζ/g;
			$str = $str.replace(regExp, "&zeta;");
			
			// http://www.fileformat.info/info/unicode/char/03b7/index.htm
			// eta (Entity Number: &#951;)
			regExp = /η/g;
			$str = $str.replace(regExp, "&eta;");
			
			// http://www.fileformat.info/info/unicode/char/03b8/index.htm
			// theta (Entity Number: &#952;)
			regExp = /θ/g;
			$str = $str.replace(regExp, "&theta;");
			
			// http://www.fileformat.info/info/unicode/char/03b9/index.htm
			// iota (Entity Number: &#953;)
			regExp = /ι/g;
			$str = $str.replace(regExp, "&iota;");
			
			// http://www.fileformat.info/info/unicode/char/03ba/index.htm
			// kappa (Entity Number: &#954;)
			regExp = /κ/g;
			$str = $str.replace(regExp, "&kappa;");
			
			// http://www.fileformat.info/info/unicode/char/03bb/index.htm
			// lambda (Entity Number: &#955;)
			regExp = /λ/g;
			$str = $str.replace(regExp, "&lambda;");
			
			// http://www.fileformat.info/info/unicode/char/03bc/index.htm
			// mu (Entity Number: &#956;)
			regExp = /μ/g;
			$str = $str.replace(regExp, "&mu;");
			
			// http://www.fileformat.info/info/unicode/char/03bd/index.htm
			// nu (Entity Number: &#957;)
			regExp = /ν/g;
			$str = $str.replace(regExp, "&nu;");
			
			// http://www.fileformat.info/info/unicode/char/03be/index.htm
			// xi (Entity Number: &#958;)
			regExp = /ξ/g;
			$str = $str.replace(regExp, "&xi;");
			
			// http://www.fileformat.info/info/unicode/char/03bf/index.htm
			// omicron (Entity Number: &#959;)
			regExp = /ο/g;
			$str = $str.replace(regExp, "&omicron;");
			
			// http://www.fileformat.info/info/unicode/char/03c0/index.htm
			// pi (Entity Number: &#960;)
			regExp = /π/g;
			$str = $str.replace(regExp, "&pi;");
			
			// http://www.fileformat.info/info/unicode/char/03c1/index.htm
			// rho (Entity Number: &#961;)
			regExp = /ρ/g;
			$str = $str.replace(regExp, "&rho;");
			
			// http://www.fileformat.info/info/unicode/char/03c2/index.htm
			// sigmaf (Entity Number: &#962;)
			regExp = /ς/g;
			$str = $str.replace(regExp, "&sigmaf;");
			
			// http://www.fileformat.info/info/unicode/char/03c3/index.htm
			// sigma (Entity Number: &#963;)
			regExp = /σ/g;
			$str = $str.replace(regExp, "&sigma;");
			
			// http://www.fileformat.info/info/unicode/char/03c4/index.htm
			// tau (Entity Number: &#964;)
			regExp = /τ/g;
			$str = $str.replace(regExp, "&tau;");
			
			// http://www.fileformat.info/info/unicode/char/03c5/index.htm
			// upsilon (Entity Number: &#965;)
			regExp = /υ/g;
			$str = $str.replace(regExp, "&upsilon;");
			
			// http://www.fileformat.info/info/unicode/char/03c6/index.htm
			// phi (Entity Number: &#966;)
			regExp = /φ/g;
			$str = $str.replace(regExp, "&phi;");
			
			// http://www.fileformat.info/info/unicode/char/03c7/index.htm
			// chi (Entity Number: &#967;)
			regExp = /χ/g;
			$str = $str.replace(regExp, "&chi;");
			
			// http://www.fileformat.info/info/unicode/char/03c8/index.htm
			// psi (Entity Number: &#968;)
			regExp = /ψ/g;
			$str = $str.replace(regExp, "&psi;");
			
			// http://www.fileformat.info/info/unicode/char/03c9/index.htm
			// omega (Entity Number: &#969;)
			regExp = /ω/g;
			$str = $str.replace(regExp, "&omega;");
						 
			// http://www.fileformat.info/info/unicode/char/03d1/index.htm
			// theta symbol (Entity Number: &#977;)
			regExp = /ϑ/g;
			$str = $str.replace(regExp, "&thetasym;");
			
			// http://www.fileformat.info/info/unicode/char/03d2/index.htm
			// upsilon symbol (Entity Number: &#978;)
			regExp = /ϒ/g;
			$str = $str.replace(regExp, "&upsih;");
			
			// http://www.fileformat.info/info/unicode/char/03d6/index.htm
			// pi symbol (Entity Number: &#982;)
			regExp = /ϖ/g;
			$str = $str.replace(regExp, "&piv;");

			///////////////////////////////////////////////////////////////////////
			//  Other Entities Supported by HTML
			//  http://www.w3schools.com/tags/ref_symbols.asp
			///////////////////////////////////////////////////////////////////////
			
			// http://www.fileformat.info/info/unicode/char/0152/index.htm
			// capital ligature OE (Entity Number: &#338;)
			regExp = /Œ/g;
			$str = $str.replace(regExp, "&OElig;");
			
			// http://www.fileformat.info/info/unicode/char/0153/index.htm
			// small ligature oe (Entity Number: &#339;)
			regExp = /œ/g;
			$str = $str.replace(regExp, "&oelig;");
			
			// http://www.fileformat.info/info/unicode/char/0160/index.htm
			// capital S with caron (Entity Number: &#352;)
			regExp = /Š/g;
			$str = $str.replace(regExp, "&Scaron;");
			
			// http://www.fileformat.info/info/unicode/char/0161/index.htm
			// small S with caron (Entity Number: &#353;)
			regExp = /š/g;
			$str = $str.replace(regExp, "&scaron;");
			
			// http://www.fileformat.info/info/unicode/char/0178/index.htm
			// capital Y with diaeres (Entity Number: &#376;)
			regExp = /Ÿ/g;
			$str = $str.replace(regExp, "&Yuml;");
			
			// http://www.fileformat.info/info/unicode/char/0192/index.htm
			// f with hook (Entity Number: &#402;)
			regExp = /ƒ/g;
			$str = $str.replace(regExp, "&fnof;");
			
			// http://www.fileformat.info/info/unicode/char/02c6/index.htm
			// modifier letter circumflex accent (Entity Number: &#710;)
			regExp = /ˆ/g;
			$str = $str.replace(regExp, "&circ;");
			
			// http://www.fileformat.info/info/unicode/char/02dc/index.htm
			// small tilde (Entity Number: &#732;)
			regExp = /˜/g;
			$str = $str.replace(regExp, "&tilde;");
			
			// http://www.fileformat.info/info/unicode/char/2002/index.htm
			// en space (Entity Number: &#8194;)
			regExp = / /g;
			$str = $str.replace(regExp, "&ensp;");
			
			// http://www.fileformat.info/info/unicode/char/2003/index.htm
			// em space (Entity Number: &#8195;)
			regExp = / /g;
			$str = $str.replace(regExp, "&emsp;");
			
			// http://www.fileformat.info/info/unicode/char/2009/index.htm
			// thin space (Entity Number: &#8201;)
			regExp = / /g;
			$str = $str.replace(regExp, "&thinsp;");
			
			// http://www.fileformat.info/info/unicode/char/200c/index.htm
			// zero width non-joiner (Entity Number: &#8204;)
			//regExp = //g;
			//$str = $str.replace(regExp, "&zwnj;");
			
			// http://www.fileformat.info/info/unicode/char/200d/index.htm
			// zero width joiner (Entity Number: &#8205;)
			//regExp = /‍/g;
			//$str = $str.replace(regExp, "&zwj;");
			
			// http://www.fileformat.info/info/unicode/char/200e/index.htm
			// left-to-right mark (Entity Number: &#8206;)
			regExp = /	‎/g;
			$str = $str.replace(regExp, "&lrm;");
			
			// http://www.fileformat.info/info/unicode/char/200f/index.htm
			// right-to-left mark (Entity Number: &#8207;)
			regExp = /‏‏	‏/g;
			$str = $str.replace(regExp, "&rlm;");
			
			// http://www.fileformat.info/info/unicode/char/2013/index.htm
			// en dash (Entity Number: &#8211;)
//			regExp = /–/g;
//			$str = $str.replace(regExp, "&ndash;");
			
			// http://www.fileformat.info/info/unicode/char/2014/index.htm
			// em dash (Entity Number: &#8212;)
//			regExp = /—/g;
//			$str = $str.replace(regExp, "&mdash;");

			// http://www.fileformat.info/info/unicode/char/2018/index.htm
			// left single quote (Entity Number: &#8216;)
			regExp = /‘/g;
			$str = $str.replace(regExp, "&lsquo;");
			
			// http://www.fileformat.info/info/unicode/char/2019/index.htm
			// right single quote (Entity Number: &#8217;)
			regExp = /’/g;
			$str = $str.replace(regExp, "&rsquo;");
			
			// http://www.fileformat.info/info/unicode/char/201a/index.htm
			// single low-9 quote (Entity Number: &#8218;)
			regExp = /‚/g;
			$str = $str.replace(regExp, "&sbquo;");
			
			// http://www.fileformat.info/info/unicode/char/201c/index.htm
			// left double quote (Entity Number: &#8220;)
			regExp = /“/g;
			$str = $str.replace(regExp, "&ldquo;");
			
			// http://www.fileformat.info/info/unicode/char/201d/index.htm
			// right double quote (Entity Number: &#8221;)
			regExp = /”/g;
			$str = $str.replace(regExp, "&rdquo;");
			
			// http://www.fileformat.info/info/unicode/char/201e/index.htm
			// double low-9 quote (Entity Number: &#8222;)
			regExp = /„/g;
			$str = $str.replace(regExp, "&bdquo;");
			
			// http://www.fileformat.info/info/unicode/char/2020/index.htm
			// dagger (Entity Number: &#8224;)
			regExp = /†/g;
			$str = $str.replace(regExp, "&dagger;");
			
			// http://www.fileformat.info/info/unicode/char/2021/index.htm
			// double dagger (Entity Number: &#8225;)
			regExp = /‡/g;
			$str = $str.replace(regExp, "&Dagger;");
			
			// http://www.fileformat.info/info/unicode/char/2022/index.htm
			// bullet (Entity Number: &#8226;)
			regExp = /•/g;
			$str = $str.replace(regExp, "&bull;");
			
			// http://www.fileformat.info/info/unicode/char/2026/index.htm
			// horizontal ellipsis (Entity Number: &#8230;)
			regExp = /…/g;
			$str = $str.replace(regExp, "&hellip;");
			
			// http://www.fileformat.info/info/unicode/char/2030/index.htm
			// per mill sign (Entity Number: &#8240;)
			regExp = /‰/g;
			$str = $str.replace(regExp, "&permil;");

			// http://www.fileformat.info/info/unicode/char/2032/index.htm
			// minutes (Entity Number: &#8242;)
			regExp = /′/g;
			$str = $str.replace(regExp, "&prime;");

			// http://www.fileformat.info/info/unicode/char/2033/index.htm
			// seconds (Entity Number: &#8243;)
			regExp = /″/g;
			$str = $str.replace(regExp, "&Prime;");

			// http://www.fileformat.info/info/unicode/char/2039/index.htm
			// single left-pointing angle quote (Entity Number: &#8249;)
			regExp = /‹/g;
			$str = $str.replace(regExp, "&lsaquo;");
			
			// http://www.fileformat.info/info/unicode/char/203a/index.htm
			// single right-pointing angle quote (Entity Number: &#8250;)
			regExp = /›/g;
			$str = $str.replace(regExp, "&rsaquo;");
			
			// http://www.fileformat.info/info/unicode/char/203e/index.htm
			// overline, = spacing overscore (Entity Number: &#8254;)
			regExp = /‾/g;
			$str = $str.replace(regExp, "&oline;");

			// http://www.fileformat.info/info/unicode/char/20ac/index.htm
			// euro (Entity Number: &#8364;)
			regExp = /€/g;
			$str = $str.replace(regExp, "&euro;");

			// http://www.fileformat.info/info/unicode/char/2122/index.htm
			// trademark sign (Entity Number: &#8482;)
			regExp = /™/g;
			$str = $str.replace(regExp, "&trade;");
			
			// http://www.fileformat.info/info/unicode/char/2190/index.htm
			// leftward arrow (Entity Number: &#8592;)
			regExp = /←/g;
			$str = $str.replace(regExp, "&larr;");
			
			// http://www.fileformat.info/info/unicode/char/2191/index.htm
			// upward arrow (Entity Number: &#8593;)
			regExp = /↑/g;
			$str = $str.replace(regExp, "&uarr;");
			
			// http://www.fileformat.info/info/unicode/char/2192/index.htm
			// rightward arrow (Entity Number: &#8594;)
			regExp = /→/g;
			$str = $str.replace(regExp, "&rarr;");
			
			// http://www.fileformat.info/info/unicode/char/2193/index.htm
			// downward arrow (Entity Number: &#8595;)
			regExp = /↓/g;
			$str = $str.replace(regExp, "&darr;");
	
			// http://www.fileformat.info/info/unicode/char/2194/index.htm
			// left right arrow (Entity Number: &#8596;)
			regExp = /↔/g;
			$str = $str.replace(regExp, "&harr;");

			// http://www.fileformat.info/info/unicode/char/21b5/index.htm
			// carriage return arrow (Entity Number: &#8629;)
			regExp = /↵/g;
			$str = $str.replace(regExp, "&crarr;");
			
			// http://www.fileformat.info/info/unicode/char/2308/index.htm
			// left ceiling (Entity Number: &#8968;)
			regExp = /⌈/g;
			$str = $str.replace(regExp, "&lceil;");

			// http://www.fileformat.info/info/unicode/char/2309/index.htm
			// right ceiling (Entity Number: &#8969;)
			regExp = /⌉/g;
			$str = $str.replace(regExp, "&rceil;");

			// http://www.fileformat.info/info/unicode/char/230a/index.htm
			// left floor (Entity Number: &#8970;)
			regExp = /⌊/g;
			$str = $str.replace(regExp, "&lfloor;");

			// http://www.fileformat.info/info/unicode/char/230b/index.htm
			// right floor (Entity Number: &#8971;)
			regExp = /⌋/g;
			$str = $str.replace(regExp, "&rfloor;");

			// http://www.fileformat.info/info/unicode/char/25ca/index.htm
			// lozenge (Entity Number: &#9674;)
			regExp = /◊/g;
			$str = $str.replace(regExp, "&loz;");

			// http://www.fileformat.info/info/unicode/char/2660/index.htm
			// black spade suit (Entity Number: &#9824;)
			regExp = /♠/g;
			$str = $str.replace(regExp, "&spades;");
			
			// http://www.fileformat.info/info/unicode/char/2663/index.htm
			// black club suit (Entity Number: &#9827;)
			regExp = /♣/g;
			$str = $str.replace(regExp, "&clubs;");
			
			// http://www.fileformat.info/info/unicode/char/2665/index.htm
			// black heart suit (Entity Number: &#9829;)
			regExp = /♥/g;
			$str = $str.replace(regExp, "&hearts;");
			
			// http://www.fileformat.info/info/unicode/char/2666/index.htm
			// black diamond suit (Entity Number: &#9830;)
			regExp = /♦/g;
			$str = $str.replace(regExp, "&diams;");

			///////////////////////////////////////////////////////////////////////
			//  Other Named Entities
			///////////////////////////////////////////////////////////////////////
			
			// http://www.fileformat.info/info/unicode/char/002f/index.htm
			// slash (Entity Number: &#47;)
//			regExp = /\//g;
//			$str = $str.replace(regExp, "&frasl;");
			
			///////////////////////////////////////////////////////////////////////

			return $str;
		}
		
		
		
		
		
		
		public static function decode($str:String):String {
			var regExp:RegExp;
			
			///////////////////////////////////////////////////////////////////////
			// Reserved Characters in HTML
			// http://www.w3schools.com/tags/ref_entities.asp
			///////////////////////////////////////////////////////////////////////
			
			// http://www.fileformat.info/info/unicode/char/0026/index.htm
			// ampersand (Entity Number: &#38;)
			regExp = /&amp;/g;
			$str = $str.replace(regExp, "&");
			
			// http://www.fileformat.info/info/unicode/char/0022/index.htm
			// double quotation mark (Entity Number: &#34;)
			regExp = /&quot;/g;
			$str = $str.replace(regExp, "\"");
			
			// http://www.fileformat.info/info/unicode/char/0027/index.htm
			// apostrophe (Entity Number: &#39;)
			regExp = /&apos;/g;
			$str = $str.replace(regExp, "'");
			
			// http://www.fileformat.info/info/unicode/char/003c/index.htm
			// less-than sign (Entity Number: &#60;)
			regExp = /&lt;/g;
			$str = $str.replace(regExp, "<");
			
			// http://www.fileformat.info/info/unicode/char/003e/index.htm
			// greater-than sign (Entity Number: &#62;)
			regExp = /&gt;/g;
			$str = $str.replace(regExp, ">");
			
			///////////////////////////////////////////////////////////////////////
			// ISO 8859-1 Symbols
			// http://www.w3schools.com/tags/ref_entities.asp
			///////////////////////////////////////////////////////////////////////
			
			// http://www.fileformat.info/info/unicode/char/00a0/index.htm
			// non-breaking space (Entity Number: &#160;)
			regExp = /&nbsp;/g;
			$str = $str.replace(regExp, " ");
			
			// http://www.fileformat.info/info/unicode/char/00a1/index.htm
			// inverted exclamation (Entity Number: &#161;)
			regExp = /&iexcl;/g;
			$str = $str.replace(regExp, "¡");
			
			// http://www.fileformat.info/info/unicode/char/00a2/index.htm
			// cent sign (Entity Number: &#162;)
			regExp = /&cent;/g;
			$str = $str.replace(regExp, "¢");
			
			// http://www.fileformat.info/info/unicode/char/00a3/index.htm
			// pound sterling (Entity Number: &#163;)
			regExp = /&pound;/g;
			$str = $str.replace(regExp, "£");
			
			// http://www.fileformat.info/info/unicode/char/00a4/index.htm
			// general currency sign (Entity Number: &#164;)
			regExp = /&curren;/g;
			$str = $str.replace(regExp, "¤");
			
			// http://www.fileformat.info/info/unicode/char/00a5/index.htm
			// yen sign (Entity Number: &#165;)
			regExp = /&yen;/g;
			$str = $str.replace(regExp, "¥");
			
			// http://www.fileformat.info/info/unicode/char/00a6/index.htm
			// broken vertical bar (Entity Number: &#166;)
			regExp = /&brvbar;/g;
			$str = $str.replace(regExp, "¦");
			
			// http://www.fileformat.info/info/unicode/char/00a7/index.htm
			// section sign (Entity Number: &#167;)
			regExp = /&sect;/g;
			$str = $str.replace(regExp, "§");
			
			// http://www.fileformat.info/info/unicode/char/00a8/index.htm
			// umlaut (Entity Number: &#168;)
			regExp = /&uml;/g;
			$str = $str.replace(regExp, "¨");
			
			// http://www.fileformat.info/info/unicode/char/00a9/index.htm
			// copyright (Entity Number: &#169;)
			regExp = /&copy;/g;
			$str = $str.replace(regExp, "©");
			
			// http://www.fileformat.info/info/unicode/char/00aa/index.htm
			// feminine ordinal (Entity Number: &#170;)
			regExp = /&ordf;/g;
			$str = $str.replace(regExp, "ª");
			
			// http://www.fileformat.info/info/unicode/char/00ab/index.htm
			// left angle quote (Entity Number: &#171;)
			regExp = /&laquo;/g;
			$str = $str.replace(regExp, "«");
			
			// http://www.fileformat.info/info/unicode/char/00ac/index.htm
			// not sign (Entity Number: &#172;)
			regExp = /&not;/g;
			$str = $str.replace(regExp, "¬");
			
			// http://www.fileformat.info/info/unicode/char/00ad/index.htm
			// soft hyphen (Entity Number: &#173;)
			//regExp = /&shy;/g;
			//$str = $str.replace(regExp, "");
			
			// http://www.fileformat.info/info/unicode/char/00ae/index.htm
			// registered trademark (Entity Number: &#174;)
			regExp = /&reg;/g;
			$str = $str.replace(regExp, "®");
			
			// http://www.fileformat.info/info/unicode/char/00af/index.htm
			// macron accent (Entity Number: &#175;)
			regExp = /&macr;/g;
			$str = $str.replace(regExp, "¯");
			
			// http://www.fileformat.info/info/unicode/char/00b0/index.htm
			// degree sign (Entity Number: &#176;)
			regExp = /&deg;/g;
			$str = $str.replace(regExp, "°");
			
			// http://www.fileformat.info/info/unicode/char/00b1/index.htm
			// plus or minus (Entity Number: &#177;)
			regExp = /&plusmn;/g;
			$str = $str.replace(regExp, "±");
			
			// http://www.fileformat.info/info/unicode/char/00b2/index.htm
			// superscript two (Entity Number: &#178;)
			regExp = /&sup2;/g;
			$str = $str.replace(regExp, "²");
			
			// http://www.fileformat.info/info/unicode/char/00b3/index.htm
			// superscript three (Entity Number: &#179;)
			regExp = /&sup3;/g;
			$str = $str.replace(regExp, "³");
			
			// http://www.fileformat.info/info/unicode/char/00b4/index.htm
			// acute accent (Entity Number: &#180;)
			regExp = /&acute;/g;
			$str = $str.replace(regExp, "´");
			
			// http://www.fileformat.info/info/unicode/char/00b5/index.htm
			// micro sign (Entity Number: &#181;)
			regExp = /&micro;/g;
			$str = $str.replace(regExp, "µ");
			
			// http://www.fileformat.info/info/unicode/char/00b6/index.htm
			// paragraph sign (Entity Number: &#182;)
			regExp = /&para;/g;
			$str = $str.replace(regExp, "¶");
			
			// http://www.fileformat.info/info/unicode/char/00b7/index.htm
			// middle dot (Entity Number: &#183;)
			regExp = /&middot;/g;
			$str = $str.replace(regExp, "·");
			
			// http://www.fileformat.info/info/unicode/char/00b8/index.htm
			// cedilla (Entity Number: &#184;)
			regExp = /&cedil;/g;
			$str = $str.replace(regExp, "¸");
			
			// http://www.fileformat.info/info/unicode/char/00b9/index.htm
			// superscript one (Entity Number: &#185;)
			regExp = /&sup1;/g;
			$str = $str.replace(regExp, "¹");
			
			// http://www.fileformat.info/info/unicode/char/00ba/index.htm
			// masculine ordinal (Entity Number: &#186;)
			regExp = /&ordm;/g;
			$str = $str.replace(regExp, "º");
			
			// http://www.fileformat.info/info/unicode/char/00bb/index.htm
			// right angle quote (Entity Number: &#187;)
			regExp = /&raquo;/g;
			$str = $str.replace(regExp, "»");
			
			// http://www.fileformat.info/info/unicode/char/00bc/index.htm
			// one-fourth (Entity Number: &#188;)
			regExp = /&frac14;/g;
			$str = $str.replace(regExp, "¼");
			
			// http://www.fileformat.info/info/unicode/char/00bd/index.htm
			// one-half (Entity Number: &#189;)
			regExp = /&frac12;/g;
			$str = $str.replace(regExp, "½");
			
			// http://www.fileformat.info/info/unicode/char/00be/index.htm
			// three-fourths (Entity Number: &#190;)
			regExp = /&frac34;/g;
			$str = $str.replace(regExp, "¾");
			
			// http://www.fileformat.info/info/unicode/char/00bf/index.htm
			// inverted question mark (Entity Number: &#191;)
			regExp = /&iquest;/g;
			$str = $str.replace(regExp, "¿");
			
			// http://www.fileformat.info/info/unicode/char/00d7/index.htm
			// multiplication sign (Entity Number: &#215;)
			regExp = /&times;/g;
			$str = $str.replace(regExp, "×");
			
			// http://www.fileformat.info/info/unicode/char/00f7/index.htm
			// division sign (Entity Number: &#247;)
			regExp = /&divide;/g;
			$str = $str.replace(regExp, "÷");
			
			///////////////////////////////////////////////////////////////////////
			// ISO 8859-1 Characters
			// http://www.w3schools.com/tags/ref_entities.asp
			///////////////////////////////////////////////////////////////////////
			
			// http://www.fileformat.info/info/unicode/char/00c0/index.htm
			// uppercase A, grave accent (Entity Number: &#192;)
			regExp = /&Agrave;/g;
			$str = $str.replace(regExp, "À");
			
			// http://www.fileformat.info/info/unicode/char/00c1/index.htm
			// uppercase A, acute accent (Entity Number: &#193;)
			regExp = /&Aacute;/g;
			$str = $str.replace(regExp, "Á");
			
			// http://www.fileformat.info/info/unicode/char/00c2/index.htm
			// uppercase A, circumflex accent (Entity Number: &#194;)
			regExp = /&Acirc;/g;
			$str = $str.replace(regExp, "Â");
			
			// http://www.fileformat.info/info/unicode/char/00c3/index.htm
			// uppercase A, tilde (Entity Number: &#195;)
			regExp = /&Atilde;/g;
			$str = $str.replace(regExp, "Ã");
			
			// http://www.fileformat.info/info/unicode/char/00c4/index.htm
			// uppercase A, umlaut (Entity Number: &#196;)
			regExp = /&Auml;/g;
			$str = $str.replace(regExp, "Ä");
			
			// http://www.fileformat.info/info/unicode/char/00c5/index.htm
			// uppercase A, ring (Entity Number: &#197;)
			regExp = /&Aring;/g;
			$str = $str.replace(regExp, "Å");
			
			// http://www.fileformat.info/info/unicode/char/00c6/index.htm
			// uppercase AE (Entity Number: &#198;)
			regExp = /&AElig;/g;
			$str = $str.replace(regExp, "Æ");
			
			// http://www.fileformat.info/info/unicode/char/00c7/index.htm
			// uppercase C, cedilla (Entity Number: &#199;)
			regExp = /&Ccedil;/g;
			$str = $str.replace(regExp, "Ç");
			
			// http://www.fileformat.info/info/unicode/char/00c8/index.htm
			// uppercase E, grave accent (Entity Number: &#200;)
			regExp = /&Egrave;/g;
			$str = $str.replace(regExp, "È");
			
			// http://www.fileformat.info/info/unicode/char/00c9/index.htm
			// uppercase E, acute accent (Entity Number: &#201;)
			regExp = /&Eacute;/g;
			$str = $str.replace(regExp, "É");
			
			// http://www.fileformat.info/info/unicode/char/00ca/index.htm
			// uppercase E, circumflex accent (Entity Number: &#202;)
			regExp = /&Ecirc;/g;
			$str = $str.replace(regExp, "Ê");
			
			// http://www.fileformat.info/info/unicode/char/00cb/index.htm
			// uppercase E, umlaut (Entity Number: &#203;)
			regExp = /&Euml;/g;
			$str = $str.replace(regExp, "Ë");
			
			// http://www.fileformat.info/info/unicode/char/00cc/index.htm
			// uppercase I, grave accent (Entity Number: &#204;)
			regExp = /&Igrave;/g;
			$str = $str.replace(regExp, "Ì");
			
			// http://www.fileformat.info/info/unicode/char/00cd/index.htm
			// uppercase I, acute accent (Entity Number: &#205;)
			regExp = /&Iacute;/g;
			$str = $str.replace(regExp, "Í");
			
			// http://www.fileformat.info/info/unicode/char/00ce/index.htm
			// uppercase I, circumflex accent (Entity Number: &#206;)
			regExp = /&Icirc;/g;
			$str = $str.replace(regExp, "Î");
			
			// http://www.fileformat.info/info/unicode/char/00cf/index.htm
			// uppercase I, umlaut (Entity Number: &#207;)
			regExp = /&Iuml;/g;
			$str = $str.replace(regExp, "Ï");
			
			// http://www.fileformat.info/info/unicode/char/00d0/index.htm
			// uppercase Eth, Icelandic (Entity Number: &#208;)
			regExp = /&ETH;/g;
			$str = $str.replace(regExp, "Ð");
			
			// http://www.fileformat.info/info/unicode/char/00d1/index.htm
			// uppercase N, tilde (Entity Number: &#209;)
			regExp = /&Ntilde;/g;
			$str = $str.replace(regExp, "Ñ");
			
			// http://www.fileformat.info/info/unicode/char/00d2/index.htm
			// uppercase O, grave accent (Entity Number: &#210;)
			regExp = /&Ograve;/g;
			$str = $str.replace(regExp, "Ò");
			
			// http://www.fileformat.info/info/unicode/char/00d3/index.htm
			// uppercase O, acute accent (Entity Number: &#211;)
			regExp = /&Oacute;/g;
			$str = $str.replace(regExp, "Ó");
			
			// http://www.fileformat.info/info/unicode/char/00d4/index.htm
			// uppercase O, circumflex accent (Entity Number: &#212;)
			regExp = /&Ocirc;/g;
			$str = $str.replace(regExp, "Ô");
			
			// http://www.fileformat.info/info/unicode/char/00d5/index.htm
			// uppercase O, tilde (Entity Number: &#213;)
			regExp = /&Otilde;/g;
			$str = $str.replace(regExp, "Õ");
			
			// http://www.fileformat.info/info/unicode/char/00d6/index.htm
			// uppercase O, umlaut (Entity Number: &#214;)
			regExp = /&Ouml;/g;
			$str = $str.replace(regExp, "Ö");
			
			// http://www.fileformat.info/info/unicode/char/00d8/index.htm
			// uppercase O, slash (Entity Number: &#216;)
			regExp = /&Oslash;/g;
			$str = $str.replace(regExp, "Ø");
			
			// http://www.fileformat.info/info/unicode/char/00d9/index.htm
			// uppercase U, grave accent (Entity Number: &#217;)
			regExp = /&Ugrave;/g;
			$str = $str.replace(regExp, "Ù");
			
			// http://www.fileformat.info/info/unicode/char/00da/index.htm
			// uppercase U, acute accent (Entity Number: &#218;)
			regExp = /&Uacute;/g;
			$str = $str.replace(regExp, "Ú");
			
			// http://www.fileformat.info/info/unicode/char/00db/index.htm
			// uppercase U, circumflex accent (Entity Number: &#219;)
			regExp = /&Ucirc;/g;
			$str = $str.replace(regExp, "Û");
			
			// http://www.fileformat.info/info/unicode/char/00dc/index.htm
			// uppercase U, umlaut (Entity Number: &#220;)
			regExp = /&Uuml;/g;
			$str = $str.replace(regExp, "Ü");
			
			// http://www.fileformat.info/info/unicode/char/00dd/index.htm
			// uppercase Y, acute accent (Entity Number: &#221;)
			regExp = /&Yacute;/g;
			$str = $str.replace(regExp, "Ý");
			
			// http://www.fileformat.info/info/unicode/char/00de/index.htm
			// uppercase THORN, Icelandic (Entity Number: &#222;)
			regExp = /&THORN;/g;
			$str = $str.replace(regExp, "Þ");
			
			// http://www.fileformat.info/info/unicode/char/00df/index.htm
			// lowercase sharps, German (Entity Number: &#223;)
			regExp = /&szlig;/g;
			$str = $str.replace(regExp, "ß");
			
			// http://www.fileformat.info/info/unicode/char/00e0/index.htm
			// lowercase a, grave accent (Entity Number: &#224;)
			regExp = /&agrave;/g;
			$str = $str.replace(regExp, "à");
			
			// http://www.fileformat.info/info/unicode/char/00e1/index.htm
			// lowercase a, acute accent (Entity Number: &#225;)
			regExp = /&aacute;/g;
			$str = $str.replace(regExp, "á");
			
			// http://www.fileformat.info/info/unicode/char/00e2/index.htm
			// lowercase a, circumflex accent (Entity Number: &#226;)
			regExp = /&acirc;/g;
			$str = $str.replace(regExp, "â");
			
			// http://www.fileformat.info/info/unicode/char/00e3/index.htm
			// lowercase a, tilde (Entity Number: &#227;)
			regExp = /&atilde;/g;
			$str = $str.replace(regExp, "ã");
			
			// http://www.fileformat.info/info/unicode/char/00e4/index.htm
			// lowercase a, umlaut (Entity Number: &#228;)
			regExp = /&auml;/g;
			$str = $str.replace(regExp, "ä");
			
			// http://www.fileformat.info/info/unicode/char/00e5/index.htm
			// lowercase a, ring (Entity Number: &#229;)
			regExp = /&aring;/g;
			$str = $str.replace(regExp, "å");
			
			// http://www.fileformat.info/info/unicode/char/00e6/index.htm
			// lowercase ae (Entity Number: &#230;)
			regExp = /&aelig;/g;
			$str = $str.replace(regExp, "æ");
			
			// http://www.fileformat.info/info/unicode/char/00e7/index.htm
			// lowercase c, cedilla (Entity Number: &#231;)
			regExp = /&ccedil;/g;
			$str = $str.replace(regExp, "ç");
			
			// http://www.fileformat.info/info/unicode/char/00e8/index.htm
			// lowercase e, grave accent (Entity Number: &#232;)
			regExp = /&egrave;/g;
			$str = $str.replace(regExp, "è");
			
			// http://www.fileformat.info/info/unicode/char/00e9/index.htm
			// lowercase e, acute accent (Entity Number: &#233;)
			regExp = /&eacute;/g;
			$str = $str.replace(regExp, "é");
			
			// http://www.fileformat.info/info/unicode/char/00ea/index.htm
			// lowercase e, circumflex accent (Entity Number: &#234;)
			regExp = /&ecirc;/g;
			$str = $str.replace(regExp, "ê");
			
			// http://www.fileformat.info/info/unicode/char/00eb/index.htm
			// lowercase e, umlaut (Entity Number: &#235;)
			regExp = /&euml;/g;
			$str = $str.replace(regExp, "ë");
			
			// http://www.fileformat.info/info/unicode/char/00ec/index.htm
			// lowercase i, grave accent (Entity Number: &#236;)
			regExp = /&igrave;/g;
			$str = $str.replace(regExp, "ì");
			
			// http://www.fileformat.info/info/unicode/char/00ed/index.htm
			// lowercase i, acute accent (Entity Number: &#237;)
			regExp = /&iacute;/g;
			$str = $str.replace(regExp, "í");
			
			// http://www.fileformat.info/info/unicode/char/00ee/index.htm
			// lowercase i, circumflex accent (Entity Number: &#238;)
			regExp = /&icirc;/g;
			$str = $str.replace(regExp, "î");
			
			// http://www.fileformat.info/info/unicode/char/00ef/index.htm
			// lowercase i, umlaut (Entity Number: &#239;)
			regExp = /&iuml;/g;
			$str = $str.replace(regExp, "ï");
			
			// http://www.fileformat.info/info/unicode/char/00f0/index.htm
			// lowercase eth, Icelandic (Entity Number: &#240;)
			regExp = /&eth;/g;
			$str = $str.replace(regExp, "ð");
			
			// http://www.fileformat.info/info/unicode/char/00f1/index.htm
			// lowercase n, tilde (Entity Number: &#241;)
			regExp = /&ntilde;/g;
			$str = $str.replace(regExp, "ñ");
			
			// http://www.fileformat.info/info/unicode/char/00f2/index.htm
			// lowercase o, grave accent (Entity Number: &#242;)
			regExp = /&ograve;/g;
			$str = $str.replace(regExp, "ò");
			
			// http://www.fileformat.info/info/unicode/char/00f3/index.htm
			// lowercase o, acute accent (Entity Number: &#243;)
			regExp = /&oacute;/g;
			$str = $str.replace(regExp, "ó");
			
			// http://www.fileformat.info/info/unicode/char/00f4/index.htm
			// lowercase o, circumflex accent (Entity Number: &#244;)
			regExp = /&ocirc;/g;
			$str = $str.replace(regExp, "ô");
			
			// http://www.fileformat.info/info/unicode/char/00f5/index.htm
			// lowercase o, tilde (Entity Number: &#245;)
			regExp = /&otilde;/g;
			$str = $str.replace(regExp, "õ");
			
			// http://www.fileformat.info/info/unicode/char/00f6/index.htm
			// lowercase o, umlaut (Entity Number: &#246;)
			regExp = /&ouml;/g;
			$str = $str.replace(regExp, "ö");
			
			// http://www.fileformat.info/info/unicode/char/00f8/index.htm
			// lowercase o, slash (Entity Number: &#248;)
			regExp = /&oslash;/g;
			$str = $str.replace(regExp, "ø");
			
			// http://www.fileformat.info/info/unicode/char/00f9/index.htm
			// lowercase u, grave accent (Entity Number: &#249;)
			regExp = /&ugrave;/g;
			$str = $str.replace(regExp, "ù");
			
			// http://www.fileformat.info/info/unicode/char/00fa/index.htm
			// lowercase u, acute accent (Entity Number: &#250;)
			regExp = /&uacute;/g;
			$str = $str.replace(regExp, "ú");
			
			// http://www.fileformat.info/info/unicode/char/00fb/index.htm
			// lowercase u, circumflex accent (Entity Number: &#251;)
			regExp = /&ucirc;/g;
			$str = $str.replace(regExp, "û");
			
			// http://www.fileformat.info/info/unicode/char/00fc/index.htm
			// lowercase u, umlaut (Entity Number: &#252;)
			regExp = /&uuml;/g;
			$str = $str.replace(regExp, "ü");
			
			// http://www.fileformat.info/info/unicode/char/00fd/index.htm
			// lowercase y, acute accent (Entity Number: &#253;)
			regExp = /&yacute;/g;
			$str = $str.replace(regExp, "ý");
			
			// http://www.fileformat.info/info/unicode/char/00fe/index.htm
			// lowercase thorn, Icelandic (Entity Number: &#254;)
			regExp = /&thorn;/g;
			$str = $str.replace(regExp, "þ");
			
			// http://www.fileformat.info/info/unicode/char/00ff/index.htm
			// lowercase y, umlaut (Entity Number: &#255;)
			regExp = /&yuml;/g;
			$str = $str.replace(regExp, "ÿ");
			
			///////////////////////////////////////////////////////////////////////
			//  Math Symbols Supported by HTML
			//  http://www.w3schools.com/tags/ref_symbols.asp
			///////////////////////////////////////////////////////////////////////
			
			// http://www.fileformat.info/info/unicode/char/2200/index.htm
			// for all (Entity Number: &#8704;)
			regExp = /&forall;/g;
			$str = $str.replace(regExp, "∀");
			
			// http://www.fileformat.info/info/unicode/char/2202/index.htm
			// part (Entity Number: &#8706;)
			regExp = /&part;/g;
			$str = $str.replace(regExp, "∂");
			
			// http://www.fileformat.info/info/unicode/char/2203/index.htm
			// exists (Entity Number: &#8707;)
			regExp = /&exist;/g;
			$str = $str.replace(regExp, "∃");
			
			// http://www.fileformat.info/info/unicode/char/2205/index.htm
			// empty (Entity Number: &#8709;)
			regExp = /&empty;/g;
			$str = $str.replace(regExp, "∅");
			
			// http://www.fileformat.info/info/unicode/char/2207/index.htm
			// nabla (Entity Number: &#8711;)
			regExp = /&nabla;/g;
			$str = $str.replace(regExp, "∇");
			
			// http://www.fileformat.info/info/unicode/char/2208/index.htm
			// isin (Entity Number: &#8712;)
			regExp = /&isin;/g;
			$str = $str.replace(regExp, "∈");
			
			// http://www.fileformat.info/info/unicode/char/2209/index.htm
			// notin (Entity Number: &#8713;)
			regExp = /&notin;/g;
			$str = $str.replace(regExp, "∉");
			
			// http://www.fileformat.info/info/unicode/char/220b/index.htm
			// ni (Entity Number: &#8715;)
			regExp = /&ni;/g;
			$str = $str.replace(regExp, "∋");
			
			// http://www.fileformat.info/info/unicode/char/220f/index.htm
			// prod (Entity Number: &#8719;)
			regExp = /&prod;/g;
			$str = $str.replace(regExp, "∏");
			
			// http://www.fileformat.info/info/unicode/char/2211/index.htm
			// sum (Entity Number: &#8721;)
			regExp = /&sum;/g;
			$str = $str.replace(regExp, "∑");
			
			// http://www.fileformat.info/info/unicode/char/2212/index.htm
			// minus (Entity Number: &#8722;)
			regExp = /&minus;/g;
			$str = $str.replace(regExp, "−");
			
			// http://www.fileformat.info/info/unicode/char/2217/index.htm
			// lowast (Entity Number: &#8727;)
			regExp = /&lowast;/g;
			$str = $str.replace(regExp, "∗");
			
			// http://www.fileformat.info/info/unicode/char/221a/index.htm
			// square root (Entity Number: &#8730;)
			regExp = /&radic;/g;
			$str = $str.replace(regExp, "√");
			
			// http://www.fileformat.info/info/unicode/char/221d/index.htm
			// proportional to (Entity Number: &#8733;)
			regExp = /&prop;/g;
			$str = $str.replace(regExp, "∝");
			
			// http://www.fileformat.info/info/unicode/char/221e/index.htm
			// infinity (Entity Number: &#8734;)
			regExp = /&infin;/g;
			$str = $str.replace(regExp, "∞");
			
			// http://www.fileformat.info/info/unicode/char/2220/index.htm
			// angle (Entity Number: &#8736;)
			regExp = /&ang;/g;
			$str = $str.replace(regExp, "∠");
			
			// http://www.fileformat.info/info/unicode/char/2227/index.htm
			// and (Entity Number: &#8743;)
			regExp = /&and;/g;
			$str = $str.replace(regExp, "∧");
			
			// http://www.fileformat.info/info/unicode/char/2228/index.htm
			// or (Entity Number: &#8744;)
			regExp = /&or;/g;
			$str = $str.replace(regExp, "∨");
			
			// http://www.fileformat.info/info/unicode/char/2229/index.htm
			// cap (Entity Number: &#8745;)
			regExp = /&cap;/g;
			$str = $str.replace(regExp, "∩");
			
			// http://www.fileformat.info/info/unicode/char/222a/index.htm
			// cup (Entity Number: &#8746;)
			regExp = /&cup;/g;
			$str = $str.replace(regExp, "∪");
			
			// http://www.fileformat.info/info/unicode/char/222b/index.htm
			// integral (Entity Number: &#8747;)
			regExp = /&int;/g;
			$str = $str.replace(regExp, "∫");
			
			// http://www.fileformat.info/info/unicode/char/2234/index.htm
			// therefore (Entity Number: &#8756;)
			regExp = /&there4;/g;
			$str = $str.replace(regExp, "∴");
			
			// http://www.fileformat.info/info/unicode/char/223c/index.htm
			// similar to (Entity Number: &#8764;)
			regExp = /&sim;/g;
			$str = $str.replace(regExp, "∼");
			
			// http://www.fileformat.info/info/unicode/char/2245/index.htm
			// congruent to (Entity Number: &#8773;)
			regExp = /&cong;/g;
			$str = $str.replace(regExp, "≅");
			
			// http://www.fileformat.info/info/unicode/char/2248/index.htm
			// almost equal (Entity Number: &#8776;)
			regExp = /&asymp;/g;
			$str = $str.replace(regExp, "≈");
			
			// http://www.fileformat.info/info/unicode/char/2260/index.htm
			// not equal (Entity Number: &#8800;)
			regExp = /&ne;/g;
			$str = $str.replace(regExp, "≠");
			
			// http://www.fileformat.info/info/unicode/char/2261/index.htm
			// equivalent (Entity Number: &#8801;)
			regExp = /&equiv;/g;
			$str = $str.replace(regExp, "≡");
			
			// http://www.fileformat.info/info/unicode/char/2264/index.htm
			// less or equal (Entity Number: &#8804;)
			regExp = /&le;/g;
			$str = $str.replace(regExp, "≤");
			
			// http://www.fileformat.info/info/unicode/char/2265/index.htm
			// greater or equal (Entity Number: &#8805;)
			regExp = /&ge;/g;
			$str = $str.replace(regExp, "≥");
			
			// http://www.fileformat.info/info/unicode/char/2282/index.htm
			// subset of (Entity Number: &#8834;)
			regExp = /&sub;/g;
			$str = $str.replace(regExp, "⊂");
			
			// http://www.fileformat.info/info/unicode/char/2283/index.htm
			// superset of (Entity Number: &#8835;)
			regExp = /&sup;/g;
			$str = $str.replace(regExp, "⊃");
			
			// http://www.fileformat.info/info/unicode/char/2284/index.htm
			// not subset of (Entity Number: &#8836;)
			regExp = /&nsub;/g;
			$str = $str.replace(regExp, "⊄");
			
			// http://www.fileformat.info/info/unicode/char/2286/index.htm
			// subset or equal (Entity Number: &#8838;)
			regExp = /&sube;/g;
			$str = $str.replace(regExp, "⊆");
			
			// http://www.fileformat.info/info/unicode/char/2287/index.htm
			// superset or equal (Entity Number: &#8839;)
			regExp = /&supe;/g;
			$str = $str.replace(regExp, "⊇");
			
			// http://www.fileformat.info/info/unicode/char/2295/index.htm
			// circled plus (Entity Number: &#8853;)
			regExp = /&oplus;/g;
			$str = $str.replace(regExp, "⊕");
			
			// http://www.fileformat.info/info/unicode/char/2297/index.htm
			// cirled times (Entity Number: &#8855;)
			regExp = /&otimes;/g;
			$str = $str.replace(regExp, "⊗");
			
			// http://www.fileformat.info/info/unicode/char/22a5/index.htm
			// perpendicular (Entity Number: &#8869;)
			regExp = /&perp;/g;
			$str = $str.replace(regExp, "⊥");
			
			// http://www.fileformat.info/info/unicode/char/22c5/index.htm
			// dot operator (Entity Number: &#8901;)
			regExp = /&sdot;/g;
			$str = $str.replace(regExp, "⋅");
			
			///////////////////////////////////////////////////////////////////////
			//  Greek Letters Supported by HTML
			//  http://www.w3schools.com/tags/ref_symbols.asp
			///////////////////////////////////////////////////////////////////////
			
			// http://www.fileformat.info/info/unicode/char/0391/index.htm
			// Alpha (Entity Number: &#913;)
			regExp = /&Alpha;/g;
			$str = $str.replace(regExp, "Α");
			
			// http://www.fileformat.info/info/unicode/char/0392/index.htm
			// Beta (Entity Number: &#914;)
			regExp = /&Beta;/g;
			$str = $str.replace(regExp, "Β");
			
			// http://www.fileformat.info/info/unicode/char/0393/index.htm
			// Gamma (Entity Number: &#915;)
			regExp = /&Gamma;/g;
			$str = $str.replace(regExp, "Γ");
			
			// http://www.fileformat.info/info/unicode/char/0394/index.htm
			// Delta (Entity Number: &#916;)
			regExp = /&Delta;/g;
			$str = $str.replace(regExp, "Δ");
			
			// http://www.fileformat.info/info/unicode/char/0395/index.htm
			// Epsilon (Entity Number: &#917;)
			regExp = /&Epsilon;/g;
			$str = $str.replace(regExp, "Ε");
			
			// http://www.fileformat.info/info/unicode/char/0396/index.htm
			// Zeta (Entity Number: &#918;)
			regExp = /&Zeta;/g;
			$str = $str.replace(regExp, "Ζ");
			
			// http://www.fileformat.info/info/unicode/char/0397/index.htm
			// Eta (Entity Number: &#919;)
			regExp = /&Eta;/g;
			$str = $str.replace(regExp, "Η");
			
			// http://www.fileformat.info/info/unicode/char/0398/index.htm
			// Theta (Entity Number: &#920;)
			regExp = /&Theta;/g;
			$str = $str.replace(regExp, "Θ");
			
			// http://www.fileformat.info/info/unicode/char/0399/index.htm
			// Iota (Entity Number: &#921;)
			regExp = /&Iota;/g;
			$str = $str.replace(regExp, "Ι");
			
			// http://www.fileformat.info/info/unicode/char/039a/index.htm
			// Kappa (Entity Number: &#922;)
			regExp = /&Kappa;/g;
			$str = $str.replace(regExp, "Κ");
			
			// http://www.fileformat.info/info/unicode/char/039b/index.htm
			// Lambda (Entity Number: &#923;)
			regExp = /&Lambda;/g;
			$str = $str.replace(regExp, "Λ");
			
			// http://www.fileformat.info/info/unicode/char/039c/index.htm
			// Mu (Entity Number: &#924;)
			regExp = /&Mu;/g;
			$str = $str.replace(regExp, "Μ");
			
			// http://www.fileformat.info/info/unicode/char/039d/index.htm	
			// Nu (Entity Number: &#925;)
			regExp = /&Nu;/g;
			$str = $str.replace(regExp, "Ν");
			
			// http://www.fileformat.info/info/unicode/char/039e/index.htm
			// Xi (Entity Number: &#926;)
			regExp = /&Xi;/g;
			$str = $str.replace(regExp, "Ξ");
			
			// http://www.fileformat.info/info/unicode/char/039f/index.htm
			// Omicron (Entity Number: &#927;)
			regExp = /&Omicron;/g;
			$str = $str.replace(regExp, "Ο");
			
			// http://www.fileformat.info/info/unicode/char/03a0/index.htm
			// Pi (Entity Number: &#928;)
			regExp = /&Pi;/g;
			$str = $str.replace(regExp, "Π");
			
			// http://www.fileformat.info/info/unicode/char/03a1/index.htm
			// Rho (Entity Number: &#929;)
			regExp = /&Rho;/g;
			$str = $str.replace(regExp, "Ρ");
				
			// http://www.fileformat.info/info/unicode/char/03a3/index.htm
			// Sigma (Entity Number: &#931;)
			regExp = /&Sigma;/g;
			$str = $str.replace(regExp, "Σ");
			
			// http://www.fileformat.info/info/unicode/char/03a4/index.htm
			// Tau (Entity Number: &#932;)
			regExp = /&Tau;/g;
			$str = $str.replace(regExp, "Τ");
			
			// http://www.fileformat.info/info/unicode/char/03a5/index.htm
			// Upsilon (Entity Number: &#933;)
			regExp = /&Upsilon;/g;
			$str = $str.replace(regExp, "Υ");
			
			// http://www.fileformat.info/info/unicode/char/03a6/index.htm
			// Phi (Entity Number: &#934;)
			regExp = /&Phi;/g;
			$str = $str.replace(regExp, "Φ");
			
			// http://www.fileformat.info/info/unicode/char/03a7/index.htm
			// Chi (Entity Number: &#935;)
			regExp = /&Chi;/g;
			$str = $str.replace(regExp, "Χ");
			
			// http://www.fileformat.info/info/unicode/char/03a8/index.htm
			// Psi (Entity Number: &#936;)
			regExp = /&Psi;/g;
			$str = $str.replace(regExp, "Ψ");
			
			// http://www.fileformat.info/info/unicode/char/03a9/index.htm
			// Omega (Entity Number: &#937;)
			regExp = /&Omega;/g;
			$str = $str.replace(regExp, "Ω");
						
			// http://www.fileformat.info/info/unicode/char/03b1/index.htm
			// alpha (Entity Number: &#945;)
			regExp = /&alpha;/g;
			$str = $str.replace(regExp, "α");
			
			// http://www.fileformat.info/info/unicode/char/03b2/index.htm
			// beta (Entity Number: &#946;)
			regExp = /&beta;/g;
			$str = $str.replace(regExp, "β");
			
			// http://www.fileformat.info/info/unicode/char/03b3/index.htm
			// gamma (Entity Number: &#947;)
			regExp = /&gamma;/g;
			$str = $str.replace(regExp, "γ");
			
			// http://www.fileformat.info/info/unicode/char/03b4/index.htm
			// delta (Entity Number: &#948;)
			regExp = /&delta;/g;
			$str = $str.replace(regExp, "δ");
			
			// http://www.fileformat.info/info/unicode/char/03b5/index.htm
			// epsilon (Entity Number: &#949;)
			regExp = /&epsilon;/g;
			$str = $str.replace(regExp, "ε");
			
			// http://www.fileformat.info/info/unicode/char/03b6/index.htm
			// zeta (Entity Number: &#950;)
			regExp = /&zeta;/g;
			$str = $str.replace(regExp, "ζ");
			
			// http://www.fileformat.info/info/unicode/char/03b7/index.htm
			// eta (Entity Number: &#951;)
			regExp = /&eta;/g;
			$str = $str.replace(regExp, "η");
			
			// http://www.fileformat.info/info/unicode/char/03b8/index.htm
			// theta (Entity Number: &#952;)
			regExp = /&theta;/g;
			$str = $str.replace(regExp, "θ");
			
			// http://www.fileformat.info/info/unicode/char/03b9/index.htm
			// iota (Entity Number: &#953;)
			regExp = /&iota;/g;
			$str = $str.replace(regExp, "ι");
			
			// http://www.fileformat.info/info/unicode/char/03ba/index.htm
			// kappa (Entity Number: &#954;)
			regExp = /&kappa;/g;
			$str = $str.replace(regExp, "κ");
			
			// http://www.fileformat.info/info/unicode/char/03bb/index.htm
			// lambda (Entity Number: &#955;)
			regExp = /&lambda;/g;
			$str = $str.replace(regExp, "λ");
			
			// http://www.fileformat.info/info/unicode/char/03bc/index.htm
			// mu (Entity Number: &#956;)
			regExp = /&mu;/g;
			$str = $str.replace(regExp, "μ");
			
			// http://www.fileformat.info/info/unicode/char/03bd/index.htm
			// nu (Entity Number: &#957;)
			regExp = /&nu;/g;
			$str = $str.replace(regExp, "ν");
			
			// http://www.fileformat.info/info/unicode/char/03be/index.htm
			// xi (Entity Number: &#958;)
			regExp = /&xi;/g;
			$str = $str.replace(regExp, "ξ");
			
			// http://www.fileformat.info/info/unicode/char/03bf/index.htm
			// omicron (Entity Number: &#959;)
			regExp = /&omicron;/g;
			$str = $str.replace(regExp, "ο");
			
			// http://www.fileformat.info/info/unicode/char/03c0/index.htm
			// pi (Entity Number: &#960;)
			regExp = /&pi;/g;
			$str = $str.replace(regExp, "π");
			
			// http://www.fileformat.info/info/unicode/char/03c1/index.htm
			// rho (Entity Number: &#961;)
			regExp = /&rho;/g;
			$str = $str.replace(regExp, "ρ");
			
			// http://www.fileformat.info/info/unicode/char/03c2/index.htm
			// sigmaf (Entity Number: &#962;)
			regExp = /&sigmaf;/g;
			$str = $str.replace(regExp, "ς");
			
			// http://www.fileformat.info/info/unicode/char/03c3/index.htm
			// sigma (Entity Number: &#963;)
			regExp = /&sigma;/g;
			$str = $str.replace(regExp, "σ");
			
			// http://www.fileformat.info/info/unicode/char/03c4/index.htm
			// tau (Entity Number: &#964;)
			regExp = /&tau;/g;
			$str = $str.replace(regExp, "τ");
			
			// http://www.fileformat.info/info/unicode/char/03c5/index.htm
			// upsilon (Entity Number: &#965;)
			regExp = /&upsilon;/g;
			$str = $str.replace(regExp, "υ");
			
			// http://www.fileformat.info/info/unicode/char/03c6/index.htm
			// phi (Entity Number: &#966;)
			regExp = /&phi;/g;
			$str = $str.replace(regExp, "φ");
			
			// http://www.fileformat.info/info/unicode/char/03c7/index.htm
			// chi (Entity Number: &#967;)
			regExp = /&chi;/g;
			$str = $str.replace(regExp, "χ");
			
			// http://www.fileformat.info/info/unicode/char/03c8/index.htm
			// psi (Entity Number: &#968;)
			regExp = /&psi;/g;
			$str = $str.replace(regExp, "ψ");
			
			// http://www.fileformat.info/info/unicode/char/03c9/index.htm
			// omega (Entity Number: &#969;)
			regExp = /&omega;/g;
			$str = $str.replace(regExp, "ω");
						 
			// http://www.fileformat.info/info/unicode/char/03d1/index.htm
			// theta symbol (Entity Number: &#977;)
			regExp = /&thetasym;/g;
			$str = $str.replace(regExp, "ϑ");
			
			// http://www.fileformat.info/info/unicode/char/03d2/index.htm
			// upsilon symbol (Entity Number: &#978;)
			regExp = /&upsih;/g;
			$str = $str.replace(regExp, "ϒ");
			
			// http://www.fileformat.info/info/unicode/char/03d6/index.htm
			// pi symbol (Entity Number: &#982;)
			regExp = /&piv;/g;
			$str = $str.replace(regExp, "ϖ");
			
			///////////////////////////////////////////////////////////////////////
			//  Other Entities Supported by HTML
			//  http://www.w3schools.com/tags/ref_symbols.asp
			///////////////////////////////////////////////////////////////////////
			
			// http://www.fileformat.info/info/unicode/char/0152/index.htm
			// capital ligature OE (Entity Number: &#338;)
			regExp = /&OElig;/g;
			$str = $str.replace(regExp, "Œ");
			
			// http://www.fileformat.info/info/unicode/char/0153/index.htm
			// small ligature oe (Entity Number: &#339;)
			regExp = /&oelig;/g;
			$str = $str.replace(regExp, "œ");
			
			// http://www.fileformat.info/info/unicode/char/0160/index.htm
			// capital S with caron (Entity Number: &#352;)
			regExp = /&Scaron;/g;
			$str = $str.replace(regExp, "Š");
			
			// http://www.fileformat.info/info/unicode/char/0161/index.htm
			// small S with caron (Entity Number: &#353;)
			regExp = /&scaron;/g;
			$str = $str.replace(regExp, "š");
			
			// http://www.fileformat.info/info/unicode/char/0178/index.htm
			// capital Y with diaeres (Entity Number: &#376;)
			regExp = /&Yuml;/g;
			$str = $str.replace(regExp, "Ÿ");
			
			// http://www.fileformat.info/info/unicode/char/0192/index.htm
			// f with hook (Entity Number: &#402;)
			regExp = /&fnof;/g;
			$str = $str.replace(regExp, "ƒ");
			
			// http://www.fileformat.info/info/unicode/char/02c6/index.htm
			// modifier letter circumflex accent (Entity Number: &#710;)
			regExp = /&circ;/g;
			$str = $str.replace(regExp, "ˆ");
			
			// http://www.fileformat.info/info/unicode/char/02dc/index.htm
			// small tilde (Entity Number: &#732;)
			regExp = /&tilde;/g;
			$str = $str.replace(regExp, "˜");
			
			// http://www.fileformat.info/info/unicode/char/2002/index.htm
			// en space (Entity Number: &#8194;)
			regExp = /&ensp;/g;
			$str = $str.replace(regExp, " ");
			
			// http://www.fileformat.info/info/unicode/char/2003/index.htm
			// em space (Entity Number: &#8195;)
			regExp = /&emsp;/g;
			$str = $str.replace(regExp, " ");
			
			// http://www.fileformat.info/info/unicode/char/2009/index.htm
			// thin space (Entity Number: &#8201;)
			regExp = /&thinsp;/g;
			$str = $str.replace(regExp, " ");
			
			// http://www.fileformat.info/info/unicode/char/200c/index.htm
			// zero width non-joiner (Entity Number: &#8204;)
			//regExp = /&zwnj;/g;
			//$str = $str.replace(regExp, "");
			
			// http://www.fileformat.info/info/unicode/char/200d/index.htm
			// zero width joiner (Entity Number: &#8205;)
			//regExp = /&zwj;‍/g;
			//$str = $str.replace(regExp, "");
			
			// http://www.fileformat.info/info/unicode/char/200e/index.htm
			// left-to-right mark (Entity Number: &#8206;)
			regExp = /&lrm;/g;
			$str = $str.replace(regExp, "	‎");
			
			// http://www.fileformat.info/info/unicode/char/200f/index.htm
			// right-to-left mark (Entity Number: &#8207;)
			regExp = /&rlm;‏‏/g;
			$str = $str.replace(regExp, "	‏");
			
			// http://www.fileformat.info/info/unicode/char/2013/index.htm
			// en dash (Entity Number: &#8211;)
			regExp = /&ndash;/g;
			$str = $str.replace(regExp, "–");
			
			// http://www.fileformat.info/info/unicode/char/2014/index.htm
			// em dash (Entity Number: &#8212;)
			regExp = /&mdash;/g;
			$str = $str.replace(regExp, "—");

			// http://www.fileformat.info/info/unicode/char/2018/index.htm
			// left single quote (Entity Number: &#8216;)
			regExp = /&lsquo;/g;
			$str = $str.replace(regExp, "‘");
			
			// http://www.fileformat.info/info/unicode/char/2019/index.htm
			// right single quote (Entity Number: &#8217;)
			regExp = /&rsquo;/g;
			$str = $str.replace(regExp, "’");
			
			// http://www.fileformat.info/info/unicode/char/201a/index.htm
			// single low-9 quote (Entity Number: &#8218;)
			regExp = /&sbquo;/g;
			$str = $str.replace(regExp, "‚");
			
			// http://www.fileformat.info/info/unicode/char/201c/index.htm
			// left double quote (Entity Number: &#8220;)
			regExp = /&ldquo;/g;
			$str = $str.replace(regExp, "“");
			
			// http://www.fileformat.info/info/unicode/char/201d/index.htm
			// right double quote (Entity Number: &#8221;)
			regExp = /&rdquo;/g;
			$str = $str.replace(regExp, "”");
			
			// http://www.fileformat.info/info/unicode/char/201e/index.htm
			// double low-9 quote (Entity Number: &#8222;)
			regExp = /&bdquo;/g;
			$str = $str.replace(regExp, "„");
			
			// http://www.fileformat.info/info/unicode/char/2020/index.htm
			// dagger (Entity Number: &#8224;)
			regExp = /&dagger;/g;
			$str = $str.replace(regExp, "†");
			
			// http://www.fileformat.info/info/unicode/char/2021/index.htm
			// double dagger (Entity Number: &#8225;)
			regExp = /&Dagger;/g;
			$str = $str.replace(regExp, "‡");
			
			// http://www.fileformat.info/info/unicode/char/2022/index.htm
			// bullet (Entity Number: &#8226;)
			regExp = /&bull;/g;
			$str = $str.replace(regExp, "•");
			
			// http://www.fileformat.info/info/unicode/char/2026/index.htm
			// horizontal ellipsis (Entity Number: &#8230;)
			regExp = /&hellip;/g;
			$str = $str.replace(regExp, "…");
			
			// http://www.fileformat.info/info/unicode/char/2030/index.htm
			// per mill sign (Entity Number: &#8240;)
			regExp = /&permil;/g;
			$str = $str.replace(regExp, "‰");
			
			// http://www.fileformat.info/info/unicode/char/2032/index.htm
			// minutes (Entity Number: &#8242;)
			regExp = /&prime;/g;
			$str = $str.replace(regExp, "′");

			// http://www.fileformat.info/info/unicode/char/2033/index.htm
			// seconds (Entity Number: &#8243;)
			regExp = /&Prime;/g;
			$str = $str.replace(regExp, "″");
			
			// http://www.fileformat.info/info/unicode/char/2039/index.htm
			// single left-pointing angle quote (Entity Number: &#8249;)
			regExp = /&lsaquo;/g;
			$str = $str.replace(regExp, "‹");
			
			// http://www.fileformat.info/info/unicode/char/203a/index.htm
			// single right-pointing angle quote (Entity Number: &#8250;)
			regExp = /&rsaquo;/g;
			$str = $str.replace(regExp, "›");
			
			// http://www.fileformat.info/info/unicode/char/203e/index.htm
			// overline, = spacing overscore (Entity Number: &#8254;)
			regExp = /&oline;/g;
			$str = $str.replace(regExp, "‾");
			
			// http://www.fileformat.info/info/unicode/char/20ac/index.htm
			// euro (Entity Number: &#8364;)
			regExp = /&euro;/g;
			$str = $str.replace(regExp, "€");
			
			// http://www.fileformat.info/info/unicode/char/2122/index.htm
			// trademark sign (Entity Number: &#8482;)
			regExp = /&trade;/g;
			$str = $str.replace(regExp, "™");
			
			// http://www.fileformat.info/info/unicode/char/2190/index.htm
			// leftward arrow (Entity Number: &#8592;)
			regExp = /&larr;/g;
			$str = $str.replace(regExp, "←");
			
			// http://www.fileformat.info/info/unicode/char/2191/index.htm
			// upward arrow (Entity Number: &#8593;)
			regExp = /&uarr;/g;
			$str = $str.replace(regExp, "↑");
			
			// http://www.fileformat.info/info/unicode/char/2192/index.htm
			// rightward arrow (Entity Number: &#8594;)
			regExp = /&rarr;/g;
			$str = $str.replace(regExp, "→");
			
			// http://www.fileformat.info/info/unicode/char/2193/index.htm
			// downward arrow (Entity Number: &#8595;)
			regExp = /&darr;/g;
			$str = $str.replace(regExp, "↓");
			
			// http://www.fileformat.info/info/unicode/char/2194/index.htm
			// left right arrow (Entity Number: &#8596;)
			regExp = /&harr;/g;
			$str = $str.replace(regExp, "↔");
			
			// http://www.fileformat.info/info/unicode/char/21b5/index.htm
			// carriage return arrow (Entity Number: &#8629;)
			regExp = /&crarr;/g;
			$str = $str.replace(regExp, "↵");
			
			// http://www.fileformat.info/info/unicode/char/2308/index.htm
			// left ceiling (Entity Number: &#8968;)
			regExp = /&lceil;/g;
			$str = $str.replace(regExp, "⌈");
			
			// http://www.fileformat.info/info/unicode/char/2309/index.htm
			// right ceiling (Entity Number: &#8969;)
			regExp = /&rceil;/g;
			$str = $str.replace(regExp, "⌉");
			
			// http://www.fileformat.info/info/unicode/char/230a/index.htm
			// left floor (Entity Number: &#8970;)
			regExp = /&lfloor;/g;
			$str = $str.replace(regExp, "⌊");
			
			// http://www.fileformat.info/info/unicode/char/230b/index.htm
			// right floor (Entity Number: &#8971;)
			regExp = /&rfloor;/g;
			$str = $str.replace(regExp, "⌋");
			
			// http://www.fileformat.info/info/unicode/char/25ca/index.htm
			// lozenge (Entity Number: &#9674;)
			regExp = /&loz;/g;
			$str = $str.replace(regExp, "◊");
			
			// http://www.fileformat.info/info/unicode/char/2660/index.htm
			// black spade suit (Entity Number: &#9824;)
			regExp = /&spades;/g;
			$str = $str.replace(regExp, "♠");
			
			// http://www.fileformat.info/info/unicode/char/2663/index.htm
			// black club suit (Entity Number: &#9827;)
			regExp = /&clubs;/g;
			$str = $str.replace(regExp, "♣");
			
			// http://www.fileformat.info/info/unicode/char/2665/index.htm
			// black heart suit (Entity Number: &#9829;)
			regExp = /&hearts;/g;
			$str = $str.replace(regExp, "♥");
			
			// http://www.fileformat.info/info/unicode/char/2666/index.htm
			// black diamond suit (Entity Number: &#9830;)
			regExp = /&diams;/g;
			$str = $str.replace(regExp, "♦");
			
			///////////////////////////////////////////////////////////////////////
			//  Other Named Entities
			///////////////////////////////////////////////////////////////////////
			
			// http://www.fileformat.info/info/unicode/char/002f/index.htm
			// slash (Entity Number: &#47;)
			regExp = /&frasl;/g;
			$str = $str.replace(regExp, "/");
			
			///////////////////////////////////////////////////////////////////////

			return $str;
		}
		
	}

}

// Usage Example
//
// import com.adrianparr.utils.HtmlEntityNames;
// var myString1:String = "©";
// trace(HtmlEntityNames.encode(myString1));
// var myString2:String = "&clubs;";
// trace(HtmlEntityNames.decode(myString2));
//
// OUTPUT
// &copy;
// ♣

