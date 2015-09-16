package com.napkee.exporters
{
	import com.napkee.managers.ApplicationManager;
	import com.napkee.utils.ComponentParser;
	
	import flash.events.Event;
	
	import mx.controls.HTML;
	import mx.core.UIComponent;
	
	public class MapParser extends BasicParser implements IControlParser
	{
		
		public function MapParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "map.xml";
		}
		
		public override function getHtml():String
		{
			var cp:ComponentParser = getBaseHtml();
			cp.setPlaceHolder("location",ApplicationManager.getMapLocation());
			return cp.getParsed();			
		}
		
		
	}
}