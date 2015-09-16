package com.napkee.exporters
{
	import com.napkee.utils.ColorUtils;
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import mx.containers.Canvas;
	import mx.containers.HDividedBox;
	import mx.core.UIComponent;
	
	public class HSplitterParser extends BasicParser implements IControlParser
	{
		
		public function HSplitterParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "hsplitter.xml";
		}
		
	}
}