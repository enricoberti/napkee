package com.napkee.managers
{
	import com.adobe.utils.StringUtil;
	import com.napkee.NapkeeApplication;
	import com.napkee.export.ExportEvent;
	import com.napkee.export.ExportJobManager;
	import com.napkee.export.ExportSpec;
	import com.napkee.export.ExportTaskBuilder;
	import com.napkee.export.settings.FlashRuntimeType;
	import com.napkee.export.settings.IdeType;
	import com.napkee.export.settings.SdkType;
	import com.napkee.importers.BMMLParser;
	import com.napkee.utils.ComponentParser;
	import com.napkee.utils.StringConstants;
	import com.napkee.utils.StringUtils;
	import com.napkee.utils.TimeUtils;
	import com.napkee.vo.BMMLFile;
	import com.napkee.vo.BMPRFile;
	import com.napkee.windows.ExportProjectAskWindow;
	import com.napkee.windows.ExportSingleAskWindow;
	
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragActions;
	import flash.desktop.NativeDragManager;
	import flash.events.Event;
	import flash.events.FileListEvent;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.setTimeout;
	
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.core.FlexGlobals;
	import mx.core.IFlexDisplayObject;
	import mx.events.CloseEvent;
	import mx.events.DividerEvent;
	import mx.events.DragEvent;
	import mx.events.ListEvent;
	import mx.managers.CursorManager;
	import mx.managers.PopUpManager;
	
	public class UIManager
	{
		public function UIManager()
		{
		}
		
		public static function initWindow():void
		{
			var wh:String = NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.WINDOW_H) as String;
			if (StringUtils.isNotBlank(wh)){
				NapkeeApplication.application.nativeWindow.height = new Number(wh);
			}
			var ww:String = NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.WINDOW_W) as String;
			if (StringUtils.isNotBlank(ww)){
				NapkeeApplication.application.nativeWindow.width = new Number(ww);
			}
		}
		
		public static function onDividerDrag(event:DividerEvent):void
		{
			//fileList.columnWidth = fileList.width-10;				//vBoxFileList.width = 
		}


		public static function onDragIn(event:NativeDragEvent):void
		{
			NativeDragManager.dropAction = NativeDragActions.MOVE;
			if(event.clipboard.hasFormat(ClipboardFormats.FILE_LIST_FORMAT)){
    			NativeDragManager.acceptDragDrop(NapkeeApplication.application); //'this' is the receiving component
			}
		}
		
		public static function onDrop(event:NativeDragEvent):void
		{
		    if(event.clipboard.hasFormat(ClipboardFormats.FILE_LIST_FORMAT)){
		    	//var text:String = String(event.clipboard.getData(ClipboardFormats.TEXT_FORMAT));
		    	var droppedFiles:Array = event.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
		    	for each(var file:File in droppedFiles){
		    		if (file.extension.toLowerCase() == "bmml"){
			    		var fi:BMMLFile = new BMMLFile();
						fi.file = file;
						NapkeeApplication.application.projectManager.addFile(fi);
		    		}
		    	}
		    }
		}
		
		public static function onFileClick(event:ListEvent):void
		{
			clearPanels();
			CursorManager.setBusyCursor();
			var fi:BMMLFile = NapkeeApplication.application.projectManager.project.files.getItemAt(event.rowIndex) as BMMLFile;
			NapkeeApplication.application.projectManager.watchFileChanges(fi.file);
			NapkeeApplication.application.projectManager.selectedIndex = event.rowIndex;
			
			openRenderingProgressWindow(null);
			setTimeout(showParsedFile,250,fi.file);			
			//showParsedFile(fi.file);
		}
		

		public static function onListDrop(event:DragEvent):void
		{
			NapkeeApplication.application.projectManager.project.markToSave();
		}
		
	
		public static function showParsedFile(file:File):void
		{
			clearPanels();
			
			var pa:BMMLParser = new BMMLParser(file.nativePath);
			if (pa.hasProblems){
				CursorManager.removeBusyCursor();
				Alert.show("Ooops, it seems that the file has been deleted in the meanwhile!");
				return;
			}
			FlexGlobals.topLevelApplication.bmmlSourceW.htmlLoader.window.highlightString(pa.getBmml());
			FlexGlobals.topLevelApplication.webHTML.htmlLoader.window.highlightString(pa.getHtml());
            FlexGlobals.topLevelApplication.webCSS.htmlLoader.window.highlightString(pa.getCss());
            FlexGlobals.topLevelApplication.webJS.htmlLoader.window.highlightString(pa.getJs());
			
			var file:File = File.applicationStorageDirectory.resolvePath("content/preview.html");
			var filestream:FileStream = new FileStream();
			filestream.open(file, FileMode.WRITE);
			filestream.writeUTFBytes(pa.getDocument());
			filestream.close();
			
            FlexGlobals.topLevelApplication.webPreview.addEventListener(Event.COMPLETE, rendered);
            FlexGlobals.topLevelApplication.webPreview.htmlLoader.load(new URLRequest("app-storage:/content/preview.html"));
			CursorManager.removeBusyCursor();
			closeRenderingProgressWindow(null);
		}
		
		private static function rendered(event:Event):void
		{
			var file:File = File.applicationStorageDirectory.resolvePath("content/preview.html");
			//if (file.exists)
			//	file.deleteFile();
		}
		
		public static function showUpdateAvailable(version:String):void
		{
			FlexGlobals.topLevelApplication.updateMessageLbl.text = "A new version of Napkee (" + version + ") is available for download.";
			FlexGlobals.topLevelApplication.updateMessage.height = 20;
			FlexGlobals.topLevelApplication.updateMessage.visible = true;
		}
		
		public static function clearPanels():void
		{
			try {
				FlexGlobals.topLevelApplication.bmmlSourceW.htmlLoader.window.highlightString("");
				FlexGlobals.topLevelApplication.webHTML.htmlLoader.window.highlightString("");
				FlexGlobals.topLevelApplication.webCSS.htmlLoader.window.highlightString("");
				FlexGlobals.topLevelApplication.webJS.htmlLoader.window.highlightString("");
				FlexGlobals.topLevelApplication.webPreview.htmlLoader.loadString("");
			}
			catch (error:Error)
			{
				// this is to fix linux!
			}
		}
		
		
		private static function loadProject(event:Event):void
		{
			NapkeeApplication.application.projectManager.loadProject(event);
		}
		
        public static function selectHandler(event:Event):void 
        {
            Alert.show(event.target.label);
        }
        
        
        public static function closeUnsavedProjectWindow(event:Event):void
        {
        	PopUpManager.removePopUp(FlexGlobals.topLevelApplication.unsavedProjectWindow);
        }
        
        public static function saveAndQuit(event:Event):void
        {
        	NapkeeApplication.application.projectManager.saveProject(event);
        	quit(event);
        }
        
        public static function quit(event:Event):void
        {
        	ApplicationManager.exit(event);
        }

		public static function showWebNature():void
		{
            var projectManager: ProjectManager = NapkeeApplication.application.projectManager;
			clearPanels();
			if (projectManager.selectedIndex > -1){
				var fi:BMMLFile = projectManager.project.files.getItemAt(projectManager.selectedIndex) as BMMLFile;
				openRenderingProgressWindow(null);
				setTimeout(showParsedFile,250,fi.file);
			}
			projectManager.project.nature = StringConstants.PROJECT_NATURE_WEB;
			FlexGlobals.topLevelApplication.naviWeb.visible = true;
			FlexGlobals.topLevelApplication.naviWeb.percentHeight = 100;
			FlexGlobals.topLevelApplication.naviWeb.percentWidth = 100;
		}
		
		private static var mockupFile:File;
		public static function loadBMML(event:Event): void
        {
			mockupFile = new File(ApplicationManager.getLastOpenedFolder());
			mockupFile.addEventListener(FileListEvent.SELECT_MULTIPLE, selectMultipleHandler);
			try {
				mockupFile.browseForOpenMultiple("Select one or more BMML or BMPR files",[new FileFilter("Balsamiq Mockups file", "*.bmml"), new FileFilter("Balsamiq Mockups project", "*.bmpr")]);
			}
			catch (error:Error){
				// cannot open more than one browse files
			}
		}
		
		private static function selectMultipleHandler(event:FileListEvent): void
		{
			var files:Array = event.files;
			for(var i:int=0; i<files.length; i++){
				var selectedFile:File = files[i] as File;
				ApplicationManager.setLastOpenedFolder(selectedFile.parent.nativePath);
		        tentativelyAddFile(selectedFile);
		    }		
		}
		
		public static function tentativelyAddFile(f:File):void
		{
		    var fileName:String = f.nativePath.toString();
		    if(fileName.toLowerCase().indexOf(".bmml") != -1){
		    	var bmml:BMMLFile = new BMMLFile();
				bmml.file = f;
				NapkeeApplication.application.projectManager.addFile(bmml);
		    }
			else if (fileName.toLowerCase().indexOf(".bmpr") != -1) {
				var bmpr:BMPRFile = new BMPRFile();
				bmpr.file = f;
				NapkeeApplication.application.projectManager.addProject(bmpr);
			}
		    else{
		    	Alert.show("Napkee works only with Balsamiq Mockups files (bmml or bmpr).");
		    }
		}
		
		public static function projectNameChangeHandler():void
		{
            var projectManager: ProjectManager = NapkeeApplication.application.projectManager;            
			projectManager.project.name = FlexGlobals.topLevelApplication.projectName.text;
		}
		
		public static function changeTitleBar():void
		{
            var projectManager: ProjectManager = NapkeeApplication.application.projectManager;
			FlexGlobals.topLevelApplication.nativeWindow.title = "Napkee - ";
			if (projectManager.projectFile != null){
				FlexGlobals.topLevelApplication.nativeWindow.title += projectManager.projectFile.nativePath; 
			}
			else {
				FlexGlobals.topLevelApplication.nativeWindow.title += projectManager.project.name;
			}
			if (!projectManager.project.isSaved){
				if (FlexGlobals.topLevelApplication.nativeWindow.title.indexOf("*")==-1) FlexGlobals.topLevelApplication.nativeWindow.title += " *";
			}
		}
		
		
		public static function aboutNapkee(event:Event):void
		{
			FlexGlobals.topLevelApplication.aboutWindow.addEventListener(CloseEvent.CLOSE, UIManager.closeAboutWindow);
			PopUpManager.addPopUp(FlexGlobals.topLevelApplication.aboutWindow,NapkeeApplication.application,true);
			PopUpManager.centerPopUp(FlexGlobals.topLevelApplication.aboutWindow);
		}
		
		public static function closeAboutWindow(event:Event):void
        {
        	PopUpManager.removePopUp(FlexGlobals.topLevelApplication.aboutWindow);
        }
		
		public static function giveFeedback(event:Event):void
		{
			FlexGlobals.topLevelApplication.feedbackWindow.addEventListener(CloseEvent.CLOSE, UIManager.closeGiveFeedback);
			PopUpManager.addPopUp(FlexGlobals.topLevelApplication.feedbackWindow,NapkeeApplication.application,true);
			PopUpManager.centerPopUp(FlexGlobals.topLevelApplication.feedbackWindow);
		}
		
		public static function closeGiveFeedback(event:Event):void
		{
			PopUpManager.removePopUp(FlexGlobals.topLevelApplication.feedbackWindow);
		}

		public static function napkeeRegistered(event:Event):void
		{
			FlexGlobals.topLevelApplication.napkeeRegisteredWindow.addEventListener(CloseEvent.CLOSE, UIManager.closeNapkeeRegisteredWindow);
			PopUpManager.addPopUp(FlexGlobals.topLevelApplication.napkeeRegisteredWindow,NapkeeApplication.application,true);
			PopUpManager.centerPopUp(FlexGlobals.topLevelApplication.napkeeRegisteredWindow);
		}
		
		public static function closeNapkeeRegisteredWindow(event:Event):void {
        	PopUpManager.removePopUp(FlexGlobals.topLevelApplication.napkeeRegisteredWindow);
        	//Application.application.isAReboot = true;
        	//Application.application.exitHandler(event);
        }

		public static function preferencesNapkee(event:Event):void {
			FlexGlobals.topLevelApplication.preferencesWindow.init();
			FlexGlobals.topLevelApplication.preferencesWindow.addEventListener(CloseEvent.CLOSE, UIManager.closePreferencesWindow);
			PopUpManager.addPopUp(FlexGlobals.topLevelApplication.preferencesWindow,NapkeeApplication.application,true);
			PopUpManager.centerPopUp(FlexGlobals.topLevelApplication.preferencesWindow);
		}
        
		public static function closePreferencesWindow(event:Event):void {
        	PopUpManager.removePopUp(FlexGlobals.topLevelApplication.preferencesWindow);
        }

        private static var exportFolder:File;
        private static var newExportFolder:File;
        private static var exportFile:File;
        private static var exportedFile:File;
        private static var exportedFolder:File;
        
        public static function exportSelectedMockup(event:Event):void
        {
        	var currentFile:BMMLFile = FlexGlobals.topLevelApplication.fileList.selectedItem as BMMLFile;
        	if (currentFile != null){
        		exportFile = currentFile.file;
        		var folder:File = new File(currentFile.file.parent.nativePath + File.separator + StringUtils.getNormalizedName(currentFile.file.name) + "_export");
				if (folder.exists){
					exportSingleAsk(folder);
				}
				else {
					exportSingleExecute(folder);
				}
        	}
        }
        
        public static function exportProjectSilent(event:Event):void
        {
        	var folder:File = new File(NapkeeApplication.application.projectManager.projectFile.parent.nativePath + File.separator + StringUtils.getNormalizedName(NapkeeApplication.application.projectManager.projectFile.name) + "_export_" + NapkeeApplication.application.projectManager.project.nature);
        	if (folder.exists)
        		folder.deleteDirectory(true);
       		setTimeout(exportProjectExecuteSilent,250,folder);
        }
        
        public static function exportProject(event:Event):void
        {
        	var folder:File;
        	if (NapkeeApplication.application.projectManager.projectFile == null){
        		
        		if (NapkeeApplication.application.projectManager.project.files != null && NapkeeApplication.application.projectManager.project.files.length > 0){
	        		var firstFile:BMMLFile = NapkeeApplication.application.projectManager.project.files.getItemAt(0) as BMMLFile;
	        		folder = new File(firstFile.file.parent.nativePath + File.separator + StringUtils.getNormalizedName(firstFile.file.name) + "_export_" + NapkeeApplication.application.projectManager.project.nature);
        		}
        		else {
        			NapkeeApplication.application.projectManager.saveProject(null);
        			return;	
        		}
        	}
        	else {
       			folder = new File(NapkeeApplication.application.projectManager.projectFile.parent.nativePath + File.separator + StringUtils.getNormalizedName(NapkeeApplication.application.projectManager.projectFile.name) + "_export_" + NapkeeApplication.application.projectManager.project.nature);
       		}
			if (folder.exists){
				exportProjectAsk(folder);
			}
			else {
				openExportProjectProgressWindow(null);
        		setTimeout(exportProjectExecute,250,folder);
			}
        }
        
        public static function exportProjectAsk(folder:File):void
        {
        	exportFolder = folder;
        	newExportFolder = new File(folder.nativePath + "_" + TimeUtils.getTimestamp(new Date()));
        	FlexGlobals.topLevelApplication.exportProjectAskWindow.addEventListener(ExportProjectAskWindow.OVERWRITE,UIManager.overwriteProject);
        	FlexGlobals.topLevelApplication.exportProjectAskWindow.addEventListener(ExportProjectAskWindow.CREATE_NEW,UIManager.createNewProject);
        	openExportProjectAskWindow(null);
        }
        
        private static function makeFinalProjectName(defaultName:String):String {
            if (NapkeeApplication.application.projectManager.project != null && StringUtils.isNotBlank(NapkeeApplication.application.projectManager.project.name))
                return NapkeeApplication.application.projectManager.project.name;
            else
                return defaultName;
        }
        
        private static function createExportSpec(folder:File): ExportSpec {
            var spec: ExportSpec = new ExportSpec();
            spec.exportNature = NapkeeApplication.application.projectManager.project.nature;
            spec.applicationName = StringUtils.getNormalizedName(folder.name);
            spec.projectName = makeFinalProjectName(spec.applicationName);
            spec.sourceMockups = NapkeeApplication.application.projectManager.project.files;
            spec.targetFolder = folder;
            return spec;           
        }
        
        public static function exportProjectExecute(folder:File):void
        {
            var spec: ExportSpec = createExportSpec(folder);
            var exportJobManager:ExportJobManager = NapkeeApplication.application.exportJobManager;
            exportJobManager.addEventListener(ExportEvent.MOCKUP_EXPORTED, function(e: ExportEvent):void {
                trace("mockup generated: "+ e.sourceMockup.file.name);
                FlexGlobals.topLevelApplication.exportProjectProgressWindow.dispatchEvent(new Event("PROGRESS"));
            });
            
            if (exportJobManager.accepts(spec)) {
                trace("export job executing...");
                var builder:ExportTaskBuilder = exportJobManager.buildJob(spec);
                exportJobManager.execute(builder.tasklist);
                exportedFolder = folder;
            } else {
            	FlexGlobals.topLevelApplication.exportProjectProgressWindow.resetCounter();
            	folder.createDirectory();
            	if (NapkeeApplication.application.projectManager.project.nature == StringConstants.PROJECT_NATURE_WEB){
            		
    	        	RepositoryManager.copyHtmlAssetsToFolder(folder.nativePath);
    	        	var cycle:int = 0;
    	        	for each(var mockupFile:BMMLFile in NapkeeApplication.application.projectManager.project.files){
    	        		var exFile:File = exportBMMLToHTML(folder,mockupFile);
    					if (cycle == 0){
    						exportedFolder = exFile;
    	        		}
    	        		cycle++;
    	        		FlexGlobals.topLevelApplication.exportProjectProgressWindow.dispatchEvent(new Event("PROGRESS")); 
    				}
            	}
            }
        	closeExportProjectProgressWindow(null);
        	exportProjectDoneWindow(folder);
        }
        
        public static function exportProjectExecuteSilent(folder:File):void {
        	folder.createDirectory();
            var spec: ExportSpec = createExportSpec(folder);
            var exportJobManager:ExportJobManager = NapkeeApplication.application.exportJobManager;
            
            if (exportJobManager.accepts(spec)) {
                var builder:ExportTaskBuilder = exportJobManager.buildJob(spec);
                exportJobManager.execute(builder.tasklist);
                exportedFolder = folder;
            } else {
            	if (NapkeeApplication.application.projectManager.project.nature == StringConstants.PROJECT_NATURE_WEB){
            		
    	        	RepositoryManager.copyHtmlAssetsToFolder(folder.nativePath);
    	        	var cycle:int = 0;
    	        	for each(var mockupFile:BMMLFile in NapkeeApplication.application.projectManager.project.files){
    	        		var exFile:File = exportBMMLToHTML(folder,mockupFile);
    					if (cycle == 0){
    						exportedFolder = exFile;
    	        		}
    	        		cycle++;
    				}
            	}
            }
        	trace("Project exported correctly in "+folder.nativePath);
        	FlexGlobals.topLevelApplication.exit();
        }
        
        public static function overwriteProject(event:Event):void
        {
        	if (exportFolder.exists)
        		exportFolder.deleteDirectory(true);
        	closeExportProjectAskWindow(event);
        	//exportProjectExecute(exportFolder);
        	openExportProjectProgressWindow(null);
        	setTimeout(exportProjectExecute,250,exportFolder);
        }

        public static function createNewProject(event:Event):void
        {
        	closeExportProjectAskWindow(event);
        	//exportProjectExecute(newExportFolder);
        	openExportProjectProgressWindow(null);
        	setTimeout(exportProjectExecute,250,newExportFolder);
        }
        
        
        public static function openExportProjectProgressWindow(event:Event):void
		{
			PopUpManager.addPopUp(FlexGlobals.topLevelApplication.exportProjectProgressWindow,NapkeeApplication.application,true);
			PopUpManager.centerPopUp(FlexGlobals.topLevelApplication.exportProjectProgressWindow);
		}
		
		public static function closeExportProjectProgressWindow(event:Event):void
        {
        	PopUpManager.removePopUp(FlexGlobals.topLevelApplication.exportProjectProgressWindow);
        }

        public static function openRenderingProgressWindow(event:Event):void
		{
			PopUpManager.addPopUp(FlexGlobals.topLevelApplication.renderingProgressWindows,NapkeeApplication.application,true);
			PopUpManager.centerPopUp(FlexGlobals.topLevelApplication.renderingProgressWindows);
		}
		
		public static function closeRenderingProgressWindow(event:Event):void
        {
        	PopUpManager.removePopUp(FlexGlobals.topLevelApplication.renderingProgressWindows);
        }

        public static function openExportProjectAskWindow(event:Event):void
		{
			FlexGlobals.topLevelApplication.exportProjectAskWindow.destination = exportFolder.name;
			FlexGlobals.topLevelApplication.exportProjectAskWindow.newDestination = newExportFolder.name;
			FlexGlobals.topLevelApplication.exportProjectAskWindow.addEventListener(CloseEvent.CLOSE, UIManager.closeExportProjectAskWindow);
			PopUpManager.addPopUp(FlexGlobals.topLevelApplication.exportProjectAskWindow,NapkeeApplication.application,true);
			PopUpManager.centerPopUp(FlexGlobals.topLevelApplication.exportProjectAskWindow);
		}
		
		public static function closeExportProjectAskWindow(event:Event):void
        {
        	PopUpManager.removePopUp(FlexGlobals.topLevelApplication.exportProjectAskWindow);
        }

        public static function exportProjectDoneWindow(folder:File):void
		{
			FlexGlobals.topLevelApplication.exportProjectDoneWindow.mockupFileName = NapkeeApplication.application.projectManager.project.name;
			FlexGlobals.topLevelApplication.exportProjectDoneWindow.destination = folder.nativePath;
			FlexGlobals.topLevelApplication.exportProjectDoneWindow.addEventListener(CloseEvent.CLOSE, UIManager.closeExportProjectDoneWindow);
			PopUpManager.addPopUp(FlexGlobals.topLevelApplication.exportProjectDoneWindow,NapkeeApplication.application,true);
			PopUpManager.centerPopUp(FlexGlobals.topLevelApplication.exportProjectDoneWindow);
		}
		
		public static function closeExportProjectDoneWindow(event:Event):void
        {
        	if (ApplicationManager.isOpenExport()){
        		navigateToURL(new URLRequest(exportedFolder.url));
        	}
        	PopUpManager.removePopUp(FlexGlobals.topLevelApplication.exportProjectDoneWindow);
        }

      	public static function exportBMMLToHTML(destinationFolder:File, bmmlToExport:BMMLFile, includeLinkedFiles:Boolean = true):File
      	{
      		var pa:BMMLParser = new BMMLParser(bmmlToExport.file.nativePath);
		    var file:File = destinationFolder.resolvePath("preview.html");
			var filestream:FileStream = new FileStream();
			filestream.open(file, FileMode.WRITE);
			filestream.writeUTFBytes(pa.getDocument());
			filestream.close();
			var exFile:File = new File(destinationFolder.nativePath + File.separator + StringUtils.getNormalizedName(bmmlToExport.file.name) + ".html");
			file.copyTo(exFile,true);
			
			// copy the imported images
			var directory:File = destinationFolder.resolvePath("images/imported");
			var imagesDestDir:File = File.applicationStorageDirectory.resolvePath("content/images/imported/");
			var contents:Array = imagesDestDir.getDirectoryListing(); 
			for (var fiz:uint = 0; fiz<contents.length; fiz++) {
				var fizFile:File = contents[fiz] as File;
				fizFile.copyTo(new File(directory.nativePath + File.separator + fizFile.name),true);
			}
			
			if (includeLinkedFiles){
				var fs:FileStream = new FileStream();
				fs.open(bmmlToExport.file, FileMode.READ);
				var bmml:XML = XML(fs.readUTFBytes(fs.bytesAvailable));
				// search for linked files
				for each (var checkControl:XML in bmml.controls.control){
					if (StringUtils.isNotBlank(checkControl.controlProperties.href)){
						var fi:BMMLFile = new BMMLFile();
						fi.file = new File(bmmlToExport.file.parent.nativePath+File.separator+checkControl.controlProperties.href);
						if (fi.file.exists){ //check on the BMML file
							var alreadyExportedFile:File = new File(destinationFolder.nativePath + File.separator + StringUtils.getNormalizedName(fi.file.name) + ".html");
							if (!alreadyExportedFile.exists){
								exportBMMLToHTML(destinationFolder,fi);
							}
						}
					}
					if (StringUtils.isNotBlank(checkControl.controlProperties.hrefs)){
						var linkedFiles:Array = (checkControl.controlProperties.hrefs).split("%2C");
						for (var l:int = 0;l<linkedFiles.length;l++){
							var link:String = StringUtil.trim(unescape(linkedFiles[l] as String));
							if (StringUtils.isNotBlank(link)){
								var fi:BMMLFile = new BMMLFile();
								fi.file = new File(bmmlToExport.file.parent.nativePath+File.separator+link);
								if (fi.file.exists){
									var alreadyExportedFile:File = new File(destinationFolder.nativePath + File.separator + StringUtils.getNormalizedName(fi.file.name) + ".html");
									if (!alreadyExportedFile.exists){
										exportBMMLToHTML(destinationFolder,fi);
									}
								}
							}				
						}
					}
				}
			}
			if (file.exists)
				file.deleteFile();
			return exFile;
      	}
        
        public static function exportSingleExecute(folder:File):void
        {
        	folder.createDirectory();
        	if (exportFile != null){
        		var bF:BMMLFile = new BMMLFile();
        		bF.file = exportFile;
        		
	        	if (NapkeeApplication.application.projectManager.project.nature == StringConstants.PROJECT_NATURE_WEB){
		        	RepositoryManager.copyHtmlAssetsToFolder(folder.nativePath);
		        	exportedFile = exportBMMLToHTML(folder,bF);
	        	}
        	}
        	exportSingleDoneWindow(folder);
        }
        
        
        
        public static function exportSingleAsk(folder:File):void
        {
        	exportFolder = folder;
        	newExportFolder = new File(folder.nativePath + "_" + TimeUtils.getTimestamp(new Date()));
        	FlexGlobals.topLevelApplication.exportSingleAskWindow.addEventListener(ExportSingleAskWindow.OVERWRITE,UIManager.overwriteSingle);
        	FlexGlobals.topLevelApplication.exportSingleAskWindow.addEventListener(ExportSingleAskWindow.CREATE_NEW,UIManager.createNewSingle);
        	openExportSingleAskWindow(null);
        }
        
        public static function overwriteSingle(event:Event):void
        {
        	if (exportFolder.exists)
        		exportFolder.deleteDirectory(true);
        	closeExportSingleAskWindow(event);
        	exportSingleExecute(exportFolder);
        }

        public static function createNewSingle(event:Event):void
        {
        	closeExportSingleAskWindow(event);
        	exportSingleExecute(newExportFolder);
        }
        
        
        public static function openExportSingleAskWindow(event:Event):void
		{
			FlexGlobals.topLevelApplication.exportSingleAskWindow.destination = exportFolder.name;
			FlexGlobals.topLevelApplication.exportSingleAskWindow.newDestination = newExportFolder.name;
			FlexGlobals.topLevelApplication.exportSingleAskWindow.addEventListener(CloseEvent.CLOSE, UIManager.closeExportSingleAskWindow);
			PopUpManager.addPopUp(FlexGlobals.topLevelApplication.exportSingleAskWindow,NapkeeApplication.application,true);
			PopUpManager.centerPopUp(FlexGlobals.topLevelApplication.exportSingleAskWindow);
		}
		
		public static function closeExportSingleAskWindow(event:Event):void
        {
        	PopUpManager.removePopUp(FlexGlobals.topLevelApplication.exportSingleAskWindow);
        }

        public static function exportSingleDoneWindow(folder:File):void
		{
			FlexGlobals.topLevelApplication.exportSingleDoneWindow.mockupFileName = exportFile.name;
			FlexGlobals.topLevelApplication.exportSingleDoneWindow.destination = folder.nativePath;
			FlexGlobals.topLevelApplication.exportSingleDoneWindow.addEventListener(CloseEvent.CLOSE, UIManager.closeExportSingleDoneWindow);
			PopUpManager.addPopUp(FlexGlobals.topLevelApplication.exportSingleDoneWindow,NapkeeApplication.application,true);
			PopUpManager.centerPopUp(FlexGlobals.topLevelApplication.exportSingleDoneWindow);
		}
		
		public static function closeExportSingleDoneWindow(event:Event):void
        {
        	navigateToURL(new URLRequest(exportedFile.url));
        	PopUpManager.removePopUp(FlexGlobals.topLevelApplication.exportSingleDoneWindow);
        }
        
        public static function onlineHelp(event:Event):void
        {
        	navigateToURL(new URLRequest("http://www.napkee.com/support/"));
        }
        public static function onlineFaq(event:Event):void
        {
        	navigateToURL(new URLRequest("http://www.napkee.com/support/"));
        }
        public static function onlineFeedback(event:Event):void
        {
        	navigateToURL(new URLRequest("http://support.napkee.com"));
        }
        
        private static var selectedText:String = "";
        
        public static function showCopyToClipboard(event:Event,text:String):void
		{
			selectedText = text;
			if (StringUtils.isNotBlank(selectedText)){
				FlexGlobals.topLevelApplication.ctc.visible = true;
			}
		}

		public static function hideCopyToClipboard(event:Event):void
		{
			selectedText = "";
			FlexGlobals.topLevelApplication.ctc.visible = false;
		}
        
        public static function copyToClipboard(event:Event):void
        {
			Clipboard.generalClipboard.clear();
			Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, selectedText, false);
        	hideCopyToClipboard(event);
        }
        
	}
}