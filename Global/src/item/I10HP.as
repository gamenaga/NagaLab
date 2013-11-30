package item
{
	import ui.HpBar;

    public class I10HP extends Item
    {

        public function I10HP(num:int=0,iconID:int=10,isItemActive:Boolean=false)
        {
            super(num, iconID, isItemActive);
        }// end function

        override protected function add() : void
        {
                //Chk_first.chk(41, "道具\\2\\001<font size=\'+5\' color=\'#" + Css.TITLE + "\'>慢吞吞蜗牛</font><br><br><font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'><b>功能说明</b></font>：<br><br>我爬、我爬、我爬<b>...</b><br><font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'>速度变慢</font>、变慢、变慢<b>...</b>", Global.g_mode > -1);

        }// end function

        override public function item_do() : void
        {
			HpBar.changeHP(1);
			item_over();
        }// end function
		
		override public function achCount() : void
		{
			DataObj.data[30] ++;
		}// end function
    }
}
