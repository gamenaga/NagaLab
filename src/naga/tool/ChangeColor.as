package naga.tool
{
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;

    public class ChangeColor
    {

        public static function go(obj:DisplayObject, color:String, alpha:Number=1) : void
        {
			obj.transform.colorTransform = new ColorTransform(int("0x" + color.slice(0, 2)) / 255, int("0x" + color.slice(2, 4)) / 255, int("0x" + color.slice(4, 6)) / 255, alpha, 0, 0, 0, 0);
        }// end function
		
		public static function r(obj:DisplayObject) : void
		{
			if(obj.transform.colorTransform != null)
			{
			obj.transform.colorTransform= null;
			}
		}// end function
    }
}
