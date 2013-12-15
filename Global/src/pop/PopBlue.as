package pop
{
	import audio.Music;
	
	import naga.global.Global;
	

    public class PopBlue extends Pop
    {

        public function PopBlue(id:int=0,movePath:int=0)
		{
			super(id,movePath);
        }// end function

        override protected function value() : void
        {
			sp = sp*.4;
			speed2=speed2*.4;
			p.popBC.gotoAndStop(2);
//			trace("popBlue 21:	"+p.popBC.currentFrame+"	"+p.visible+"	"+p.visible);
			PopFactory.blue_pop ++;
            //Chk_first.chk(32, "<p align=\'center\'><font size=\'+5\' color=\'#" + Css.TITLE + "\'>蓝色泡泡</font>（分数<b>50</b>）</p><br>点<b>3</b>下，才会破。<br><br>里面包裹着<font color=\'#" + Css.IMPORTANT + "\'>道具</fon>", Global.g_mode > -1);
            score = POP_BLUE;
            bomb_chk = 3;
			addItemBlue();
//			scale=scale*.9;
//			vx=Global.vx*2;
//			vy=Global.vy*2;
//			p.addEventListener(Event.ENTER_FRAME,pudding);
        }// end function
		
		
		private function addItemBlue():void{
			//测试道具
						addItem(2);
						/*
			var rd:int = Math.random() * 100;
			if (rd < 45)
			{
				addItem(5);
			}
			else if (rd < 80)
			{
				addItem(1);
			}
			else if (rd < 95)
			{
				addItem(2);
			}
			else
			{
				addItem(10);
			}
			//			*/
		}//endfunc
		
		override protected function bomb_click() : void
        {
            Music.play();
//            var sca:Number = scale * .91;
			p.scaleX=p.scaleY=scale;
			scale=scale*.9;
            vx=Global.vx*(Math.random()+1);
			vy=Global.vy*(Math.random()+1);
            if (bomb_chk == 3)
            {
                bomb_chk = 2;
				p.popBC.gotoAndStop(3);
            }
            else if (bomb_chk == 2)
            {
                bomb_chk = 1;
				p.popBC.gotoAndStop(1);
            }
            else
            {
                bomb_chk = 0;
            }
//			trace("popBlue 60	:	"+bomb_chk+"	currentFrame:"+p.popBC.currentFrame);
        }// end function

        override protected function achCount() : void
        {
			DataObj.data[12] ++;
        }// end function

        override protected function whenDel() : void
        {
//			p.removeEventListener(Event.ENTER_FRAME,pudding);
			PopFactory.blue_pop --;
//			if(PopFactory.blue_pop<0){
//				PopFactory.blue_pop=0;
//			}
        }// end function

    }
}
