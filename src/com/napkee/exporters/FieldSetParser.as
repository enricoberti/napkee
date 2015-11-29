package com.napkee.exporters
{
  import com.napkee.utils.ColorUtils;
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringUtils;
  
  import mx.core.UIComponent;
  
  public class FieldSetParser extends BasicParser implements IControlParser
  {
    
    public function FieldSetParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "fieldset.xml";
      if (StringUtils.isBlank(control.controlProperties.text)){
        if (control.controlProperties.child("text").length() > 0){
          control.controlProperties.text = "";
        }
        else {
          control.controlProperties.text = "Group%20Name";
        }
      }
    }
    
    public override function getHtml():String
    {
      var cp:ComponentParser = getBaseHtml();
      cp.setPlaceHolder("label",StringUtils.escapeCharsAndGetHtml(unescape(control.controlProperties.text)));
      return cp.getParsed();			
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
      return cp.getParsed();
    }
    
  }
}