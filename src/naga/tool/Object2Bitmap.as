package naga.tool
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	
	/**
	 * 把一个DisplayObject中所有内容，转为一整张Bitmap，返回该Bitmap
	 */
	public class Object2Bitmap
	{
		/**
		 * @param obj 源对象
		 */
		public static function go(obj:DisplayObject) : Bitmap
		{
//						trace("obj2bmp 12:	"+obj+"		obj.width="+obj.width+"		obj.height="+obj.height);
			var bmp:Bitmap = new Bitmap(new BitmapData(obj.width, obj.height, true, 0));
			bmp.bitmapData.draw(obj);
			return bmp;
		}// end function
		
	}
}
