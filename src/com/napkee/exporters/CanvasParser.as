package com.napkee.exporters
{
  import com.napkee.utils.ColorUtils;
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringUtils;
  
  import mx.containers.Canvas;
  import mx.core.UIComponent;
  
  public class CanvasParser extends BasicParser implements IControlParser
  {
    
    public function CanvasParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "canvas.xml";
    }
    
    public override function getCss():String
    {
      var cp:ComponentParser = getBaseCss();
      if (StringUtils.isNotBlank(control.controlProperties.backgroundAlpha)){
        cp.setPlaceHolder("opacity",control.controlProperties.backgroundAlpha);
        cp.setPlaceHolder("opacityIE",(control.controlProperties.backgroundAlpha*100));
      }
      else {
        cp.setPlaceHolder("opacity","1.0");
        cp.setPlaceHolder("opacityIE","100");
      }
      if (StringUtils.isNotBlank(control.controlProperties.color)){
        cp.setPlaceHolder("color","#"+ColorUtils.intToHex(control.controlProperties.color));
      }
      else {
        cp.setPlaceHolder("color","#FFFFFF");
      }
      
      var borderColor:String = "#000";
      if (StringUtils.isNotBlank(control.controlProperties.borderColor)){
        borderColor = "#"+ColorUtils.intToHex(control.controlProperties.borderColor);
      }
      
      var borderStyle:String = "1px solid";
      
      if (StringUtils.isNotBlank(control.controlProperties.borderStyle)){
        if (control.controlProperties.borderStyle == "none"){
          borderStyle = "0px solid";
        }
        else if (control.controlProperties.borderStyle == "roundedSolid"){
          borderStyle = "1px solid";
          cp.setPlaceHolder("radius","10px");
        }
        else if (control.controlProperties.borderStyle == "roundedDotted"){
          borderStyle = "1px dashed";
          cp.setPlaceHolder("radius","10px");
        } 
        else {
          borderStyle = "1px solid";
        }
      }
      cp.setPlaceHolder("radius","0px");
      cp.setPlaceHolder("border",borderStyle+" "+borderColor);
      
      return cp.getParsed();
    }
    
    
    public override function getJsDocReady():String
    {
      var cp:ComponentParser = getBaseJsDocReady();
      cp.setPlaceHolder("clickCode",getJsSingleLink());
      return cp.getParsed();
    }
    
    
  }
}