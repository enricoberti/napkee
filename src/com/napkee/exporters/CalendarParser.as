package com.napkee.exporters
{
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringUtils;
  
  import mx.controls.DateChooser;
  import mx.core.UIComponent;
  import mx.formatters.DateFormatter;
  
  public class CalendarParser extends BasicParser implements IControlParser
  {
    
    public function CalendarParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "calendar.xml";
    }
    
    public override function getHtml():String
    {
      var cp:ComponentParser = getBaseHtml();
      var df:DateFormatter = new DateFormatter();
      df.formatString = "MM-DD-YYYY"
      cp.setPlaceHolder("date", df.format(new Date()));
      return cp.getParsed();			
    }
    
    
  }
}