package com.napkee.exporters
{
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import flash.events.MouseEvent;
	
	import mx.containers.Canvas;
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.controls.Spacer;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.effects.Move;
	import mx.utils.StringUtil;
	
	public class IPhoneMenuParser extends BasicParser implements IControlParser
	{
		
		public function IPhoneMenuParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "iphonemenu.xml";
			if (StringUtils.isBlank(control.controlProperties.text)){
				control.controlProperties.text = "A%20Simple%20Label%0A+%20Add%20and%20sub-menu%2C%20%3E%0A-%20Delete%5Cr%28Cancel%29%0ATwo%20Labels%5C%2C%20and%20a%20comma%2C%20yup%0Av%20A%20Checkmark%2C%20%28%3E%29%0A*%20A%20Bullet%2C%20%3D%0A_%20Space%20for%20an%20icon%0A__%20Space%20for%20a%20big%20icon%0AOn%20button%2C%20ON%0AOff%20button%2C%20OFF%0A%20%0Av%20An%20empty%20row%2C%20%28above%29";
			}
		}
		
		private var jsCode:String = "";
		
		public override function getHtml():String
		{
			var cp:ComponentParser = getBaseHtml();
			
			
			var code:String = "";
			code += "<tr><td>";
			
			
			var crumbs:Array = (control.controlProperties.text).split("%0A");
			
			for (var i:int = 0;i<crumbs.length;i++){
				var unescaped:String = crumbs[i] as String;
				var line:String = StringUtil.trim(unescape(crumbs[i] as String));
				line = line.replace(/\\,/g, "|~escc~|");
				code += '<table'+(i==crumbs.length-1?' class="lastTable"':'')+'><tr>';
				if (line.indexOf(",") > -1){
					var parts:Array = line.split(",");
					if (unescaped.indexOf("+%20") == 0) { // add button
						code += '<td class="menuIcon"><img src="images/iphone/menuAdd.png" width="20" height="20" alt="MenuAdd"></td>';
						parts[0] = parts[0].substr(2);
					}
					if (unescaped.indexOf("-%20") == 0) { // delete button
						code += '<td class="menuIcon"><img src="images/iphone/menuDelete.png" width="20" height="20" alt="MenuDelete"></td>';
						parts[0] = parts[0].substr(2);
					}
					if (unescaped.indexOf("v%20") == 0) { // checkmark
						code += '<td class="menuIcon"><img src="images/iphone/menuCheckmark.png" width="20" height="20" alt="MenuCheckmark"></td>';
						parts[0] = parts[0].substr(2);
					}
					if (unescaped.indexOf("*%20") == 0) { // bullet
						code += '<td class="menuIcon"><img src="images/iphone/menuBullet.png" width="20" height="20" alt="MenuBullet"></td>';
						parts[0] = parts[0].substr(2);
					}
					if (unescaped.indexOf("_%20") == 0) { // icon
						code += '<td class="menuIcon">&nbsp;</td>';
						parts[0] = parts[0].substr(2);
					}
					if (unescaped.indexOf("__%20") == 0) { // big icon
						code += '<td class="menuBigIcon">&nbsp;</td>';
						parts[0] = parts[0].substr(3);
					}
					code += '<td>'+StringUtils.escapeCharsAndGetHtml(parts[0].replace(/\|\~escc\~\|/g, ","),true)+'</td>';
					if (StringUtil.trim(parts[1]) == ">"){
						code += '<td class="menuIcon"><img src="images/iphone/menuSub.png" width="20" height="20" alt="MenuSub"></td>';
					}
					else if (StringUtil.trim(parts[1]) == "(>)"){
						code += '<td class="menuIcon"><img src="images/iphone/menuSubFilled.png" width="20" height="20" alt="MenuSubFilled"></td>';
					}
					else if (StringUtil.trim(parts[1]) == "="){
						code += '<td class="menuIcon"><img src="images/iphone/menuList.png" width="20" height="20" alt="MenuList"></td>';
					}
					else if (StringUtil.trim(parts[1]) == "ON"){
						code += '<td class="menuIcon"><div id="'+(getComponentID() + "i" + i)+'" class="napkeeSwitch"></div></td>';
						jsCode += '$("#'+(getComponentID() + "i" + i)+'").iphoneSwitch("on",function(){},	function() {},	{});';
					}
					else if (StringUtil.trim(parts[1]) == "OFF"){
						code += '<td class="menuIcon"><div id="'+(getComponentID() + "i" + i)+'" class="napkeeSwitch"></div></td>';
						jsCode += '$("#'+(getComponentID() + "i" + i)+'").iphoneSwitch("off",function(){},	function() {},	{});';
					}
					else {
						code += '<td class="rowDesc">'+StringUtils.escapeCharsAndGetHtml(parts[1].replace(/\|\~escc\~\|/g, ","),true)+'</td>';
					}
				}
				else {
					if (unescaped.indexOf("+%20") == 0) { // add button
						code += '<td class="menuIcon"><img src="images/iphone/menuAdd.png" width="20" height="20" alt="MenuAdd"></td>';
						line = line.substr(2);
					}
					if (unescaped.indexOf("-%20") == 0) { // delete button
						code += '<td class="menuIcon"><img src="images/iphone/menuDelete.png" width="20" height="20" alt="MenuAdd"></td>';
						line = line.substr(2);
					}
					if (unescaped.indexOf("v%20") == 0) { // checkmark
						code += '<td class="menuIcon"><img src="images/iphone/menuCheckmark.png" width="20" height="20" alt="MenuCheckmark"></td>';
						line = line.substr(2);
					}
					if (unescaped.indexOf("*%20") == 0) { // bullet
						code += '<td class="menuIcon"><img src="images/iphone/menuBullet.png" width="20" height="20" alt="MenuBullet"></td>';
						line = line.substr(2);
					}
					if (unescaped.indexOf("_%20") == 0) { // icon
						code += '<td class="menuIcon">&nbsp;</td>';
						line = line.substr(2);
					}
					if (unescaped.indexOf("__%20") == 0) { // big icon
						code += '<td class="menuBigIcon">&nbsp;</td>';
						line = line.substr(3);
					}
					code += '<td>'+StringUtils.escapeCharsAndGetHtml(line.replace(/\|\~escc\~\|/g, ","),true)+'</td>';
				}
				// id="'+(getComponentID() + "i" + i)+'"
				
				code += '</tr></table>';
				
			}
			
			code += "</td></tr>";
			
			cp.setPlaceHolder("code",code);
			return cp.getParsed();			
		}
		
		public override function getCss():String
		{
			var cp:ComponentParser = getBaseCss();
			var borderStyle:String = "1px solid #CCCCCC";
			
			if (StringUtils.isNotBlank(control.controlProperties.borderStyle)){
				if (control.controlProperties.borderStyle == "none"){
					borderStyle = "0px";
				}
			}
			cp.setPlaceHolder("border",borderStyle);
			return cp.getParsed();
		}
		
		public override function getJsDocReady():String
		{
			var cp:ComponentParser = getBaseJsDocReady();
			cp.setPlaceHolder("code",jsCode);
			return cp.getParsed();
		}
		
		
	}
}