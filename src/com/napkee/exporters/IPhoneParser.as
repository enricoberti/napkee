package com.napkee.exporters
{
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import mx.controls.Image;
	import mx.core.UIComponent;
	
	public class IPhoneParser extends BasicParser implements IControlParser
	{

		public function IPhoneParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "iphone.xml";
			var orientation:String = "portrait";
			if (StringUtils.isNotBlank(unescape(control.controlProperties.orientation))){
				orientation = unescape(control.controlProperties.orientation);
			}
			if (orientation == "portrait"){
				if (control.@w == -1){
					control.@w = 282;
				}
				if (control.@h == -1){
					control.@h = 510;
				}
			}
			else {
				if (control.@w == -1){
					control.@w = 510;
				}
				if (control.@h == -1){
					control.@h = 282;
				}
			}
			var originalRatio:Number = 0.55294;
			var boxW:Number = Number(control.@w);
			var boxH:Number = Number(control.@h);
			var boxCenterX:Number = Number(control.@x) + boxW/2;
			var boxCenterY:Number = Number(control.@y) + boxH/2;
			
			var zoomFactor:Number = 1;
			if (orientation == "portrait"){
				if (getWidth()/getHeight() > originalRatio){
					zoomFactor = getHeight()/510;
				}
				else {
					zoomFactor = getWidth()/282;
				}
				control.@w = 275*zoomFactor;
				control.@h = 539*zoomFactor;
				control.@x = boxCenterX - (control.@w/2) - zoomFactor; 
				control.@y = boxCenterY - (control.@h/2);
			}
			else {
				if (getHeight()/getWidth() > originalRatio){
					zoomFactor = getWidth()/510;
				}
				else {
					zoomFactor = getHeight()/282;
				}
				control.@w = 539*zoomFactor;
				control.@h = 275*zoomFactor;
				control.@x = boxCenterX - (control.@w/2) - zoomFactor; 
				control.@y = boxCenterY - (control.@h/2) + (5*zoomFactor);
			}
			
		}
		
		public override function getHtml():String
		{
			var cp:ComponentParser = getBaseHtml();
			
			var folder:String = "topbar";
			if (StringUtils.isNotBlank(unescape(control.controlProperties.topBar))){
				if (unescape(control.controlProperties.topBar) == "false"){
					folder = "notopbar";
				}
			}
			var pattern:String = "allWhite";
			if (StringUtils.isNotBlank(unescape(control.controlProperties.bgPattern))){
				pattern = unescape(control.controlProperties.bgPattern);
			}
			
			var orientation:String = "portrait";
			if (StringUtils.isNotBlank(unescape(control.controlProperties.orientation))){
				orientation = unescape(control.controlProperties.orientation);
			}
			
			var transparent:String = "";
			if (StringUtils.isNotBlank(unescape(control.controlProperties.bgTransparent))){
				transparent = unescape(control.controlProperties.bgTransparent);
				if (transparent == "true"){
					transparent = "_transparent";
				}
			}
			cp.setPlaceHolder("source","images/iphone/"+folder+"_"+orientation+"/iphone4_"+pattern+transparent+".png");

			return cp.getParsed();			
		}

		
	}
}