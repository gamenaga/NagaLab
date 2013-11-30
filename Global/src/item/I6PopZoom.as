package item
{
	import com.greensock.TweenLite;
	import com.easing.Circ;
	
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import eff.E3FlashRound;
	
	import naga.eff.Vision;
	import naga.global.Css;
	import naga.global.Global;
	import naga.system.Sounds;
	
	import pop.PopFactory;
	
	import ui.UI;

    public class I6PopZoom extends Item
    {
        private static var iDoing:Boolean = false;
		private var bigSmall:PicEffBigSmall=new PicEffBigSmall();

        public function I6PopZoom(num:int=0, iconID:int=6,isItemActive:Boolean=false,time:int=8000)
        {
            super(num, iconID, isItemActive, time);
        }// end function

        override protected function add() : void
        {
                //Chk_first.chk(45, "干扰道具\\2\\006<font size=\'+5\' color=\'#" + Css.TITLE + "\'>魔力盒</font><br><br><font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'><b>功能说明</b></font>：<br><br>充满魔力的盒子！<br>让泡泡<font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'>变大变小</font>！", Global.g_mode > -1);
            
        }// end function

        override public function item_do() : void
        {
            if (!iDoing)
            {
				iDoing = true;
                Sounds.play(Se_dige, 8);
//				trace("i6 44:	"+parent+"	"+parent.width+"	"+parent.parent,parent.width*.5+"	"+icon.width+"	"+bigSmall.width);
				bigSmall.x=icon.width*.5
				icon.addChild(bigSmall);
				bigSmall.BC.play();
//				bigSmall.y=-bigSmall.height*.5;
//				MoveTo.add(icon.parent.parent,10,UI.item_do_x,UI.item_do_y,1,1.5);
				TweenLite.to(icon.parent.parent, .6, {x:UI.item_do_x, y:UI.item_do_y, ease:Circ.easeInOut});
//                icon.scaleY = 1.5;
//                icon.scaleX = 1.5;
//                icon.x = icon.x - icon.width * 0.125;
//                icon.y = icon.y - icon.height * 0.2;
//                addEventListener(Event.ENTER_FRAME, this.run1);
                time_id = setTimeout(run1_over, 3000);
            }
            else
			{
				item_over();
            }
        }// end function

        private function run1_over() : void
        {
            time_id = setTimeout(run2_over, 1000);
        }// end function

        private function run2_over() : void
        {
			//摇奖结束
			var rand:int=Math.random()*10;
//			trace("I6 87:	"+rand);
			if (rand>5)
			{
				bigSmall.BC.gotoAndStop(3);
				PopFactory.sca_eff = Math.random() * 0.2 + 1.3;
			}
			else{
				bigSmall.BC.gotoAndStop(1);
				PopFactory.sca_eff = .8- Math.random() * 0.1;
			}
			Vision.instance.add("i006" + id, E3FlashRound,Global.eff_floor, this.parent.x, this.parent.y, Css.YELL_D, .8, 1000,2,0,false,false,true);
            time_id = setTimeout(i6_over, ms);
        }// end function
		
		private function i6_over() : void
		{
			iDoing = false;
			icon.removeChild(bigSmall);
			PopFactory.sca_eff = 1;
			item_over();
		}// end function
		
		override public function achCount() : void
		{
			DataObj.data[26] ++;
		}// end function
		
    }
}
