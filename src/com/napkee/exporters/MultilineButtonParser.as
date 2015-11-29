package com.napkee.exporters
{
  import com.napkee.utils.ColorUtils;
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringUtils;
  
  import mx.core.UIComponent;
  
  public class MultilineButtonParser extends BasicParser implements IControlParser
  {
    
    public function MultilineButtonParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier, "btn");
      templateName = "multilinebutton.xml";
      if (StringUtils.isBlank(control.controlProperties.text)){
        control.controlProperties.text = "Multiline%20Button%0ASecond%20line%20of%20text";
      }
    }
    
    public override function getHtml():String
    {
      var cp:ComponentParser = getBaseHtml();
      var code:String = "<span>";
      var crumbs:Array = (control.controlProperties.text).split("%0A");
      
      if (StringUtils.isNotBlank(crumbs[0])){
        code += unescape(crumbs[0]);
        code += "<br/>";
      }
      if (StringUtils.isNotBlank(crumbs[1])){
        code += "<small>";
        code += unescape(crumbs[1]);
        code += "</small>";
      }
      cp.setPlaceHolder("code",code);
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
        cp.setPlaceHolder("labelColor","#"+ColorUtils.getLabelColor(control.controlProperties.color));
      }
      else {
        cp.setPlaceHolder("color","#FFFFFF");
        cp.setPlaceHolder("labelColor","#000000");
      }
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