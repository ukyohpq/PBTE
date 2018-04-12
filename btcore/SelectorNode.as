package btcore
{
	public class SelectorNode extends NodeContainer
	{
		public function SelectorNode()
		{
		}
		
		
		public override function tick():int
		{
			var length:int = children.length;
			for (var i:int = 0; i < length; i++) 
			{
				if(children[i].tick() == NodeTickResult.SUCCESS)
				{
					return NodeTickResult.SUCCESS;
				}
			}
			return NodeTickResult.FAILURE;
		}


	}
}