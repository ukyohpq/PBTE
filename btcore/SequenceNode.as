package btcore
{
	public class SequenceNode extends NodeContainer
	{
		public function SequenceNode()
		{
		}
		

		public override function tick():int
		{
			var length:int = children.length;
			for (var i:int = 0; i < length; i++) 
			{
				if(children[i].tick() == NodeTickResult.FAILURE)
				{
					return NodeTickResult.FAILURE;
				}
			}
			return NodeTickResult.SUCCESS;
		}
		
	}
}