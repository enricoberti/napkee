package com.napkee.managers
{
  import com.adobe.air.filesystem.FileMonitor;
  import com.adobe.air.filesystem.events.FileMonitorEvent;
  import com.adobe.utils.StringUtil;
  import com.napkee.NapkeeApplication;
  import com.napkee.domain.ApplicationSetting;
  import com.napkee.domain.Project;
  import com.napkee.utils.FileUtils;
  import com.napkee.utils.StringConstants;
  import com.napkee.utils.StringUtils;
  import com.napkee.vo.BMMLFile;
  import com.napkee.vo.BMPRFile;
  
  import flash.data.SQLConnection;
  import flash.data.SQLMode;
  import flash.data.SQLResult;
  import flash.data.SQLStatement;
  import flash.events.Event;
  import flash.events.SQLErrorEvent;
  import flash.events.SQLEvent;
  import flash.filesystem.File;
  import flash.filesystem.FileMode;
  import flash.filesystem.FileStream;
  import flash.net.FileFilter;
  import flash.xml.XMLDocument;
  import flash.xml.XMLNode;
  
  import mx.collections.ArrayCollection;
  import mx.controls.Alert;
  import mx.controls.Button;
  import mx.core.FlexGlobals;
  import mx.rpc.xml.SimpleXMLEncoder;
  
  public class ProjectManager
  {
    
    [Bindable] public var project: Project;
    [Bindable] public var filesCounterLabel: String = "";
    
    public var projectFile:File;
    public var projectContent:XML;
    
    public var selectedIndex:int = -1;
    
    public var monitor:FileMonitor = new FileMonitor();
    
    public function ProjectManager()
    {
      project = new Project();
      project.addEventListener(Project.MODEL_CHANGED, onModelChanged);
    }
    
    private function onModelChanged(event:Event):void
    {
      if (project.files != null){
        filesCounterLabel = project.files.length + " file" + (project.files.length!=1?"s":"");
        if (project.files.length == 0){
          FlexGlobals.topLevelApplication.exportProjectBtn.enabled = false;
        }
        else {
          FlexGlobals.topLevelApplication.exportProjectBtn.enabled = true;
        }
      }
      UIManager.changeTitleBar();
    }
    
    public function newProject(event:Event):void
    {
      projectFile = null;
      UIManager.clearPanels();
      project.name = StringConstants.NEW_PROJECT;
      project.nature = StringConstants.PROJECT_NATURE_WEB;
      
      UIManager.showWebNature();
      
      project.files = new ArrayCollection();
      project.markAsSaved();
      
      deleteLastOpenedProject();
    }
    
    public function loadProject(event:Event):void
    {
      
      if (!project.isSaved){
        //TODO: handle project not saved
      }
      projectFile = new File();
      projectFile.addEventListener(Event.SELECT, loadProjectEventHandler);
      projectFile.browseForOpen("Select a Napkee project file",[new FileFilter("Napkee Project", "*.nee")]);
    }
    
    private function loadProjectEventHandler(e:Event): void {
      var fileName:String = projectFile.nativePath.toString();
      openProjectFile(fileName);
    }
    
    public function openProjects(files: Array): void {
      for (var i:int=0; i<files.length; i++){
        if (files[i].indexOf(".nee") != -1 ){
          openProjectFile(files[i]);
        }
      }
    }
    
    public function openProjectFile(fileName:String): void {
      if (!FileUtils.exists(fileName)){
        Alert.show("Napkee cannot load the project ("+fileName+")!");
        newProject(null);
        return;
      }
      else {
        projectFile = new File(fileName);
      }
      
      if(fileName.toLowerCase().indexOf(".nee") != -1){
        var fs:FileStream = new FileStream();
        fs.open(projectFile, FileMode.READ);
        projectContent = XML(fs.readUTFBytes(fs.bytesAvailable));
        fs.close();
        
        project.name = projectContent.@name;
        project.nature = projectContent.@nature;
        project.path = projectFile.parent.nativePath;
        
        UIManager.showWebNature();
        
        project.files = new ArrayCollection();
        var filesNotAvailable:Array = new Array();
        
        for each (var file:XML in projectContent.mockups.file){
          var path:String = file.@path;
          if (StringUtil.beginsWith(path,".")){
            // it's a relative path
            path = project.path + File.separator + path;
          }
          try {
            var realFile:File = new File(path);
            if (realFile.exists){
              var fi:BMMLFile = new BMMLFile();
              fi.file = new File(path);
              project.addFile(fi);
            } else {
              filesNotAvailable.push(path);
            }
          } catch(error:Error){
            filesNotAvailable.push(path);
          }
        }
        if (filesNotAvailable.length > 0){
          Alert.show("Some files are not available anymore: "+filesNotAvailable);
          project.markToSave();
        } else {
          project.markAsSaved();
        }
        saveLastOpenedProject();
        
      }
      else {
        Alert.show("Napkee can load just Napkee project files (.nee)!");
      }
    }
    
    public function openProjectFileSilent(fileName:String):void {
      
      if (!FileUtils.exists(fileName)){
        trace("Napkee cannot load the  project ("+fileName+")!");
        NapkeeApplication.application.exit();
      }
      else {
        trace("Exporting "+fileName+"...");
        projectFile = new File(fileName);
      }
      
      if(fileName.toLowerCase().indexOf(".nee") != -1){
        var fs:FileStream = new FileStream();
        fs.open(projectFile, FileMode.READ);
        projectContent = XML(fs.readUTFBytes(fs.bytesAvailable));
        fs.close();
        
        project.name = projectContent.@name;
        project.nature = projectContent.@nature;
        project.path = projectFile.parent.nativePath;
        
        project.files = new ArrayCollection();
        var filesNotAvailable:Array = new Array();
        
        for each (var file:XML in projectContent.mockups.file){
          var path:String = file.@path;
          if (StringUtil.beginsWith(path,".")){
            // it's a relative path
            path = project.path + File.separator + path;
          }
          try {
            var realFile:File = new File(path);
            if (realFile.exists){
              var fi:BMMLFile = new BMMLFile();
              fi.file = new File(path);
              project.addFile(fi);
            }
            else {
              filesNotAvailable.push(path);
            }
          }
          catch(error:Error){
            filesNotAvailable.push(path);
          }
        }
        
        if (filesNotAvailable.length > 0){
          trace("Some files are not available anymore: "+filesNotAvailable);
          project.markToSave();
        }
        else {
          project.markAsSaved();
        }
        
        //saveLastOpenedProject();
        
      }
      else{
        trace("Napkee can load just Napkee project files (.nee)!");
      }
    }
    
    public function saveProject(event:Event):void
    {
      
      if (projectFile == null){
        // asks to save the file
        saveProjectAs(null);
      }
      else {
        writeProjectToFile();
      }
    }
    
    public function saveProjectAs(event:Event):void
    {
      var f:File = File.desktopDirectory;
      f.browseForSave("Save As Napkee project");
      f.addEventListener(Event.SELECT, function (event:Event):void {
        projectFile = event.target as File;
        if (projectFile.extension != "nee"){ 
          projectFile.url = projectFile.url + ".nee" 
        }
        writeProjectToFile();
      });
    }
    
    private function writeProjectToFile():void
    {
      var stream:FileStream = new FileStream();
      stream.open(projectFile,FileMode.WRITE);
      stream.writeUTFBytes(getProjectContent().toXMLString());
      stream.close();
      saveLastOpenedProject();
      project.markAsSaved();
    }
    
    public function loadLastOpenedProject():void
    {
      var lastOpenedProject:String = NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.LAST_PROJECT) as String;
      if (lastOpenedProject != null){
        openProjectFile(lastOpenedProject);
      }
      else {
        newProject(null);
      }
    }
    
    private function saveLastOpenedProject():void
    {
      var lastOpenedProject:ApplicationSetting = NapkeeApplication.application.applicationSettingsDAO.getSettingObj(StringConstants.LAST_PROJECT);
      if (lastOpenedProject == null){
        NapkeeApplication.application.applicationSettingsDAO.createSetting(StringConstants.LAST_PROJECT,projectFile.nativePath);
      }
      else {
        lastOpenedProject.value = projectFile.nativePath;
        NapkeeApplication.application.applicationSettingsDAO.updateSettingObj(lastOpenedProject);
      }
    }
    
    private function deleteLastOpenedProject():void
    {
      var lastOpenedProject:ApplicationSetting = NapkeeApplication.application.applicationSettingsDAO.getSettingObj(StringConstants.LAST_PROJECT);
      if (lastOpenedProject != null){
        NapkeeApplication.application.applicationSettingsDAO.removeSettingObj(lastOpenedProject);
      }
    }
    
    private function getProjectContent():XML
    {
      var currentContent:XML = <napkee><mockups></mockups></napkee>;
      currentContent.@version = "1.0";
      currentContent.@nature = project.nature;
      currentContent.@name = project.name;
      for each(var mockupFile:BMMLFile in project.files){
        var fi:XML = <file/>;
        if (projectFile != null){
          var relPath:String = projectFile.parent.getRelativePath(mockupFile.file,true);
          if (StringUtils.isNotBlank(relPath))
            fi.@["path"] = "." + File.separator + relPath;
          else
            fi.@["path"] = mockupFile.file.nativePath;
        }
        else {
          fi.@["path"] = mockupFile.file.nativePath;
        }
        currentContent.mockups.appendChild(fi);
      }
      return currentContent;
    }
    
    public function addProject(bmprFile:BMPRFile):void
    {
      var conn:SQLConnection = new SQLConnection(); 
      
      conn.addEventListener(SQLEvent.OPEN, openHandler); 
      conn.addEventListener(SQLErrorEvent.ERROR, errorHandler); 
      
      conn.openAsync(bmprFile.file, SQLMode.READ); 
      
      
      
      function openHandler(event:SQLEvent):void 
      { 
        var selectStmt:SQLStatement = new SQLStatement(); 
        selectStmt.sqlConnection = conn; 
        selectStmt.text = "SELECT * FROM RESOURCES"; 
        
        selectStmt.addEventListener(SQLEvent.RESULT, resultHandler); 
        selectStmt.addEventListener(SQLErrorEvent.ERROR, errorHandler); 
        
        selectStmt.execute(); 
        
        function mockupJSONToXML(obj:Object):XML
        {
          var qName:QName = new QName("mockup");
          var xmlDocument:XMLDocument = new XMLDocument();
          var simpleXMLEncoder:SimpleXMLEncoder = new SimpleXMLEncoder(xmlDocument);
          var xmlNode:XMLNode = simpleXMLEncoder.encodeValue(obj, qName, xmlDocument);
          var xml:XML = new XML(xmlDocument.toString());
          return xml;
        }
        
        function resultHandler(event:SQLEvent):void 
        { 
          var result:SQLResult = selectStmt.getResult(); 
          var tempDir:File = File.createTempDirectory();
          var numResults:int = result.data.length; 
          for (var i:int = 0; i < numResults; i++) 
          { 
            var row:Object = result.data[i];
            var id:String = row.ID;
            var attrs:Object = JSON.parse(row.ATTRIBUTES);
            
            trace(tempDir.nativePath);
            if (attrs.mimeType == "text/vnd.balsamiq.bmml") {
              var data:Object = JSON.parse(row.DATA).mockup;
              
              var mockupFile:File = tempDir.resolvePath(id + ".bmml");
              var fs:FileStream = new FileStream();
              fs.open(mockupFile, FileMode.WRITE);
              fs.writeUTFBytes(mockupJSONToXML(data));
              fs.close();
              var fi:BMMLFile = new BMMLFile();
              fi.file = new File(mockupFile.nativePath);
              fi.name = attrs.name;
              addFile(fi);
            }
          } 
        } 
      } 
      
      function errorHandler(event:SQLErrorEvent):void 
      { 
        trace("Error message:", event.error.message); 
        trace("Details:", event.error.details); 
      }
      
      
      
    }
    
    public function addFile(bmmlFile:BMMLFile):void
    {
      try {
        var alreadyInTheProject:Boolean = false;
        for each(var mockupFile:BMMLFile in project.files){
          if (mockupFile.file.nativePath == bmmlFile.file.nativePath){
            alreadyInTheProject = true;
            break;
          }
        }
        if (!alreadyInTheProject){
          FlexGlobals.topLevelApplication.exportProjectBtn.enabled = true;
          
          if (bmmlFile.file.exists){
            
            project.addFile(bmmlFile);
            
            var fs:FileStream = new FileStream();
            fs.open(bmmlFile.file, FileMode.READ);
            var bmml:XML = XML(fs.readUTFBytes(fs.bytesAvailable));
            // search for linked files
            var openLinkedFiles:Boolean = true;
            for each (var checkControl:XML in bmml.controls.control){
              if (openLinkedFiles){
                var hrefStr:String;
                var fileName:String = "";
                var fi:BMMLFile;
                if (StringUtils.isNotBlank(checkControl.controlProperties.href)) {
                  hrefStr = checkControl.controlProperties.href;
                  if (hrefStr.indexOf("%26bm%3B")>-1) 
                    fileName = hrefStr.split("%26bm%3B")[1];
                  else 
                    fileName = hrefStr;
                  fi = new BMMLFile();
                  fi.file = new File(bmmlFile.file.parent.nativePath+File.separator+unescape(fileName));
                  addFile(fi);
                }
                if (StringUtils.isNotBlank(checkControl.controlProperties.hrefs)) {
                  var linkedFiles:Array = (checkControl.controlProperties.hrefs).split("%2C");
                  for (var l:int = 0;l<linkedFiles.length;l++) {
                    hrefStr = linkedFiles[l] as String;
                    if (hrefStr.indexOf("%26bm%3B")>-1)
                      fileName = hrefStr.split("%26bm%3B")[1];
                    else
                      fileName = hrefStr;
                    var link:String = StringUtil.trim(unescape(fileName));
                    if (StringUtils.isNotBlank(link)) {
                      fi = new BMMLFile();
                      fi.file = new File(bmmlFile.file.parent.nativePath+File.separator+unescape(link));
                      addFile(fi);
                    }				
                  }
                }
              }
            }			
          }
        }
      }
      catch(error:Error){
        Alert.show("There was an error while adding the file "+bmmlFile.file.name);
      }	
      
      
    }
    
    public function removeFile(fi:BMMLFile):void
    {
      var idx:int = project.removeFile(fi);
      if (idx == selectedIndex){
        monitor.unwatch();
        UIManager.clearPanels();
      }
      else {
        FlexGlobals.topLevelApplication.fileList.selectedIndex = selectedIndex;
      }
      var ffound:Boolean = false;
      for (var i:Number = 0; i<NapkeeApplication.application.avoidAutoLoad.length; i++){
        var avoidFile:File = NapkeeApplication.application.avoidAutoLoad.getItemAt(i) as File;
        if (avoidFile.nativePath == fi.file.nativePath){
          ffound = true;
        }
      }
      if (!ffound){
        NapkeeApplication.application.avoidAutoLoad.addItem(fi.file);
      }
      
    }
    
    public function startMonitor():void
    {
      monitor.addEventListener(FileMonitorEvent.CHANGE, onFileChange);
      monitor.addEventListener(FileMonitorEvent.MOVE, onFileMove);
      monitor.addEventListener(FileMonitorEvent.CREATE, onFileCreate);
      
    }
    
    public function watchFileChanges(file:File):void
    {
      //monitor.unwatch();
      monitor.file = file;
      monitor.watch();		
    }
    
    private function onFileChange(e:FileMonitorEvent):void
    {
      UIManager.showParsedFile(e.file);
    }
    
    private function onFileMove(e:FileMonitorEvent):void
    {
    }
    
    private function onFileCreate(e:FileMonitorEvent):void
    {
    }
    
  }
}