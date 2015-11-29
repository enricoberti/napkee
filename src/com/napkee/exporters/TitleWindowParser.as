package com.napkee.exporters
{
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringUtils;
  
  import mx.containers.TitleWindow;
  import mx.core.UIComponent;
  
  public class TitleWindowParser extends BasicParser implements IControlParser
  {
    
    public function TitleWindowParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "titlewindow.xml";
      if (StringUtils.isBlank(control.controlProperties.text)){
        if (control.controlProperties.child("text").length() > 0){
          control.controlProperties.text = "";
        }
        else {
          control.controlProperties.text = "Window%20Name";
        }
      }
    }
    
    public override function getHtml():String
    {
      var cp:ComponentParser = getBaseHtml();
      cp.setPlaceHolder("title",StringUtils.escapeCharsAndGetHtml(unescape(control.controlProperties.text)));
      var footerHeight:int = 30;
      if (StringUtils.isNotBlank(control.controlProperties.bottomheight)){
        footerHeight = (control.controlProperties.bottomheight*1)-2;
        if (control.controlProperties.bottomheight == "0"){
          cp.setPlaceHolder("footerDisplay","hide");
        }
      }
      cp.setPlaceHolder("footerDisplay","");
      cp.setPlaceHolder("bodyStyle", "max-height:" + (getHeight() - footerHeight - 80) + "px;min-height:" + (getHeight() - footerHeight - 80) + "px");
      return cp.getParsed();			
    }
    
    public override function getCss():String
    {
      var cp:ComponentParser = getBaseCss();
      
      if (StringUtils.isNotBlank(control.controlProperties.topheight)){
        cp.setPlaceHolder("headerHeight",((control.controlProperties.topheight*1)-2)+"px");
      }
      else {
        cp.setPlaceHolder("headerHeight","15px");
      }
      if (StringUtils.isNotBlank(control.controlProperties.bottomheight)){
        cp.setPlaceHolder("footerHeight",((control.controlProperties.bottomheight*1)-2)+"px");
        if (control.controlProperties.bottomheight == "0"){
          cp.setPlaceHolder("footerDisplay","hide");
        }
      }
      else {
        cp.setPlaceHolder("footerHeight","15px");
      }
      cp.setPlaceHolder("footerDisplay","");
      
      return cp.getParsed();
    }
    
    public override function getJsDocReady():String
    {
      var cp:ComponentParser = getBaseJsDocReady();
      if (StringUtils.isNotBlank(control.controlProperties.dragger)){
        var code:String = "";
        if (control.controlProperties.dragger == "true"){
          code = "$(\"#"+(getComponentID())+"\").resizable();";
        }
        cp.setPlaceHolder("code",code);
      }
      else {
        cp.setPlaceHolder("code","");
      }
      return cp.getParsed();
    }
    
    
  }
}