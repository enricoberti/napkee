package com.napkee.exporters
{
  import com.napkee.domain.TreeModel;
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringUtils;
  
  import mx.controls.Tree;
  import mx.core.UIComponent;
  import mx.utils.StringUtil;
  
  public class TreeParser extends BasicParser implements IControlParser
  {
    
    public function TreeParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "tree.xml";
      if (StringUtils.isBlank(control.controlProperties.text)){
        control.controlProperties.text = "f%20Use%20f%20for%20closed%20folders%0AF%20Use%20F%20for%20open%20folders%0A%5B+%5D%20You%20may%20also%20use%20this%0A%5B-%5D%20and%20this%0A%5Bx%5D%20or%20this%0A%5B%20%5D%20and%20this%0A%3E%20or%20even%20this%0Av%20and%20this%0A-%20Use%20-%20for%20a%20file%20icon%0A_%20or%20_%20to%20leave%20a%20space%20for%20your%20own%20icon%0AF%20use%20spaces%20or%20dots%20for%20hierarchy%0A%20v%20just%20like%0A..-%20this";
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
        else if (line.charAt(0) == " ") { //Count spaces in the beginning
          level = line.match(/\s+/)[0].length;
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
      //if (children.length > 0){
      output += "<ul>";
      //}
      for (var i:int = 0; i<children.length; i++) {
        var child:TreeModel = children[i];
        var childXML:XML = <node/>;
        childXML.@label = purgeSpecialChars(child.label) + (child.problem?" [corrected]":"");
        var cssClass:String = getCssClass(child.label);
        if (cssClass == "closed"){
          output += "<li id=\""+(getComponentID() + "i" + incrementalIndex)+"\" class=\""+cssClass+"\">";
          output += "<span class=\"hand folder\">"+StringUtils.escapeCharsAndGetHtml(purgeSpecialChars(child.label))+"</span>";
          incrementalIndex++;
        }
        else {
          output += "<li id=\""+(getComponentID() + "i" + incrementalIndex)+"\">";
          output += "<span class=\"hand "+cssClass+"\">"+StringUtils.escapeCharsAndGetHtml(purgeSpecialChars(child.label))+"</span>";
          incrementalIndex++;
        }
        if (cssClass != "file")
          output += recurseHTML(child.children); 
        output += "</li>";
      }
      //if (children.length > 0){
      output += "</ul>";
      //}
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
    
    private function getCssClass(line:String):String
    {
      if (line.substr(0,1) == "f")
        return "closed";
      if (line.substr(0,1) == "F")
        return "folder";
      if (line.substr(0,3) == "[+]")
        return "closed";
      if (line.substr(0,3) == "[-]")
        return "folder";
      if (line.substr(0,3) == "[x]")
        return "file";
      if (line.substr(0,3) == "[ ]")
        return "file";
      if (line.substr(0,1) == "v")
        return "folder";
      if (line.substr(0,1) == ">")
        return "closed";
      if (line.substr(0,1) == "-")
        return "file";
      if (line.substr(0,1) == "_")
        return "file";
      return "file";
    }
    
    
  }
}