package com.napkee.export
{
  import com.napkee.export.settings.FlashRuntimeType;
  import com.napkee.export.settings.IdeType;
  import com.napkee.export.settings.SdkType;
  
  import flash.filesystem.File;
  import mx.collections.ArrayCollection;
  
  public class ExportSpec {        
    public var targetIde: IdeType;
    public var targetSdk: SdkType;
    public var targetRuntime: FlashRuntimeType;
    
    public var exportNature: String;
    public var targetFolder: File;
    public var projectName: String;
    public var applicationName:String;
    public var sourceMockups: ArrayCollection;  // BMMFile
  }
}