package item
{
	import naga.global.Css;
	import naga.global.Global;
	import naga.system.Bubble;
	import naga.system.Sounds;
	
	import pop.PopFactory;

    public class I1SpeedDown extends Item
    {
//        private static var bak_speed:Number = 0;

        public function I1SpeedDown(num:int=0, iconID:int=1,isItemActive:Boolean=false)
        {
            super(num, iconID, isItemActive);
        }// end function

        override protected function add() : void
        {
                //Chk_first.chk(41, "道具\\2\\001<font size=\'+5\' color=\'#" + Css.TITLE + "\'>慢吞吞蜗牛</font><br><br><font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'><b>功能说明</b></font>：<br><br>我爬、我爬、我爬<b>...</b><br><font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'>速度变慢</font>、变慢、变慢<b>...</b>", Global.g_mode > -1);

        }// end function

        override public function item_do() : void
        {
			Sounds.play(Se_wu);
			PopFactory.changeMoveSp(Global.g_move_sp_bak*.8);
//				trace("i1 35:	"+id+"	"+ms,parent.x,parent.y)
//                Vision.add("I001" + id, E1GrowGreen, 0, 0, null, 0.3, ms, 1, false, true,true);
				Bubble.instance.removeBubble(Bubble.TYPE_SCORE);
				Bubble.instance.removeBubble("ComboDash");
				Bubble.instance.show("<b>减速…</b>","SpeedDown",parent.x,parent.y,80,Css.SIZE*1.3,Css.GREEN,true);
//                change_speed(Global.g_sp + 50);
				
//				trace("I1 43:	"+this.parent.parent);
//				MoveTo.add(icon.parent.parent,10,Global.item_do_x,Global.item_do_y,1,1.5);
//                time_id = setTimeout(item_over, ms);
//            else
//            {
//				ObjPool.instance.returnObj(this);
				item_over();
//            }
        }// end functionå
		
		override public function achCount() : void
		{
			DataObj.data[21] ++;
		}// end function
		
    }
}
