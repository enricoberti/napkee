package com.napkee.exporters
{
  import com.adobe.utils.StringUtil;
  import com.napkee.managers.ApplicationManager;
  import com.napkee.utils.ColorUtils;
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringUtils;
  
  import mx.controls.Image;
  import mx.controls.Text;
  import mx.core.UIComponent;
  
  public class VCurlyParser extends BasicParser implements IControlParser
  {
    
    public function VCurlyParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "vcurly.xml";
      if (StringUtils.isBlank(control.controlProperties.text)){
        control.controlProperties.text = "A%20paragraph%20of%20text.%0AA%20second%20row%20of%20text.";
      }
    }
    
    public override function getHtml():String
    {
      var cp:ComponentParser = getBaseHtml();
      var code:String = "";
      var crumbs:Array = (control.controlProperties.text).split("%0A");
      for (var i:int = 0;i<crumbs.length;i++){
        var line:String = StringUtil.trim(unescape(crumbs[i] as String));
        code += StringUtils.escapeCharsAndGetHtml(line) + '<br/>';
      }
      cp.setPlaceHolder("label",code);
      if (StringUtils.isNotBlank(control.controlProperties.direction)){
        if (control.controlProperties.direction == "right"){
          cp.setPlaceHolder("bottomImage","<img src=\"images/vcurlyleft.png\" width=\"24\" style=\"height:"+ ((control.@h!="-1")?control.@h:control.@measuredH)+"px\" />");
          cp.setPlaceHolder("bottomCell","Visible");
          cp.setPlaceHolder("topImage","&nbsp;");
          cp.setPlaceHolder("topCell","Invisible");
        }
        if (control.controlProperties.direction == "left"){
          cp.setPlaceHolder("bottomImage","&nbsp;");
          cp.setPlaceHolder("bottomCell","Invisible");
          cp.setPlaceHolder("topImage","<img src=\"images/vcurlyright.png\" width=\"24\" style=\"height:"+ ((control.@h!="-1")?control.@h:control.@measuredH)+"px\" />");
          cp.setPlaceHolder("topCell","Visible");
        }
      }
      else {
        cp.setPlaceHolder("bottomImage","&nbsp;");
        cp.setPlaceHolder("bottomCell","Invisible");
        cp.setPlaceHolder("topImage","<img src=\"images/vcurlyright.png\" width=\"24\" style=\"height:"+ ((control.@h!="-1")?control.@h:control.@measuredH)+"px\" />");
        cp.setPlaceHolder("topCell","Visible");
      }
      
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
      cp.setPlaceHolder("clickCode",getJsSingleLink());
      return cp.getParsed();
    }
    
    
  }
}