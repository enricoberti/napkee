package com.napkee.exporters
{
  import mx.containers.HBox;
  import mx.controls.Button;
  import mx.core.UIComponent;
  
  public class MediaControlsParser extends BasicParser implements IControlParser
  {
    
    public function MediaControlsParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "mediacontrols.xml";
    }
    
  }
}