package com.napkee.exporters
{
  import com.napkee.utils.ComponentParser;
  
  import mx.controls.Button;
  import mx.core.UIComponent;
  
  public class HelpButtonParser extends BasicParser implements IControlParser
  {
    
    public function HelpButtonParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "helpbutton.xml";
    }
    
    public override function getJsDocReady():String
    {
      var cp:ComponentParser = getBaseJsDocReady();
      cp.setPlaceHolder("clickCode",getJsSingleLink());
      return cp.getParsed();
    }
    
  }
}