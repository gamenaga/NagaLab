package naga.tool
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	

    public class Shadow
    {

        public static function go(obj:Sprite, dis:Number = 1) : void
        {
//			if(Glo.is_hd){
				var sd:Bitmap = GetBitmap.go(obj);
				sd.x = dis;
				sd.y = dis;
				ChangeColor.go(sd, "111111", 0.8);
//				var ob:Sprite = new Sprite();
//				ob.addChild(sd);
//				ob.addChild(obj);
//				sd = GetBitmap.go(ob);
				obj.addChild(sd);
				obj.setChildIndex(sd, 0);
//				return sd;
//			}
        }// end function

    }
}
