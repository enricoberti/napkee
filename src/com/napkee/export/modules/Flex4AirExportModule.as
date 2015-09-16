package com.napkee.export.modules
{
    import com.napkee.export.ExportEvent;
    import com.napkee.export.ExportSpec;
    import com.napkee.export.ExportTaskBuilder;
    import com.napkee.export.Substitutions;
    import com.napkee.export.settings.FlashRuntimeType;
    import com.napkee.export.settings.IdeType;
    import com.napkee.export.settings.SdkType;
    import com.napkee.importers.BMMLParser;
    import com.napkee.utils.StringConstants;
    import com.napkee.utils.StringUtils;
    import com.napkee.vo.BMMLFile;
    
    import flash.errors.IllegalOperationError;
    import flash.events.IEventDispatcher;
    import flash.filesystem.File;
    
    import mx.collections.ArrayCollection;
    import mx.modules.ModuleBase;
    
    public class Flex4AirExportModule extends ModuleBase implements IExportModule {

        private var _eventDispatcher:IEventDispatcher;
        
        public function set eventDispatcher(eventDispatcher: IEventDispatcher): void {
            this._eventDispatcher = eventDispatcher;
        }

        public function get displayName(): String {
            return "Flex 4 AIR export";
        }
        
        public function accepts(spec: ExportSpec): Boolean {
            return spec.exportNature==StringConstants.PROJECT_NATURE_FLEX && spec.targetIde===IdeType.IDE_FLASH_BUILDER4 
                && spec.targetSdk===SdkType.SDK_FLEX4 && spec.targetRuntime.isAir();
        }

        public function buildJob(spec: ExportSpec): ExportTaskBuilder {
            if (!accepts(spec)) 
                throw new IllegalOperationError("specification is not acceptable");
            
            if (spec.exportNature==StringConstants.PROJECT_NATURE_FLEX && spec.targetIde===IdeType.IDE_FLASH_BUILDER4 
                && spec.targetSdk===SdkType.SDK_FLEX4 && spec.targetRuntime.isAir()) {
                var builder:ExportTaskBuilder = new ExportTaskBuilder(spec);
                
                generateProjectFlex4AirForBuilder4(builder);
                generateSourcesForApplication(builder);
                generateSourcesForMockups(builder, spec.sourceMockups);
                return builder;
            }
            return null;
        }
        
        private function generateProjectFlex4AirForBuilder4(builder:ExportTaskBuilder): void {
            builder
                // ide files
                .copy("assets/templates/flex4/fb4air/halo/flexProperties.txt", ".flexProperties")
                .transformAndCopy("assets/templates/flex4/fb4air/halo/actionScriptProperties.txt", new Substitutions()
                    .replace("mainApp", builder.spec.applicationName+".mxml"), ".actionScriptProperties")
                .transformAndCopy("assets/templates/flex4/fb4air/halo/project.txt", new Substitutions()
                    .replace("projectName", builder.spec.projectName), ".project")
                // libs
                .copy("assets/templates/flex4/libs_flex", "libs")
                // remove last ".000"
                .visitFiles(function (f: File):void {
                    if (f.extension == "000") f.moveTo(new File(f.nativePath.substr(0,f.nativePath.length-4)));
                });
        }
        
        private function generateSourcesForApplication(builder:ExportTaskBuilder):void {
            var firstMockup: BMMLFile = builder.spec.sourceMockups.getItemAt(0) as BMMLFile;
            
            builder
                .transformAndCopy("assets/templates/flex4/fb4air/halo/main.mxml.000", new Substitutions()
                .replace("asCode","")
                .replace("code","<local:"+StringUtils.getNormalizedName(firstMockup.file.name)+" width=\"100%\" height=\"100%\"/>"),
                "src/"+builder.spec.applicationName+".mxml")
                .copy("assets/templates/flex4/napkee.css", "src/napkee.css")
                .copy("assets/templates/flex4/assets", "src/assets");
            if (builder.spec.targetRuntime.isAir())
                builder.copy("assets/templates/flex4/fb4air/halo/appDescriptor.txt", "src/"+builder.spec.applicationName+"-app.xml");
        }
        
        private function generateSourcesForMockups(builder:ExportTaskBuilder, sourceMockups: ArrayCollection):void {
            for each(var mockupFile:BMMLFile in sourceMockups) {
                var parser:BMMLParser = new BMMLParser(mockupFile.file.nativePath);
                builder.transformAndCopy("assets/templates/flex4/component.mxml.000", new Substitutions()
                    .replace("code", parser.getMxml())
                    .replace("asCode", parser.getAs()),
                    "src/"+StringUtils.getNormalizedName(mockupFile.file.name)+".mxml");
                
                _eventDispatcher.dispatchEvent(ExportEvent.mockupExported(mockupFile));
                
                generateSourcesForMockups(builder, mockupFile.linkedFiles);
            }
        }
        
    }
}