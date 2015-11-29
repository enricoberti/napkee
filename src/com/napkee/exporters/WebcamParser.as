package com.napkee.exporters
{
  import com.napkee.utils.ComponentParser;
  
  import mx.core.UIComponent;
  
  public class WebcamParser extends BasicParser implements IControlParser
  {
    
    public function WebcamParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "webcam.xml";
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