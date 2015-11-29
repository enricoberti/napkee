package com.napkee.exporters
{
  import com.napkee.managers.ApplicationManager;
  import com.napkee.utils.ColorUtils;
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringUtils;
  
  import flash.filesystem.File;
  
  import mx.controls.Button;
  import mx.core.UIComponent;
  
  public class ButtonParser extends BasicParser implements IControlParser {
    
    public function ButtonParser(controlCode:XML,offsetModifier:OffsetModifier) {
      super(controlCode,offsetModifier, "btn");
      templateName = "button.xml";
      if (StringUtils.isBlank(control.controlProperties.text)) {
        if (control.controlProperties.child("text").length() > 0) {
          control.controlProperties.text = "";
        } else {
          control.controlProperties.text = "Button";
        }
      }
    }
    
    private function getIcon(iconStr:String):String {
      var iconComponents:Array = iconStr.split("%7C");
      var sizePx:String = "";
      var size:String = "small";
      var iconName:String = "";
      if (iconComponents.length > 1){
        iconName = iconComponents[0];
        size = iconComponents[1];
      }
      switch (size){
        case "xsmall":
          sizePx = "16";
          break;
        case "small":
          sizePx = "24";
          break;
        case "medium":
          sizePx = "32";
          break;
        case "large":
          sizePx = "48";
          break;
        default:
          sizePx = "48";
      }
      return '<img src="' + ApplicationManager.getHTMLIconsFolder()+"/napkee/"+iconName+".png" + '" width="'+sizePx+'" height="'+sizePx+'" /> ';
    }
    
    public override function getHtml():String
    {
      var cp:ComponentParser = getBaseHtml();
      
      var code:String = "";
      
      if (StringUtils.isNotBlank(control.controlProperties.icon)){
        code += "<table align=\"center\"><tr><td valign=\"middle\">";
        code += getIcon(control.controlProperties.icon);
        code += "</td><td valign=\"middle\">";
        code += StringUtils.escapeCharsAndGetHtml(unescape(control.controlProperties.text));
        code += "</td></tr></table>";
      }
      else {
        code += StringUtils.escapeCharsAndGetHtml(unescape(control.controlProperties.text));
      }
      cp.setPlaceHolder("code",code);
      
      if (StringUtils.isNotBlank(control.controlProperties.state) && control.controlProperties.state == "disabled"){
        cp.setPlaceHolder("disabled","disabled");
      }
      else {
        cp.removeAttribute("disabled");
      }
      return cp.getParsed();			
    }
    
    public override function getCss():String
    {
      var cp:ComponentParser = getBaseCss();
      if (StringUtils.isNotBlank(control.controlProperties.color)){
        //				cp.setPlaceHolder("color","#"+ColorUtils.intToHex(control.controlProperties.color));
        cp.setPlaceHolder("color","#"+ColorUtils.getLabelColor(control.controlProperties.color));
      }
      else {
        cp.removeCssAttribute("color");
      }
      var buttonHeight:Number = new Number(((control.@h!="-1")?control.@h:control.@measuredH));
      if (buttonHeight == 28){
        cp.setPlaceHolder("buttonHeight","");
      }
      else {
        cp.setPlaceHolder("buttonHeight","height: "+buttonHeight+"px;");
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