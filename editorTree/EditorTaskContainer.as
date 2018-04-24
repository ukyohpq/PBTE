package editorTree
{
	import simpleBtree.ITask;
	import simpleBtree.TaskContainer;
	
	public class EditorTaskContainer extends EditorTask implements IEditorTaskContainer
	{
		public function EditorTaskContainer()
		{
			super();
		}
		
		protected override function get task():ITask
		{
			return new TaskContainer();
		}
		
		public function addChild(task:ITask):void
		{
			TaskContainer(task).addChild(task);
		}
		
		public function removeChild(task:ITask):void
		{
			TaskContainer(task).removeChild(task);
		}
	}
}