package com.napkee.exporters
{
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import mx.core.UIComponent;
	
	public class CoverFlowParser extends BasicParser implements IControlParser
	{
		
		public function CoverFlowParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "coverflow.xml";
		}
		
		public override function getJsDocReady():String
		{
			var cp:ComponentParser = getBaseJsDocReady();
			cp.setPlaceHolder("width",((control.@w!="-1")?control.@w:control.@measuredW));
			cp.setPlaceHolder("height",((control.@h!="-1")?control.@h:control.@measuredH));
			
			var queryString:String = "";
			if (StringUtils.isNotBlank(control.controlProperties.src)){
				if (String(control.controlProperties.src).indexOf("http") > -1){
					queryString += "?img=" + control.controlProperties.src;
				}
			}
			if (StringUtils.isNotBlank(control.controlProperties.verticalScrollbar)){
				if (StringUtils.isNotBlank(queryString)){
					queryString += "&s=true";
				}
				else {
					queryString += "?s=true";
				}
			}
			cp.setPlaceHolder("querystring", queryString);
			return cp.getParsed();
		}
		
	}
}