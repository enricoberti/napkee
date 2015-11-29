package com.napkee.exporters
{
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringUtils;
  
  import mx.controls.LinkButton;
  import mx.core.UIComponent;
  
  public class LinkParser extends BasicParser implements IControlParser
  {
    
    public function LinkParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "link.xml";
      if (StringUtils.isBlank(control.controlProperties.text)){
        control.controlProperties.text = "a link";
      }
      if (StringUtils.isBlank(control.controlProperties.underline)){
        control.controlProperties.underline = "true";
      }
    }
    
    public override function getHtml():String
    {
      var cp:ComponentParser = getBaseHtml();
      //cp.setPlaceHolder("label",StringUtils.getHtmlString(unescape(control.controlProperties.text)));
      cp.setPlaceHolder("label",StringUtils.escapeCharsAndGetHtml(unescape(control.controlProperties.text)));
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