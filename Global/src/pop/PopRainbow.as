package pop
{
	import audio.Music;
	
	import eff.E3FlashRound;
	
	import naga.eff.Vision;
	import naga.global.Global;
	import naga.system.Sounds;

    public class PopRainbow extends Pop
    {
//		private var sc
        public function PopRainbow(id:int=0,movePath:int=0,scores:int=0)
		{
			super(id,movePath);
        }// end function

        override protected function value() : void
        {
			bomb_chk = Math.random()*10+5;
			sp = sp*(.4-bomb_chk*.01);
			speed2=speed2*(.5-score*.01);
			p.popBC.gotoAndStop(5);
			PopFactory.rainbow_pop ++;
            //Chk_first.chk(32, "<p align=\'center\'><font size=\'+5\' color=\'#" + Css.TITLE + "\'>黑色泡泡</font>（分数<b>50</b>）</p><br>点<b>3</b>下，才会破。<br><br>里面包裹着<font color=\'#" + Css.IMPORTANT + "\'>道具</fon>", Global.g_mode > -1);
            score = bomb_chk*5;//每点1次 5分
//			p.addEventListener(Event.ENTER_FRAME,pudding);
//			trace("popRainbow 30:	value over:	"+num,p.width,p.alpha,p.x,p.y);
        }// end function
		
		override protected function bomb_click() : void
        {
            Music.play();
			p.scaleX=p.scaleY=scale;
            if (bomb_chk >3)
            {
				scale=scale*1.1;
				bomb_chk --;
            }
			else if (bomb_chk == 3)
			{
				Sounds.play(Se_over);
				Vision.instance.add("black_pop", E3FlashRound,Global.eff_floor, p.x, p.y,null, 1, 2000,p.scaleX*1.5,0,false,false,true);
				addItemBlack();
//				sca = p.scaleY * .9;
				scale=scale*.8
				bomb_chk = 2;
				p.popBC.gotoAndStop(3);
			}
			else if (bomb_chk == 2)
			{
//				sca = scale * .9;
				scale=scale*.9
				bomb_chk = 1;
				p.popBC.gotoAndStop(1);
			}
			else
			{
				bomb_chk = 0;
			}
			vx=Global.vx*(Math.random()+1);
			vy=Global.vy*(Math.random()+1);
//			p.scaleY = sca;
//			p.scaleX = sca;
        }// end function

		private function addItemBlack():void{
			var rd:int = Math.random()*100;
//			if(rd>60){
//				//60分以上变蓝泡泡
				p.popBC.gotoAndStop(2);
				if(rd<60)
				{
					addItem(9);
				}
				else if(rd<80)
				{
					addItem(5);
				}
				else if(rd<90){
					addItem(1);
				}
				else if(rd<98){
					addItem(10);
				}
				else {
					addItem(12);
				}
//			}
//			else{
//				//60分以下变白泡泡
//				p.pop.gotoAndStop(1);
//				if(rd<10){
//					addItem(7);
//				}
//				else if(rd<15){
//					addItem(6);
//				}
//			}
		}
		
        override protected function achCount() : void
        {
			DataObj.data[13] ++;
        }// end function
		
//		override protected function miss() : void
//		{
////			missed = true;
////			if (p.popBC.currentFrame==2){
////				
////			}
////			else
////			{
//			if (Global.g_mode !=null && Main.mode.game_state==Main.mode.STATE_PLAY)
//			{
//				Main.combo_over();
//				Bubble.instance.show(1, p.x, p.y, "Miss", 60, Css.SIZE*1.5, Css.SILVER);
//			}
//		}// end function

        override protected function whenDel() : void
        {
//			trace("popRainbow 124:	"+num);
//			p.removeEventListener(Event.ENTER_FRAME,pudding);
			PopFactory.rainbow_pop --;
//			if(PopFactory.black_pop<0){
//				PopFactory.black_pop=0;
//			}
        }// end function

    }
}
