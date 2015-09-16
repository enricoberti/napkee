package com.napkee.export
{
    import com.napkee.export.modules.IExportModule;
    
    import flash.errors.IllegalOperationError;
    import flash.events.EventDispatcher;
    
    import mx.collections.ArrayCollection;
    import mx.events.ModuleEvent;
    import mx.modules.IModuleInfo;
    import mx.modules.ModuleManager;

    /**
    * Register a list of modules that can export the project
    * according to an export specification.
     */
    public class ExportJobManager extends EventDispatcher {
        
        public var exportModules: ArrayCollection = new ArrayCollection();
        private var loadingModules: ArrayCollection = new ArrayCollection();
        
        public function ExportJobManager() {
            loadExportModule("com/napkee/export/modules/HtmlSimpleExportModule.swf");
            //loadExportModule("com/napkee/export/modules/Html5BootstrapExportModule.swf");
            loadExportModule("com/napkee/export/modules/Flex4AirExportModule.swf");
        }
        
        private function loadExportModule(url:String):void {
            var module:IModuleInfo = ModuleManager.getModule(url);
            module.addEventListener(ModuleEvent.READY, registerModuleInstance);
            module.load();
            loadingModules.addItem(module); // save the moduleinfo reference, so we can get the READY event
        }
        
        private function registerModuleInstance(e: ModuleEvent):void {
            var instance: IExportModule = e.module.factory.create() as IExportModule;
            instance.eventDispatcher = this;
            exportModules.addItem(instance);
            loadingModules.removeItemAt(loadingModules.getItemIndex(e.module));
        }
        
        public function accepts(spec: ExportSpec): Boolean {
            for each (var m: IExportModule in exportModules) if (m.accepts(spec)) return true;
            return false;
        }
        
        public function buildJob(spec: ExportSpec): ExportTaskBuilder {
            for each (var m: IExportModule in exportModules)
                if (m.accepts(spec)) return m.buildJob(spec);
            throw new IllegalOperationError("Cannot find an export module with the required capabilities");
        }
        
        public function execute(tasklist: ArrayCollection): void {
            for each (var t:IExportTask in tasklist) {
                t.perform();
            }
        }
    }
}