package model
{
	import flash.utils.Dictionary;

	public class AppData
	{
		private static var _ins:AppData;
		public static function getInstance():AppData
		{
			return _ins ||= new AppData();
		}
		
		private var _projectMap:Dictionary;
		private var _currentProject:ProjectData;

		public function get currentProject():ProjectData
		{
			return _currentProject;
		}

		private var _globalLibData:LibData;
		public function AppData()
		{
			_projectMap = new Dictionary();
			_globalLibData = new LibData();
			_currentProject = new ProjectData();
		}
	}
}