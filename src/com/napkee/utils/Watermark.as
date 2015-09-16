package com.napkee.utils
{
	import com.napkee.exporters.BasicParser;
	import com.napkee.exporters.IControlParser;
	import com.napkee.exporters.OffsetModifier;
	
	public class Watermark extends BasicParser implements IControlParser
	{
		
		public function Watermark(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "watermark.xml";
		}
		
		public override function getHtml():String
		{
			var cp:ComponentParser = new ComponentParser(xmlTemplate.children()[0]);
			cp.setPlaceHolder("id",PREFIX + "w" + control.@controlID);
			return cp.getParsed();			
		}
		
		public override function getCss():String
		{
			var cp:ComponentParser = new ComponentParser(xmlTemplate.children()[1]);
			cp.setPlaceHolder("id",PREFIX + "w" + control.@controlID);
			cp.setPlaceHolder("left",((offset !=null)?control.@x-offset.x:control.@x)+"px");
			cp.setPlaceHolder("top",((offset !=null)?control.@y-offset.y:control.@y)+"px");
			cp.setPlaceHolder("fontSize",(Math.floor(Math.random()*20) + 8)+"px");
			cp.setPlaceHolder("color","#000000");
			return cp.getParsed();
		}
		
	}
}