package naga.system
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;

    public class FontEn9
    {
        public static const font_width:Array = new Array(6, 4, 3, 5, 6, 5, 5, 6, 3, 4, 4, 5, 5, 4, 5, 3, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 3, 4, 5, 5, 5, 5, 6, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 5, 5, 5, 5, 5, 5, 5, 5, 6, 5, 5, 5, 4, 5, 4, 5, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 4, 5, 5, 4, 6, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 5, 5, 5, 5, 3, 5, 6, 5);
        private static const font_img:Bitmap = new Bitmap(new FontEn9_());
		
        public static function char(idx:int, color:String = null) : BitmapData
        {
            var bmpd:BitmapData = new BitmapData(font_width[idx], 9);
            bmpd.copyPixels(font_img.bitmapData, new Rectangle(idx % 10 * 6, int(idx / 10) * 9, 6, 9), new Point(0, 0));
            if (color != null)
            {
                bmpd.colorTransform(new Rectangle(1, 1, font_width[idx] - 2, bmpd.height - 2), new ColorTransform(int("0x" + color.slice(0, 2)) / 255, int("0x" + color.slice(2, 4)) / 255, int("0x" + color.slice(4, 6)) / 255, 1, 0, 0, 0, 0));
            }
            return bmpd;
        }// end function

    }
}
