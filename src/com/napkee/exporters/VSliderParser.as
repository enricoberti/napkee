package com.napkee.exporters
{
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import mx.controls.VSlider;
	import mx.core.UIComponent;
	
	public class VSliderParser extends BasicParser implements IControlParser
	{
		
		public function VSliderParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "vslider.xml";
		}
		
		public override function getJsDocReady():String
		{
			var cp:ComponentParser = getBaseJsDocReady();
			if (StringUtils.isNotBlank(control.controlProperties.value)){
				cp.setPlaceHolder("value",(100-control.controlProperties.value));
			}
			else {
				cp.setPlaceHolder("value","100");
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