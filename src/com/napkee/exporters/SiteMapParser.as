package com.napkee.exporters
{
	import com.napkee.domain.TreeModel;
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringUtils;
	
	import mx.controls.Tree;
	import mx.core.UIComponent;
	import mx.utils.StringUtil;
	
	public class SiteMapParser extends BasicParser implements IControlParser
	{
		
		public function SiteMapParser(controlCode:XML,offsetModifier:OffsetModifier)
		{
			super(controlCode,offsetModifier);
            templateName = "sitemap.xml";
			if (StringUtils.isBlank(control.controlProperties.text)){
				control.controlProperties.text = "Home%0A-%20Products%0A--%20Product%201%0A--%20Product%202%0A-%20About%20Us%5CrCompany%0A-%20Support%0A-%20Blog";
			}
		}
		
		public override function getHtml():String
		{
			var cp:ComponentParser = getBaseHtml();
			
			// the new lines are %0A
			// open folder: f,[-],[ ],v
			// closed folder: F,[+],[x],>			
			var code:String = "";
			
			var parsedTree:TreeModel = onRunAlgorithm(control.controlProperties.text);
			
			code = recurseHTML(parsedTree.children);
			cp.setPlaceHolder("code",code.substring(4,code.length-5));
			
			return cp.getParsed();			
		}
		
		public override function getJsDocReady():String
		{
			var cp:ComponentParser = getBaseJsDocReady();
			cp.setPlaceHolder("clickCode",getJsMultipleLinks());
			return cp.getParsed();
		}
		
		
		
		private function onRunAlgorithm(treeString:String):TreeModel
		{
			//treeString = treeString.replace(/\r\n/g, "\n").replace(/\r/g, "\n"); //Normalize newlines to only have \n's
			var lines:Array = treeString.split("%0A");
			var tree:TreeModel = new TreeModel("Tree");
			var prevModel:TreeModel = null;
			var prevParent:TreeModel = tree;
			var currentLevel:int = 0;
			for (var i:int = 0; i<lines.length; i++) {
				var line:String = unescape(lines[i]);
				var level:int = 0;
				if (line.charAt(0) == ".") { //Count points in the beginning
					level = line.match(/\.+/)[0].length;
				}
				else if (line.charAt(0) == "-") { //Count spaces in the beginning
					level = line.match(/-+/)[0].length;
				}
					
				var model:TreeModel = new TreeModel(line.substr(level));
				if (level == currentLevel || !prevModel) {
					//Add to same old parent
					model.parent = prevParent;
					prevParent.children.push(model);
				}
				else if (level > currentLevel) {
					//Add to children of prev node
					currentLevel++;
					if (level > currentLevel) model.problem = true;
					model.parent = prevModel;
					prevModel.children.push(model);
					prevParent = prevModel;
				}
				else {
					//Add to parent of parent child
					for (var j:int = currentLevel; j > level; j--) prevParent = prevParent.parent;
						currentLevel = level;
						model.parent = prevParent;
						prevParent.children.push(model);
					}
					prevModel = model;
				}

				return tree;
		}
		
		private function recurseXML(startingNode:XML,children:Array):XML
		{
			for (var i:int = 0; i<children.length; i++) {
				var child:TreeModel = children[i];
				var childXML:XML = <node/>;
				childXML.@label = StringUtils.getHtmlString(purgeSpecialChars(child.label)) + (child.problem?" [corrected]":"");
				recurseXML(childXML,child.children);
				startingNode.appendChild(childXML);
			}
			return startingNode;
		}
		
		private var incrementalIndex:int = 0;
		private function recurseHTML(children:Array):String
		{
			var output:String = "";
			output += "<ul>";
			for (var i:int = 0; i<children.length; i++) {
				var child:TreeModel = children[i];
				var childXML:XML = <node/>;
				childXML.@label = purgeSpecialChars(child.label) + (child.problem?" [corrected]":"");
				output += "<li id=\""+(getComponentID() + "i" + incrementalIndex)+"\">";
				output += "<span>"+StringUtils.escapeCharsAndGetHtml(purgeSpecialChars(child.label), true)+"</span>";
				incrementalIndex++;
				output += recurseHTML(child.children); 
				output += "</li>";
			}
			output += "</ul>";
			return output;	
		}
		
		private function purgeSpecialChars(line:String):String
		{
			if (line.substr(0,1).toLowerCase() == "f")
				return StringUtil.trim(line.substr(1));
			if (line.substr(0,1) == "[" && line.substr(2,1) == "]")
				return StringUtil.trim(line.substr(3));
			if (line.substr(0,1) == "v")
				return StringUtil.trim(line.substr(1));
			if (line.substr(0,1) == ">")
				return StringUtil.trim(line.substr(1));
			if (line.substr(0,1) == "-")
				return StringUtil.trim(line.substr(1));
			if (line.substr(0,1) == "_")
				return StringUtil.trim(line.substr(1));
			return line;
		}
		
	}
}