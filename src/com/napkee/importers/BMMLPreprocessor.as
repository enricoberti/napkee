package com.napkee.importers
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public class BMMLPreprocessor
	{
		private var bmml:XML;
		private var mergedControlList:XMLList = new XMLList("<controls/>");
		
		public function BMMLPreprocessor(bmmlFile:File)
		{
			
			if (!bmmlFile.exists){
				// TODO: handle exception
				return;
			}
			
			var fs:FileStream = new FileStream();
			fs.open(bmmlFile, FileMode.READ);
			bmml = XML(fs.readUTFBytes(fs.bytesAvailable));
			
			var lastZOrder:Number = 0;
			
			for each (var control:XML in bmml.controls.control){
				lastZOrder = control.@zOrder*1;
				if (control.@controlTypeID != "com.balsamiq.mockups::Component"){
					mergedControlList.appendChild(control);
				}
				if (control.@controlTypeID == "com.balsamiq.mockups::Component"){
					var fragmentLoader:FragmentLoader = new FragmentLoader(control, bmmlFile);
					if (fragmentLoader.exists()){
						for each (var fragmentControl:XML in fragmentLoader.getModifiedControls()){
							//trace(fragmentControl);
							mergedControlList.appendChild(fragmentControl);
						}
						var zOrderDifference:Number = fragmentLoader.getLastZOrder() - lastZOrder;
						for each (var controlZOrder:XML in bmml.controls.control){
							if (controlZOrder.@zOrder*1 > lastZOrder){
								controlZOrder.@zOrder = controlZOrder.@zOrder*1 + zOrderDifference;
							}
						}
					}
					else {
						mergedControlList.appendChild(control);
					}
				}
			}
			
		}
		
		public function getControls():XMLList
		{
			return mergedControlList;
		}

	}
}