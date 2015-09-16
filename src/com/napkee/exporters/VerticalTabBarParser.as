package com.napkee.exporters
{
	import com.napkee.utils.ColorUtils;
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import mx.containers.Canvas;
	import mx.core.UIComponent;
	import mx.utils.StringUtil;
	
	public class VerticalTabBarParser extends BasicParser implements IControlParser
	{
		
		public function VerticalTabBarParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "verticaltabbar.xml";
			if (StringUtils.isBlank(control.controlProperties.text)){
				if (control.controlProperties.child("text").length() > 0){
					control.controlProperties.text = "";
				}
				else {
					control.controlProperties.text = "First%20Tab%0ASecond%20Tab%0AThird%20Tab%0AFourth%20Tab";
				}
			}
		}
		
		public override function getHtml():String
		{
			var cp:ComponentParser = getBaseHtml();
			var selectedIndex:int = StringUtils.isNotBlank(control.controlProperties.selectedIndex)?control.controlProperties.selectedIndex:-1;
			
			escapeCommas();
			var crumbs:Array = (control.controlProperties.text).split("%0A");
			
			var code:String = "";
			var tabsWhere:String = "tabs-left";
			if (control.controlProperties.position == "right"){
				tabsWhere = "tabs-right";
			}
			code += "<div id=\""+getComponentID()+"\" class=\"napkeeComponent napkeeTabbar tabbable "+ tabsWhere+"\">\n";
			
			
			var menuCode:String = "";
			var divsCode:String = "";
			
			menuCode += '\t<ul class="nav nav-tabs">\n';
			for (var i:int = 0;i<crumbs.length;i++){
				var link:String = StringUtil.trim(unescape(crumbs[i] as String));
				var active:String = "";
				if (selectedIndex > -1 && selectedIndex == i){
					active = " class=\"active\"";
				}
				menuCode += '\t\t\t\t<li'+active+'><a id="'+getComponentID()+'i'+i+'" href="#'+getComponentID()+'-'+i+'" data-toggle="tab">'+StringUtils.escapeCharsAndGetHtml(link)+'</a></li>\n';
			}
			menuCode += "\t</ul>\n";
			
			
			divsCode += '\t<div class="tab-content">\n';
			for (var i:int = 0;i<crumbs.length;i++){
				var active:String = "";
				if (selectedIndex > -1 && selectedIndex == i){
					active = " active";
				}
				divsCode += '\t\t\t\t<div id="'+getComponentID()+'-'+i+'" class="tab-pane'+active+'">${children'+i+'}</div>\n';
			}
			divsCode += "\t</div>\n";
			
			code += menuCode;
			code += divsCode;
			
			code += "</div>\n";
			
			cp.setPlaceHolder("code",code);
			return cp.getParsed();			
		}
		
		public override function getCss():String
		{
			var cp:ComponentParser = getBaseCss();
			if (StringUtils.isNotBlank(control.controlProperties.backgroundAlpha)){
				cp.setPlaceHolder("opacity",control.controlProperties.backgroundAlpha);
				cp.setPlaceHolder("opacityIE",(control.controlProperties.backgroundAlpha*100));
			}
			else {
				cp.setPlaceHolder("opacity","1.0");
				cp.setPlaceHolder("opacityIE","100");
			}
			if (StringUtils.isNotBlank(control.controlProperties.color)){
				cp.setPlaceHolder("color","#"+ColorUtils.intToHex(control.controlProperties.color));
			}
			else {
				cp.setPlaceHolder("color","#FFFFFF");
			}
			return cp.getParsed();
		}
		
		public override function getJsDocReady():String
		{
			var cp:ComponentParser = getBaseJsDocReady();
			cp.setPlaceHolder("selected",((StringUtils.isNotBlank(control.controlProperties.selectedIndex))?control.controlProperties.selectedIndex:0));
			cp.setPlaceHolder("position",((StringUtils.isNotBlank(control.controlProperties.position))?control.controlProperties.position:"left"));
        	cp.setPlaceHolder("width",((control.@w!="-1")?control.@w:control.@measuredW));
			cp.setPlaceHolder("height",((control.@h!="-1")?control.@h:control.@measuredH));
			cp.setPlaceHolder("clickCode",getJsMultipleLinks());
			return cp.getParsed();
		}
		
	}
}