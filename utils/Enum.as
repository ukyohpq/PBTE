package utils 
{
	import flash.utils.getQualifiedClassName;

	public class Enum
	{
		private var _enumValue:Object;
		public function Enum(value:Object)
		{
			this._enumValue = value;
		}
		
		public function name():String
		{
			return this.toString();	
		}
		
		public function toString():String
		{
			return "[ enum:" + getQualifiedClassName(this) + " " + this._enumValue.toString() +"]";
		}
	}
}