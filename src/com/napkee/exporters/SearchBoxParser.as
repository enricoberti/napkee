package com.napkee.exporters
{
	import com.napkee.utils.ColorUtils;
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import mx.containers.Canvas;
	import mx.controls.Image;
	import mx.controls.TextInput;
	import mx.core.UIComponent;
	
	public class SearchBoxParser extends BasicParser implements IControlParser
	{
		
		public function SearchBoxParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "searchbox.xml";
			if (StringUtils.isBlank(control.controlProperties.text)){
				if (control.controlProperties.child("text").length() > 0){
					control.controlProperties.text = "";
				}
				else {
					control.controlProperties.text = "search";
				}
			}
		}
		
		public override function getHtml():String
		{
			var cp:ComponentParser = getBaseHtml();
			cp.setPlaceHolder("label",StringUtils.escapeCharsAndGetHtml(unescape(control.controlProperties.text)));
			
			if (StringUtils.isNotBlank(control.controlProperties.state) && control.controlProperties.state == "disabled"){
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
			cp.setPlaceHolder("newWidth",((control.@w!="-1")?control.@w:control.@measuredW)-20+"px");
			cp.setPlaceHolder("newHeight",((control.@h!="-1")?control.@h:control.@measuredH)-4+"px");
			if (StringUtils.isNotBlank(control.controlProperties.color)){
				cp.setPlaceHolder("color","#"+ColorUtils.intToHex(control.controlProperties.color));
			}
			else {
				cp.removeCssAttribute("color");
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