package pop
{
	
	import audio.Music;
	
	import eff.E6Flash;
	
	import naga.eff.Vision;
	import naga.global.Global;
	
	import ui.O2Bar;

    public class PopWhite extends Pop
    {
		private var hasItem:Boolean;
        public function PopWhite(id:int=0,movePath:int=0)
        {
			super(id,movePath);
		}

        override protected function value() : void
        {
			hasItem=false;
			PopFactory.white_pop ++;
			p.popBC.gotoAndStop(1);
			addItemWhite();
//            if (PopFactory.white_item < 1)//当全场 道具白泡泡 数量<1
//            {
//				var rd:Number;
//                rd = Math.random();
                
                if (items != null)
                {
					hasItem=true;
					PopFactory.white_item ++;
                }
//            }
            //Chk_first.chk(31, "<p align=\'center\'><font size=\'+5\' color=\'#" + Css.TITLE + "\'>白色泡泡</font>（分数<b>10</b>）</p><br>点<b>1</b>下，就会破！<br><br>最最普通的一种泡泡<br><br><font color=\'#" + Css.IMPORTANT + "\'>不可以</font>跑出屏幕哦", Global.g_mode > -1);
            score = POP_WHITE;
//			p.addEventListener(Event.ENTER_FRAME,pudding);
//            color = null;
//			trace("popWrite 37:	value over:"+p.width,p.alpha,p.x,p.y);
        }// end function
		
		private function addItemWhite():void{
			//测试道具
//			addItem(8);
//			/*
			var rd:Number= Math.random();
			if (PopFactory.popID > 300)
			{
				if (rd > 0.97)
				{
					addItem(4);
				}
				else if (rd > 0.95)
				{
					addItem(6);
				}
				else if (rd > 0.92)
				{
					addItem(7);
				}
				else if (rd > 0.91)
				{
					addItem(8);
				}
			}
			else if (PopFactory.popID < 100)
			{
				if (rd > 0.99)
				{
					addItem(4);
				}
			}
			else if (PopFactory.popID < 200)
			{
				if (rd > 0.98)
				{
					addItem(4);
				}
				else if (rd > 0.96)
				{
					addItem(6);
				}
			}
			else //Main.popID<300
			{
				if (rd > 0.97)
				{
					addItem(4);
				}
				else if (rd > 0.95)
				{
					addItem(6);
				}
				else if (rd > 0.93)
				{
					addItem(7);
				}
			}
//			*/
		}//endfunc
		
		override protected function bomb_click() : void
        {
            Music.play();
            bomb_chk = 0;
			O2Bar.changeO2(10);
        }// end function
//
//        override protected function miss() : void
//        {
//			missed = true;
//            if (Global.g_mode !=null && Main.mode.game_state==Main.mode.STATE_PLAY)
//            {
//                //Chk_first.chk(55, "<p align=\'center\'><font color=\'#" + Css.TITLE + "\' size=\'+10\'>跑了</font></p><br><b>\"</b>白色泡泡<b>\"</b>逃跑了！<br><br>和<b>\"</b>Miss<b>\"</b>一样，会中断连击。", Global.g_mode == 1);
//                Main.combo_over(false);
//                Bubble.instance.show(1, p.x, p.y, "Miss", 60, Css.SIZE*1.5, Css.SILVER);
//            }
//        }// end function

        override protected function achCount() : void
        {
			DataObj.data[11] ++;
        }// end function

        override protected function whenDel() : void
        {
			PopFactory.white_pop --;
//			p.removeEventListener(Event.ENTER_FRAME,pudding);
			if(hasItem){
				PopFactory.white_item --;
			}
        }// end function

    }
}
