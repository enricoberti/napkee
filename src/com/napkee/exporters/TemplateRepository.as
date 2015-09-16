package com.napkee.exporters
{
    import flash.filesystem.File;
    
    import mx.collections.ArrayCollection;

    public class TemplateRepository {

        public var rootFolder: File = File.applicationDirectory;
        
        private var searchPath: ArrayCollection;

        public function TemplateRepository(... paths) {
            searchPath = new ArrayCollection(paths);
            searchPath.addItem("assets/templates/components");
        }
        
        public function findTemplateFile(templateName:String): File {
            for each(var path:String in searchPath) {
                var file:File = rootFolder.resolvePath(path).resolvePath(templateName);
                if (file.exists)
                    return file;
            }
            throw new Error("cannot find template");
        }
    }
}