package com.napkee.exporters
{
	import com.napkee.utils.ColorUtils;
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import mx.controls.ColorPicker;
	import mx.core.UIComponent;
	
	public class ColorPickerParser extends BasicParser implements IControlParser
	{
		
		public function ColorPickerParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "colorpicker.xml";
		}
		
		public override function getHtml():String
		{
			var cp:ComponentParser = getBaseHtml();
			if (control.controlProperties.color != null){
				cp.setPlaceHolder("color","#"+ColorUtils.intToHex(control.controlProperties.color));
			}
			else {
				cp.setPlaceHolder("color","#FFCC00");
			}
			return cp.getParsed();			
		}
		
		public override function getJsDocReady():String
		{
			var cp:ComponentParser = getBaseJsDocReady();
			if (control.controlProperties.color != null){
				cp.setPlaceHolder("color","#"+ColorUtils.intToHex(control.controlProperties.color));
			}
			else {
				cp.setPlaceHolder("color","#FFCC00");
			}
			return cp.getParsed();
		}
		

	}
}