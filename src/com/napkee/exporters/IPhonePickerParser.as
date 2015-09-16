package com.napkee.exporters
{
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.controls.Label;
	import mx.controls.Spacer;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.utils.StringUtil;
	
	public class IPhonePickerParser extends BasicParser implements IControlParser
	{
		
		public function IPhonePickerParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "iphonepicker.xml";
			if (StringUtils.isBlank(control.controlProperties.text)){
				control.controlProperties.text = "8%2C00%0A9%2C01%2C%20AM%0A10%2C02%2C%20PM%0A11%2C03%0A12%2C04";
			}
		}
		
		public override function getHtml():String
		{
			var cp:ComponentParser = getBaseHtml();
			
			var code:String = "";
			code += "";
			
			var maxColumns:Number = 0;
			var maxRows:Number = 0;
			
			
			var crumbs:Array = (control.controlProperties.text).split("%0A");
			maxRows = crumbs.length;
			
			var selectedIndex:Number = (maxRows<3)?maxRows-1:2;
			
			for (var i:int = 0;i<crumbs.length;i++){
				var unescaped:String = crumbs[i] as String;
				var line:String = StringUtil.trim(unescape(crumbs[i] as String));
				line = line.replace(/\\,/g, "|~escc~|");
				if (line.indexOf(",") > -1){
					var parts:Array = line.split(",");
					if (parts.length > maxColumns) maxColumns = parts.length;
				}
			}
			
			for (var i:int = 0;i<maxRows;i++){
				code += "<tr"+(i==selectedIndex?" class=\"selected\"":"")+">";
				var unescaped:String = crumbs[i] as String;
				var line:String = StringUtil.trim(unescape(crumbs[i] as String));
				line = line.replace(/\\,/g, "|~escc~|");
				if (line.indexOf(",") > -1){
					var parts:Array = line.split(",");
					for (var j:int = 0; j<parts.length; j++){
						code += "<td>"+parts[j].replace(/\|\~escc\~\|/g, ",")+"</td>";
					}
					for (var j:int = maxColumns; j>parts.length; j--){
						code += "<td>&nbsp;</td>";
					}
				}
				code += "</tr>";
			}
			for (var i:int = 5;i>maxRows;i--){
				code += "<tr>";
				for (var j:int = 0; j<maxColumns; j++){
					code += "<td>&nbsp;</td>";
				}
				code += "</tr>";
			}
			
			code += "";
			
			cp.setPlaceHolder("code",code);
			return cp.getParsed();			
		}
		
		public override function getCss():String
		{
			var cp:ComponentParser = getBaseCss();
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