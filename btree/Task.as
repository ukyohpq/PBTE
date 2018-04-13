package btree
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * This is the abstract base class of all behavior tree tasks. The {@code Task} of a behavior tree has a status, one control and a
	 * list of children.
	 * 
	 * @param <E> type of the blackboard object that tasks use to read or modify game state
	 * @author implicit-invocation
	 * @author davebaol 
	 * @author ukyohpq 
	 * 
	 */
	public class Task
	{
		/** The clone strategy (if any) that {@link #cloneTask()} will use. Defaults to {@code null}, meaning that {@link #copyTo(Task)}
		 * is used instead. In this case, properly overriding this method in each task is developer's responsibility but this gives you
		 * the opportunity to target GWT.
		 * <p>
		 * For instance, if you don't care about GWT, you can let Kryo make a deep copy for you like that
		 * 
		 * <pre>
		 * <code>
		 *    Task.TASK_CLONER = new TaskCloner() {
		 *       Kryo kryo;
		 *       
		 *       {@literal @}Override
		 *       public {@code <T> Task<T> cloneTask (Task<T>} task) {
		 *          if (kryo == null) {
		 *             kryo = new Kryo();
		 *             kryo.setInstantiatorStrategy(new DefaultInstantiatorStrategy(new StdInstantiatorStrategy()));
		 *          }
		 *          return kryo.copy(task);
		 *       }
		 *    };
		 * </code>
		 * </pre> */
		public static var TASK_CLONER:TaskCloner = null;
		
		protected var _status:TaskStatus = TaskStatus.FRESH;

		/** The status of this task. */
		public function get status():TaskStatus
		{
			return _status;
		}

		
		/** The parent of this task */
		protected var control:Task;
		
		/** The behavior tree this task belongs to. */
		protected var tree:BehaviorTree;
		
		protected var _guard:Task;

		/** The guard of this task */
		public function get guard():Task
		{
			return _guard;
		}

		/**
		 * @private
		 */
		public function set guard(value:Task):void
		{
			_guard = value;
		}

		
		/**
		 * This method will add a child to the list of this task's children
		 * @param child the child task which will be added
		 * @return the index where the child has been added.
		 * @throws IllegalStateException if the child cannot be added for whatever reason.
		 */
		public final function addChild(child:Task):int
		{
			var index:int = addChildToTask(child);
//			if(tree != n)
		}
		
		/**
		 * This method will add a child to the list of this task's children
		 * @param child the child task which will be added
		 * @return the index where the child has been added.
		 * @throws IllegalStateException if the child cannot be added for whatever reason.
		 */
		protected function addChildToTask(child:Task):int
		{
			throw "must be override";
		}
		
		/**
		 * Returns the number of children of this task. 
		 * @return an int giving the number of children of this task
		 * 
		 */
		public function getChildCount():int
		{
			throw "must be override";
		}
		
		/**
		 * Returns the child at the given index
		 * @param i child index
		 * @return 
		 * 
		 */
		public function getChild(i:int):Task
		{
			throw "must be override";
		}
		
		/**
		 * Returns the blackboard object of the behavior tree this task belongs to
		 * @return blackboard object
		 * @throws IllegalStateException if this task has never run
		 */
		public function getObject():Object
		{
			if(tree == null)
			{
				throw new Error("This task has never run");
			}
			return tree.getObject();
		}
		
		/**
		 * This method will set a task as this task's control (parent)
		 * @param control the parent task
		 * 
		 */
		public function setControl(control:Task):void
		{
			this.control = control;
			this.tree = control.tree;
		}
		
		/**
		 * Checks the guard of this task
		 * @param control the parent task
		 * @return {@code true} if guard evaluation succeeds or there's no guard; {@code false} otherwise.
		 * @throws IllegalStateException if guard evaluation returns any status other than {@link Status#SUCCEEDED} and {@link Status#FAILED}.
		 * 
		 */
		public function checkGuard(control:Task):Boolean
		{
			// No guard to check
			if(guard == null) return true;
			
			// Check the guard of the guard recursively
			if(!guard.checkGuard(control)) return false;
			
			// Use the tree's guard evaluator task to check the guard of this task
			guard.setControl(control.tree.guardEvaluator);
			guard.start();
			guard.run();
			switch(guard.getStatus())
			{
				case TaskStatus.SUCCEEDED:
					return true;
				case TaskStatus.FAILED:
					return false;
				default:
					throw new Error("Illegal guard status '" + guard.getStatus() + "'. Guards must either succeed or fail in one step.");
			}
		}
		
		/**
		 * This method will be called once before this task's first run
		 * 
		 */
		public function start():void
		{
			
		}
		
		/**
		 * This method will be called by {@link #success()}, {@link #fail()} or {@link #cancel()}, meaning that this task's status has 
		 * just been set to {@link Status#SUCCEEDED}, {@link Status#FAILED} or {@link Status#CANCELLED} respectively. 
		 */
		public function end():void
		{
			
		}
		
		/**
		 * This method contains the update logic of this task. The actual implementation MUST call {@link #running()},
		 * {@link #success()} or {@link #fail()} exactly once.
		 * 
		 */
		public function run():void
		{
			throw "must be override";
		}
		
		/**
		 * this method will be called in {@link #run()} to inform control that this task needs to run again
		 * 
		 */
		public final function running():void
		{
			var previusStatus:TaskStatus = _status;
			_status = TaskStatus.RUNNING;
			if(tree.listenners != null && tree.listaners.size > 0)
				tree.notifyStatusUpdated(this, previusStatus);
			if(control != null)
				control.childRunning(this, this);
		}
		
		/**
		 * This method will be called in {@link #run()} to inform control that this task has finished running with a success result
		 * 
		 */
		public final function success():void
		{
			var previousStatus = _status;
			_status = TaskStatus.SUCCEEDED;
			if(tree.listeners != null && tree.listaners.size > 0)
				tree.notifyStatusUpdate(this, previousStatus);
			end();
			if(control != null)
				control.childSucess(this);	
		}
		
		/**
		 * his method will be called in {@link #run()} to inform control that this task has finished running with a failure result
		 * 
		 */
		public final function fail():void
		{
			var previusStatus = _status;
			_status = TaskStatus.FAILED;
			if(tree.listeners != null && tree.listeners.size > 0)
				tree.notifyStatusUpdate(this, previusStatus);
			if(control != null)
				control.childFail(this);
		}
		
		/**
		 * This method will be called when one of the children of this task succeeds
		 * @param task the task that succeeded
		 * 
		 */
		public function childSuccess(task:Task):void
		{
			throw "must be override";
		}
		
		/**
		 * This method will be called when one of the children of this task fails
		 * @param task the task that failed
		 * 
		 */
		public function childFail(task:Task):void
		{
			throw "must be override";
		}
		
		/**
		 * This method will be called when one of the ancestors of this task needs to run again
		 * @param runningTask the task that needs to run again
		 * @param reporter the task that reports, usually one of this task's children
		 * 
		 */
		public function childRunning(runningTask, reporter:Task):void
		{
			throw "must be override";
		}
		
		/**
		 * Terminates this task and all its running children. This method MUST be called only if this task is running
		 * 
		 */
		public function cancel():void
		{
			cancelRunningChildren(0);
			var previousStatus = _status;
			_status = TaskStatus.CANCELLED;
			if(tree.listeners != null && tree.listeners.size > 0)
				tree.notifyStatusUpdate(this, previousStatus);
			end();
		}
		
		/**
		 * Terminates the running children of this task starting from the specified index up to the end
		 * @param startIndex the start index
		 * 
		 */
		protected function cancelRunningChildren(startIndex:int):void
		{
			var length:int = getChildCount();
			for (var i:int = startIndex; i < length; i++) 
			{
				var child:Task = getChild(i);
				if(child.status == TaskStatus.RUNNING)
					child.cancel();
			}
		}
		
		/**
		 * Resets this task to make it restart from scratch on next run
		 * 
		 */
		public function resetTask():void
		{
			if(_status == TaskStatus.RUNNING) cancel();
			var length:int = getChildCount();
			for (var i:int = 0; i < length; i++) 
			{
				getChild(i).resetTask();
			}
			_status = TaskStatus.FRESH;
			tree = null;
			control = null;
		}
		
		/**
		 * Clones this task to a new one. If you don't specify a clone strategy through {@link #TASK_CLONER} the new task is 
		 * instantiated via reflection and {@link #copyTo(Task)} is invoked.
		 * @return the cloned task
		 * @throws TaskCloneException if the task cannot be successfully cloned.
		 */
		public function cloneTask():Task
		{
			if(TASK_CLONER != null)
			{
				try
				{
					return TASK_CLONER.cloneTask(this);
				}catch(e:Error)
				{
					throw new TaskCloneException(e.message);
				}
			}
			try
			{
				var thisCls:Class = getDefinitionByName(getQualifiedClassName(this));
				var clone:Task = copyTo(new thisCls());
				clone.guard = guard == null?null:guard.cloneTask();
				return clone;
			}catch(e:Error)
			{
				throw new TaskCloneException(e.message);
			}
		}
		
		/**
		 * Copies this task to the given task. This method is invoked by {@link #cloneTask()} only if {@link #TASK_CLONER} is
		 * {@code null} which is its default value.
		 * @param task the task to be filled
		 * @return the given task for chaining
		 * @throws TaskCloneException if the task cannot be successfully copied.
		 * 
		 */
		protected function copyto(task:Task):Task
		{
			throw "must be override";
		}
		
		public function reset():void
		{
			control = null;
			guard = null;
			_status = TaskStatus.FRESH;
			tree = null;
		}
		
		public function Task()
		{
		}
	}
}