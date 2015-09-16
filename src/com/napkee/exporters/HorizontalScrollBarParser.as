package com.napkee.exporters
{
	import com.napkee.utils.ComponentParser;
	
	import mx.controls.HScrollBar;
	import mx.core.UIComponent;
	
	public class HorizontalScrollBarParser extends BasicParser implements IControlParser
	{
		
		public function HorizontalScrollBarParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "horizontalscrollbar.xml";
		}
		
		public override function getCss():String
		{
			var cp:ComponentParser = new ComponentParser(xmlTemplate.children()[1]);
			cp.setPlaceHolder("id",getComponentID());
			cp.setPlaceHolder("left",((offset !=null)?control.@x-offset.x:control.@x)+"px");
			cp.setPlaceHolder("top",((offset !=null)?control.@y-offset.y:control.@y)+"px");

			cp.setPlaceHolder("z",control.@zOrder);
			
			var width:Number = new Number((control.@w!="-1")?control.@w:control.@measuredW);
			cp.setPlaceHolder("width",(width-32)+"px");
			return cp.getParsed();
		}
		
	}
}