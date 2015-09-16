package com.napkee.export.modules
{
    import com.napkee.export.ExportSpec;
    import com.napkee.export.ExportTaskBuilder;
    
    import flash.events.IEventDispatcher;

    public interface IExportModule {
        
        function set eventDispatcher(ed: IEventDispatcher): void;
        
        function get displayName(): String;
        
        function accepts(spec: ExportSpec): Boolean;
        
        function buildJob(spec: ExportSpec): ExportTaskBuilder;
    }
}