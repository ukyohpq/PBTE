package btcore
{
	import flash.text.engine.TabAlignment;
	import flash.utils.Dictionary;

	public class NodeContainer extends Node
	{
		protected var children:Vector.<Node>;
		protected var childDic:Dictionary;
		public function NodeContainer()
		{
			children = Vector.<Node>([]);
			childDic = new Dictionary(true);
		}
		
		public function addChild(child:Node):void
		{
			if(childDic[child] == null)
			{
				childDic[child] = children.push(child);
			}else{
				var index:int = childDic[child];
				children.splice(index, 1);
				childDic[child] = children.push(child);
			}
		}

	}
}