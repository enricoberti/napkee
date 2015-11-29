package com.napkee.domain
{
  
  [Bindable]
  [Table(name="applicationsettings")]
  public class ApplicationSetting
  {
    [Id]
    [Column(name="id")]
    public var id:int;
    
    [Column(name="property")]
    public var property:String;
    
    [Column(name="value")]
    public var value:String;
    
    public function ApplicationSetting()
    {
    }
    
  }
}