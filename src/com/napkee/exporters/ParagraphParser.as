package com.napkee.exporters
{
	import com.napkee.utils.ColorUtils;
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import flash.filesystem.File;
	
	import mx.controls.Text;
	import mx.core.UIComponent;
	import mx.utils.StringUtil;
	
	public class ParagraphParser extends BasicParser implements IControlParser
	{
		
		public function ParagraphParser(controlCode:XML, offsetModifier:OffsetModifier, bmmlFile:File)
		{
			super(controlCode,offsetModifier);
            templateName = "paragraph.xml";
			if (StringUtils.isBlank(control.controlProperties.text)){
				control.controlProperties.text = "A%20paragraph%20of%20text.%0AA%20_second_%20%5Brow%5D%20of%20*text*.";
			}
			// replace macros
			var paragraphText:String = unescape(control.controlProperties.text);
			paragraphText = paragraphText.replace(/\{mockup\-path\}/g, bmmlFile.url);
			paragraphText = paragraphText.replace(/\{mockup\-name\}/g, bmmlFile.name.substr(0,bmmlFile.name.lastIndexOf(".")));
			control.controlProperties.text = escape(paragraphText);
		}
		
		public override function getHtml():String
		{
			var cp:ComponentParser = getBaseHtml();
			var code:String = "";
			var crumbs:Array = (control.controlProperties.text).split("%0A");
			for (var i:int = 0;i<crumbs.length;i++){
				var line:String = StringUtil.trim(unescape(crumbs[i] as String));
				var htmlLine:String = StringUtils.escapeCharsAndGetHtml(line);
				if (htmlLine.indexOf("*") > -1 || htmlLine.indexOf("-") > -1){ 
					htmlLine = htmlLine.replace(/^\* (.*)$/gm, "<li>$1</li>");
                	htmlLine = htmlLine.replace(/^\- (.*)$/gm, "<li>$1</li>");
                	htmlLine = htmlLine.replace(/<\/li>\n/gm, "</li>");
					code += htmlLine;
    			}
				else {
					code += htmlLine + '<br/>';
				}
			}
			cp.setPlaceHolder("code",code);
			return cp.getParsed();			
		}
		
		public override function getCss():String
		{
			var cp:ComponentParser = getBaseCss();
			if (control.controlProperties.color != null){
				cp.setPlaceHolder("color","#"+ColorUtils.intToHex(control.controlProperties.color));
			}
			else {
				cp.setPlaceHolder("color","#000000");
			}
			
			return cp.getParsed();
		}
		
		public override function getJsDocReady():String
		{
			var cp:ComponentParser = getBaseJsDocReady();
			cp.setPlaceHolder("clickCode",getJsSingleLink());
			return cp.getParsed();
		}
		
		
	}
}