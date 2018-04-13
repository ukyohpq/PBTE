package btree.annotation
{
	public interface TaskConstraint
	{
		public function minChildren():int;
		public function maxChildren():int;
	}
}