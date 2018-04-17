package btree.branch
{
	import utils.Enum;

	/**
	 * The enumeration of the child orchestrators supported by the {@link Parallel} task
	 * @author ukyohpq
	 * 
	 */
	public class Orchestrator extends Enum
	{
		/**
		 * The default orchestrator - starts or resumes all children every single step 
		 */
		public static const Resume:Orchestrator = new ResumeOrchestrator("Resume");
		
		/**
		 * Children execute until they succeed or fail but will not re-run until the parallel task has succeeded or failed
		 */
		public static const Join:Orchestrator = new JoinOrchestrator("Join");
		
		/**
		 * Called by parallel task each run
		 * @param parallel The {@link Parallel} task
		 * 
		 */
		public function execute(parallel:Parallel):void
		{
			throw "must be override";
		}
	}
}
import btree.Task;
import btree.TaskStatus;
import btree.branch.Orchestrator;
import btree.branch.Parallel;

class ResumeOrchestrator extends Orchestrator
{
	public override function execute(parallel:Parallel):void
	{
		parallel.noRunningTasks = true;
		parallel.lastResult = false;
		var children:Vector.<Task> = parallel.getChildren();
		var length:int = children.length;
		for(parallel.currentChildIndex = 0; parallel.currentChildIndex < length; parallel.currentChildIndex++)
		{
			var child:Task = children[parallel.currentChildIndex];
			if(child.status == TaskStatus.RUNNING)
			{
				child.run();
			}else{
				child.setControl(parallel);
				child.start();
				if(child.checkGuard(parallel))
					child.run();
				else
					child.fail();
			}
			
			if(parallel.lastResult != null)// Current child has finished either with success or fail
			{
				parallel._cancelRunningChildren(parallel.noRunningTasks ? parallel.currentChildIndex + 1 : 0);
				if(parallel.lastResult)
					parallel.success();
				else
					parallel.fail();
				return;
			}
		}
		parallel.running();
	}
}

class JoinOrchestrator extends Orchestrator
{
	public override function execute(parallel:Parallel):void
	{
		parallel.noRunningTasks = true;
		parallel.lastResult = false;
		var children:Vector.<Task> = parallel.getChildren();
		var length:int = children.length;
		for(parallel.currentChildIndex = 0;parallel.currentChildIndex < length;parallel.currentChildIndex++)
		{
			var child:Task = children[parallel.currentChildIndex];
			switch(child.status)
			{				
				case TaskStatus.RUNNING:
					child.run();
					break;
				case TaskStatus.SUCCEEDED:
				case TaskStatus.FAILED:
					break;	
				default:
					child.setControl(parallel);
					child.start();
					if(child.checkGuard(parallel))
						child.run();
					else
						child.fail();
					break;
			}
			
			if(parallel.lastResult != null)
			{
				parallel._cancelRunningChildren(parallel.noRunningTasks? parallel.currentChildIndex + 1 : 0);
				parallel.resetAllChildren();
				if(parallel.lastResult)
					parallel.success();
				else
					parallel.fail();
				return;
			}
		}
		parallel.running();
	}
}