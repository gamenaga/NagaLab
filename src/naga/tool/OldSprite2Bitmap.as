package naga.tool
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 *
	 * 把一个Sprite中所有内容，转为一整张Bitmap，返回该Sprite
	 * 
	 * 
	 * 
	 */
    public class OldSprite2Bitmap
    {
		/**
		 *
		 * @param obj 源对象
		 * 
		 * 
		 * 
		 */
        public static function go(obj:Sprite) : Sprite
        {
//			trace("spr2img 15:	"+obj);
            var bmp:Bitmap = GetBitmap.go(obj);
            obj.graphics.clear();
			var temp:int = obj.numChildren-1;
            while (temp >= 0)
            {
				trace("spr2img 15:	"+temp+"/"+obj.numChildren,obj.getChildAt(temp));
                obj.removeChildAt(temp);
                temp --;
            }
            obj.addChild(bmp);
            return obj;
        }// end function

    }
}
