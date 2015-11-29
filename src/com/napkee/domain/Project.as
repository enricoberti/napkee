package com.napkee.domain
{
  import com.napkee.vo.BMMLFile;
  
  import flash.events.Event;
  import flash.events.EventDispatcher;
  
  import mx.collections.ArrayCollection;
  
  
  public class Project extends EventDispatcher
  {
    
    public static const MODEL_CHANGED:String = 'model_changed';
    
    [Bindable] public var name:String;
    [Bindable] public var nature:String;
    [Bindable] public var path:String;
    [Bindable] public var isSaved:Boolean = false;
    [Bindable] public var files:ArrayCollection;
    
    
    public function Project()
    {
    }
    
    public function setName(projectName:String):void
    {
      name = projectName;
      isSaved = false;
      this.dispatchEvent(new Event(Project.MODEL_CHANGED));
    }
    
    public function setNature(projectNature:String):void
    {
      nature = projectNature;
      isSaved = false;
      this.dispatchEvent(new Event(Project.MODEL_CHANGED));
    }
    
    public function setPath(projectPath:String):void
    {
      path = projectPath;
    }
    
    public function addFile(file:BMMLFile):void
    {
      files.addItem(file);
      isSaved = false;
      this.dispatchEvent(new Event(Project.MODEL_CHANGED));
    }
    
    public function removeFile(file:BMMLFile):int
    {
      var returnIndex:int = -1;
      var idx:int = 0;
      for each(var mockupFile:BMMLFile in files){
        if (mockupFile.file.nativePath == file.file.nativePath){
          files.removeItemAt(idx);
          returnIndex = idx;
        }
        idx++;
      }
      isSaved = false;
      this.dispatchEvent(new Event(Project.MODEL_CHANGED));
      return returnIndex;
    }
    
    public function markToSave():void
    {
      isSaved = false;
      this.dispatchEvent(new Event(Project.MODEL_CHANGED));
    }
    
    public function markAsSaved():void
    {
      isSaved = true;
      this.dispatchEvent(new Event(Project.MODEL_CHANGED));
    }
    
  }
}
