package com.napkee.managers
{
  import com.napkee.export.ExportSpec;
  import com.napkee.export.ExportTaskBuilder;
  import com.napkee.utils.StringUtils;
  
  import flash.filesystem.File;
  
  public class RepositoryManager
  {
    public function RepositoryManager() {
    }
    
    public static function initRepository():void {
      var folder:File = File.applicationStorageDirectory.resolvePath("content");
      if (folder.exists)
        folder.deleteDirectory(true);
      
      folder.createDirectory();
      
      var cssDir:File = File.applicationDirectory.resolvePath("assets/templates/html/css");
      var cssDestDir:File = File.applicationStorageDirectory.resolvePath("content/css");
      cssDir.copyTo(cssDestDir);
      
      if (StringUtils.isNotBlank(ApplicationManager.getAdditionalFolder())){
        var additionalFolder:File = new File(ApplicationManager.getAdditionalFolder());
        if (additionalFolder.exists){
          var destAdditionalFolder:File = folder.resolvePath(additionalFolder.name);
          additionalFolder.copyTo(destAdditionalFolder,true);
        }
      } 
      
      var imagesDir:File = File.applicationDirectory.resolvePath("assets/templates/html/images");
      var imagesDestDir:File = File.applicationStorageDirectory.resolvePath("content/images");
      imagesDir.copyTo(imagesDestDir);
      
      var importedImagesDestDir:File = File.applicationStorageDirectory.resolvePath("content/images/imported");
      importedImagesDestDir.createDirectory();
      
      var fontDir:File = File.applicationDirectory.resolvePath("assets/templates/html/font");
      var fontDestDir:File = File.applicationStorageDirectory.resolvePath("content/font");
      fontDir.copyTo(fontDestDir,true);
      
      var iconsDir:File = File.applicationDirectory.resolvePath("assets/templates/html/icons");
      var iconsDestDir:File = File.applicationStorageDirectory.resolvePath("content/"+ApplicationManager.getHTMLIconsFolder());
      iconsDir.copyTo(iconsDestDir,true);
      
      var jsDir:File = File.applicationDirectory.resolvePath("assets/templates/html/js");
      var jsDestDir:File = File.applicationStorageDirectory.resolvePath("content/js");
      jsDir.copyTo(jsDestDir);
      
      var swfDir:File = File.applicationDirectory.resolvePath("assets/templates/html/swf");
      var swfDestDir:File = File.applicationStorageDirectory.resolvePath("content/swf");
      swfDir.copyTo(swfDestDir);
      
      
      var original:File = File.applicationDirectory.resolvePath("assets/templates/html/preview.template.html");
      var newFile:File = File.applicationStorageDirectory.resolvePath("content/preview.html");
      original.copyTo(newFile, true);
    }
    
    public static function copyHtmlAssetsToFolder(path:String):void {
      var destFolder:File = new File(path);
      
      var cssDir:File = File.applicationDirectory.resolvePath("assets/templates/html/css");
      var cssDestDir:File = destFolder.resolvePath("css");
      cssDir.copyTo(cssDestDir);
      
      if (StringUtils.isNotBlank(ApplicationManager.getAdditionalFolder())){
        var additionalFolder:File = new File(ApplicationManager.getAdditionalFolder());
        if (additionalFolder.exists){
          var destAdditionalFolder:File = destFolder.resolvePath(additionalFolder.name);
          additionalFolder.copyTo(destAdditionalFolder,true);
        }
      } 
      
      var imagesDir:File = File.applicationDirectory.resolvePath("assets/templates/html/images");
      var imagesDestDir:File = destFolder.resolvePath("images");
      imagesDir.copyTo(imagesDestDir);
      
      var fontDir:File = File.applicationDirectory.resolvePath("assets/templates/html/font");
      var fontDestDir:File = destFolder.resolvePath("font");
      fontDir.copyTo(fontDestDir);
      
      
      var iconsDir:File = File.applicationDirectory.resolvePath("assets/templates/html/icons");
      var iconsDestDir:File = destFolder.resolvePath(ApplicationManager.getHTMLIconsFolder());
      iconsDir.copyTo(iconsDestDir);
      
      var jsDir:File = File.applicationDirectory.resolvePath("assets/templates/html/js");
      var jsDestDir:File = destFolder.resolvePath("js");
      jsDir.copyTo(jsDestDir);
      
      var swfDir:File = File.applicationDirectory.resolvePath("assets/templates/html/swf");
      var swfDestDir:File = destFolder.resolvePath("swf");
      swfDir.copyTo(swfDestDir);
      
      
      var original:File = File.applicationDirectory.resolvePath("assets/templates/html/preview.template.html");
      var newFile:File = destFolder.resolvePath("preview.html");
      original.copyTo(newFile, true);
    }
    
    
    public static function removeTripleZero(folder:File):void {
      var listFiles:Array = folder.getDirectoryListing();
      for each(var f:File in listFiles) {
        if (f.isDirectory) {
          removeTripleZero(f);
        }
        else {
          f.moveTo(new File(f.nativePath.substring(0,f.nativePath.length-4)),true);
        }
      }			
    }
  }
}