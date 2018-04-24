package editorTree
{
	import simpleBtree.Task;
	import simpleBtree.TaskContainer;
	
	public class EditorTree extends EditorLeafTask implements IEditorTree
	{
		public function EditorTree()
		{
			super();
		}
		
		public function get activeTask():Task
		{
			return null;
		}
		
		public function get root():TaskContainer
		{
			return null;
		}
		
		public function setActiveTask(task:Task):void
		{
		}
	}
}