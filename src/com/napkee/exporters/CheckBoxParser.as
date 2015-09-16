package com.napkee.exporters
{
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import mx.controls.CheckBox;
	import mx.core.UIComponent;
	
	public class CheckBoxParser extends BasicParser implements IControlParser
	{
		
		public function CheckBoxParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "checkbox.xml";
			if (StringUtils.isBlank(control.controlProperties.text)){
				if (control.controlProperties.child("text").length() > 0){
					control.controlProperties.text = "";
				}
				else {
					control.controlProperties.text = "Checkbox";
				}
			}
		}
		
		public override function getHtml():String
		{
			var cp:ComponentParser = getBaseHtml();
			cp.setPlaceHolder("label",StringUtils.escapeCharsAndGetHtml(unescape(control.controlProperties.text)));
			
			if (StringUtils.isNotBlank(control.controlProperties.state)){
				if (control.controlProperties.state == "up"){
					cp.removeAttribute("disabled");
					cp.removeAttribute("checked");
				}
				if (control.controlProperties.state == "selected"){
					cp.setPlaceHolder("checked","checked");
					cp.removeAttribute("disabled");
				}
				if (control.controlProperties.state == "disabled"){
					cp.setPlaceHolder("disabled","disabled");
					cp.removeAttribute("checked");
				}
				if (control.controlProperties.state == "disabledSelected"){
					cp.setPlaceHolder("disabled","disabled");
					cp.setPlaceHolder("checked","checked");
				}
			}
			else {
				cp.removeAttribute("disabled");
				cp.removeAttribute("checked");
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