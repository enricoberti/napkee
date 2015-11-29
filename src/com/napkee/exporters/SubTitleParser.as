package com.napkee.exporters
{
  import com.napkee.utils.ColorUtils;
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringUtils;
  
  import mx.controls.Label;
  import mx.core.UIComponent;
  
  public class SubTitleParser extends BasicParser implements IControlParser
  {
    
    public function SubTitleParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "subtitle.xml";
      if (StringUtils.isBlank(control.controlProperties.text)){
        control.controlProperties.text = "A%20Subtitle";
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
      var cp:ComponentParser = new ComponentParser(xmlTemplate.children()[1]);
      cp.setPlaceHolder("id",getComponentID());
      cp.setPlaceHolder("left",((offset !=null)?control.@x-offset.x:control.@x)+"px");
      cp.setPlaceHolder("top",((offset !=null)?control.@y-offset.y:control.@y)+"px");
      cp.setPlaceHolder("width",((control.@w!="-1")?control.@w:control.@measuredW)+"px");
      cp.setPlaceHolder("height",((control.@h!="-1")?control.@h:control.@measuredH)+"px");
      cp.setPlaceHolder("z",control.@zOrder);
      if (StringUtils.isNotBlank(control.controlProperties.size)){
        cp.setPlaceHolder("fontSize",control.controlProperties.size+"px");
      }
      else {
        cp.setPlaceHolder("fontSize","24px");
      }
      if (StringUtils.isNotBlank(control.controlProperties.italic) && control.controlProperties.italic == "true"){
        cp.setPlaceHolder("fontStyle","italic");
      }
      else {
        cp.setPlaceHolder("fontStyle","normal");
      }
      if (StringUtils.isNotBlank(control.controlProperties.bold) && control.controlProperties.bold == "true"){
        cp.setPlaceHolder("fontWeight","bold");
      }
      else {
        cp.setPlaceHolder("fontWeight","normal");
      }
      if (StringUtils.isNotBlank(control.controlProperties.underline) && control.controlProperties.underline == "true"){
        cp.setPlaceHolder("textDecoration","underline");
      }
      else {
        cp.setPlaceHolder("textDecoration","none");
      }
      if (control.controlProperties.color != null){
        cp.setPlaceHolder("color","#"+ColorUtils.intToHex(control.controlProperties.color));
      }
      else {
        cp.setPlaceHolder("color","#000000");
      }
      if (StringUtils.isNotBlank(control.controlProperties.align)){
        cp.setPlaceHolder("textAlign",control.controlProperties.align);
      }
      else {
        cp.setPlaceHolder("textAlign","center");
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