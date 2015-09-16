package com.napkee.exporters
{
	import com.napkee.utils.ColorUtils;
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import mx.controls.VRule;
	import mx.core.UIComponent;
	
	public class VRuleParser extends BasicParser implements IControlParser
	{
		
		public function VRuleParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "vrule.xml";
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
			if (control.controlProperties.color != null){
				cp.setPlaceHolder("color","#"+ColorUtils.intToHex(control.controlProperties.color));
			}
			else {
				cp.setPlaceHolder("color","#000000");
			}			
			return cp.getParsed();
		}
		
		
	}
}