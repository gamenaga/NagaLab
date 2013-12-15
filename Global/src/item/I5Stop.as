package item
{
	import com.easing.Circ;
	import com.greensock.TweenLite;
	
	import flash.utils.setTimeout;
	
	import naga.eff.GameStop;
	import naga.system.Sounds;
	
	import ui.UI;

    public class I5Stop extends Item
    {
		private static var iDoing:Boolean=false;
        public function I5Stop(num:int=0, iconID:int=5,isItemActive:Boolean=false,time:int=2000)
        {
            super(num, iconID, isItemActive, time);
        }// end function

        override protected function add() : void
        {
                //Chk_first.chk(44, "道具\\2\\005<font size=\'+5\' color=\'#" + Css.TITLE + "\'>定时器</font><br><br><font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'><b>功能说明</b></font>：<br><br>滴答！滴答？滴答？！<br>启动定时器，时间<font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'>定格<b>2</b>秒</font>！", Global.g_mode > -1);
            
        }// end function

        override public function item_do() : void
        {
			if (!iDoing)
			{
				isChkCut = true;
				iDoing = true;
				Sounds.play(Se_dida, 4);
//			MoveTo.add(icon.parent.parent,10,UI.item_do_x,UI.item_do_y,1,1.5);
			TweenLite.to(icon.parent.parent, .6, {x:UI.item_do_x, y:UI.item_do_y, ease:Circ.easeInOut});

            call();
//            E2_shake.add(icon, ms, 10, false, true);
            time_id = setTimeout(i5_over, ms);
			}
			else
			{
				item_over();
			}
        }// end function
		
		private function i5_over() : void
		{
			over();
			item_over();
		}// end function
		
        public static function call() : void
        {
			GameStop.stop(true);
        }// end function

        public static function over() : void
        {
			GameStop.run();
			iDoing=false;
        }// end function
		
		override public function achCount() : void
		{
			DataObj.data[25] ++;
		}// end function
		
    }
}
