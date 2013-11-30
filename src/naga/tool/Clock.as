package naga.tool
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import naga.global.Css;
	import naga.global.Global;
	

    public class Clock extends Sprite
    {
        private var tf:TextField = new TextField();

        public function Clock()
        {
            this.mouseEnabled = false;
            this.mouseChildren = false;
            addChild(tf);
        }// end function

        public function go(second:int, type:String = "en", size:int = 18, color:String = "ffffff", align:String = "center") : void
        {
            var str:String = null;
            if (type == "en")
            {
                str = Secend2TimeEn.go(second, size, color);
            }
            else if (type == "cn")
            {
                str = Secend2TimeCn.go(second, size, color);
            }
            else
            {
                str = "<font size=\'" + size + "\' color\'#" + color + "\'>" + second + "</font>";
            }
            this.tf.htmlText = "<p align=\'" + align + "\'><font face=\'"+Css.FONT+"\'>" + str + "</font></p>";
				var temp:int = numChildren - 1;
				while (temp > 0)
				{
					removeChild(getChildAt(temp));
					temp = temp - 1;
				}
				String2Font.go(this.tf, this, size, color,false);
        }// end function

    }
}
