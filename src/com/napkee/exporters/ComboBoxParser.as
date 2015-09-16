package com.napkee.exporters
{
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import mx.controls.ComboBox;
	import mx.core.UIComponent;
	import mx.utils.StringUtil;
	
	public class ComboBoxParser extends BasicParser implements IControlParser
	{
		
		public function ComboBoxParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "combobox.xml";
			if (StringUtils.isBlank(control.controlProperties.text)){
				if (control.controlProperties.child("text").length() > 0){
					control.controlProperties.text = "";
				}
				else {
					control.controlProperties.text = "ComboBox";
				}
			}
		}
		
		public override function getHtml():String
		{
			var cp:ComponentParser = getBaseHtml();
			
			var code:String = "";
			var crumbs:Array = (control.controlProperties.text).split("%0A");
			for (var i:int = 0;i<crumbs.length;i++){
				var link:String = StringUtil.trim(unescape(crumbs[i] as String));
				//if (StringUtils.isNotBlank(link)){
					code += '<option>'+StringUtils.escapeCharsAndGetHtml(link)+'</option>';
				//}				
			}
			cp.setPlaceHolder("code",code);
			if (StringUtils.isNotBlank(control.controlProperties.state) && (control.controlProperties.state == "disabled" || control.controlProperties.state == "disabledClosed")){
				cp.setPlaceHolder("disabled","disabled");
			}
			else {
				cp.removeAttribute("disabled");
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