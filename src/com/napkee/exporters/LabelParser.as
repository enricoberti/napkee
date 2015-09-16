package com.napkee.exporters
{
	import com.napkee.managers.ApplicationManager;
	import com.napkee.utils.ColorUtils;
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import flash.filesystem.File;
	
	import mx.controls.Label;
	import mx.core.UIComponent;
	
	
	public class LabelParser extends BasicParser implements IControlParser
	{
		public function LabelParser(controlCode:XML, offsetModifier:OffsetModifier, bmmlFile:File)
		{
			super(controlCode,offsetModifier);
            templateName = "label.xml";
			if (StringUtils.isBlank(control.controlProperties.text)){
				control.controlProperties.text = "Some text";
			}
			// replace macros
			var labelText:String = unescape(control.controlProperties.text);
			labelText = labelText.replace(/\{mockup\-path\}/g, bmmlFile.url);
			labelText = labelText.replace(/\{mockup\-name\}/g, bmmlFile.name.substr(0,bmmlFile.name.lastIndexOf(".")));
			control.controlProperties.text = escape(labelText);
		}
		
		public override function getHtml():String
		{
			var cp:ComponentParser = getBaseHtml();
			cp.setPlaceHolder("label",StringUtils.escapeCharsAndGetHtml(unescape(control.controlProperties.text)));
			if (control.controlProperties.textOrientation != null){
				if (control.controlProperties.textOrientation == "up"){
					cp.setPlaceHolder("orientationClass","napkeeLabelUp");
				}
				else if (control.controlProperties.textOrientation == "down"){
					cp.setPlaceHolder("orientationClass","napkeeLabelDown");
				}
				else if (control.controlProperties.textOrientation == "slanted"){
					cp.setPlaceHolder("orientationClass","napkeeLabelSlanted");
				}
				else {
					cp.setPlaceHolder("orientationClass","");
				}
			}
			else {
				cp.setPlaceHolder("orientationClass","");
			}
			return cp.getParsed();			
		}
		
		public override function getCss():String
		{
			var cp:ComponentParser = new ComponentParser(xmlTemplate.children()[1]);
			cp.setPlaceHolder("iconsFolder",ApplicationManager.getHTMLIconsFolder());
			cp.setPlaceHolder("id",getComponentID());
			var top:Number = ((offset !=null)?control.@y-offset.y:control.@y)*1;
			var left:Number = ((offset !=null)?control.@x-offset.x:control.@x)*1;
			var width:String = (getWidth()*1.1)+"px";
			var height:String = ((control.@h!="-1")?control.@h:control.@measuredH)+"px";
			
			if (control.controlProperties.textOrientation != null){
				if (control.controlProperties.textOrientation == "up"){
					cp.setPlaceHolder("width",height);
					cp.setPlaceHolder("height",width);
					cp.setPlaceHolder("top",(((getWidth()*1.1)/2)+top)+"px");
					cp.setPlaceHolder("left",(left-((getWidth()*1.1)/2))+"px");
				}
				else if (control.controlProperties.textOrientation == "down"){
					cp.setPlaceHolder("width",height);
					cp.setPlaceHolder("height",width);
					cp.setPlaceHolder("top",(((getWidth()*1.1)/2)+top)+"px");
					cp.setPlaceHolder("left",(left-((getWidth()*1.1)/2))+"px");
				}
				else if (control.controlProperties.textOrientation == "slanted"){
					cp.setPlaceHolder("width",width);
					cp.setPlaceHolder("height",height);
					cp.setPlaceHolder("top",(getHeight()/3+top)+"px");
					cp.setPlaceHolder("left",(left)+"px");
				}
				else {
					cp.setPlaceHolder("width",width);
					cp.setPlaceHolder("height",height);
					cp.setPlaceHolder("top",(top)+"px");
					cp.setPlaceHolder("left",(left)+"px");
				}
			}
			else {
				cp.setPlaceHolder("width",width);
				cp.setPlaceHolder("height",height);
				cp.setPlaceHolder("top",(top)+"px");
				cp.setPlaceHolder("left",(left)+"px");
			}
			
			cp.setPlaceHolder("z",control.@zOrder);
			if (StringUtils.isNotBlank(control.controlProperties.size)){
				cp.setPlaceHolder("fontSize",control.controlProperties.size+"px");
			}
			else {
				cp.setPlaceHolder("fontSize", "14px");
			}
			if (StringUtils.isNotBlank(control.controlProperties.italic) && control.controlProperties.italic == "true"){
				cp.setPlaceHolder("fontStyle","italic");
			}
			else {
				cp.setPlaceHolder("fontStyle","normal");
			}
			if (StringUtils.isNotBlank(control.controlProperties.bold) && control.controlProperties.bold == "true"){
				cp.setPlaceHolder("fontWeight","bold");
			}
			else {
				cp.setPlaceHolder("fontWeight","normal");
			}
			if (StringUtils.isNotBlank(control.controlProperties.underline) && control.controlProperties.underline == "true"){
				cp.setPlaceHolder("textDecoration","underline");
			}
			else {
				cp.setPlaceHolder("textDecoration","none");
			}
			if (StringUtils.isNotBlank(control.controlProperties.align)){
				cp.setPlaceHolder("textAlign",control.controlProperties.align);
			}
			else {
				cp.setPlaceHolder("textAlign","left");
			}
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