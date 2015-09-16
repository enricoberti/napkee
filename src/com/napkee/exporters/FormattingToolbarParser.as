package com.napkee.exporters
{
	import com.napkee.utils.ColorUtils;
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import mx.core.UIComponent;
	
	public class FormattingToolbarParser extends BasicParser implements IControlParser
	{
		
		public function FormattingToolbarParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "formattingtoolbar.xml";
		}
		
		
	
		
	}
}