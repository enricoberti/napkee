package com.napkee.vo
{
	import com.adobe.utils.StringUtil;
	import com.napkee.utils.StringUtils;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.collections.ArrayCollection;
	
	public class BMMLFile {
		
		[Bindable] public var file:File;

        private function get xml(): XML {
            var fs:FileStream = new FileStream();
            fs.open(file, FileMode.READ);
            var xml:XML = XML(fs.readUTFBytes(fs.bytesAvailable));
            fs.close();
            return xml;
        }
        
        public function get linkedFiles(): ArrayCollection {
            var linked: ArrayCollection = new ArrayCollection();
            for each (var mockupControl:XML in xml.controls.control) {
                if (StringUtils.isNotBlank(mockupControl.controlProperties.href)) {
                    var fi:BMMLFile = new BMMLFile();
                    fi.file = new File(file.parent.nativePath+File.separator+mockupControl.controlProperties.href);
                    if (fi.file.exists)
                        linked.addItem(fi);
                }
                if (StringUtils.isNotBlank(mockupControl.controlProperties.hrefs)) {
                    var linkedFiles:Array = (mockupControl.controlProperties.hrefs).split("%2C");
                    for (var l:int = 0;l<linkedFiles.length;l++){
                        var link:String = StringUtil.trim(unescape(linkedFiles[l] as String));
                        if (StringUtils.isNotBlank(link)){
                            var fi:BMMLFile = new BMMLFile();
                            fi.file = new File(file.parent.nativePath+File.separator+link);
                            if (fi.file.exists){
                                linked.addItem(fi);
                            }
                        }				
                    }
                }
            }
            return linked;
        }
	}
}