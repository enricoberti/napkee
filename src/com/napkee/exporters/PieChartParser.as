package com.napkee.exporters
{
  import com.napkee.utils.ComponentParser;
  
  import mx.charts.PieChart;
  import mx.charts.series.PieSeries;
  import mx.collections.ArrayCollection;
  import mx.core.UIComponent;
  
  public class PieChartParser extends BasicParser implements IControlParser
  {
    
    public function PieChartParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "piechart.xml";
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