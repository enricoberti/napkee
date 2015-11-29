package com.napkee.exporters
{
  import com.napkee.utils.ComponentParser;
  
  import mx.charts.CategoryAxis;
  import mx.charts.ColumnChart;
  import mx.charts.series.ColumnSeries;
  import mx.collections.ArrayCollection;
  import mx.core.UIComponent;
  
  public class ColumnChartParser extends BasicParser implements IControlParser
  {
    
    public function ColumnChartParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "columnchart.xml";
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