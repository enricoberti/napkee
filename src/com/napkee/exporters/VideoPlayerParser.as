package com.napkee.exporters
{
	import com.napkee.utils.ComponentParser;
	
	import mx.core.UIComponent;
	
	public class VideoPlayerParser extends BasicParser implements IControlParser
	{
		
		public function VideoPlayerParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "videoplayer.xml";
		}
		
		public override function getJsDocReady():String
		{
			var cp:ComponentParser = new ComponentParser(xmlTemplate.children()[2]);
			cp.setPlaceHolder("id",getComponentID());
			cp.setPlaceHolder("width",((control.@w!="-1")?control.@w:control.@measuredW));
			cp.setPlaceHolder("height",((control.@h!="-1")?control.@h:control.@measuredH));
			return cp.getParsed();
		}
		
		
	}
}