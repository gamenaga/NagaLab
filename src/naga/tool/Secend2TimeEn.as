package naga.tool
{

    public class Secend2TimeEn
    {

        public static function go(second:int, size:int = 18, color:String = "ffffff") : String
        {
            var font:String = "<font size=\'" + size + "\' color=\'#" + color + "\'>";
            var h:String = int(second / 3600).toString();
            var m:String = int(second % 3600 / 60).toString();
            var s:String = int(second % 3600 % 60).toString();
            if (int(h) > 0)
			{
				if (int(h) < 10)
				{
					h = "0" + h;
				}
				font = font + (h + ":");
			}
			if (int(m) < 10)
			{
				m = "0" + m;
			}
			font = font + (m + ":");
			if (int(s) < 10)
			{
				s = "0" + s;
			}
			font = font + (s + "</font>");
			return font;
		}// end function

    }
}
