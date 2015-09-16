package com.napkee.exporters
{
	import com.napkee.utils.ColorUtils;
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import mx.controls.TextArea;
	import mx.core.UIComponent;
	
	public class TextAreaParser extends BasicParser implements IControlParser
	{
		
		public function TextAreaParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "textarea.xml";
			if (StringUtils.isBlank(control.controlProperties.text)){
				if (control.controlProperties.child("text").length() > 0){
					control.controlProperties.text = "";
				}
				else {
					control.controlProperties.text = "Some%20text%0AA%20second%20line%20of%20text";
				}
			}
		}
		
		public override function getHtml():String
		{
			var cp:ComponentParser = getBaseHtml();
			cp.setPlaceHolder("label",StringUtils.escapeCharsAndGetHtml(unescape(control.controlProperties.text),false,true));
			if ((StringUtils.isNotBlank(control.controlProperties.state) && control.controlProperties.state == "disabled") || (unescape(control.controlProperties.text).charAt(0) == "-" && unescape(control.controlProperties.text).charAt(unescape(control.controlProperties.text).length-1)=="-")){
				cp.setPlaceHolder("disabled","disabled");
			}
			else {
				cp.removeAttribute("disabled");
			}
			return cp.getParsed();			
		}
		
		public override function getCss():String
		{
			var cp:ComponentParser = getBaseCss();
			if (StringUtils.isNotBlank(control.controlProperties.backgroundAlpha)){
				cp.setPlaceHolder("opacity",control.controlProperties.backgroundAlpha);
				cp.setPlaceHolder("opacityIE",(control.controlProperties.backgroundAlpha*100));
			}
			else {
				cp.setPlaceHolder("opacity","1.0");
				cp.setPlaceHolder("opacityIE","100");
			}
			if (StringUtils.isNotBlank(control.controlProperties.color)){
				cp.setPlaceHolder("color","#"+ColorUtils.intToHex(control.controlProperties.color));
				cp.setPlaceHolder("labelColor","#"+ColorUtils.getLabelColor(control.controlProperties.color));
			}
			else {
				cp.setPlaceHolder("color","#FFFFFF");
				cp.setPlaceHolder("labelColor","#000000");
			}
			return cp.getParsed();
		}
		
		
	}
}