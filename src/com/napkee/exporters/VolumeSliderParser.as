package com.napkee.exporters
{
  import com.napkee.utils.ComponentParser;
  
  import mx.containers.HBox;
  import mx.controls.HSlider;
  import mx.controls.Image;
  import mx.core.UIComponent;
  
  public class VolumeSliderParser extends BasicParser implements IControlParser
  {
    
    public function VolumeSliderParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "volumeslider.xml";
    }
    
    
  }
}