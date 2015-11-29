package com.napkee.exporters
{
  import com.adobe.utils.StringUtil;
  import com.napkee.NapkeeApplication;
  import com.napkee.managers.ApplicationManager;
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringUtils;
  
  import flash.filesystem.File;
  import flash.filesystem.FileMode;
  import flash.filesystem.FileStream;
  
  import mx.core.UIComponent;
  
  public class BasicParser implements IControlParser {
    private var _xmlTemplate:XML = null;
    public var control:XML = new XML();
    public var PREFIX:String = ApplicationManager.getPrefix();
    public var offset:OffsetModifier;
    public var customDataArray:Array = new Array();
    public var customData:String = "";
    public var prefilledCustomCss:String = "";
    
    private var _templateName:String;
    private var _templateRepository: TemplateRepository;
    
    public function BasicParser(controlCode:XML,offsetModifier:OffsetModifier, customCssClass:String="") {
      control = controlCode;
      offset = offsetModifier;
      customDataArray = getCustomData();
      customData = getCustomDataRaw();
      prefilledCustomCss = customCssClass;
    }
    
    public function getComponentID():String {
      if (StringUtils.isNotBlank(control.controlProperties.customID)){
        return control.controlProperties.customID;	
      }
      else { 
        return PREFIX + control.@controlID;
      }
    }
    
    public function getWidth():Number {
      return new Number((control.@w!="-1")?control.@w:control.@measuredW);
    }
    
    public function getHeight():Number {
      return new Number((control.@h!="-1")?control.@h:control.@measuredH);
    }
    
    public function getTop():Number {
      return new Number(control.@y);
    }
    
    public function getLeft():Number {
      return new Number(control.@x);
    }
    
    public function getCustomDataRaw():String {
      if (StringUtils.isNotBlank(control.controlProperties.customData)){
        return unescape(unescape(control.controlProperties.customData));
      }
      return "";
    }
    
    public function getCustom(key:String):String {
      for (var i:int = 0;i<customDataArray.length;i++){
        var item:String = customDataArray[i] as String;
        if (item.toLowerCase().indexOf(key.toLowerCase()) > -1){
          if (item.indexOf("=") > -1){
            return item.split("=")[1] + "";
          }
          else {
            return "true";
          }
        }
      }
      return "";
    }
    
    public function getCustomData():Array {
      if (StringUtils.isNotBlank(control.controlProperties.customData)){
        var code:String = unescape(unescape(control.controlProperties.customData));
        return code.split(String.fromCharCode(13));
      }
      else {
        return new Array();
      }
    }
    
    public function getCustomCss():String {
      var customCss:String = "";
      var customData:Array = getCustomData();
      for (var i:int = 0;i<customData.length;i++){
        var item:String = customDataArray[i] as String;
        if (item.toLocaleLowerCase() != ".napkee" && item.charAt(0) == "."){
          customCss += " " + item.substr(1);
        }
      }
      return customCss;
    }
    
    public function set templateRepository(repo: TemplateRepository): void {
      this._templateRepository = repo;
    }
    
    public function get xmlTemplate(): XML {
      if (_xmlTemplate == null) {
        var file:File = _templateRepository.findTemplateFile(templateName);
        var fs:FileStream = new FileStream();
        fs.open(file, FileMode.READ);
        _xmlTemplate = XML(fs.readUTFBytes(fs.bytesAvailable));
        fs.close();
      }
      return _xmlTemplate;
    }
    
    public function get templateName(): String {
      return _templateName;
    }
    
    public function set templateName(name:String): void {
      _templateName = name;
      _xmlTemplate = null;
    }
    
    public function loadApplicationTemplate(source:String): void {
      if (NapkeeApplication.application.iconXML == null) {
        var fs:FileStream = new FileStream();
        fs.open(File.applicationDirectory.resolvePath(source), FileMode.READ);
        _xmlTemplate = XML(fs.readUTFBytes(fs.bytesAvailable));
        NapkeeApplication.application.iconXML = xmlTemplate;
      } else {
        _xmlTemplate = NapkeeApplication.application.iconXML;
      }
    }
    
    public function getHtml():String {
      var cp:ComponentParser = getBaseHtml();
      return cp.getParsed();	
    }
    
    public function getCss():String {
      var cp:ComponentParser = getBaseCss();
      return cp.getParsed();	
    }
    
    public function getJsImport():String {
      var jsGlobal:String = "";
      if (customDataArray.length > 0){
        for (var i:int = 0;i<customDataArray.length;i++){
          if (customDataArray[i].indexOf("I") > -1){
            var parts:Array = customDataArray[i].split(":");
            if (parts.length > 1){
              var status:String = parts[1];
              if (status == "hidden"){
                jsGlobal += "$(\"#"+getComponentID()+"\").hide();\n";	
              }
              else {
                jsGlobal += status + "\n";	
              }
            }		
          }
        }
      }
      return jsGlobal;
    }
    
    public function getJsDocReady():String {
      var cp:ComponentParser = getBaseJsDocReady();
      return cp.getParsed();	
    }
    
    public function getCssImport():String {
      return "";
    }
    
    public function escapeCommas():void {
      // deal with escape chars			
      var componentText:String = control.controlProperties.text;
      while (componentText.indexOf("%5C%2C")>-1){
        componentText = componentText.substring(0,componentText.indexOf("%5C%2C")) + ","+ componentText.substr(componentText.indexOf("%5C%2C")+6);
      }
      control.controlProperties.text = componentText;
    }
    
    public function getBaseHtml():ComponentParser {
      var cp:ComponentParser = new ComponentParser(xmlTemplate.children()[0]);
      cp.setPlaceHolder("id",getComponentID());
      // new icons folder
      cp.setPlaceHolder("iconsFolder", "icons");
      //			var customClass:String = getCustom("class");
      //			if (customClass != ""){
      //				cp.addCssClass(customClass);
      //			}
      if (getCustomData().indexOf(".napkee") > -1){
        cp.setPlaceHolder("style", "napkee");
      }
      
      cp.setPlaceHolder("style", prefilledCustomCss + getCustomCss());
      
      return cp;			
    }
    
    public function getBaseCss():ComponentParser {
      var cp:ComponentParser = new ComponentParser(xmlTemplate.children()[1]);
      cp.setPlaceHolder("iconsFolder", "icons");
      cp.setPlaceHolder("id",getComponentID());
      cp.setPlaceHolder("left",((offset !=null)?control.@x-offset.x:control.@x)+"px");
      cp.setPlaceHolder("top",((offset !=null)?control.@y-offset.y:control.@y)+"px");
      if (getCustom("forgetsize") == "true" || getCustom("nosize") == "true"){
        cp.removeCssAttribute("width");
        cp.removeCssAttribute("height");
      }
      else {
        if (control.@controlTypeID == "com.balsamiq.mockups::Title" || control.@controlTypeID == "com.balsamiq.mockups::SubTitle" || control.@controlTypeID == "com.balsamiq.mockups::Label"){
          cp.setPlaceHolder("width",(getWidth()*1.1)+"px");
        }
        else {
          cp.setPlaceHolder("width",((control.@w!="-1")?control.@w:control.@measuredW)+"px");
        }
        cp.setPlaceHolder("height",((control.@h!="-1")?control.@h:control.@measuredH)+"px");
      }
      cp.setPlaceHolder("z",control.@zOrder);
      
      if (getCustom("forgetfont") == "true" || getCustom("nofont") == "true"){
        cp.removeCssAttribute("font-size");
        cp.removeCssAttribute("font-style");
        cp.removeCssAttribute("font-weight");
        cp.removeCssAttribute("text-decoration");
        cp.removeCssAttribute("text-align");
        cp.removeCssAttribute("color");
      }
      else {
        if (StringUtils.isNotBlank(control.controlProperties.size)){
          cp.setPlaceHolder("fontSize",control.controlProperties.size+"px");
        }
        else {
          cp.setPlaceHolder("fontSize","14px");
        }
        if (StringUtils.isNotBlank(control.controlProperties.italic) && control.controlProperties.italic == "true"){
          cp.setPlaceHolder("fontStyle","italic");
        }
        else {
          cp.setPlaceHolder("fontStyle","normal");
        }
        if (StringUtils.isNotBlank(control.controlProperties.bold) && control.controlProperties.bold == "true"){
          cp.setPlaceHolder("fontWeight","bold");
        }
        else {
          cp.setPlaceHolder("fontWeight","normal");
        }
        if (StringUtils.isNotBlank(control.controlProperties.underline) && control.controlProperties.underline == "true"){
          cp.setPlaceHolder("textDecoration","underline");
        }
        else {
          cp.setPlaceHolder("textDecoration","none");
        }
        if (StringUtils.isNotBlank(control.controlProperties.align)){
          cp.setPlaceHolder("textAlign",control.controlProperties.align);
        }
        else {
          cp.setPlaceHolder("textAlign","left");
        }
      }
      return cp;
    }
    
    public function getBaseJsDocReady():ComponentParser {
      var cp:ComponentParser = new ComponentParser(xmlTemplate.children()[2]);
      cp.setPlaceHolder("id",getComponentID());
      return cp;
    }
    
    public function getJsSingleLink():String {
      var customDataCode:String = getCustom("click");
      
      var hrefStr:String = control.controlProperties.href;
      
      if (hrefStr.indexOf("%26bm%3B")>-1){
        // new version of Balsamiq Links
        return customDataCode + getJsSingleLinkFromString(hrefStr.split("%26bm%3B")[1]);
      } 
      else {
        return customDataCode + getJsSingleLinkFromString(control.controlProperties.href);
      }
    }
    
    public function getJsSingleLinkFromString(str:String, params:String = ""):String {
      var clickCode:String = "";
      if (StringUtils.isNotBlank(str)){
        var link:String = str.toString();
        clickCode = "showMockup('"+StringUtils.getNormalizedName(unescape(link))+".html');";
      }
      clickCode += "\n";
      clickCode += "\tevent.stopPropagation();\n";
      clickCode += "\tevent.preventDefault();\n";
      return clickCode;
    }
    
    public function getJsMultipleLinks():String {
      var customDataCode:String = '\n$("#'+getComponentID()+'").click(function(event){\n';
      var customParams:String = "";
      if (customDataArray.length > 0){
        
        for (var i:int = 0;i<customDataArray.length;i++){
          if (customDataArray[i].indexOf("J") > -1){
            var parts:Array = customDataArray[i].split(":");
            if (parts.length > 1){
              customDataCode += parts[1];
            }		
          }
          if (customDataArray[i].indexOf("H") > -1){
            var parts:Array = customDataArray[i].split(":");
            if (parts.length > 1){
              customDataCode += "hideElement('"+parts[1]+"');\n";
            }		
          }
          if (customDataArray[i].indexOf("S") > -1){
            var parts:Array = customDataArray[i].split(":");
            if (parts.length > 1){
              customDataCode += "showElement('"+parts[1]+"');\n";
            }		
          }
          if (customDataArray[i].indexOf("T") > -1){
            var parts:Array = customDataArray[i].split(":");
            if (parts.length > 1){
              customDataCode += "toggleElement('"+parts[1]+"');\n";
            }		
          }
          if (customDataArray[i].indexOf("params") > -1){
            var parts:Array = customDataArray[i].split(":");
            if (parts.length > 1){
              var specifiedParams:Array = parts[1].split(",");
              customParams = "{";
              for (var j:int = 0; j<specifiedParams.length; j++){
                customParams += specifiedParams[j];
              }
              customParams += "}";
            }		
          }
        }
      }
      customDataCode += "});\n";
      var clickCode:String = "";
      if (StringUtils.isNotBlank(control.controlProperties.hrefs)){
        var linkedFiles:Array = (control.controlProperties.hrefs).split("%2C");
        for (var l:int = 0;l<linkedFiles.length;l++){
          clickCode += '\n$("#'+(getComponentID() + "i" + l)+'").click(function(event){\n';
          var link:String = "";
          var hrefStr:String = linkedFiles[l];
          if (hrefStr.indexOf("%26bm%3B")>-1){
            link = hrefStr.split("%26bm%3B")[1];
          }
          else {
            link = StringUtil.trim(unescape(linkedFiles[l] as String));
          }
          
          if (StringUtils.isNotBlank(link)){
            clickCode += "\t"+getJsSingleLinkFromString(link) + "\n";
          }
          clickCode += "});\n";
        }
      }
      return customDataCode + clickCode;
    }
    
  }
}