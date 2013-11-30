package item
{
	import game.ModeNormal;
	
	import naga.eff.Flash;
	import naga.eff.Shake;
	import naga.global.Css;
	import naga.global.Global;
	import naga.system.Bubble;
	import naga.system.Sounds;
	
	import pop.PopFactory;
	
	import ui.HpBar;

    public class I3Bad extends Item
    {

        public function I3Bad(num:int=0, iconID:int=3 , isItemActive:Boolean=false)
        {
            super(num, iconID, isItemActive);
        }// end function

        override protected function add() : void
        {
        }// end function

        override public function item_do() : void
        {
//			trace("i3 28:	bad  !!!!!!");
			Flash.instance.go(0, false,  "000000");
            Sounds.play(Se_bad);
			Main.mode.combo_over();
			HpBar.changeHP(-1);
            //Chk_first.chk(54, "<p align=\'center\'><font color=\'#" + Css.TITLE + "\' size=\'+10\'>Miss</font></p><br>1 .触摸到<b>\"</b>空白处<b>\"</b><br><br>2 .击中了红泡泡<br><br><b>PS: </b>Miss=<b>Miss</b><br>（是不是其他部位触到屏幕了？）", Global.g_mode > -1);
//            Vision.instance.add("I003" + id, E6FlashBlack,Global.eff_floor, 0, 0, null, 0.5, 500,1,0,false,true,true);
			ModeNormal.overX=parent.x;
			ModeNormal.overY=parent.y;
			Bubble.instance.show("<b>哦！天哪</b>", Bubble.TYPE_BAD, parent.x, parent.y, 180,Css.SIZE,Css.SILVER,true);
            Shake.add(Global.bg, 1500,15);
            PopFactory.changeSpeed(PopFactory.g_sp + 100);
			PopFactory.changeMoveSp(Global.g_move_sp_bak*.9);
			item_over();
        }// end function
		
		override public function achCount() : void
		{
			DataObj.data[23] ++;
		}// end function
		
    }
}
