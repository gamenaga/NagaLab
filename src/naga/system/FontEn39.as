package naga.system
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;

    public class FontEn39
    {
        public static const font_width:Array = new Array(27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27);
        private static const font_img:Bitmap = new Bitmap(new FontEn39_());
		
        public static function char(idx:int, color:String = null) : BitmapData
        {
            var bmpd:BitmapData = new BitmapData(font_width[idx], 39);
            bmpd.copyPixels(font_img.bitmapData, new Rectangle(idx % 10 * 27, int(idx / 10) * 39, 27, 39), new Point(0, 0));
            if (color != null)
            {
                bmpd.colorTransform(new Rectangle(1, 1, font_width[idx] - 2, bmpd.height - 2), new ColorTransform(int("0x" + color.slice(0, 2)) / 255, int("0x" + color.slice(2, 4)) / 255, int("0x" + color.slice(4, 6)) / 255, 1, 0, 0, 0, 0));
            }
            return bmpd;
        }// end function

    }
}
