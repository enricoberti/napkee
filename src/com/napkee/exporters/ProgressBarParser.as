package com.napkee.exporters
{
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import mx.controls.ProgressBar;
	import mx.core.UIComponent;
	
	public class ProgressBarParser extends BasicParser implements IControlParser
	{
		
		public function ProgressBarParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "progressbar.xml";
		}
		
		public override function getHtml():String
		{
			var cp:ComponentParser = getBaseHtml();
			if (StringUtils.isNotBlank(control.controlProperties.indeterminate) && control.controlProperties.indeterminate == "true"){
				cp.setPlaceHolder("value","100");
				cp.setPlaceHolder("additional", "progress-striped active");
			}
			
			if (StringUtils.isNotBlank(control.controlProperties.scrollBarValue)){
				cp.setPlaceHolder("value",control.controlProperties.scrollBarValue);
			}
			else {
				cp.setPlaceHolder("value","50");
			}
			cp.setPlaceHolder("additional", "");
			
			return cp.getParsed();
		}
		

	}
}