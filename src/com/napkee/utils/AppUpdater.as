package com.napkee.utils
{
  import air.update.ApplicationUpdaterUI;
  import air.update.events.UpdateEvent;
  
  import com.napkee.NapkeeApplication;
  import com.napkee.managers.ApplicationManager;
  import com.napkee.managers.UIManager;
  
  import flash.desktop.NativeApplication;
  import flash.events.ErrorEvent;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.net.URLLoader;
  import flash.net.URLLoaderDataFormat;
  import flash.net.URLRequest;
  import flash.system.Capabilities;
  
  import mx.controls.Alert;
  
  public class AppUpdater
  {
    // Instantiate the updater
    private var xmlLoader:URLLoader;
    
    public function AppUpdater()
    {
    }
    
    public function checkForUpdate():void {
      var ver:String = Capabilities.version;
      var dbg:String = (Capabilities.isDebugger) ? ' (debug)' : '';
      var flashVersion:String = ver + dbg;
      var updateURL:String = StringConstants.UPDATE_URL + "?v="+getApplicationVersion()+"&fv="+flashVersion; // Server-side XML file describing update
      loadDataXml(updateURL);
    }
    
    // Find the current version for our Label below
    public function getApplicationVersion():String {
      var appXML:XML = NativeApplication.nativeApplication.applicationDescriptor;
      var ns:Namespace = appXML.namespace();
      return appXML.ns::versionLabel;
    }
    
    private function loadDataXml(xmlPath:String):void
    {
      xmlLoader = new URLLoader();
      xmlLoader.dataFormat = URLLoaderDataFormat.TEXT;
      xmlLoader.addEventListener(Event.COMPLETE, onXmlLoader_COMPLETE);
      xmlLoader.addEventListener(IOErrorEvent.IO_ERROR , onXmlLoader_IO_ERROR);
      var xmlRequest:URLRequest = new URLRequest();
      xmlRequest.url = xmlPath;
      
      try {
        xmlLoader.load(xmlRequest);
      } catch (error:Error) {
        trace("catch: Unable to load XML data.");
      }
    }
    
    private function onXmlLoader_COMPLETE(event:Event):void
    {
      xmlLoader.removeEventListener(Event.COMPLETE, onXmlLoader_COMPLETE);
      xmlLoader.removeEventListener(IOErrorEvent.IO_ERROR , onXmlLoader_IO_ERROR);
      
      try {
        var dataXml:XML = new XML(event.target.data);
        if (getApplicationVersion() != dataXml.version){
          UIManager.showUpdateAvailable(dataXml.version);
        }
      } catch (err:TypeError) {
        trace("Could not parse text into XML");
      }
    }
    
    private function onXmlLoader_IO_ERROR(event:IOErrorEvent):void
    {
      trace("onXmlLoader_IO_ERROR("+event+")");
      trace("event.text: "+String(event.text));
    }
    
  }
}