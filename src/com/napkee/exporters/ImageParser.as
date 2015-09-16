package com.napkee.exporters
{
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	import com.napkee.vo.BMMLFile;
	
	import flash.filesystem.File;
	import flash.system.Capabilities;
	
	import mx.controls.Image;
	import mx.core.FlexGlobals;
	import mx.core.UIComponent;
	
	public class ImageParser extends BasicParser implements IControlParser
	{
		
		public function ImageParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "image.xml";
		}
		
		public override function getHtml():String
		{
			var cp:ComponentParser = getBaseHtml();
			
			if (unescape(control.controlProperties.src).indexOf("http") == 0){
				cp.setPlaceHolder("source",unescape(control.controlProperties.src));
			}
			else if (unescape(control.controlProperties.src).indexOf("file") == 0){
				var imgFile:File;
				try {
					imgFile = new File(unescape(control.controlProperties.src));
					if (imgFile.exists){
						var imagesDestDir:File = File.applicationStorageDirectory.resolvePath("content/images/imported/");
						
						var destFile:File = new File(imagesDestDir.nativePath + File.separator + imgFile.name);
						if (destFile.exists){
							var originalName:String = imgFile.name.substr(0,imgFile.name.length - (imgFile.extension.length + 1));
							destFile = new File(imagesDestDir.nativePath + File.separator + originalName + "_" + getComponentID() + "." + imgFile.extension);
						}
						imgFile.copyTo(destFile,true);
						cp.setPlaceHolder("source","images/imported/"+destFile.name);
					}
					else {
						cp.setPlaceHolder("source","js/holder.js/" + getWidth() + "x" + getHeight());
					}
				}
				catch (error:Error){
					cp.setPlaceHolder("source","js/holder.js/" + getWidth() + "x" + getHeight());
				}
			}
			else {
				if (StringUtils.isNotBlank(unescape(control.controlProperties.src))){
					try {
						var imgFile:File;
						if ((control.controlProperties.src).indexOf("%24ACCOUNT") > -1){
							var assets:File = File.documentsDirectory.resolvePath("Balsamiq Mockups");
							imgFile = assets.resolvePath(unescape((control.controlProperties.src).substr(11)));
							//var path:String = "file:///"+ imgFile.;
						}
						else {
							var path:String = "file:///"+ control.@location + File.separator + unescape(control.controlProperties.src);
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
							//cp.setPlaceHolder("source",path);
							cp.setPlaceHolder("source","images/imported/"+destFile.name);
						}
						else {
							cp.setPlaceHolder("source","js/holder.js/" + getWidth() + "x" + getHeight());
						}
					}
					catch (error:Error){
						cp.setPlaceHolder("source","js/holder.js/" + getWidth() + "x" + getHeight());
					}
				}
				else {
					cp.setPlaceHolder("source","js/holder.js/" + getWidth() + "x" + getHeight());
				}
			}
			
			if (StringUtils.isNotBlank(unescape(control.controlProperties.text))){
				cp.setPlaceHolder("label",unescape(control.controlProperties.text));
			}
			else {
				cp.setPlaceHolder("label","");
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
		
		public override function getJsDocReady():String
		{
			var cp:ComponentParser = getBaseJsDocReady();
			cp.setPlaceHolder("clickCode",getJsSingleLink());
			return cp.getParsed();
		}
		
	}
}