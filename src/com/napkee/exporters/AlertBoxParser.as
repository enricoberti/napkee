package com.napkee.exporters
{
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringConstants;
  import com.napkee.utils.StringUtils;
  
  import mx.containers.HBox;
  import mx.containers.VBox;
  import mx.controls.Button;
  import mx.controls.Label;
  import mx.controls.Spacer;
  import mx.core.UIComponent;
  import mx.utils.StringUtil;
  
  public class AlertBoxParser extends BasicParser implements IControlParser
  {
    
    public function AlertBoxParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "alertbox.xml";
      if (StringUtils.isBlank(control.controlProperties.text)){
        control.controlProperties.text = "Alert%0AAlert%20text%20goes%20here%0ANo%2C%20Yes";
      }
    }
    
    public override function getHtml():String
    {
      var cp:ComponentParser = getBaseHtml();
      var code:String = "";
      var crumbs:Array = (control.controlProperties.text).split("%0A");
      if (StringUtils.isNotBlank(crumbs[0])){
        code += "<h3>";
        code += unescape(crumbs[0]);
        code += "</h3>";
      }
      if (StringUtils.isNotBlank(crumbs[1])){
        code += "<h5>";
        code += unescape(crumbs[1]);
        code += "</h5>";
      }
      if (StringUtils.isNotBlank(crumbs[2])){
        code += "<div>";
        if (unescape(crumbs[2]).indexOf(",")>-1){
          var buttons:Array = unescape(crumbs[2]).split(",");
          code += '<button id="'+getComponentID() + 'Btn0">'+StringUtil.trim(buttons[0])+'</button>';
          code += '<button id="'+getComponentID() + 'Btn1">'+StringUtil.trim(buttons[1])+'</button>';
        }
        else {
          code += '<button id="'+getComponentID() + 'Btn">'+crumbs[2]+'</button>';
        }
        code += "</div>";
      }
      cp.setPlaceHolder("code",code);
      return cp.getParsed();
    }
    
    public override function getCss():String
    {
      var cp:ComponentParser = getBaseCss();
      var width:Number = new Number((control.@w!="-1")?control.@w:control.@measuredW);
      cp.setPlaceHolder("buttonWidth",Math.round((width-20)/2)+"px");
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