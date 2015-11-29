package com.napkee.importers
{
  import com.napkee.utils.StringUtils;
  
  import flash.filesystem.File;
  import flash.filesystem.FileMode;
  import flash.filesystem.FileStream;
  
  import mx.collections.XMLListCollection;
  
  public class FragmentLoader
  {
    
    private var bmml:XML;
    private var lastZOrder:Number;
    private var originalFile:File;
    
    public function FragmentLoader(componentBmml:XML, originalBmmlFile:File)
    {
      originalFile = originalBmmlFile;
      var fragmentFilePath:String = componentBmml.controlProperties.src;
      var groupToLoad:String = "";
      if (fragmentFilePath.indexOf("#") > -1){
        groupToLoad = fragmentFilePath.substring(fragmentFilePath.indexOf("#")+1);
        fragmentFilePath = fragmentFilePath.substring(0,fragmentFilePath.indexOf("#"));
      }
      var fragmentFile:File;
      if (fragmentFilePath.indexOf("%24ACCOUNT") > -1 || fragmentFilePath.indexOf("$ACCOUNT") > -1){
        var assets:File = File.documentsDirectory.resolvePath("Balsamiq Mockups");
        fragmentFile = new File(assets.nativePath + unescape(fragmentFilePath.substr(fragmentFilePath.indexOf("ACCOUNT")+7)));
      }
      else {
        fragmentFile = originalBmmlFile.parent.resolvePath(fragmentFilePath);
      }
      
      
      if (!fragmentFile.exists){
        trace("Problems with the file");
      }
      else {
        var fs:FileStream = new FileStream();
        fs.open(fragmentFile, FileMode.READ);
        bmml = XML(fs.readUTFBytes(fs.bytesAvailable));
        
        var originalControls:XMLList = bmml.controls.control;
        bmml.controls = new XMLList("<controls/>");
        var originalZOrder:Number = componentBmml.@zOrder*1;
        
        var groupFound:Boolean = false;
        for each (var control:XML in originalControls){
          if (groupToLoad != ""){
            if (control.controlProperties.controlName == groupToLoad){
              groupFound = true;
            }
          }
        }
        
        for each (var control:XML in originalControls){
          var appendControl:Boolean = false;				
          if (groupToLoad != ""){
            if (control.controlProperties.controlName == groupToLoad){
              appendControl = true;
            }
          }
          else {
            appendControl = true;
          }
          
          if (appendControl){
            control.@x = componentBmml.@x*1 + (control.@x*1 - (bmml.@measuredW*1 - bmml.@mockupW*1)); 
            control.@y = componentBmml.@y*1 + (control.@y*1 - (bmml.@measuredH*1 - bmml.@mockupH*1));
            for each (var overrider:XML in componentBmml.controlProperties.override){
              if (control.@controlTypeID == "__group__"){
                for each (var innerGroupControl:XML in control.groupChildrenDescriptors.control){
                  if (overrider.@controlID == innerGroupControl.@controlID){
                    var controlProperties:XMLListCollection = new XMLListCollection();
                    if (innerGroupControl.controlProperties != null){
                      controlProperties = new XMLListCollection(innerGroupControl.controlProperties);
                    }
                    for each (var property:XML in overrider.children()){
                      if (controlProperties.elements(property.localName()).length() > 0){
                        controlProperties.elements(property.localName())[0] = property;
                      }
                      else {
                        controlProperties.addItem(property);
                      }
                    }
                    innerGroupControl.controlProperties = controlProperties.copy();
                  }
                }
              }
              else {
                if (overrider.@controlID == control.@controlID){
                  var controlProperties:XMLListCollection = new XMLListCollection();
                  if (control.controlProperties != null){
                    controlProperties = new XMLListCollection(control.controlProperties);
                  }
                  for each (var property:XML in overrider.children()){
                    if (controlProperties.elements(property.localName()).length() > 0){
                      controlProperties.elements(property.localName())[0] = property;
                    }
                    else {
                      controlProperties.addItem(property);
                    }
                  }
                  control.controlProperties = controlProperties.copy();
                  if (StringUtils.isNotBlank(overrider.@w)){
                    control.@w = overrider.@w;
                  }
                  if (StringUtils.isNotBlank(overrider.@h)){
                    control.@h = overrider.@h;
                  }
                  if (StringUtils.isNotBlank(overrider.@x) && Number(control.@x) > 0){
                    control.@x = Number(componentBmml.@x) + Number(overrider.@x);
                  }
                  if (StringUtils.isNotBlank(overrider.@y) && Number(control.@y) > 0){
                    control.@y = Number(componentBmml.@y) + Number(overrider.@y);
                  }
                }
              }
            }
            control.@controlID = componentBmml.@controlID + "_" + control.@controlID;
            if (groupToLoad != ""){
              control.@x = componentBmml.@x*1; 
              control.@y = componentBmml.@y*1;
            }
            else {
              //control.@x = componentBmml.@x*1 + (control.@x*1 - (bmml.@measuredW*1 - bmml.@mockupW*1)); 
              //control.@y = componentBmml.@y*1 + (control.@y*1 - (bmml.@measuredH*1 - bmml.@mockupH*1));
              //if (StringUtils.isNotBlank(overrider.@x)){
              //	control.@x = Number(componentBmml.@x) + Number(overrider.@x);
              //}
              //if (StringUtils.isNotBlank(overrider.@y)){
              //	control.@y = Number(componentBmml.@y) + Number(overrider.@y);
              //}
            } 
            control.@zOrder = originalZOrder++;
            lastZOrder = control.@zOrder*1;
            bmml.controls.appendChild(control);
          }
          if (groupToLoad != "" && !groupFound){
            bmml.controls.appendChild(componentBmml);
            lastZOrder = componentBmml.@zOrder*1;
          } 
        }
      }
    }
    
    public function exists():Boolean
    {
      return bmml != null;
    }
    
    public function getModifiedControls():XMLList
    {
      if (bmml != null)
        return bmml.controls.control;
      else
        return null;
    }
    
    public function getLastZOrder():Number
    {
      return lastZOrder;
    }
    
    
    
  }
}