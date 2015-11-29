package com.napkee.exporters
{
  import com.napkee.utils.ComponentParser;
  
  import mx.controls.Image;
  import mx.core.UIComponent;
  
  public class RedXParser extends BasicParser implements IControlParser
  {
    
    public function RedXParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "redx.xml";
    }
    
    public override function getHtml():String
    {
      var cp:ComponentParser = getBaseHtml();
      return cp.getParsed();			
    }
    
    public override function getCss():String
    {
      var cp:ComponentParser = getBaseCss();
      return cp.getParsed();
    }
    
    public override function getJsDocReady():String
    {
      var cp:ComponentParser = getBaseJsDocReady();
      return cp.getParsed();
    }
    
  }
}