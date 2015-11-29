package com.napkee.exporters
{
  import com.napkee.managers.ApplicationManager;
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringUtils;
  
  import mx.containers.HBox;
  import mx.containers.VBox;
  import mx.controls.HRule;
  import mx.controls.Image;
  import mx.controls.Label;
  import mx.controls.Spacer;
  import mx.core.ScrollPolicy;
  import mx.core.UIComponent;
  import mx.utils.StringUtil;
  
  public class MenuParser extends BasicParser implements IControlParser
  {
    
    public function MenuParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "menu.xml";
      if (StringUtils.isBlank(control.controlProperties.text)){
        control.controlProperties.text = "Open%2CCTRL+O%0AOpen%20Recent%20%3E%0A---%0Ao%20Option%20One%0AOption%20Two%0A%3D%0Ax%20Toggle%20Item%0A-Disabled%20Item-%0AExit%2CCTRL+Q";
      }
    }
    
    public override function getHtml():String
    {
      var cp:ComponentParser = getBaseHtml();
      
      var code:String = "";
      code += "<div id=\"" + getComponentID() + "\" class=\"napkeeComponent napkeeMenu dropdown clearfix\">";
      code += '<ul class="dropdown-menu" style="display: block; position: static;">';
      
      
      var crumbs:Array = (control.controlProperties.text).split("%0A");
      
      for (var i:int = 0;i<crumbs.length;i++){
        var unescaped:String = crumbs[i] as String;
        var line:String = StringUtil.trim(unescape(crumbs[i] as String));
        
        if (line == "---" || line == "="){
          code += '<li id="'+(getComponentID() + "i" + i)+'" class="divider"></li>';
        }
        else {
          var disabled:String = "";
          if (unescaped.indexOf("-") == 0) {
            disabled = "disabled";
            line = line.substr(1,line.length-2);
          }
          code += '<li id="'+(getComponentID() + "i" + i)+'" class="'+disabled+'"><a tabindex="-1" href="#">';
          // check for a selected or toggle
          if (unescaped.indexOf("o%20") == 0) {
            code += "<img src=\""+ApplicationManager.getHTMLIconsFolder()+"/napkee/DotIcon.png\" width=\"12\" height=\"12\"/> ";
            line = line.substr(2);
          }
          else if (unescaped.indexOf("x%20") == 0) {
            code += "<img src=\""+ApplicationManager.getHTMLIconsFolder()+"/napkee/CheckMarkIcon.png\" width=\"12\" height=\"12\"/> ";	
            line = line.substr(2);
          }
          else {
            code += "&nbsp;";	
          }
          
          if (line.indexOf(",") > -1){ // has shortcut
            var parts:Array = line.split(",");
            code += StringUtils.escapeCharsAndGetHtml(StringUtil.trim(parts[0]));
            code += "&nbsp;"+StringUtil.trim(parts[1])+"";
          }
          else {
            if (unescaped.indexOf("%3E") > -1){ // has children
              code += StringUtils.escapeCharsAndGetHtml(line.substr(0,line.length-1));
              code += "&nbsp;&gt;";
            }
            else { // normal
              code += StringUtils.escapeCharsAndGetHtml(line);
              //code += "<td>&nbsp;</td>";	
            }
          }
          code += '</a></li>';
        }
      }
      
      code += "</ul></div>";
      
      cp.setPlaceHolder("code",code);
      return cp.getParsed();			
    }
    
    public override function getCss():String
    {
      var cp:ComponentParser = getBaseCss();
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