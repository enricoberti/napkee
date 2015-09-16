package com.napkee.exporters
{
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import mx.controls.DateField;
	import mx.core.UIComponent;
	
	public class DateChooserParser extends BasicParser implements IControlParser
	{
		
		public function DateChooserParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "datechooser.xml";
		}
		
		public override function getHtml():String
		{
			var cp:ComponentParser = getBaseHtml();
			cp.setPlaceHolder("value", StringUtils.getHtmlString(unescape(control.controlProperties.text)));
			return cp.getParsed();			
		}
		
		public override function getCss():String
		{
			var cp:ComponentParser = new ComponentParser(xmlTemplate.children()[1]);
			cp.setPlaceHolder("id",getComponentID());
			cp.setPlaceHolder("left",((offset !=null)?control.@x-offset.x:control.@x)+"px");
			cp.setPlaceHolder("top",((offset !=null)?control.@y-offset.y:control.@y)+"px");
			cp.setPlaceHolder("width",(new Number(((control.@w!="-1")?control.@w:control.@measuredW))-18)+"px");
			cp.setPlaceHolder("height",((control.@h!="-1")?control.@h:control.@measuredH)+"px");
			cp.setPlaceHolder("z",control.@zOrder);
			return cp.getParsed();
		}
		
	}
}