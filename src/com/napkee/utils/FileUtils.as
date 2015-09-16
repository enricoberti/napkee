package com.napkee.utils
{
	import flash.filesystem.File;
	
	public class FileUtils
	{
		public function FileUtils()
		{
		}
		
		public static function exists(path:String):Boolean
		{
			var f:File = new File(path);
			return f.exists;
		}

	}
}