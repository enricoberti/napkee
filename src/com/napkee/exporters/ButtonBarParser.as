package com.napkee.exporters
{
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import mx.collections.ArrayCollection;
	import mx.controls.ToggleButtonBar;
	import mx.core.UIComponent;
	import mx.utils.StringUtil;
	
	public class ButtonBarParser extends BasicParser implements IControlParser
	{
		
		public function ButtonBarParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "buttonbar.xml";
			if (StringUtils.isBlank(control.controlProperties.text)){
				if (control.controlProperties.child("text").length() > 0){
					control.controlProperties.text = "%20%2C...";
				}
				else {
					control.controlProperties.text = "One%2C%20Two%2C%20Three";
				}
			}
		}
		
		public override function getHtml():String
		{
			var cp:ComponentParser = getBaseHtml();
			
			var code:String = "";
			
			var selectedIndex:int = (StringUtils.isNotBlank(control.controlProperties.selectedIndex)?control.controlProperties.selectedIndex:0)
			escapeCommas();
			var crumbs:Array = (control.controlProperties.text).split("%2C");
			for (var i:int = 0;i<crumbs.length;i++){
				var cssClass:String = " class=\"btn"
				if (i==selectedIndex){
					cssClass += " active"
				}
				cssClass += "\"";
				var link:String = StringUtil.trim(unescape(crumbs[i] as String));
				code += '<a'+ cssClass +' href="#" id="'+getComponentID()+'i'+i+'">'+StringUtils.escapeCharsAndGetHtml(link)+'</a>';
			}
			cp.setPlaceHolder("code",code);
			return cp.getParsed();			
		}
		
		public override function getCss():String
		{
			var cp:ComponentParser = getBaseCss();
			
			if (StringUtils.isNotBlank(unescape(control.controlProperties.text))){
				cp.setPlaceHolder("display","inline-table");
			}
			else {
				cp.setPlaceHolder("display","none");
			}
			
			var buttonHeight:Number = new Number(((control.@h!="-1")?control.@h:control.@measuredH));
			if (buttonHeight == 29){
				cp.setPlaceHolder("buttonHeight","");
				cp.setPlaceHolder("lineHeight","");
			}
			else {
				cp.setPlaceHolder("buttonHeight","height:"+buttonHeight+"px;");
				cp.setPlaceHolder("lineHeight","line-height:"+buttonHeight+"px;");
			}
			
			var crumbs:Array = (control.controlProperties.text).split("%2C");
			if (control.@w!="-1"){
				var buttonWidth:Number = Math.floor(new Number(((control.@w!="-1")?control.@w:control.@measuredW))/crumbs.length)-26;
				cp.setPlaceHolder("buttonWidth","width:"+buttonWidth+"px;");
			}
			else {
				cp.setPlaceHolder("buttonWidth","");
			}
			
			
			return cp.getParsed();
		}
		
		public override function getJsDocReady():String
		{
			var cp:ComponentParser = getBaseJsDocReady();
			cp.setPlaceHolder("clickCode",getJsMultipleLinks());
			return cp.getParsed();
		}
		
	
		
	}
}