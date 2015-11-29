package com.napkee.exporters
{
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringUtils;
  
  import mx.controls.Image;
  import mx.core.UIComponent;
  
  public class ScratchoutParser extends BasicParser implements IControlParser
  {
    
    public function ScratchoutParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "scratchout.xml";
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
      
      if (StringUtils.isNotBlank(control.controlProperties.color)){
        cp.setPlaceHolder("color",control.controlProperties.color);
      }
      else {
        cp.setPlaceHolder("color","0x666666");
      }
      
      cp.setPlaceHolder("width",((control.@w!="-1")?control.@w:control.@measuredW));
      cp.setPlaceHolder("height",((control.@h!="-1")?control.@h:control.@measuredH));
      return cp.getParsed();
    }
    
    
  }
}