package com.napkee.exporters
{
  import com.adobe.utils.StringUtil;
  import com.napkee.managers.ApplicationManager;
  import com.napkee.utils.ColorUtils;
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringUtils;
  
  import flash.filters.DropShadowFilter;
  
  import mx.containers.HBox;
  import mx.controls.Label;
  import mx.core.UIComponent;
  
  public class TooltipParser extends BasicParser implements IControlParser
  {
    
    public function TooltipParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "tooltip.xml";
      if (StringUtils.isBlank(control.controlProperties.text)){
        control.controlProperties.text = "a tooltip";
      }
      if (StringUtils.isBlank(control.controlProperties.align)){
        control.controlProperties.align = "center";
      }
    }
    
    public override function getHtml():String
    {
      var cp:ComponentParser = getBaseHtml();
      var code:String = "";
      var crumbs:Array = (control.controlProperties.text).split("%0A");
      for (var i:int = 0;i<crumbs.length;i++){
        var line:String = StringUtil.trim(unescape(crumbs[i] as String));
        code += StringUtils.escapeCharsAndGetHtml(line);
      }
      cp.setPlaceHolder("label",code);
      
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
      if (StringUtils.isNotBlank(control.controlProperties.tooltipDirection)){
        if (control.controlProperties.tooltipDirection == "NE"){
          cp.setPlaceHolder("calcTop", (getTop() - 41) + "px");
        }
        if (control.controlProperties.tooltipDirection == "NW"){
          cp.setPlaceHolder("calcTop", (getTop() - 41) + "px");
        }
        if (control.controlProperties.tooltipDirection == "SE"){
          cp.setPlaceHolder("calcTop", (getTop() + 41) + "px");
        }
        if (control.controlProperties.tooltipDirection == "SW"){
          cp.setPlaceHolder("calcTop", (getTop() + 41) + "px");
        }
      }
      else {
        cp.setPlaceHolder("calcTop", (getTop() + 41) + "px");
      }
      return cp.getParsed();
    }
    
    public override function getJsDocReady():String
    {
      var cp:ComponentParser = getBaseJsDocReady();
      cp.setPlaceHolder("clickCode",getJsSingleLink());
      if (StringUtils.isNotBlank(control.controlProperties.tooltipDirection)){
        if (control.controlProperties.tooltipDirection == "NE"){
          cp.setPlaceHolder("placement","bottom");
        }
        if (control.controlProperties.tooltipDirection == "NW"){
          cp.setPlaceHolder("placement","bottom");
        }
        if (control.controlProperties.tooltipDirection == "SE"){
          cp.setPlaceHolder("placement","top");
        }
        if (control.controlProperties.tooltipDirection == "SW"){
          cp.setPlaceHolder("placement","top");
        }
      }
      else {
        cp.setPlaceHolder("placement","top");
      }
      
      return cp.getParsed();
    }
    
    
  }
}