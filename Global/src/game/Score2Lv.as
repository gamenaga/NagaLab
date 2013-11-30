package game
{
	import naga.global.Css;

    public class Score2Lv
    {

        public static function go(param1:int, param2:Class) : String
        {
            var lv:String = null;
            if (param1 < param2.E_)
            {
                lv = "<FONT COLOR=\'#" + Css.BL_D2 + "\'>E</FONT>";
            }
            else if (param1 < param2.D)
            {
                lv = "<FONT COLOR=\'#" + Css.BL_D2 + "\'>E+</FONT>";
            }
            else if (param1 < param2.D_)
            {
                lv = "<FONT COLOR=\'#" + Css.BL_D + "\'>D</FONT>";
            }
            else if (param1 < param2.C)
            {
                lv = "<FONT COLOR=\'#" + Css.BL_D + "\'>D+</FONT>";
            }
            else if (param1 < param2.C_)
            {
                lv = "<FONT COLOR=\'#" + Css.YELLOW + "\'>C</FONT>";
            }
            else if (param1 < param2.B)
            {
                lv = "<FONT COLOR=\'#" + Css.YELLOW + "\'>C+</FONT>";
            }
            else if (param1 < param2.B_)
            {
                lv = "<FONT COLOR=\'#" + Css.ORAN_D + "\'>B</FONT>";
            }
            else if (param1 < param2.A)
            {
                lv = "<FONT COLOR=\'#" + Css.ORAN_D + "\'>B+</FONT>";
            }
            else if (param1 < param2.A_)
            {
                lv = "<FONT COLOR=\'#" + Css.ORANGE + "\'>A</FONT>";
            }
            else if (param1 < param2.S)
            {
                lv = "<FONT COLOR=\'#" + Css.ORANGE + "\'>A+</FONT>";
            }
            else if (param1 < param2.SS)
            {
                lv = "<FONT COLOR=\'#" + Css.ORAN_S + "\'>S</FONT>";
            }
            else if (param1 < param2.SSS)
            {
                lv = "<FONT COLOR=\'#" + Css.ORAN_S + "\'>SS</FONT>";
            }
            else
            {
                lv = "<FONT COLOR=\'#" + Css.ORAN_S + "\'>SSS</FONT>";
            }
            return lv;
        }// end function

    }
}
