package com.napkee.exporters
{
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import mx.controls.NumericStepper;
	import mx.core.UIComponent;
	
	public class NumericStepperParser extends BasicParser implements IControlParser
	{
		
		public function NumericStepperParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "numericstepper.xml";
			if (StringUtils.isBlank(control.controlProperties.text)){
				if (control.controlProperties.child("text").length() > 0){
					control.controlProperties.text = "";
				}
				else {
					control.controlProperties.text = "3";
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
			var cp:ComponentParser = new ComponentParser(xmlTemplate.children()[1]);
			cp.setPlaceHolder("id",getComponentID());
			cp.setPlaceHolder("left",((offset !=null)?control.@x-offset.x:control.@x)+"px");
			cp.setPlaceHolder("top",((offset !=null)?control.@y-offset.y:control.@y)+"px");
			cp.setPlaceHolder("width",((control.@w!="-1")?control.@w:control.@measuredW)+"px");
			cp.setPlaceHolder("widthInput",(new Number(((control.@w!="-1")?control.@w:control.@measuredW))-29)+"px");
			cp.setPlaceHolder("height",((control.@h!="-1")?control.@h:control.@measuredH)+"px");
			cp.setPlaceHolder("z",control.@zOrder);
			return cp.getParsed();
		}
		
		
		public override function getJsDocReady():String
		{
			var cp:ComponentParser = getBaseJsDocReady();
			if (StringUtils.isNotBlank(control.controlProperties.text)){
				cp.setPlaceHolder("value",control.controlProperties.text);
			}
			else {
				cp.setPlaceHolder("value","3");
			}
			
			if (StringUtils.isNotBlank(control.controlProperties.state)){
				if (control.controlProperties.state == "disabled"){
					cp.setPlaceHolder("enable","disable");
				}
				else {
					cp.setPlaceHolder("enable","enable");
				}
			}
			else {
				cp.setPlaceHolder("enable","enable");
			}
			
			return cp.getParsed();
		}
		

	}
}