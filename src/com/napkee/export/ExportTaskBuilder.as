package com.napkee.export
{
    import flash.errors.IllegalOperationError;
    import flash.filesystem.File;
    
    import mx.collections.ArrayCollection;

    /**
    * A builder with Fluent Interface to create a task list
     */
    public class ExportTaskBuilder
    {
        public var tasklist: ArrayCollection = new ArrayCollection();
        public var spec: ExportSpec;
        
        public function ExportTaskBuilder(spec: ExportSpec) {
            this.spec = spec;
        }
        
        public function copy(source:*, destPath:String): ExportTaskBuilder {
            if (source is String) {
                source = File.applicationDirectory.resolvePath(source);
            }
            if (!source is File) throw new IllegalOperationError("invalid source type");
            tasklist.addItem(new ExportTaskImpl(ExportTaskImpl.copyImpl, source, spec.targetFolder, destPath));
            return this;
        }

        public function transformAndCopy(sourcePath:String, transformer:ITransformContent, destPath:String): ExportTaskBuilder {
            tasklist.addItem(new ExportTaskImpl(ExportTaskImpl.transformAndCopyImpl, sourcePath, transformer, spec.targetFolder, destPath));
            return this;
        }
        
        /**
        * @param func: visitor function to invoke for each file, will be passed the File instance
        * @param folder: folder to visit; null = targetFolder of the ExportSpec
         */
        public function visitFiles(func:Function, recursive:Boolean = true, folder: File = null): ExportTaskBuilder {
            if (folder == null) {
                folder = spec.targetFolder;
            }
            tasklist.addItem(new ExportTaskImpl(ExportTaskImpl.visitFilesImpl, func, recursive, folder));
            return this;
        }
    }

}