package btree.branch
{
	import utils.Enum;

	/**
	 * The enumeration of the policies supported by the {@link Parallel} task.
	 * @author ukyohpq
	 * 
	 */
	public class Policy extends Enum
	{	
		/**
		 * The sequence policy makes the {@link Parallel} task fail as soon as one child fails; if all children succeed, then the
		 * parallel task succeeds. This is the default policy.
		 */
		public static const Sequence:Policy = new SequencePolicy("Sequence");
		/**
		 * The selector policy makes the {@link Parallel} task succeed as soon as one child succeeds; if all children fail, then the
		 * parallel task fails.
		 */
		public static const Selector:Policy = new SelectorPolicy("Selector");
		
		/**
		 * Called by parallel task each time one of its children succeeds.
		 * @param parallel the parallel task
		 * @return {@code Boolean.TRUE} if parallel must succeed, {@code Boolean.FALSE} if parallel must fail and {@code null} if
		 *         parallel must keep on running.
		 * 
		 */
		public function onChildSuccess(parallel:Parallel):Boolean
		{
			throw "must be override";
		}
		
		/**
		 * Called by parallel task each time one of its children fails.
		 * @param parallel the parallel task
		 * @return {@code Boolean.TRUE} if parallel must succeed, {@code Boolean.FALSE} if parallel must fail and {@code null} if
		 *         parallel must keep on running.
		 * 
		 */
		public function onChildFail(parallel:Parallel):Boolean
		{
			throw "must be override";
		}
	}
}
import btree.Task;
import btree.TaskStatus;
import btree.branch.Orchestrator;
import btree.branch.Parallel;
import btree.branch.Policy;

import org.flexunit.runners.ParentRunner;

class SequencePolicy extends Policy
{
	public override function onChildSuccess(parallel:Parallel):Boolean
	{
		var children:Vector.<Task> = parallel.getChildren();
		switch(parallel.orchestrator)
		{
			case Orchestrator.Join:
				return parallel.noRunningTasks && children[children.length - 1].status == TaskStatus.SUCCEEDED;
			case Orchestrator.Resume:
			default:
				return parallel.noRunningTasks && parallel.currentChildIndex == children.length - 1;
		}
	}
	
	public override function onChildFail(parallel:Parallel):Boolean
	{
		return false;
	}
}


class SelectorPolicy extends Policy
{
	public override function onChildSuccess(parallel:Parallel):Boolean
	{
		return true;
	}
	
	public override function onChildFail(parallel:Parallel):Boolean
	{
		var children:Vector.<Task> = parallel.getChildren();
		return parallel.noRunningTasks && parallel.currentChildIndex == children.length - 1;
	}
}
