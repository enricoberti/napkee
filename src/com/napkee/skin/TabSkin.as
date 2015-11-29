package com.napkee.skin
{
  import mx.containers.Canvas;
  
  public class TabSkin extends Canvas
  {
    
    override protected function updateDisplayList(w:Number, h:Number):void
    {
      this.styleName = "tab";
      super.updateDisplayList(w, h);
    }
    
  }
}