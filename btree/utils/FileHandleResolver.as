package btree.utils
{
	/**
	 * Interface for classes the can map a file name to a {@link FileHandle}. Used to allow the {@link AssetManager} to load resources
 	 * from anywhere or implement caching strategies.
 	 * @author mzechner
	 * @author ukyohpq
	 * 
	 */
	public interface FileHandleResolver
	{
		function resolve(fileName:String):FileHandle;
	}
}