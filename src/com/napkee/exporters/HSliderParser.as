package com.napkee.exporters
{
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import mx.controls.HSlider;
	import mx.core.UIComponent;
	
	public class HSliderParser extends BasicParser implements IControlParser
	{
		
		public function HSliderParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "hslider.xml";
		}
		
		public override function getJsDocReady():String
		{
			var cp:ComponentParser = getBaseJsDocReady();
			if (StringUtils.isNotBlank(control.controlProperties.value)){
				cp.setPlaceHolder("value",control.controlProperties.value);
			}
			else {
				cp.setPlaceHolder("value","0");
			}
			if (StringUtils.isNotBlank(control.controlProperties.state)){
				if (control.controlProperties.state == "disabled"){
					cp.setPlaceHolder("enabled","disable");
				}
				else {
					cp.setPlaceHolder("enabled","enable");
				}
			}
			else {
				cp.setPlaceHolder("enabled","enable");
			}
			return cp.getParsed();
		}
		
	}
}