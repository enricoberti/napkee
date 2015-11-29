package com.napkee.exporters
{
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringUtils;
  
  import mx.containers.Canvas;
  import mx.containers.HBox;
  import mx.controls.HTML;
  import mx.controls.Text;
  import mx.core.UIComponent;
  import mx.utils.StringUtil;
  
  public class ArrowParser extends BasicParser implements IControlParser
  {
    
    public function ArrowParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "arrow.xml";
      if (StringUtils.isBlank(control.controlProperties.text)){
        control.controlProperties.text = "";
      }
    }
    
    public override function getHtml():String
    {
      var cp:ComponentParser = getBaseHtml();
      
      if (StringUtils.isNotBlank(unescape(control.controlProperties.text))){
        var code:String = "";
        var crumbs:Array = (control.controlProperties.text).split("%0A");
        for (var i:int = 0;i<crumbs.length;i++){
          var line:String = StringUtil.trim(unescape(crumbs[i] as String));
          code += StringUtils.escapeCharsAndGetHtml(line,true) + '<br/>';
        }
        cp.setPlaceHolder("label",code);
      }
      else {
        cp.setPlaceHolder("label","");
      }
      
      
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
      cp.setPlaceHolder("zplus",new Number(control.@zOrder)+1);
      if (StringUtils.isNotBlank(unescape(control.controlProperties.text))){
        cp.setPlaceHolder("display","inline-table");
      }
      else {
        cp.setPlaceHolder("display","none");
      }
      if (StringUtils.isNotBlank(control.controlProperties.backgroundAlpha)){
        cp.setPlaceHolder("opacity",control.controlProperties.backgroundAlpha);
        cp.setPlaceHolder("opacityIE",(control.controlProperties.backgroundAlpha*100));
      }
      else {
        cp.setPlaceHolder("opacity","1.0");
        cp.setPlaceHolder("opacityIE","100");
      }
      return cp.getParsed();
    }
    
    public override function getJsDocReady():String
    {
      var cp:ComponentParser = getBaseJsDocReady();
      
      if (StringUtils.isNotBlank(control.controlProperties.color)){
        cp.setPlaceHolder("color",control.controlProperties.color);
      }
      else {
        cp.setPlaceHolder("color","0x000000");
      }
      if (StringUtils.isNotBlank(control.controlProperties.leftArrow)){
        if (control.controlProperties.leftArrow == "true"){
          cp.setPlaceHolder("leftArrow","y");
        }
        if (control.controlProperties.leftArrow == "false"){
          cp.setPlaceHolder("leftArrow","n");
        }
      }
      else {
        cp.setPlaceHolder("leftArrow","y");
      }
      if (StringUtils.isNotBlank(control.controlProperties.rightArrow)){
        if (control.controlProperties.rightArrow == "true"){
          cp.setPlaceHolder("rightArrow","y");
        }
        if (control.controlProperties.rightArrow == "false"){
          cp.setPlaceHolder("rightArrow","n");
        }
      }
      else {
        cp.setPlaceHolder("rightArrow","y");
      }
      
      if (StringUtils.isNotBlank(control.controlProperties.direction)){
        if (control.controlProperties.direction == "top"){
          cp.setPlaceHolder("direction","Top");
        }
        if (control.controlProperties.direction == "bottom"){
          cp.setPlaceHolder("direction","Bottom");
        }
      }
      else {
        cp.setPlaceHolder("direction","Top");
      }
      if (StringUtils.isNotBlank(control.controlProperties.curvature)){
        if (control.controlProperties.curvature == "0"){
          cp.setPlaceHolder("curvature","Zero");
        }
        if (control.controlProperties.curvature == "1"){
          cp.setPlaceHolder("curvature","Plus");
        }
        if (control.controlProperties.curvature == "-1"){
          cp.setPlaceHolder("curvature","Minus");
        }
      }
      else {
        cp.setPlaceHolder("curvature","Plus");
      }
      
      cp.setPlaceHolder("width",((control.@w!="-1")?control.@w:control.@measuredW));
      cp.setPlaceHolder("height",((control.@h!="-1")?control.@h:control.@measuredH));
      return cp.getParsed();
    }
    
  }
}