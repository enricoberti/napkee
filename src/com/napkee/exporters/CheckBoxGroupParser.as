package com.napkee.exporters
{
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import mx.containers.VBox;
	import mx.controls.CheckBox;
	import mx.controls.Label;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.utils.StringUtil;
	
	public class CheckBoxGroupParser extends BasicParser implements IControlParser
	{
		
		public function CheckBoxGroupParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "checkboxgroup.xml";
			if (StringUtils.isBlank(control.controlProperties.text)){
				if (control.controlProperties.child("text").length() > 0){
					control.controlProperties.text = "";
				}
				else {
					control.controlProperties.text = "%5B%20%5D%20not%20selected%0A%5Bx%5D%20selected%0A-%5B%20%5D%20disabled-%0A-%5Bx%5D%20disabled%20selected-%0AA%20row%20without%20a%20checkbox";
				}
			}
		}
		
		public override function getHtml():String
		{
			var cp:ComponentParser = getBaseHtml();
			
			var code:String = "";
			var crumbs:Array = (control.controlProperties.text).split("%0A");
			
			for (var i:int = 0;i<crumbs.length;i++){
				var line:String = StringUtil.trim(unescape(crumbs[i] as String));
				
				var disabled:Boolean = false;
				if (line.charAt(0) == "-" && line.charAt(line.length-1)=="-"){ // disabled
					disabled = true;
					line = line.substr(1,line.length-2);
				}
				/*
				<input id="${id}" type="checkbox" disabled="${disabled}" checked="${checked}" />
				<label for="${id}">${label}</label>
				*/
				
				if (line.indexOf("[ ]") == 0){ // unselected checkbox
					code += '\t<label for="'+ getComponentID() + 'i' + i +'" class="checkbox">\n';
					code += '\t<input id="'+ getComponentID() + 'i' + i +'" type="checkbox"'+(disabled?' disabled="true"':'')+'/>\n';
					code += '\t'+StringUtils.escapeCharsAndGetHtml(StringUtil.trim(line.substr(3)),true)+'</label>\n\t\n\n';
				}
				else if (line.indexOf("[o]") == 0 || line.indexOf("[O]") == 0 || line.indexOf("[*]") == 0 || line.indexOf("[X]") == 0 || line.indexOf("[V]") == 0 || line.indexOf("[x]") == 0 || line.indexOf("[v]") == 0 || line.indexOf("[-]") == 0){ // selected checkbox
					code += '\t<label for="'+ getComponentID() + 'i' + i +'" class="checkbox">\n';
					code += '\t<input id="'+ getComponentID() + 'i' + i +'" type="checkbox"'+(disabled?' disabled="true"':'')+' checked="true"/>\n';
					code += '\t'+StringUtils.escapeCharsAndGetHtml(StringUtil.trim(line.substr(3)),true)+'</label>\n\t\n\n';
				}
				else { // no checkbox
					code += '\t<span id="'+ getComponentID() + 'i' + i +'">'+StringUtils.escapeCharsAndGetHtml(disabled?("-"+line+"-"):line,true)+'</span>\n\t\n\n';
				}
				
			}
			
			cp.setPlaceHolder("code",code);
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