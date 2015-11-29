package com.napkee.exporters
{
  import com.adobe.utils.StringUtil;
  import com.napkee.utils.ColorUtils;
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringUtils;
  
  import mx.containers.Canvas;
  import mx.controls.Label;
  import mx.core.UIComponent;
  
  public class StickyNoteParser extends BasicParser implements IControlParser
  {
    
    public function StickyNoteParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "stickynote.xml";
      if (StringUtils.isBlank(control.controlProperties.text)){
        if (control.controlProperties.child("text").length() > 0){
          control.controlProperties.text = "";
        }
        else {
          control.controlProperties.text = "A comment";
        }
      }
      control.controlProperties.align = "center";
    }
    
    public override function getHtml():String
    {
      var cp:ComponentParser = getBaseHtml();
      
      
      var text:String = (control.controlProperties.text);
      
      if (text.indexOf("%0A") > -1){
        control.controlProperties.align = "left";
        var code:String = "";
        var crumbs:Array = text.split("%0A");
        for (var i:int = 0;i<crumbs.length;i++){
          var line:String = StringUtil.trim(unescape(crumbs[i] as String));
          code += StringUtils.escapeCharsAndGetHtml(line) + '<br/>';
        }
        cp.setPlaceHolder("label",code);
      }
      else {
        control.controlProperties.align = "center";
        cp.setPlaceHolder("label",StringUtils.escapeCharsAndGetHtml(unescape(text)));
      }
      
      //cp.setPlaceHolder("label",StringUtils.escapeCharsAndGetHtml(unescape(control.controlProperties.text)));
      
      return cp.getParsed();			
    }
    
    public override function getCss():String
    {
      var cp:ComponentParser = getBaseCss();
      if (StringUtils.isNotBlank(control.controlProperties.color)){
        cp.setPlaceHolder("color","#"+ColorUtils.intToHex(control.controlProperties.color));
      }
      else {
        cp.setPlaceHolder("color","#DACE5F");
      }
      
      return cp.getParsed();
    }
    
  }
}