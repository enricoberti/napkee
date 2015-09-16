package com.napkee.export
{
    import com.napkee.vo.BMMLFile;
    
    import flash.events.Event;
    
    public class ExportEvent extends Event
    {
        public static const MOCKUP_EXPORTED:String = "mockup_exported";
        
        public var sourceMockup: BMMLFile;
        
        public function ExportEvent(type:String, sourceMockup:BMMLFile=null, bubbles:Boolean=false, cancelable:Boolean=false) {
            super(type, bubbles, cancelable);
            this.sourceMockup = sourceMockup;
        }
        
        
        public static function mockupExported(sourceMockup: BMMLFile): ExportEvent {
            return new ExportEvent(ExportEvent.MOCKUP_EXPORTED, sourceMockup);
        }
    }
}