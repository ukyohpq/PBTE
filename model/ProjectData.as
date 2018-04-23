package model
{
	public class ProjectData
	{
		private var _projectLibData:LibData;
		private var _cmdStack:CommandStack;

		public function get cmdStack():CommandStack
		{
			return _cmdStack;
		}

		public function ProjectData()
		{
			_projectLibData = new LibData();
			_cmdStack = new CommandStack();
		}
	}
}