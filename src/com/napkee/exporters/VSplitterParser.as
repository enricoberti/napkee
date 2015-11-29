package com.napkee.exporters
{
  import com.napkee.utils.ColorUtils;
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringUtils;
  
  import mx.containers.Canvas;
  import mx.containers.VDividedBox;
  import mx.core.UIComponent;
  
  public class VSplitterParser extends BasicParser implements IControlParser
  {
    
    public function VSplitterParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "vsplitter.xml";
    }
    
    
    
  }
}