package test
{
	import flexunit.framework.Assert;
	import btcore.SequenceNode;
	
	public class SequenceNodeTest
	{		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function testTick():void
		{
			var node:SequenceNode = new SequenceNode();
			node.tick();
		}
	}
}