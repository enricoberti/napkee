package com.napkee.exporters
{
	import com.napkee.managers.ApplicationManager;
	import com.napkee.utils.ColorUtils;
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import flash.filesystem.File;
	
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.core.UIComponent;
	
	public class IconLabelParser extends BasicParser implements IControlParser
	{
		
		public function IconLabelParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "iconlabel.xml";
		}
		
		public override function getHtml():String
		{
			var cp:ComponentParser = getBaseHtml();
			
			var code:String = "";
			var iconSrc:String = String(control.controlProperties.icon);
			var source:String = "";
			var isDefaultIcon:Boolean = true;
			
			if (StringUtils.isNotBlank(iconSrc)){
				if (iconSrc.indexOf("assets")>-1){
					try {
						var iconSrcNoPipe:String = iconSrc.split("%7C")[0];
						var imgFile:File;
						if (iconSrcNoPipe.indexOf("%24ACCOUNT") > -1){
							var assets:File = File.documentsDirectory.resolvePath("Balsamiq Mockups");
							imgFile = assets.resolvePath(unescape((iconSrcNoPipe).substr(11)));
						}
						else {
							var path:String = "file:///"+ control.@location + File.separator + unescape(iconSrcNoPipe);
							imgFile = new File(path);
						}
						
						if (imgFile.exists){
							var imagesDestDir:File = File.applicationStorageDirectory.resolvePath("content/images/imported/");
							var destFile:File = new File(imagesDestDir.nativePath + File.separator + imgFile.name);
							if (destFile.exists){
								var originalName:String = imgFile.name.substr(0,imgFile.name.length - (imgFile.extension.length + 1));
								destFile = new File(imagesDestDir.nativePath + File.separator + originalName + "_" + getComponentID() + "." + imgFile.extension);
							}
							imgFile.copyTo(destFile,true);
							source = "images/imported/"+destFile.name;
							isDefaultIcon = false;
						}
						else {
							source = getIcon(iconSrc);
						}
					}
					catch (error:Error){
						source = getIcon(iconSrc);
					}
				}
				else {
					source = getIcon(iconSrc);
				}
			}
			else {
				source = ApplicationManager.getHTMLIconsFolder()+"/napkee/EmptyIcon.png";
			}
			if (StringUtils.isBlank(control.controlProperties.text)){
				if (control.controlProperties.child("text").length() > 0){
					control.controlProperties.text = "Some text";
				}
				else {
					control.controlProperties.text = "Icon Name";
				}
			}
			if (StringUtils.isNotBlank(control.controlProperties.labelPosition)){
				if (control.controlProperties.labelPosition == "right"){
					cp.setPlaceHolder("labelRight",StringUtils.escapeCharsAndGetHtml(unescape(control.controlProperties.text)));
					cp.setPlaceHolder("labelBottom","&nbsp;");
					cp.setPlaceHolder("labelLeft","&nbsp;");
				}
				else if (control.controlProperties.labelPosition == "left"){
					cp.setPlaceHolder("labelLeft",StringUtils.escapeCharsAndGetHtml(unescape(control.controlProperties.text)));
					cp.setPlaceHolder("labelBottom","&nbsp;");
					cp.setPlaceHolder("labelRight","&nbsp;");
				}
				else {
					cp.setPlaceHolder("labelBottom",StringUtils.escapeCharsAndGetHtml(unescape(control.controlProperties.text)));
					cp.setPlaceHolder("labelRight","&nbsp;");
					cp.setPlaceHolder("labelLeft","&nbsp;");
				}
			}
			else {
				cp.setPlaceHolder("labelBottom",StringUtils.escapeCharsAndGetHtml(unescape(control.controlProperties.text)));
				cp.setPlaceHolder("labelLeft","&nbsp;");
				cp.setPlaceHolder("labelRight","&nbsp;");
			}
			
			if (control.controlProperties.rotation != null){
				cp.setPlaceHolder("rotationClass","rotate"+(360-control.controlProperties.rotation*1));
			}
			else {
				cp.setPlaceHolder("rotationClass","");
			}
			
			if (getCustomCss().indexOf("icon-") > -1 && isDefaultIcon==true){
				code = '<i id="'+getComponentID()+'-i" class="napkeeComponent napkeeIcon '+getCustomCss()+'"></i>';	
			}
			else {
				code = '<img id="'+getComponentID()+'-i" src="'+source+'" class="napkeeComponent napkeeIcon" />';
			}
			cp.setPlaceHolder("code",code);
			return cp.getParsed();			
		}
		
		private function getIcon(iconStr:String):String
		{
			var iconComponents:Array = iconStr.split("%7C");
				var sizePx:String = "";
				var size:String = "small";
				var iconName:String = "";
				if (iconComponents.length > 1){
					iconName = iconComponents[0];
					size = iconComponents[1];
				}
				switch (size){
					case "xsmall":
						sizePx = "16";
						break;
					case "small":
						sizePx = "24";
						break;
					case "medium":
						sizePx = "32";
						break;
					case "large":
						sizePx = "48";
						break;
					default:
						sizePx = "48";
				}
				return ApplicationManager.getHTMLIconsFolder()+"/napkee/"+iconName+".png";
		}
		
		public override function getCss():String
		{
			var cp:ComponentParser = getBaseCss();
			cp.setPlaceHolder("imageWidth",getIconSize(control.controlProperties.icon)+"px");
			cp.setPlaceHolder("imageHeight",getIconSize(control.controlProperties.icon)+"px");
			if (StringUtils.isNotBlank(control.controlProperties.borderStyle)){
				if (control.controlProperties.borderStyle == "none"){
					cp.setPlaceHolder("border","0px solid");
				}
				else {
					cp.setPlaceHolder("border","1px solid #000");
				}
			}
			else {
				cp.setPlaceHolder("border","0px solid");
			}
			return cp.getParsed();
		}
		
		private function getIconSize(iconStr:String):String
		{
			var iconComponents:Array = iconStr.split("%7C");
				var sizePx:String = "";
				var size:String = "small";
				if (iconComponents.length > 1){
					size = iconComponents[1];
				}
				switch (size){
					case "xsmall":
						sizePx = "16";
						break;
					case "small":
						sizePx = "24";
						break;
					case "medium":
						sizePx = "32";
						break;
					case "large":
						sizePx = "48";
						break;
					default:
						sizePx = "48";
				}
				return sizePx;
		}
		
		public override function getJsDocReady():String
		{
			var cp:ComponentParser = getBaseJsDocReady();
			cp.setPlaceHolder("clickCode",getJsSingleLink());
			return cp.getParsed();
		}
		
		
	}
}