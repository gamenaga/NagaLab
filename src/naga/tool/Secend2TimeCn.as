package naga.tool
{
	import naga.global.Css;

    public class Secend2TimeCn
	{

        public static function go(second:int, size:int = 0, color:String = "ffffff") : String
        {
			if(size == 0) size = Css.SIZE;
            var str:String = "<font size=\'" + (size-3) + "\' color=\'#" + color + "\'>" + int(second % 3600 % 60) + "</font>秒";
            if (second >= 60)
            {
                str = "<font size=\'" + (size - 2) + "\' color=\'#" + color + "\'>" + int(second % 3600 / 60) + "</font>分" + str;
            }
            if (second >= 3600)
            {
                str = "<font size=\'" + (size - 1) + "\' color=\'#" + color + "\'>" + int(second / 3600) + "</font>小时" + str;
            }
//			trace("secend2Time 21:	",str);
            return str;
        }// end function

    }
}
