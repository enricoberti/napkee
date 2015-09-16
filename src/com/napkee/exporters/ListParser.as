package com.napkee.exporters
{
	import com.napkee.utils.ColorUtils;
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import mx.controls.List;
	import mx.core.UIComponent;
	import mx.utils.StringUtil;
	
	public class ListParser extends BasicParser implements IControlParser
	{
		
		public function ListParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "list.xml";
			if (StringUtils.isBlank(control.controlProperties.text)){
				if (control.controlProperties.child("text").length() > 0){
					control.controlProperties.text = "";
				}
				else {
					control.controlProperties.text = "Item%20One%0AItem%20Two%0AItem%20Three";
				}
			}
		}
		
		public override function getHtml():String
		{
			var cp:ComponentParser = getBaseHtml();
			var isSelect:Boolean = true;
			if (StringUtils.isNotBlank(control.controlProperties.borderStyle) && control.controlProperties.borderStyle == "none"){
				isSelect = false;
			}
			
			var code:String = "";
			if (isSelect){
				code += "<select id=\"" + getComponentID() + "\" class=\"napkeeComponent napkeeList\" size=\"2\">";
			}
			else {
				code += "<ul id=\"" + getComponentID() + "\" class=\"napkeeComponent napkeeList\">";
			}

			var crumbs:Array = (control.controlProperties.text).split("%0A");
			
			for (var i:int = 0;i<crumbs.length;i++){
				var line:String = StringUtil.trim(unescape(crumbs[i] as String));
				if (isSelect){
					code += '<option id="'+(getComponentID() + "i" + i)+'">'+StringUtils.escapeCharsAndGetHtml(line)+'</option>';
				}
				else {
					var italicRegEx:RegExp = /_(.*?)_/i;
					var startIndexItalic:int = line.search(italicRegEx);
					while (startIndexItalic>-1){
						line = line.replace(italicRegEx,"<i>" + StringUtils.escapeCharsAndGetHtml(line.substring(startIndexItalic+1,line.indexOf("_",startIndexItalic+1))) + "</i>");
						startIndexItalic = line.search(italicRegEx);
					}
					var boldRegEx:RegExp = /\Q*\E(.*?)\Q*\E/i;
					var startIndexBold:int = line.search(boldRegEx);
					while (startIndexBold>-1){
						line = line.replace(boldRegEx,"<b>" + StringUtils.escapeCharsAndGetHtml(line.substring(startIndexBold+1,line.indexOf("*",startIndexBold+1))) + "</b>");
						startIndexBold = line.search(boldRegEx);
					}
					var linkRegEx:RegExp = /\Q[\E(.*?)\Q]\E/i;
					var startIndexLink:int = line.search(linkRegEx);
					while (startIndexLink>-1){
						line = line.replace(linkRegEx,"<a href=\"#\">" + StringUtils.escapeCharsAndGetHtml(line.substring(startIndexLink+1,line.indexOf("]",startIndexLink+1))) + "</a>");
						startIndexLink = line.search(linkRegEx);
					}
				}
				code += '<li id="'+(getComponentID() + "i" + i)+'">' + line + '</li>';
			}
			
			if (isSelect){
				code += "</select>";
			}
			else {
				code += "</ul>";
			}
			
			cp.setPlaceHolder("code",code);
			return cp.getParsed();			
		}
		
		public override function getCss():String
		{
			var cp:ComponentParser = getBaseCss();
			var isSelect:Boolean = true;
			if (StringUtils.isNotBlank(control.controlProperties.borderStyle) && control.controlProperties.borderStyle == "none"){
				isSelect = false;
			}
			if (isSelect){
				cp.setPlaceHolder("additionalUL","");
			}
			else {
				var additional:String = "";				
				additional += "list-style-type: none;\n";
				additional += "margin: 0;\n";
				additional += "padding: 0;\n";
				additional += "padding-left: 5px;\n";
				cp.setPlaceHolder("additionalUL",additional);
			}
			return cp.getParsed();
		}
		
		public override function getJsDocReady():String
		{
			var cp:ComponentParser = getBaseJsDocReady();
			cp.setPlaceHolder("clickCode",getJsMultipleLinks());
			return cp.getParsed();
		}
		
	}
}