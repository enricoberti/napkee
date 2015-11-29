package com.napkee.domain
{
  import mx.core.UIComponent;
  
  public class ComponentModel
  {
    
    public var id:String;
    public var parent:String;
    public var bmml:XML;
    public var html:String;
    public var css:String;
    public var js:String;
    public var jsGlobal:String;
    public var asC:String;
    public var mxml:String;
    public var component:UIComponent;
    
    public function ComponentModel()
    {
      this.parent = "";
      this.html = "";
      this.css = "";
      this.js = "";
      this.jsGlobal = "";
      this.asC = "";
      this.mxml = "";
      this.component = null;
    }
    
  }
}