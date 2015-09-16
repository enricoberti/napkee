package com.napkee
{
    import com.napkee.dao.ApplicationSettingsDAO;
    import com.napkee.dao.DBManager;
    import com.napkee.export.ExportJobManager;
    import com.napkee.managers.ApplicationManager;
    import com.napkee.managers.MenuManager;
    import com.napkee.managers.ProjectManager;
    import com.napkee.managers.RepositoryManager;
    import com.napkee.managers.UIManager;
    import com.napkee.utils.AppUpdater;
    import com.napkee.vo.BMMLFile;
    import com.napkee.windows.AboutWindow;
    import com.napkee.windows.ExportProjectAskWindow;
    import com.napkee.windows.ExportProjectDoneWindow;
    import com.napkee.windows.ExportProjectProgress;
    import com.napkee.windows.ExportSingleAskWindow;
    import com.napkee.windows.ExportSingleDoneWindow;
    import com.napkee.windows.Feedback;
    import com.napkee.windows.PreferencesWindow;
    import com.napkee.windows.RenderingProgress;
    import com.napkee.windows.UnsavedProjectWindow;
    
    import flash.events.Event;
    import flash.events.InvokeEvent;
    import flash.filesystem.File;
    
    import mx.collections.ArrayCollection;
    import mx.controls.Image;
    import mx.core.WindowedApplication;
    import mx.utils.StringUtil;
    
    public class NapkeeApplication extends WindowedApplication
    {
        [Bindable] 
        public var projectManager:ProjectManager = new ProjectManager();

        public var applicationSettingsDAO:ApplicationSettingsDAO = DBManager.getApplicationSettingsDAO();
        
        public var iconXML:XML;
        
        public var isAReboot:Boolean = false;
        public var rebootInProgress:Boolean = false;
        
        public var unsavedProjectWindow:UnsavedProjectWindow = new UnsavedProjectWindow();
        public var aboutWindow:AboutWindow = new AboutWindow();
        public var preferencesWindow:PreferencesWindow = new PreferencesWindow();
        
        public var exportSingleAskWindow:ExportSingleAskWindow = new ExportSingleAskWindow();
        public var exportSingleDoneWindow:ExportSingleDoneWindow = new ExportSingleDoneWindow();
        public var exportProjectAskWindow:ExportProjectAskWindow = new ExportProjectAskWindow()
        public var exportProjectDoneWindow:ExportProjectDoneWindow = new ExportProjectDoneWindow();
        public var exportProjectProgressWindow:ExportProjectProgress = new ExportProjectProgress();
        public var renderingProgressWindows:RenderingProgress = new RenderingProgress();
		public var feedbackWindow:Feedback = new Feedback();
        
        public var appUpdater:AppUpdater = new AppUpdater();
        public var unreg:Image = new Image();
        
        public var avoidAutoLoad:ArrayCollection = new ArrayCollection();

        protected var menuManager:MenuManager = new MenuManager();
        
        public var exportJobManager:ExportJobManager = new ExportJobManager();

        
        private static var _instance: NapkeeApplication;

        public function NapkeeApplication() {
            super();
            _instance = this;
        }
        
        public static function get application(): NapkeeApplication {
            return _instance;
        }
        
        protected function initApplication(): void {
            menuManager.initMenu();
            RepositoryManager.initRepository();
            
            UIManager.initWindow();
            projectManager.loadLastOpenedProject();
            projectManager.startMonitor();
            UIManager.onDividerDrag(null);
        }
        
        public function hideHandler(event:Event):void {
            if (nativeWindow.visible)
                hideApplication();
            else
                showApplication(null);
        }
        
        public function hideApplication():void {
            nativeWindow.visible = false;
            nativeWindow.orderToBack();
        }
        
        public function showApplication(event:Event):void {
            nativeWindow.visible = true;
            nativeWindow.orderToFront();
        }
        
        public function addMockupToNapkee(path:String): void {
            var fi:BMMLFile = new BMMLFile();
            fi.file = new File(path);
            projectManager.addFile(fi);
        }

        
        private const REGISTER: String = "register";
        private const UNREGISTER: String = "unregister";
        private const EXPORT: String = "export";
        private const invokableActionsWithoutUI: Array = [REGISTER, UNREGISTER, EXPORT];
        
        public function onInvoke(invokeEvent:InvokeEvent): void {
            var args:Array = invokeEvent.arguments;
            if (args.length > 0) {
                if (invokableActionsWithoutUI.contains(args[0])) {
                    executeHeadlessInvocation(args);
                } else {
                    showApplication(invokeEvent);
                    projectManager.openProjects(args);
                }
            } else {
                this.visible = true;
            }
        }
        
        private function executeHeadlessInvocation(args:Array): void {
            if (args[0] == EXPORT){
                hideApplication();
                var projectFound:Boolean = false;
                for (var i:int=0;i<args.length;i++){
                    if (args[i].indexOf(".nee")> -1 ){
                        projectManager.openProjectFileSilent(args[i]);
                        UIManager.exportProjectSilent(null);
                        projectFound = true;
                    }
                }
                if (!projectFound){
                    trace("Please specify a project to open.");
                    exit();
                }
            } else {
                trace("Invalid arguments.");
                exit();
            }
        }
    }
}