package com.napkee.exporters
{
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringConstants;
	
	import mx.charts.BarChart;
	import mx.charts.CategoryAxis;
	import mx.charts.series.BarSeries;
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	
	public class BarChartParser extends BasicParser implements IControlParser
	{
		
		public function BarChartParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "barchart.xml";
		}
		
		public override function getJsDocReady():String
		{
			var cp:ComponentParser = getBaseJsDocReady();
			cp.setPlaceHolder("width",((control.@w!="-1")?control.@w:control.@measuredW));
			cp.setPlaceHolder("height",((control.@h!="-1")?control.@h:control.@measuredH));
			return cp.getParsed();
		}

	}
}