package com.napkee.exporters
{
  import com.napkee.utils.ColorUtils;
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringUtils;
  
  import mx.containers.Canvas;
  import mx.containers.ViewStack;
  import mx.controls.LinkBar;
  import mx.core.UIComponent;
  import mx.utils.StringUtil;
  
  public class LinkBarParser extends BasicParser implements IControlParser
  {
    
    public function LinkBarParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "linkbar.xml";
      if (StringUtils.isBlank(control.controlProperties.text)){
        control.controlProperties.text = "Home%2C%20Products%2C%20Company%2C%20Blog";
      }
    }
    
    public override function getHtml():String
    {
      var cp:ComponentParser = getBaseHtml();
      
      var code:String = "";
      escapeCommas();
      var crumbs:Array = (control.controlProperties.text).split("%2C");
      for (var i:int = 0;i<crumbs.length;i++){
        var link:String = StringUtil.trim(unescape(crumbs[i] as String));
        if (StringUtils.isNotBlank(link)){
          var extraChar:String = "";
          if (i<crumbs.length-1){
            extraChar = "<li>|</li>";
          }
          code += '<li><a href="#" id="'+getComponentID()+'i'+i+'">'+StringUtils.escapeCharsAndGetHtml(link)+'</a></li>' + extraChar;
          /*code += "<a href=\"#\">";
          code += "<span id=\""+(getComponentID() + "i" + i)+"\">" + StringUtils.getHtmlString(link) + "</span>";
          code += "</a>";
          if (i<crumbs.length-1){
          code += " | ";
          }
          */
        }				
      }
      cp.setPlaceHolder("code",code);
      return cp.getParsed();			
    }
    
    public override function getCss():String
    {
      var cp:ComponentParser = getBaseCss();
      if (control.controlProperties.color != null){
        cp.setPlaceHolder("color","#"+ColorUtils.intToHex(control.controlProperties.color));
      }
      else {
        cp.setPlaceHolder("color","#000000");
      }
      
      return cp.getParsed();
    }
    
    public override function getJsDocReady():String
    {
      var cp:ComponentParser = getBaseJsDocReady();
      cp.setPlaceHolder("clickCode",getJsMultipleLinks());
      return cp.getParsed();
    }
    
    
  }
}