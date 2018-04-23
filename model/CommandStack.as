package model
{
	import command.CommandManager;

	/**
	 * 命令栈，用于撤销，重做命令。命令栈有最大上限，可以通过配置进行调整。每当有新的命令要压栈，将会从当前位置进行压栈，后面的命令将抛弃
	 * @author ukyohpq
	 * 
	 */
	public class CommandStack
	{
		/**
		 * 命令栈。固定长度的数组，使用命令索引和栈索引共同工作。命令索引是对外的栈索引，
		 * 而栈索引是指向命令栈_stack的索引，不管是写数据，还是读数据，都是向_stack在该索引位置的元素进行读写。
		 * 通常状态下，两个索引会同时增加或者同时减少，其范围都是从0到最大值，但命令索引会在两端停下，
		 * 而栈索引则会传过去到另一头，比如，_cmdIndex已经为最大的情况下，再push入新的cmd，则_cmdIndex不变,
		 * 而_stackIndex则会加1，超过最大最，穿越到另一边，变成0。这样仅仅动两个索引，而不用动_stack中的元素，
		 * 即可实现命令栈，而且也省却了对象池。不过这种做法无法处理栈无限长的情况，但是几乎不需要使用到无限长的栈。
		 * 
		 */
		private var _stack:Vector.<CommandObj>;
		/**
		 * 命令索引
		 */
		private var _cmdIndex:int;
		/**
		 * 栈中有效命令索引，用来模拟数组长度。_stack中大于这个位置的所有元素都是无效的，都是多次redo之后，再push造成的。
		 */
		private var _totalCmd:int;
		/**
		 * 栈索引
		 */
		private var _stackIndex:int;
		public function CommandStack()
		{
			_cmdIndex = 0;
			_stackIndex = 0;
			_totalCmd = 0;
			
			_stack = Vector.<CommandObj>([]);
			var length:int = GlobalConfig.MAX_STACK;
			for (var i:int = 0; i < length; i++) 
			{
				_stack[i] = new CommandObj();
			}
		}
		
		public function undo():void
		{
			if(_cmdIndex == 0)
			{
				return;
			}else{
				_cmdIndex--;
				if(--_stackIndex < 0)
				{
					_stackIndex += _stack.length;
				}
				var cmd:CommandObj = _stack[_stackIndex];
				CommandManager.getInstance().undo(cmd.name, cmd.params);
			}
		}
		
		public function redo():void
		{
			if(_cmdIndex == _totalCmd)
			{
				return;
			}else{
				var cmd:CommandObj = _stack[_stackIndex];
				CommandManager.getInstance().redo(cmd.name, cmd.params);
				_cmdIndex++;
				if(++_stackIndex == _stack.length)
				{
					_stackIndex = 0;
				}
			}
		}
		
		public function push(name:String, params:Array = null):void
		{
			var stackLength:int = _stack.length;
			//尝试增加cmdIndex和totalCmd
			if(_cmdIndex < stackLength - 1)
			{
				_cmdIndex++;
				_totalCmd = _cmdIndex;
			}
			
			var cmdObj:CommandObj = _stack[_stackIndex];
			cmdObj.name = name;
			cmdObj.params = params;
			
			//增加stackIndex,并处理越界的情况
			if(++_stackIndex == stackLength)
			{
				_stackIndex -= stackLength;
			}
		}
		
	}
}

class CommandObj
{
	public var name:String;
	public var params:Array;
}