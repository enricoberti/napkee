package com.napkee.exporters
{
  import com.napkee.utils.ColorUtils;
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringUtils;
  
  import mx.containers.Canvas;
  import mx.core.UIComponent;
  
  public class ModalScreenParser extends BasicParser implements IControlParser
  {
    
    public function ModalScreenParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "modalscreen.xml";
    }
    
    public override function getJsDocReady():String
    {
      var cp:ComponentParser = getBaseJsDocReady();
      cp.setPlaceHolder("clickCode",getJsSingleLink());
      return cp.getParsed();
    }
    
  }
}