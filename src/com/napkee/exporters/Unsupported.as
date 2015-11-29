package com.napkee.exporters
{
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringConstants;
  import com.napkee.utils.StringUtils;
  
  import mx.containers.Canvas;
  import mx.controls.Label;
  import mx.core.UIComponent;
  
  public class Unsupported extends BasicParser implements IControlParser
  {
    
    public function Unsupported(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "unsupported.xml";
    }
    
    public override function getHtml():String
    {
      var cp:ComponentParser = getBaseHtml();
      control.controlProperties.align = "center";
      return cp.getParsed();			
    }
    
    
  }
}