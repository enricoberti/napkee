package com.napkee.exporters
{
	import com.napkee.utils.ColorUtils;
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import mx.controls.Button;
	import mx.core.UIComponent;
	
	public class PointyButtonParser extends BasicParser implements IControlParser
	{
		
		public function PointyButtonParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "pointybutton.xml";
			if (StringUtils.isBlank(control.controlProperties.text)){
				if (control.controlProperties.child("text").length() > 0){
					control.controlProperties.text = "";
				}
				else {
					control.controlProperties.text = "Button";
				}
			}
			if (StringUtils.isBlank(control.controlProperties.direction)){
				control.controlProperties.direction = "right";
			}
		}
		
		private var endSum:Number = 0;
		public override function getHtml():String
		{
			var cp:ComponentParser = getBaseHtml();
			
			cp.setPlaceHolder("label",StringUtils.escapeCharsAndGetHtml(unescape(control.controlProperties.text)));
			var disabledStr:String = "";
			if (StringUtils.isNotBlank(control.controlProperties.state) && control.controlProperties.state == "disabled"){
				disabledStr = "Disabled";
			}
			if (control.controlProperties.direction == "left"){
				cp.setPlaceHolder("leftImage","images/iphone/buttonLeftTip"+disabledStr+".png");
				cp.setPlaceHolder("leftWidth","16");
				cp.setPlaceHolder("rightImage","images/iphone/buttonRightEnd"+disabledStr+".png");
				cp.setPlaceHolder("rightWidth","6");
				endSum = 22;
			}
			else if (control.controlProperties.direction == "right"){
				cp.setPlaceHolder("rightImage","images/iphone/buttonRightTip"+disabledStr+".png");
				cp.setPlaceHolder("rightWidth","16");
				cp.setPlaceHolder("leftImage","images/iphone/buttonLeftEnd"+disabledStr+".png");
				cp.setPlaceHolder("leftWidth","6");
				endSum = 22;
			}
			else {
				cp.setPlaceHolder("rightImage","images/iphone/buttonRightEnd"+disabledStr+".png");
				cp.setPlaceHolder("rightWidth","6");
				cp.setPlaceHolder("leftImage","images/iphone/buttonLeftEnd"+disabledStr+".png");
				cp.setPlaceHolder("leftWidth","6");
				endSum = 12;
			}
			
			return cp.getParsed();			
		}
		
		public override function getCss():String
		{
			var cp:ComponentParser = getBaseCss();
			if (StringUtils.isNotBlank(control.controlProperties.color)){
				cp.setPlaceHolder("color","#"+ColorUtils.intToHex(control.controlProperties.color));
				cp.setPlaceHolder("labelColor","#"+ColorUtils.getLabelColor(control.controlProperties.color));
			}
			else {
				cp.setPlaceHolder("color","#FFFFFF");
				cp.setPlaceHolder("labelColor","#000000");
			}
			
			var disabledStr:String = "";
			var fontColor:String = "#FFFFFF";
			if (StringUtils.isNotBlank(control.controlProperties.state) && control.controlProperties.state == "disabled"){
				disabledStr = "Disabled";
				fontColor = "#CCCCCC";
			}
			cp.setPlaceHolder("backgroundImage","images/iphone/buttonBackground"+disabledStr+".png");
			cp.setPlaceHolder("fontColor",fontColor);
			
			cp.setPlaceHolder("maincellWidth", (getWidth()-endSum)+"px");
			
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