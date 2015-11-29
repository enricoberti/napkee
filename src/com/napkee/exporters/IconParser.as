package com.napkee.exporters
{
  import com.napkee.managers.ApplicationManager;
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringConstants;
  import com.napkee.utils.StringUtils;
  import com.napkee.vo.BMMLFile;
  
  import flash.filesystem.File;
  import flash.system.Capabilities;
  
  import mx.controls.Image;
  import mx.core.FlexGlobals;
  import mx.core.UIComponent;
  
  public class IconParser extends BasicParser implements IControlParser
  {
    
    public function IconParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      loadApplicationTemplate(StringConstants.COMPONENTS_FOLDER + "icon.xml");
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
      
      if (getCustomCss().indexOf("icon-") > -1 && isDefaultIcon==true){
        var rotationClass:String = "";
        if (control.controlProperties.rotation != null){
          rotationClass = " icon-rotate-"+(360-control.controlProperties.rotation*1);
        }
        code = '<i id="'+getComponentID()+'" class="napkeeComponent napkeeIcon '+getCustomCss()+rotationClass+'"></i>';	
      }
      else {
        var rotationClass:String = "";
        if (control.controlProperties.rotation != null){
          rotationClass = "rotate"+(360-control.controlProperties.rotation*1);
        }
        code = '<img id="'+getComponentID()+'" src="'+source+'" class="napkeeComponent napkeeIcon '+rotationClass+'" />';
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
      var path:String = ApplicationManager.getHTMLIconsFolder()+"/napkee/"+iconName+".png";
      return path;
    }
    
    private function getBootstrapIcon(iconStr:String):String
    {
      var iconComponents:Array = iconStr.split("%7C");
      var sizePx:String = "";
      var size:String = "small";
      var iconName:String = "";
      if (iconComponents.length > 1){
        iconName = iconComponents[0];
        size = iconComponents[1];
      }
      
      var maps:Object = new Object();
      maps["GtCircledIcon"] = "icon-play-circle";
      var path:String = maps[iconName];
      if (StringUtils.isBlank(path)){
        path = "icon-check-empty";
      }
      return path;
    }
    
    public override function getCss():String
    {
      var cp:ComponentParser = getBaseCss();
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