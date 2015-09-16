package com.napkee.exporters
{
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import mx.controls.HTML;
	import mx.core.UIComponent;
	import mx.utils.StringUtil;
	
	public class RoundButtonParser extends BasicParser implements IControlParser
	{
		
		public function RoundButtonParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "roundbutton.xml";
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
					code += StringUtils.escapeCharsAndGetHtml(line) + '<br/>';
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
				cp.setPlaceHolder("color","0xFFFFFF");
			}
			if (StringUtils.isNotBlank(control.controlProperties.color)){
				cp.setPlaceHolder("borderColor",control.controlProperties.borderColor);
			}
			else {
				cp.setPlaceHolder("borderColor","0x000000");
			}
			if (StringUtils.isNotBlank(control.controlProperties.shapeRotation)){
				cp.setPlaceHolder("rotation",control.controlProperties.shapeRotation);
			}
			else {
				cp.setPlaceHolder("rotation","0");
			}
			if (StringUtils.isNotBlank(control.controlProperties.shape)){
				if (control.controlProperties.shape == "circle"){
					cp.setPlaceHolder("shape","NapkeeCircle");
				}
				if (control.controlProperties.shape == "parallelogram"){
					cp.setPlaceHolder("shape","NapkeeParallelogram");
				}
				if (control.controlProperties.shape == "diamond"){
					cp.setPlaceHolder("shape","NapkeeDiamond");
				}
				if (control.controlProperties.shape == "star"){
					cp.setPlaceHolder("shape","NapkeeStar");
				}
				if (control.controlProperties.shape == "roundRect"){
					cp.setPlaceHolder("shape","NapkeeRoundRect");
				}
				if (control.controlProperties.shape == "rectangle"){
					cp.setPlaceHolder("shape","NapkeeRectangle");
				}
				if (control.controlProperties.shape == "triangle"){
					cp.setPlaceHolder("shape","NapkeeTriangle");
				}
				if (control.controlProperties.shape == "dottedRect"){
					cp.setPlaceHolder("shape","NapkeeDashedRect");
				}
			}
			else {
				cp.setPlaceHolder("shape","NapkeeCircle");
			}
			
			cp.setPlaceHolder("width",((control.@w!="-1")?control.@w:control.@measuredW));
			cp.setPlaceHolder("height",((control.@h!="-1")?control.@h:control.@measuredH));
			cp.setPlaceHolder("clickCode",getJsSingleLink());
			return cp.getParsed();
		}
		
		
		
	}
}