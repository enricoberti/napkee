package com.napkee.export
{
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;

    internal class ExportTaskImpl implements IExportTask {
        private var f:Function;
        private var args:Array;
        
        public function ExportTaskImpl(f: Function, ... args) {
            this.f = f;
            this.args = args;
        }
        
        public function perform(): void {
            f.apply(null, args);
        }
        
        internal static function copyImpl(sourceFile:File, targetFolder:File, destPath:String): void {
            sourceFile.copyTo(targetFolder.resolvePath(destPath));
        }
        
        internal static function transformAndCopyImpl(sourcePath:String, transformer: ITransformContent, targetFolder:File, destPath:String): void {
            var fs: FileStream = new FileStream();
            fs.open(File.applicationDirectory.resolvePath(sourcePath), FileMode.READ);
            var content:String = fs.readUTFBytes(fs.bytesAvailable);
            fs.close();
            fs.open(targetFolder.resolvePath(destPath), FileMode.WRITE);
            fs.writeUTFBytes(transformer.apply(content));
            fs.close();
        }

        internal static function visitFilesImpl(func:Function, recursive:Boolean, folder: File): void {
            for each (var f: File in folder.getDirectoryListing()) {
                if (f.isDirectory && recursive) visitFilesImpl(func, recursive, f);
                else func(f);
            }
        }
    }
}