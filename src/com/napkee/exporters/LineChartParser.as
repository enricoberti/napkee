package com.napkee.exporters
{
	import com.napkee.utils.ComponentParser;
	
	import mx.charts.CategoryAxis;
	import mx.charts.LineChart;
	import mx.charts.series.LineSeries;
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	import mx.graphics.SolidColorStroke;
	
	public class LineChartParser extends BasicParser implements IControlParser
	{
		
		public function LineChartParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "linechart.xml";
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