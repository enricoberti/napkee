package com.napkee.skin
{
	import mx.containers.Canvas;
	
	public class SelectedTabSkin extends Canvas
	{
		
		override protected function updateDisplayList(w:Number, h:Number):void
		{
			this.styleName = "selectedTab";
			super.updateDisplayList(w, h);
		}

	}
}