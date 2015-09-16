package com.napkee.exporters
{
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import flash.events.MouseEvent;
	
	import mx.containers.Canvas;
	import mx.controls.Image;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.effects.Move;
	
	public class SwitchParser extends BasicParser implements IControlParser
	{
		
		private var iPhoneSwitchMove:Move = new Move();
		
		public function SwitchParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "switch.xml";
		}
		
		public override function getJsDocReady():String
		{
			var cp:ComponentParser = getBaseJsDocReady();
			if (StringUtils.isNotBlank(control.controlProperties.onOffState)){
				cp.setPlaceHolder("state",control.controlProperties.onOffState);
			}
			else {
				cp.setPlaceHolder("state","on");
			}
			cp.setPlaceHolder("clickCode",getJsSingleLink());
			return cp.getParsed();
		}
		
		
		
	}
}