package editorTree
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import simpleBtree.IGuard;
	import simpleBtree.ITask;
	import simpleBtree.ITaskContainer;
	import simpleBtree.ITree;
	import simpleBtree.Task;
	import simpleBtree.TaskResult;
	import simpleBtree.TaskStatus;
	
	public class EditorTask implements IEditorTask
	{
		private var _task:ITask;
		private var _eventDispatcher:EventDispatcher;
		public function EditorTask()
		{
			_task = task;
			_eventDispatcher = new EventDispatcher(this);
		}
		
		protected function get task():ITask
		{
			return new Task();
		}
		
		public function get status():TaskStatus
		{
			return _task.status;
		}
		
		public function set status(value:TaskStatus):void
		{
			_task.status = value;
		}
		
		public function run(stepTime:Number):TaskResult
		{
			return _task.run(stepTime);
		}
		
		public function reset():void
		{
			_task.reset();
		}
		
		public function addGuard(guard:IGuard):void
		{
			_task.addGuard(guard);
		}
		
		public function removeGuard():void
		{
			_task.removeGuard();
		}
		

		public function get description():String
		{
			return _task.description;
		}

		public function set description(value:String):void
		{
			_task.description = value;
		}

		public function get name():String
		{
			return _task.name;
		}

		public function set name(value:String):void
		{
			_task.name = value;
		}

		public function get parent():ITaskContainer
		{
			return _task.parent;
		}

		public function set parent(value:ITaskContainer):void
		{
			_task.parent = value;
		}

		public function get tree():ITree
		{
			return _task.tree;
		}

		public function set tree(value:ITree):void
		{
			_task.tree = value;
		}

		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			_eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			_eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return _eventDispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return _eventDispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean
		{
			return _eventDispatcher.willTrigger(type);
		}
	}
}