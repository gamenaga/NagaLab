package pop
{
	import flash.utils.Timer;
	
	import eff.E2BombBlack;
	
	import naga.eff.Vision;
	import naga.global.Global;

    public class PopBlack extends Pop
    {

        public function PopBlack(id:int=-1,movePath:int=0,warnMC:Class=null,warnTime:int=2000)
        {
            super(id,movePath,warnMC,warnTime);
        }// end function
		
        override protected function value() : void
        {
			if(warnTimer==null)
			{
				warnTimer=new Timer(0,1);
			}
			p.popBC.gotoAndStop(4);
			PopFactory.bad_pop ++;
//			trace("pop_red	26:	"+score);
            //Chk_first.chk(33, "<p align=\'center\'><font size=\'+5\' color=\'#" + Css.RED + "\'>红色泡泡</font>（分数<b>-100</b>）</p><br>千万不要碰哦！<br><br>会扣分<b>!</b> 会中断连击<b>!</b><br><br>各种不给力<b>...</b>", Global.g_mode > -1);
            score = POP_RED;
//			missed=true;
            addItem(3);
//			p.addEventListener(Event.ENTER_FRAME,pudding);
        }// end function

        override protected function bomb_click() : void
        {
            bomb_chk = 0;
        }// end function

//        override public function pop_bomb() : void
//        {
//			Vision.add("bombBlack" + Math.random(), E2BombBlack,Global.eff_floor, p.x, p.y,null, .5, 200,scale,0,false,false,true);
//            if (!missed)
//            {
//                //Chk_first.chk(54, "<p align=\'center\'><font color=\'#" + Css.TITLE + "\' size=\'+10\'>Miss</font></p><br>1 .触摸到<b>\"</b>空白处<b>\"</b><br><br>2 .击中了红泡泡<br><br><b>PS: </b>Miss=<b>Miss</b><br>（是不是其他部位触到屏幕了？）", Global.g_mode > -1);
////                p.removeEventListener(Event.ENTER_FRAME, this["move_" + path]);
//				EventManager.delEventFn(p,Event.ENTER_FRAME, this["move_" + path]);
//				if(Global.m_p.getValue("score")+score>0){
//					Global.m_p.getValue("score") = Global.m_p.getValue("score") + score;
//				}
//				else{
//					Global.m_p.getValue("score")=0;
//				}
////				MttScore.score = Global.m_p.getValue("score");
//				p.pic2.visible=false;
//				items.item_do();
//            }
//			else
//			{
//				ObjPool.instance.returnObj(this);
//			}
//        }// end function
		
		
		protected override function popBombEff():void
		{
			Vision.instance.add("bomb" + num, E2BombBlack,Global.eff_floor, p.x, p.y, null, 1, 500, scale,0,false,false,true);
		}
		
		override protected function achCount() : void
		{
			DataObj.data[14] ++;
		}// end function

        override protected function whenDel() : void
        {
//			trace("popBlack 71 :	del black");
			PopFactory.bad_pop --;
//			if(PopFactory.red_pop<0){
//				PopFactory.red_pop=0;
//			}
        }// end function
		
		override protected function miss() : void
		{
			missed = true;
		}// end function
    }
}
