package btree
{
	/**
	 * The behavior tree itself.
	 * @author implicit-invocation
 	 * @author davebaol
	 * @author ukyohpq
	 * 
	 */
	public class BehaviorTree extends Task
	{
		private var rootTask:Task;
		private var object:Object;
		internal var guardEvaluator:GuardEvaluator;
		public var listeners:Vector.<Listener>;
		/**
		 * Creates a behavior tree with a root task and a blackboard object. Both the root task and the blackboard object must be set
	 	 * before running this behavior tree, see {@link #addChild(Task) addChild()} and {@link #setObject(Object) setObject()}
	 	 * respectively.
		 * @param rootTask
		 * @param object
		 * 
		 */
		public function BehaviorTree(rootTask:Task, object:Object)
		{
			this.rootTask = rootTask;
			this.object = object;
			this.tree = this;
			this.guardEvaluator = new GuardEvaluator(this);
		}
		
		/**
		 * Returns the blackboard object of this behavior tree.
		 * @return 
		 * 
		 */
		public override function getObject():Object
		{
			return object;
		}
		
		/**
		 * Sets the blackboard object of this behavior tree.
		 * @param object the new blackboard
		 * 
		 */
		public function setObject(object:Object):void
		{
			this.object = object;
		}
		
		/**
		 * This method will add a child, namely the root, to this behavior tree.
		 * @param child the root task to add
		 * @return the index where the root task has been added (always 0).
		 * @throws IllegalStateException if the root task is already set.
		 * 
		 */
		protected override function addChildToTask(child:Task):int
		{
			if(this.rootTask != null)
				throw new Error("A behavior tree cannot have more than one root task");
			this.rootTask = child;
			return 0;
		}
		
		public override function getChildCount():int
		{
			return rootTask == null?0:1;
		}
		
		public override function getChild(i:int):Task
		{
			if(i == 0 && rootTask != null)
				return rootTask;
			throw new Error("index can't be >= size: " + i + " >= " + getChildCount());
		}
		
		public override function childRunning(runningTask:Object, reporter:Task):void
		{
			running();
		}
		
		public override function childFail(task:Task):void
		{
			fail();
		}
		
		public override function childSuccess(task:Task):void
		{
			success();
		}
		
		/**
		 * This method should be called when game entity needs to make decisions: call this in game loop or after a fixed time slice if
	 	 * the game is real-time, or on entity's turn if the game is turn-based
		 * 
		 */
		public function step():void
		{
			if(rootTask.status == TaskStatus.RUNNING)
			{
				rootTask.run();
			}else{
				rootTask.setControl(this);
				rootTask.start();
				if(rootTask.checkGuard(this))
					rootTask.run();
				else
					rootTask.fail();
			}
		}
		
		public override function run():void
		{
			
		}
		
		public override function resetTask():void
		{
			super.resetTask();
			tree = this;
		}
		
		protected override function copyto(task:Task):Task
		{
			var tree:BehaviorTree = task as BehaviorTree;
			tree.rootTask = rootTask.cloneTask();
			return task;
		}
		
		public function addListener(listener:Listener):void
		{
			if(listeners == null)
				listeners = Vector.<Listener>([]);
			listeners.push(listener);
		}
		
		public function removeListener(listener:Listener):void
		{
			if(listener != null)
				listeners.splice(listeners.indexOf(listener), 1);
		}
		
		public function removeListeners():void
		{
			if(listeners != null)
				listeners.length = 0;
		}
		
		public function notifyStatusUpdated(task:Task, previousStatus:TaskStatus):void
		{
			for each (var listener:Listener in listeners) 
			{
				listener.statusUpdate(task, previousStatus);
			}
		}
		
		public function notifyChildAdded(task:Task, index:int):void
		{
			for each (var listener:Listener in listeners) 
			{
				listener.childAdded(task, index);
			}
		}
			
		public override function reset():void
		{
			removeListeners();
			this.rootTask = null;
			this.object = null;
			this.listeners = null;
			super.reset();
		}
	}
	
}
import btree.BehaviorTree;
import btree.Task;
import btree.TaskStatus;

class GuardEvaluator extends Task
{
	public function GuardEvaluator(tree:BehaviorTree = null)
	{
		this.tree = tree;
	}
	
	protected override function addChildToTask(child:Task):int
	{
		return 0;
	}
	
	public override function getChildCount():int
	{
		return 0;
	}
	
	public override function getChild(i:int):Task
	{
		return null;
	}
	
	public override function run():void
	{
		
	}
	
	public override function childSuccess(task:Task):void
	{
		
	}
	
	public override function childFail(task:Task):void
	{
		
	}
	
	public override function childRunning(runningTask:Object, reporter:Task):void
	{
		
	}
	
	protected override function copyto(task:Task):Task
	{
		return null;
	}
}

interface Listener
{
	function statusUpdate(task:Task, previousStatus:TaskStatus);
	function childAdded(task:Task, index:int);
}