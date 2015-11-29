package com.napkee.exporters
{
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringUtils;
  
  import mx.controls.MenuBar;
  import mx.core.UIComponent;
  import mx.utils.StringUtil;
  
  public class MenuBarParser extends BasicParser implements IControlParser
  {
    
    public function MenuBarParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "menubar.xml";
      if (StringUtils.isBlank(control.controlProperties.text)){
        if (control.controlProperties.child("text").length() > 0){
          control.controlProperties.text = "%20%2C...";
        }
        else {
          control.controlProperties.text = "File%2CEdit%2CView%2CHelp";
        }
      }
    }
    
    public override function getHtml():String
    {
      var cp:ComponentParser = getBaseHtml();
      var selectedIndex:int = StringUtils.isNotBlank(control.controlProperties.selectedIndex)?control.controlProperties.selectedIndex:0;
      
      var code:String = "";
      var crumbs:Array = (control.controlProperties.text).split("%2C");
      for (var i:int = 0;i<crumbs.length;i++){
        var link:String = StringUtil.trim(unescape(crumbs[i] as String));
        code +="<li id=\""+(getComponentID() + "i" + i) + "\"";
        if (selectedIndex == i){
          code += " class=\"active\"";
        }
        code += "><a href=\"#\">"+ link + "</a></li>";
      }
      cp.setPlaceHolder("code",code);
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