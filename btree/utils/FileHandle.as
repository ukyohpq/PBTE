package btree.utils
{
	import flash.filesystem.File;

	public class FileHandle
	{
		protected var file:File;
		protected var type:FileType;
		public function FileHandle(fileName:String, type:FileType = FileType.Absolute)
		{
			this.file = new File(fileName);
			this.type = type;
		}
		
		/**
		 * 
		 * @return the path of the file as specified on construction, e.g. Gdx.files.internal("dir/file.png") -> dir/file.png.
	 	 *         backward slashes will be replaced by forward slashes.
		 * 
		 */
		public function path():String
		{
			return file.url.replace("\\", "/");
		}
		
		public function name():String
		{
			return file.name;
		}
		
		public function extension():String
		{
			return file.extension;
		}
		
		public function nameWithOutExtension():String
		{
			var name:String = file.name;
			var dotIndex = name.lastIndexOf(".");
			if(dotIndex == -1)
				return name;
			return name.substring(0, dotIndex);
		}
		
		
	}
}