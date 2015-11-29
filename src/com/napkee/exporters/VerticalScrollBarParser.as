package com.napkee.exporters
{
  import com.napkee.utils.ComponentParser;
  
  import mx.controls.VScrollBar;
  import mx.core.UIComponent;
  
  public class VerticalScrollBarParser extends BasicParser implements IControlParser
  {
    
    public function VerticalScrollBarParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "verticalscrollbar.xml";
    }
    
    public override function getCss():String
    {
      var cp:ComponentParser = new ComponentParser(xmlTemplate.children()[1]);
      cp.setPlaceHolder("id",getComponentID());
      cp.setPlaceHolder("left",((offset !=null)?control.@x-offset.x:control.@x)+"px");
      cp.setPlaceHolder("top",((offset !=null)?control.@y-offset.y:control.@y)+"px");
      
      cp.setPlaceHolder("z",control.@zOrder);
      
      var height:Number = new Number((control.@h!="-1")?control.@h:control.@measuredH);
      cp.setPlaceHolder("height",(height-32)+"px");
      return cp.getParsed();
    }
    
    
  }
}