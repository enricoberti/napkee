package com.napkee.exporters
{
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringUtils;
  
  import mx.controls.Image;
  import mx.core.UIComponent;
  
  public class IPhoneKeyboardParser extends BasicParser implements IControlParser
  {
    
    private var orientation:String = "portrait";
    public function IPhoneKeyboardParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "iphonekeyboard.xml";
      if (StringUtils.isNotBlank(unescape(control.controlProperties.orientation))){
        orientation = unescape(control.controlProperties.orientation);
      }
      var originalRatio:Number = 1.4187;
      if (orientation == "landscape"){
        originalRatio = 3.0175;
      }
      var newHeight:Number;
      var newWidth:Number;
      if (getWidth()/getHeight() > originalRatio){
        newHeight = getHeight();
        newWidth = newHeight * originalRatio;
        control.@x = Number(control.@x) + ((getWidth() - newWidth)/2)
      }
      else {
        newWidth = getWidth();
        newHeight = newWidth / originalRatio;
        control.@y = Number(control.@y) + ((getHeight() - newHeight)/2)
      }
      control.@w = newWidth;
      control.@h = newHeight;
    }
    
    public override function getHtml():String
    {
      var cp:ComponentParser = getBaseHtml();
      
      cp.setPlaceHolder("source","images/iphone/iphoneKeyboard"+orientation+".png");
      
      return cp.getParsed();			
    }
    
  }
}