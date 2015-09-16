package com.napkee.importers
{
	import com.adobe.utils.StringUtil;
	import com.napkee.NapkeeApplication;
	import com.napkee.domain.ComponentModel;
	import com.napkee.exporters.IControlParser;
	import com.napkee.exporters.IParserFactory;
	import com.napkee.exporters.IconParser;
	import com.napkee.exporters.ImageParser;
	import com.napkee.exporters.LabelParser;
	import com.napkee.exporters.OffsetModifier;
	import com.napkee.exporters.ParagraphParser;
	import com.napkee.exporters.ParserFactoryForHalo;
	import com.napkee.exporters.TemplateRepository;
	import com.napkee.managers.ApplicationManager;
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringConstants;
	import com.napkee.utils.StringUtils;
	import com.napkee.utils.Watermark;
	import com.napkee.vo.BMMLFile;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.core.FlexGlobals;
	
	public class BMMLParser
	{
		private var bmml:XML;
		
		private var componentList:ArrayCollection = new ArrayCollection();
		
		public var hasProblems:Boolean = false;
		
		private var html:String = "";
		private var css:String = "";
		private var jsDocReady:String = "";
		private var jsImport:String = "";
		private var cssImport:String = "";
		private var mxml:String = "";
		private var asC:String = "";
		
		private var previewCanvas:Canvas;
		
		private var bmmlFile:File;
		
		private var browserWindowOffset:OffsetModifier;
        
        private var parserFactory: IParserFactory = new ParserFactoryForHalo();
        private var templateRepository:TemplateRepository;
		
        private const controlIdsToFixCoords: Array = [
            "com.balsamiq.mockups::Accordion","com.balsamiq.mockups::TitleWindow",
            "com.balsamiq.mockups::Canvas","com.balsamiq.mockups::ModalScreen",
            "com.balsamiq.mockups::TabBar","com.balsamiq.mockups::VerticalTabBar"];
        
        
		public function BMMLParser(filePath:String, templateRepository: TemplateRepository=null)
		{
			bmmlFile = new File(filePath);
            if (templateRepository == null) templateRepository = new TemplateRepository();
            this.templateRepository = templateRepository;
			
			previewCanvas =  new Canvas();
			previewCanvas.styleName = "previewCanvas";
			previewCanvas.percentHeight = 100;
			previewCanvas.percentWidth = 100;
			
			if (!bmmlFile.exists){
				hasProblems = true;
				return;
			}
			
			var fs:FileStream = new FileStream();
			fs.open(bmmlFile, FileMode.READ);
			bmml = XML(fs.readUTFBytes(fs.bytesAvailable));
			
			
			var offsetModifier:OffsetModifier;
			
			// search for linked files
			var openLinkedFiles:Boolean = true;
			for each (var checkControl:XML in bmml.controls.control){
				if (openLinkedFiles){
					if (StringUtils.isNotBlank(checkControl.controlProperties.href)){
						var hrefStr:String = checkControl.controlProperties.href;
						var fileName:String = "";
						if (hrefStr.indexOf("%26bm%3B")>-1){
							fileName = hrefStr.split("%26bm%3B")[1];
						}
						else {
							fileName = hrefStr;
						}
						var fi:BMMLFile = new BMMLFile();
						fi.file = new File(bmmlFile.parent.nativePath+File.separator+unescape(fileName));
						var ffound:Boolean = false;
						for (var i:Number = 0; i<FlexGlobals.topLevelApplication.avoidAutoLoad.length; i++){
							var avoidFile:File = FlexGlobals.topLevelApplication.avoidAutoLoad.getItemAt(i) as File;
							if (avoidFile.nativePath == fi.file.nativePath){
								ffound = true;
							}
						}
						if (!ffound){
							NapkeeApplication.application.projectManager.addFile(fi);
						}
					}
					if (StringUtils.isNotBlank(checkControl.controlProperties.hrefs)){
						var linkedFiles:Array = (checkControl.controlProperties.hrefs).split("%2C");
						for (var l:int = 0;l<linkedFiles.length;l++){
							var hrefStr:String = linkedFiles[l] as String;
							var fileName:String = "";
							if (hrefStr.indexOf("%26bm%3B")>-1){
								fileName = hrefStr.split("%26bm%3B")[1];
							}
							else {
								fileName = hrefStr;
							}
							var link:String = StringUtil.trim(unescape(fileName));
							if (StringUtils.isNotBlank(link)){
								var fi:BMMLFile = new BMMLFile();
								fi.file = new File(bmmlFile.parent.nativePath+File.separator+unescape(link));
								var ffound:Boolean = false;
								for (var i:Number = 0; i<FlexGlobals.topLevelApplication.avoidAutoLoad.length; i++){
									var avoidFile:File = FlexGlobals.topLevelApplication.avoidAutoLoad.getItemAt(i) as File;
									if (avoidFile.nativePath == fi.file.nativePath){
										ffound = true;
									}
								}
								if (!ffound){
									NapkeeApplication.application.projectManager.addFile(fi);
								}
							}				
						}
					}
				}
			}
			
			var bmmlPreProcessor:BMMLPreprocessor = new BMMLPreprocessor(bmmlFile);
			
			bmml.controls = bmmlPreProcessor.getControls();

            parserFactory.skipMarkup = ApplicationManager.isSkipMarkup();
            
			var controlList:XMLList = bmml.controls.control;
			for (var cZ:int=0; cZ<controlList.length(); cZ++){		
				for each (var control:XML in bmml.controls.control){
					if (control.@controlTypeID == "com.balsamiq.mockups::BrowserWindow"){
						browserWindowOffset = new OffsetModifier();
						browserWindowOffset.x = control.@x*1+5;
						browserWindowOffset.y = control.@y*1+70;
					}
					if (control.@zOrder == cZ){
						parseControl(control,offsetModifier,cZ);
						break;
					}				
				}
			}
			
			
			var clIdx:int = 0;
			for each (var cmp:ComponentModel in componentList){
				var reCmp:ComponentModel = componentList.getItemAt(clIdx) as ComponentModel;
				if (NapkeeApplication.application.projectManager.project.nature == StringConstants.PROJECT_NATURE_WEB){
					if (cmp.parent == ""){
						var cmpParser:ComponentParser = new ComponentParser(cmp.html);
						if (cmp.bmml.@controlTypeID == "com.balsamiq.mockups::Accordion"){
							var selectedIndex:String = (StringUtils.isNotBlank(cmp.bmml.controlProperties.selectedIndex)?cmp.bmml.controlProperties.selectedIndex:"0");
							if (selectedIndex == "-1"){
								selectedIndex = "0";
							}
							cmpParser.setPlaceHolder("children"+selectedIndex,getHtmlChildren(cmp,clIdx));
							var crumbs:Array = (cmp.bmml.controlProperties.text).split("%0A");
							for (var cri:int = 0;cri<crumbs.length;cri++){
								cmpParser.setPlaceHolder("children"+cri,"");
							}
						}
						else if (cmp.bmml.@controlTypeID == "com.balsamiq.mockups::TabBar"){
							var selectedIndex:String = (StringUtils.isNotBlank(cmp.bmml.controlProperties.selectedIndex)?cmp.bmml.controlProperties.selectedIndex:"0");
							if (selectedIndex == "-1"){
								selectedIndex = "0";
							}
							cmpParser.setPlaceHolder("children"+selectedIndex,getHtmlChildren(cmp,clIdx));
							var crumbs:Array = (cmp.bmml.controlProperties.text).split("%2C");
							for (var cri:int = 0;cri<crumbs.length;cri++){
								cmpParser.setPlaceHolder("children"+cri,"");
							}
						}
						else if (cmp.bmml.@controlTypeID == "com.balsamiq.mockups::VerticalTabBar"){
							var selectedIndex:String = (StringUtils.isNotBlank(cmp.bmml.controlProperties.selectedIndex)?cmp.bmml.controlProperties.selectedIndex:"0");
							if (selectedIndex == "-1"){
								selectedIndex = "0";
							}
							cmpParser.setPlaceHolder("children"+selectedIndex,getHtmlChildren(cmp,clIdx));
							var crumbs:Array = (cmp.bmml.controlProperties.text).split("%0A");
							for (var cri:int = 0;cri<crumbs.length;cri++){
								cmpParser.setPlaceHolder("children"+cri,"");
							}
						}
						else if (cmp.bmml.@controlTypeID == "com.balsamiq.mockups::Canvas" || cmp.bmml.@controlTypeID == "com.balsamiq.mockups::ModalScreen" || cmp.bmml.@controlTypeID == "com.balsamiq.mockups::TitleWindow" || cmp.bmml.@controlTypeID == "com.balsamiq.mockups::FieldSet"){
							cmpParser.setPlaceHolder("children",getHtmlChildren(cmp,clIdx));
						}
						html += cmpParser.getParsed();
					}
					css += reCmp.css;
					jsDocReady += reCmp.jsGlobal;
					jsDocReady += reCmp.js;
				}
				clIdx++;
			}
		}
		
		private function getHtmlChildren(cmp:ComponentModel, componentListIndex:int):String
		{
			var childrenCode:String = "";
			var gclIdx:int = 0;
			for each (var component:ComponentModel in componentList){
				if (component.parent == cmp.id){
					// change css from absolute to relative
					component.html = component.html.replace(/class=\"napkeeComponent/,'class="napkeeRelativeComponent');
					var om:OffsetModifier = getOffsetModifier(cmp.bmml,component.bmml);
					component.css = applyOffsetToCss(component.css,om);
					var componentParser:ComponentParser = new ComponentParser(component.html);
					if (component.bmml.@controlTypeID == "com.balsamiq.mockups::Accordion"){
						var selectedIndex:String = (StringUtils.isNotBlank(component.bmml.controlProperties.selectedIndex)?component.bmml.controlProperties.selectedIndex:"0");
						if (selectedIndex == "-1"){
							selectedIndex = "0";
						}
						componentParser.setPlaceHolder("children"+selectedIndex,getHtmlChildren(component,gclIdx));
						var crumbs:Array = (component.bmml.controlProperties.text).split("%0A");
						for (var cri:int = 0;cri<crumbs.length;cri++){
							componentParser.setPlaceHolder("children"+cri,"");
						}
					}
					else if (component.bmml.@controlTypeID == "com.balsamiq.mockups::TabBar"){
						var selectedIndex:String = (StringUtils.isNotBlank(component.bmml.controlProperties.selectedIndex)?component.bmml.controlProperties.selectedIndex:"0");
						if (selectedIndex == "-1"){
							selectedIndex = "0";
						}
						componentParser.setPlaceHolder("children"+selectedIndex,getHtmlChildren(component,gclIdx));
						var crumbs:Array = (component.bmml.controlProperties.text).split("%2C");
						for (var cri:int = 0;cri<crumbs.length;cri++){
							componentParser.setPlaceHolder("children"+cri,"");
						}
					}
					else if (component.bmml.@controlTypeID == "com.balsamiq.mockups::VerticalTabBar"){
						var selectedIndex:String = (StringUtils.isNotBlank(component.bmml.controlProperties.selectedIndex)?component.bmml.controlProperties.selectedIndex:"0");
						if (selectedIndex == "-1"){
							selectedIndex = "0";
						}
						componentParser.setPlaceHolder("children"+selectedIndex,getHtmlChildren(component,gclIdx));
						var crumbs:Array = (component.bmml.controlProperties.text).split("%0A");
						for (var cri:int = 0;cri<crumbs.length;cri++){
							componentParser.setPlaceHolder("children"+cri,"");
						}
					}
					else if (component.bmml.@controlTypeID == "com.balsamiq.mockups::Canvas" || component.bmml.@controlTypeID == "com.balsamiq.mockups::ModalScreen" || component.bmml.@controlTypeID == "com.balsamiq.mockups::TitleWindow" || component.bmml.@controlTypeID == "com.balsamiq.mockups::FieldSet"){
						componentParser.setPlaceHolder("children",getHtmlChildren(component,gclIdx));
					}
					componentList.setItemAt(component,gclIdx);
					childrenCode += componentParser.getParsed();
					//childrenCode += getChildren(component);
				}
				gclIdx++;
			}
			return childrenCode;
		}

		private function getMxmlChildren(cmp:ComponentModel, componentListIndex:int):String
		{
			var childrenCode:String = "";
			var gclIdx:int = 0;
			for each (var component:ComponentModel in componentList){
				if (component.parent == cmp.id){
					// change css from absolute to relative
					//component.html = component.html.replace(/class=\"napkeeComponent/,'class="napkeeRelativeComponent');
					var om:OffsetModifier = getOffsetModifierFlex(cmp.bmml,component.bmml);
					component.mxml = applyOffsetToProperties(component.mxml,om);
					var componentParser:ComponentParser = new ComponentParser(component.mxml);
					if (component.bmml.@controlTypeID == "com.balsamiq.mockups::Canvas" || component.bmml.@controlTypeID == "com.balsamiq.mockups::ModalScreen" || component.bmml.@controlTypeID == "com.balsamiq.mockups::TitleWindow"){
						componentParser.setPlaceHolder("children",getMxmlChildren(component,gclIdx));
					}
					else if (component.bmml.@controlTypeID == "com.balsamiq.mockups::Accordion"){
						var selectedIndex:String = (StringUtils.isNotBlank(component.bmml.controlProperties.selectedIndex)?component.bmml.controlProperties.selectedIndex:"0");
						if (selectedIndex == "-1"){
							selectedIndex = "0";
						}
						componentParser.setPlaceHolder("children"+selectedIndex,getMxmlChildren(component,gclIdx));
						var crumbs:Array = (component.bmml.controlProperties.text).split("%0A");
						for (var cri:int = 0;cri<crumbs.length;cri++){
							componentParser.setPlaceHolder("children"+cri,"");
						}
					}
					else if (component.bmml.@controlTypeID == "com.balsamiq.mockups::TabBar"){
						var selectedIndex:String = (StringUtils.isNotBlank(component.bmml.controlProperties.selectedIndex)?component.bmml.controlProperties.selectedIndex:"0");
						if (selectedIndex == "-1"){
							selectedIndex = "0";
						}
						componentParser.setPlaceHolder("children"+selectedIndex,getMxmlChildren(component,gclIdx));
						var crumbs:Array = (component.bmml.controlProperties.text).split("%2C");
						for (var cri:int = 0;cri<crumbs.length;cri++){
							componentParser.setPlaceHolder("children"+cri,"");
						}
					}
					else if (component.bmml.@controlTypeID == "com.balsamiq.mockups::VerticalTabBar"){
						var selectedIndex:String = (StringUtils.isNotBlank(component.bmml.controlProperties.selectedIndex)?component.bmml.controlProperties.selectedIndex:"0");
						if (selectedIndex == "-1"){
							selectedIndex = "0";
						}
						componentParser.setPlaceHolder("children"+selectedIndex,getMxmlChildren(component,gclIdx));
						var crumbs:Array = (component.bmml.controlProperties.text).split("%0A");
						for (var cri:int = 0;cri<crumbs.length;cri++){
							componentParser.setPlaceHolder("children"+cri,"");
						}
					}
					componentList.setItemAt(component,gclIdx);
					childrenCode += componentParser.getParsed();
					//childrenCode += getChildren(component);
				}
				gclIdx++;
			}
			return childrenCode;
		}
		
		private function getOffsetModifier(parentControl:XML,childControl:XML):OffsetModifier
		{
			var newOffset:OffsetModifier = new OffsetModifier();
			var verticalGain:Number = 0; 
			// selected index for Accordion
			if (parentControl.@controlTypeID == "com.balsamiq.mockups::TabBar"){
				if (parentControl.controlProperties.tabVPosition == "top"){
					verticalGain = 24;
				}
			}
			newOffset.y = ((new Number(childControl.@y) - new Number(parentControl.@y)) - verticalGain);
			//newOffset.y = ((new Number(childControl.@y) - new Number(parentControl.@y)));
			newOffset.x = (new Number(childControl.@x) - new Number(parentControl.@x));
			return newOffset;
		}

		private function getOffsetModifierFlex(parentControl:XML,childControl:XML):OffsetModifier
		{
			var newOffset:OffsetModifier = new OffsetModifier();
			var verticalGain:Number = 0; 
			var horizontalGain:Number = 0; 
			// selected index for Accordion
			if (parentControl.@controlTypeID == "com.balsamiq.mockups::Accordion"){
				var selectedIndex:String = (StringUtils.isNotBlank(parentControl.controlProperties.selectedIndex)?parentControl.controlProperties.selectedIndex:"0");
				verticalGain = (new Number(selectedIndex)+1) * 28; // 28 is the height of the accordion title bar
			}
			if (parentControl.@controlTypeID == "com.balsamiq.mockups::TitleWindow"){
				verticalGain = 26;
				if (StringUtils.isNotBlank(parentControl.controlProperties.topheight)){
					verticalGain = new Number(parentControl.controlProperties.topheight);
				}
			}
			if (parentControl.@controlTypeID == "com.balsamiq.mockups::TabBar"){
				if (parentControl.controlProperties.tabVPosition == "top"){
					verticalGain = 24;
				}
			}
			if (parentControl.@controlTypeID == "com.balsamiq.mockups::VerticalTabBar"){
				if (parentControl.controlProperties.position == "left"){
					horizontalGain = 80;
				}
			}
			newOffset.y = ((new Number(childControl.@y) - new Number(parentControl.@y)) - verticalGain);
			//newOffset.y = ((new Number(childControl.@y) - new Number(parentControl.@y)));
			newOffset.x = ((new Number(childControl.@x) - new Number(parentControl.@x)) - horizontalGain);
			return newOffset;
		}
		
		private function applyOffsetToCss(css:String,om:OffsetModifier):String
		{
			var newCss:String = css;
			if (StringUtils.isNotBlank(newCss)){
				var patternLeft:String = "left:";
				var indexLeft:int = newCss.indexOf(patternLeft);
				var searchLeft:int = newCss.substr(indexLeft+5).search(/[;]/);
				newCss = newCss.substr(0,indexLeft+5) + om.x + "px;" + newCss.substr(indexLeft+5+searchLeft+1);
				var patternTop:String = "top:";
				var indexTop:int = newCss.indexOf(patternTop);
				var searchTop:int = newCss.substr(indexTop+4).search(/[;]/);
				newCss = newCss.substr(0,indexTop+4) + om.y + "px;" + newCss.substr(indexTop+4+searchTop+1);
			}
			return newCss;
		}

		private function applyOffsetToProperties(mxml:String,om:OffsetModifier):String
		{
			var newMxml:String = mxml;
			if (StringUtils.isNotBlank(newMxml)){
				var patternLeft:String = 'left="';
				var indexLeft:int = newMxml.indexOf(patternLeft);
				var searchLeft:int = newMxml.substr(indexLeft+6).search(/[ ]/);
				newMxml = newMxml.substr(0,indexLeft+6) + om.x + '"' + newMxml.substr(indexLeft+6+searchLeft);
				var patternTop:String = 'top="';
				var indexTop:int = newMxml.indexOf(patternTop);
				var searchTop:int = newMxml.substr(indexTop+5).search(/[ ]/);
				newMxml = newMxml.substr(0,indexTop+5) + om.y + '"' + newMxml.substr(indexTop+5+searchTop);
			}
			return newMxml;
		}
		
		private function parseControl(control:XML,offsetModifier:OffsetModifier,idx:int): void
		{
			var parser: IControlParser = parserFactory.createParser(control, offsetModifier);
			var controlType:String = control.@controlTypeID;
			var skipWeb:Boolean = false;
            if (parser == null) {
    			switch (controlType){
    				case "__group__":
    					for each (var innerControl:XML in control.groupChildrenDescriptors.control){
    						innerControl.@x = new Number(innerControl.@x) + new Number(control.@x);
    						innerControl.@y = new Number(innerControl.@y) + new Number(control.@y);
    						innerControl.@controlID = control.@controlID + "_" + innerControl.@controlID;
    						parseControl(innerControl,offsetModifier,control.@zOrder);
    					}
    					break;
    				case "com.balsamiq.mockups::Component":
    					break;
    				case "com.balsamiq.mockups::Image":
    					control.@location = bmmlFile.parent.nativePath;
    					parser = new ImageParser(control,offsetModifier);
    					break;
    				case "com.balsamiq.mockups::Label":
    					parser = new LabelParser(control,offsetModifier,bmmlFile);
    					break;
    				case "com.balsamiq.mockups::Paragraph":
    					parser = new ParagraphParser(control,offsetModifier,bmmlFile);
    					break;
    				case "com.balsamiq.mockups::Icon":
    					control.@location = bmmlFile.parent.nativePath;
    					parser = new IconParser(control,offsetModifier);
    					break;
    				case "__watermark__":
    					parser = new Watermark(control,null);
    					break;
    				default:
    					trace("Unknown control with type:"+controlType);
    			}
            }
			if (parser != null){
                parser.templateRepository = templateRepository;

				var cmp:ComponentModel = new ComponentModel();
				cmp.id = control.@controlID;
				cmp.bmml = control;

				if (NapkeeApplication.application.projectManager.project.nature == StringConstants.PROJECT_NATURE_WEB){
					if (!skipWeb) {
						cmp.html = parser.getHtml();
						cmp.js = parser.getJsDocReady();
						cmp.jsGlobal = parser.getJsImport();
						cmp.css = parser.getCss();
					}
					for (var cZ:int=idx; cZ>=0; cZ--){		
						for each (var checkControl:XML in bmml.controls.control){
							if (checkControl.@zOrder == cZ){
								//parseControl(control,offsetModifier,cZ);
								
								if (checkControl.@controlTypeID == "com.balsamiq.mockups::Accordion" || checkControl.@controlTypeID == "com.balsamiq.mockups::TitleWindow" || checkControl.@controlTypeID == "com.balsamiq.mockups::FieldSet" || checkControl.@controlTypeID == "com.balsamiq.mockups::Canvas" || checkControl.@controlTypeID == "com.balsamiq.mockups::ModalScreen" || checkControl.@controlTypeID == "com.balsamiq.mockups::TabBar" || checkControl.@controlTypeID == "com.balsamiq.mockups::VerticalTabBar"){
									var containerStartX:Number = new Number(checkControl.@x);
									var containerStartY:Number = new Number(checkControl.@y);
									var containerEndX:Number = new Number(checkControl.@x) + new Number((checkControl.@w!="-1")?checkControl.@w:checkControl.@measuredW);
									var containerEndY:Number = new Number(checkControl.@y) + new Number((checkControl.@h!="-1")?checkControl.@h:checkControl.@measuredH);
									var ccontrolStartX:Number = new Number(control.@x);
									var ccontrolStartY:Number = new Number(control.@y);
									var ccontrolEndX:Number = new Number(control.@x) + new Number((control.@w!="-1")?control.@w:control.@measuredW);
									var ccontrolEndY:Number = new Number(control.@y) + new Number((control.@h!="-1")?control.@h:control.@measuredH);
									if (ccontrolStartX > containerStartX && ccontrolStartY > containerStartY && ccontrolEndX < containerEndX && ccontrolEndY < containerEndY && cmp.parent == ""){
										cmp.parent = checkControl.@controlID;
									}
								}
								
							}				
						}
					}
				}

				componentList.addItem(cmp);
			}
		}
		
        public function getBrowserWindowOffset(): OffsetModifier {
            return browserWindowOffset;
        }
		
		public function getBmml():String {
			return bmml.toXMLString();
		}
		
		public function getHtml():String {
			return html;
		}

		public function getCss():String {
			return css;
		}
		
		public function getJs():String {
			return jsDocReady;
		}
		
		public function getMxml():String {
			return mxml;
		}
		
		public function getAs():String {
			return asC;
		}
		
		public function getDocument():String {
			var fs:FileStream = new FileStream();
			fs.open(File.applicationDirectory.resolvePath("assets/templates/html/preview.template.html"), FileMode.READ);
			var document:String = fs.readUTFBytes(fs.bytesAvailable);
			
			var cp:ComponentParser = new ComponentParser(document);
			cp.setPlaceHolder("HTMLtitle", ApplicationManager.getHTMLTitle());
			cp.setPlaceHolder("style",css);
			if (ApplicationManager.isBrowserOffsetApplied() && browserWindowOffset != null){
				html = "<div id=\"napkeeMainCanvas\" class=\"napkeeComponent\" style=\"top:-"+browserWindowOffset.y+"px;left:-"+browserWindowOffset.x+"px\">\n" + html + "\n</div>\n";
			}
			cp.setPlaceHolder("html",html);
			cp.setPlaceHolder("jsDocReady",jsDocReady);
			
			cp.setPlaceHolder("customCode", ApplicationManager.getHTMLCustomCode());
			
			return cp.getParsed();
		}
		
		
	}
}