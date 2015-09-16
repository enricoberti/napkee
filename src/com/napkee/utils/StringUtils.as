package com.napkee.utils
{
	import mx.utils.StringUtil;
	
	public class StringUtils
	{
		public function StringUtils()
		{
		}
		
		public static function isNotBlank(string:String):Boolean
		{
			return (string != null && StringUtil.trim(string) != "");
		}

		public static function isBlank(string:String):Boolean
		{
			return (string == null || StringUtil.trim(string) == "");
		}
		
		public static function getHtmlString(string:String):String
		{
			var retStr:String = "";
			for (var i:int=0; i<string.length; i++){
				if (string.charAt(i).match(/[\*_0-9a-zA-Z<\/> ]/)){
					retStr += string.charAt(i);
				}
				else if (string.charAt(i) == "&" && string.length>i+1 && string.charAt(i+1) == "#") {
					var semi:int = string.indexOf(";",i+1);
					retStr += string.substring(i,semi+1);
					i = semi;
				}
				else {
					retStr += "&#" + formatString(string.charCodeAt(i)) + ";";
				}	
			}
			return retStr;
		}
		public static function getMxmlString(string:String):String
		{
			var retStr:String = "";
			for (var i:int=0; i<string.length; i++){
				if (string.charAt(i).match(/[0-9a-zA-Z ]/)){
					retStr += string.charAt(i);
				}
				else {
					retStr += "&#" + formatString(string.charCodeAt(i)) + ";";
				}	
			}
			return retStr;
		}
		
		public static function replaceWithLtAndGt(string:String):String
		{
			var retStr:String = "";
			for (var i:int=0; i<string.length; i++){
				if (string.charAt(i).match(/\</)){
					retStr += "&lt;";
				}
				else if (string.charAt(i).match(/\>/)){
					retStr += "&gt;";
				}
				else {
					retStr += string.charAt(i);
				}	
			}
			return retStr;
		}
		
		public static function formatString(str:Object, minLength:int = 4):String
		{
			return ("000000000" + str.toString()).substr(-minLength);
		}
		
		public static function getNormalizedName(name:String):String
		{
			var newName:String = name;
			newName = newName.replace(/[\.]/gi,"");
			newName = newName.replace(/bmml/gi,"");
			newName = newName.replace(/[ ]/gi,"");
			newName = newName.replace(/[:]/gi,"");
			newName = newName.replace(/[\-]/gi,"");
			newName = newName.replace(/["]/gi,"");
			newName = newName.replace(/[']/gi,"");
			if (newName.charCodeAt(0) >= 48 && newName.charCodeAt(0) <= 57){
				newName = "n"+newName;
			} 
			return newName;
		}
		
		public static function escapeCharsAndGetHtml(line:String, includeNewLines:Boolean = false, excludeDisabled:Boolean = false):String
		{

			line = line.replace(/&/g, "&amp;");
			line = line.replace(/</g, "&lt;");
			line = line.replace(/>/g, "&gt;");
			line = line.replace(/-/g, "&ndash;");
			
			line = line.replace(/\\_/g, "|~esci~|");
			line = line.replace(/\\\*/g, "|~escb~|");
			line = line.replace(/\\\[/g, "|~escll~|");
			line = line.replace(/\\\]/g, "|~esclr~|");
			line = line.replace(/\\\-/g, "|~escd~|");
			line = line.replace(/\\&amp;/g, "|~escamp~|");
			line = line.replace(/\*\*/g, "|~escst~|");
			line = line.replace(/(^|[\( \\r\t\n;\-\*\[\]])_(([^ ].*?)[^ ]?)_/g, "$1<i>$2</i>");
			line = line.replace(/(^|[\( \\r\t\n>;\-\[\]])\*(([^ ].*?)[^ ]?)\*/g, "$1<b>$2</b>");
			line = line.replace(/(^|[\( \\r\t\n>;\-\[\]])\~(([^ ].*?)[^ ]?)\~/g, "$1<s>$2</s>");
			line = line.replace(/(^|[\( \\r\t\n>;\-])\[(([^ ].*?)[^ ]?)\]/g, "$1<u><font color=\"#085394\">$2</font></u>");
			line = line.replace(/(^|[\( \\r\t\n>;\-])\-(([^ ].*?)[^ ]?)\-/g, "$1<font color=\"#80808B\">$2</font>");
			line = line.replace(/&amp;(([^ ].*?)[^ ]?)&amp;/g, "<u>$1</u>");
			line = line.replace(/\{color:#?(.*?)\}(.*?)\{color\}/gi, "<font color=\"#$1\">$2</font>");
			line = line.replace(/\{size:#?(.*?)\}(.*?)\{size\}/gi, "<font size=\"$1\">$2</font>");
			line = line.replace(/\|\~escst\~\|/g, "**");
			line = line.replace(/\|\~esci\~\|/g, "_");
			line = line.replace(/\|\~escb\~\|/g, "*");
			line = line.replace(/\|\~escll\~\|/g, "[");
			line = line.replace(/\|\~esclr\~\|/g, "]");
			line = line.replace(/\|\~escd\~\|/g, "-");
			line = line.replace(/\|\~escamp\~\|/g, "&amp;");
			
			if (includeNewLines){
				line = line.replace(/\\(n|r)/g, "<br/>");
			}
			line = line.replace(/\n/g, "<br/>");
			
			line = HtmlEntities.encode(line);
			
//            line = line.replace(/\{color:#?(.*?)\}(.*?)\{color\}/gi, "<font color=\"#$1\">$2</font>");
//            line = line.replace(/(^|[\( \n\*\[\]])_(.*?)_/g, "$1<i>$2</i>");
//			line = line.replace(/(^|[\( \n>\[\]])\*(.*?)\*/g, "$1<b>$2</b>");    //matching > because of the previous match transformed * in <b>
//			line = line.replace(/&amp;([^ ](.*?))&amp;/g, "<u>$1</u>");
//			if (!excludeDisabled) {
//	            line = line.replace(/(^|[\( \n\*\[\]])-(.*?)-/g, "$1<span class='disabledText'>$2</span>");
//			}
//			else {
//	            line = line.replace(/(^|[\( \n\*\[\]])-(.*?)-/g, "$1 $2");
//			}
//			line = line.replace(/(^|[\( \n>])\[(.*?)\]/g, "$1<a href=\"#\">$2</a>"); //matching > because the previous match tranformed * or _ in <b> or <i>
//
//			line = line.replace(/\\\[/g, "[");
//			line = line.replace(/\\\]/g, "]");
//			line = line.replace(/\\\*/g, "*");
//			line = line.replace(/\\\_/g, "_");
//			line = line.replace(/\\\-/g, "-");
//			line = line.replace(/\\\&amp;/g, "&amp;");
			var initialSpace:int = 0;
			if (line.indexOf(" ")==0){
				var spaceIdx:int = 0;
				while (line.charAt(spaceIdx) == " "){
					spaceIdx++;
					initialSpace++;
				}
			}
			for (var isp:int = 0; isp<initialSpace-1;isp++){
				line = "&nbsp;" + line; 
			}
			return line;
		}
		
		public static function zescapeCharsAndGetHtml(line:String,includeNewLines:Boolean = false):String
		{
			if (includeNewLines){
				var newLineRegEx:RegExp = /\\r/i;
				line = line.replace(newLineRegEx, "<br/>");
			}
			var italicRegEx:RegExp = /_(.*?)_/i;
			var startIndexItalic:int = line.search(italicRegEx);
			while (startIndexItalic>-1){
				line = line.replace(italicRegEx,"<i>" + StringUtils.getHtmlString(escapeCharsAndGetHtml(line.substring(startIndexItalic+1,line.indexOf("_",startIndexItalic+1)))) + "</i>");
				startIndexItalic = line.search(italicRegEx);
			}
			var boldRegEx:RegExp = /\Q*\E(.*?)\Q*\E/i;
			var startIndexBold:int = line.search(boldRegEx);
			while (startIndexBold>-1){
				line = line.replace(boldRegEx,"<b>" + StringUtils.getHtmlString(escapeCharsAndGetHtml(line.substring(startIndexBold+1,line.indexOf("*",startIndexBold+1)))) + "</b>");
				startIndexBold = line.search(boldRegEx);
			}
			var linkRegEx:RegExp = /\Q[\E(.*?)\Q]\E/i;
			var startIndexLink:int = line.search(linkRegEx);
			while (startIndexLink>-1){
				//line = line.replace(linkRegEx,"<a href=\"#\">" + StringUtils.getHtmlString(escapeCharsAndGetHtml(convertHtmlToWikiCode(line.substring(startIndexLink+1,line.indexOf("]",startIndexLink+1))))) + "</a>");
				line = line.replace(linkRegEx,"<a href=\"#\">" + StringUtils.getHtmlString(escapeCharsAndGetHtml(line.substring(startIndexLink+1,line.indexOf("]",startIndexLink+1)))) + "</a>");
				startIndexLink = line.search(linkRegEx);
			}
			return line;
		}
		
		public static function getFlexNewLine(line:String):String
		{
			var newLineRegEx:RegExp = /\\r/i;
			line = line.replace(newLineRegEx, " ");
			return line;
		}

		public static function convertHtmlToWikiCode(line:String):String
		{
			line = line.replace(/\<b\>/gi,"*");
			line = line.replace(/\<\/b\>/gi,"*");
			return line;
		}

	}
}