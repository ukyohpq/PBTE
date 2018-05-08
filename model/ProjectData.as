package model
{
	public class ProjectData
	{
		private var _projectLibData:LibData;
		private var _cmdStack:CommandStack;
		private var _windows:Vector.<WorkSpaceWindowData>
		public function get cmdStack():CommandStack
		{
			return _cmdStack;
		}

		public function ProjectData()
		{
			_projectLibData = new LibData();
			_cmdStack = new CommandStack();
			_windows = Vector.<WorkSpaceWindowData>([]);
		}
		
		public function createWindow():void
		{
			
		}
		
		public function loadData(data:String = ""):void
		{
			if(data == "")
			{
				data = "";
			}
		}
	}
}