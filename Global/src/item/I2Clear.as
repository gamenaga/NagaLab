package item
{
	import flash.events.TimerEvent;
	import flash.system.System;
	import flash.utils.Timer;
	
	import audio.Music;
	
	import eff.E3FlashPoint;
	
	import naga.eff.Vision;
	import naga.global.Global;
	import naga.system.EventManager;
	import naga.system.Sounds;
	
	import pop.Pop;
	import pop.SafeTime;

    public class I2Clear extends Item
    {
        public static var temp_index:int = 0;
        private static var clear_timer:Timer = new Timer(100);
		private static var isClearBad:Boolean;

        public function I2Clear(num:int=0, iconID:int=2,isItemActive:Boolean=false)
        {
            super(num, iconID, isItemActive);
        }// end function

        override protected function add() : void
        {
                //Chk_first.chk(42, "道具\\2\\002<font size=\'+5\' color=\'#" + Css.TITLE + "\'>圣光</font><br><br><font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'><b>功能说明</b></font>：<br><br>神圣的光芒<b>!</b><br><font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'>霸气秒杀</font><br>所有的<b>\"</b>白泡泡<b>\"</b>和<b>\"</b>蓝泡泡<b>\"</b>", Global.g_mode > -1);
            
        }// end function
		
		private static function checkSp():void
		{
			//在消除泡泡之前，要先确保速度的回归
//			trace("i2 40:	"+I4AddPop.bak_speed);
//			if(I4AddPop.iDoing)
//			{
//				I4AddPop.iDoing=false;
////				trace("i2 44:	"+I4AddPop.bak_speed);
//				PopFactory.changeSpeed(I4AddPop.bak_speed);
//			}
		}

        override public function item_do() : void
        {
////            if (!clear_timer.running)
////            {
////			stopClear();
//			isChkCut = true;
//				isClearBad=false;
//				Sounds.play(Se_shu, 2, 0.2);
////                id = Global.g_floor.getChildIndex(this.parent.parent);
////                Vision.add("I002" + id, E6Flash, 0, 0, "ffffff", 0, 0, 1,false,false,true);
//				Vision.add("I002",E3FlashPoint,Global.eff_floor,parent.x,parent.y,null,1,500,3,0,true,true,true);
////                E2_shake.add(Main.bg, 0, 15);
////                temp_index = Global.g_floor.numChildren - 1;
////				checkSp();
//				clear_timer.reset();
//				clear_timer.repeatCount=Global.g_floor.numChildren;
//				temp_index=Global.g_floor.numChildren-1;
////				trace("i2 68:	"+clear_timer.currentCount,"/",clear_timer.repeatCount);
////                clear_timer.addEventListener(TimerEvent.TIMER, itemClear);
//				EventManager.AddEventFn(clear_timer,TimerEvent.TIMER, itemClear);
//                clear_timer.start();
////				clear_timer.addEventListener(TimerEvent.TIMER_COMPLETE, itemClearOver);
////				trace("i2	55:	clear	"+temp_index);
////            }
////            else
////            {
////				removePop();
//////				trace("i2	55:	no clear	"+temp_index);
////            }
//			Vision.remove("i008",Global.eff_floor, true);
			I11O2Time.go();
			item_over();
        }// end function

        private function itemClear() : void
        {
			SafeTime.isSafe = true;
			if(Global.g_floor.numChildren>temp_index && temp_index>=0)
			{
				var temp_p:Pop = Global.g_floor.getChildAt(temp_index) as Pop;
//				trace("i2 84:	"+temp_p,temp_p.toString(),temp_index,temp_p.num,temp_p.is_bomb,"isClearBad:",isClearBad);
				if (!temp_p.is_bomb)
				{
					if(isClearBad==true || temp_p.toString() != "[object PopBlack]")
					{
						temp_p.popClear()
					}
				}
			}
//			else
//			{
//				itemClearOver();
//			}
			temp_index--;
			if(temp_index<0)
			{
				itemClearOver();
			}
//            var temp_p:Pop = null;
//            temp_index = Math.min(temp_index, (Global.g_floor.numChildren - 1));
////			trace("i2	65：	temp_index:"+temp_index+"/"+Global.g_floor.numChildren);
//            if (temp_index >= 0 && Global.g_floor.contains(Global.g_floor.getChildAt(temp_index)))
//            {
//                temp_p = Global.g_floor.getChildAt(temp_index) as Pop;
//                if (temp_p.num != 0 && !temp_p.is_bomb)
//                {
//                    Main.music.play();
//                    temp_p.missed = true;
//                    temp_p.pop_bomb();
//                }
//            }
//            else
//            {
//                Vision.remove("I002" + id);
////                E2_shake.stop();
//                clear_timer.stop();
//                clear_timer.removeEventListener(TimerEvent.TIMER, item_clear);
//                temp_index = 0;
////				trace("i2 88:	"+this.parent+"	"+this.parent.parent);
//				removePop();
//				SafeTime.set(300);
//            }
//            temp_index --;
        }// end function
		
		private function itemClearOver() : void
		{
//			trace("i2 123:  item clear over!!!");
//			doing=false;
//			clear_timer.removeEventListener(TimerEvent.TIMER, itemClear);
			EventManager.delEventFn(clear_timer,TimerEvent.TIMER, itemClear);
//			clear_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, itemClearOver);
//			                Vision.remove("I002" + id);
//			                temp_index = 0;
			//				trace("i2 88:	"+this.parent+"	"+this.parent.parent);
			System.gc();
			SafeTime.setSafe(300);
			item_over();
			
		}
		
//		private function stopClear():void
//		{
//			
//			if(clear_timer.hasEventListener(TimerEvent.TIMER_COMPLETE))
//			{
//				if(doing)
//				{
//					itemClearOver();
//				}
//				else
//				{
//					clearOver();
//				}
//			}
//		}

        public static function go(sp:int = 100) : void
        {
//			if(!clear_timer.running){
			isClearBad=true;
			I8Fog.over();
//				temp_index = Global.g_floor.numChildren - 1;
//				checkSp();
//				clear_timer.repeatCount=clear_timer.currentCount;
				clear_timer.delay = sp;
				clear_timer.reset();
				clear_timer.repeatCount=Global.g_floor.numChildren;
				temp_index=Global.g_floor.numChildren-1;
//				trace("i2 172:	"+temp_index,clear_timer.currentCount,"/",clear_timer.repeatCount);
//				clear_timer.addEventListener(TimerEvent.TIMER, clear);
				EventManager.AddEventFn(clear_timer,TimerEvent.TIMER, clear);
				clear_timer.start();
//			}
        }// end function

        private static function clear() : void
        {
			SafeTime.isSafe = true;
			if(Global.g_floor.numChildren>temp_index && temp_index>=0)
			{
            var temp_p:Pop = Global.g_floor.getChildAt(temp_index) as Pop;
//			trace("i2 150:	"+temp_p+"	count:"+clear_timer.currentCount,1);
//			trace("i2 182:	"+temp_p,temp_p.num,temp_p.is_bomb,temp_index,"/",Global.g_floor.numChildren,clear_timer.currentCount,"/",clear_timer.repeatCount);
//            temp_index = Math.min(temp_index, (Global.g_floor.numChildren - 1));
//            if (temp_index >= 0 && Global.g_floor.contains(Global.g_floor.getChildAt(temp_index)))
//            {
////				trace("i2 124:	"+temp_index);
//                temp_p = Global.g_floor.getChildAt(temp_index) as Pop;
				if (!temp_p.is_bomb)
                {
					temp_p.popClear();
                }
//            }
//            else
//            {
//                clear_timer.stop();
//                clear_timer.removeEventListener(TimerEvent.TIMER, clear);
//                if (Global.stop_onoff == 0 && Global.g_move_sp == 0)
//                {
//                    TimeCount.count_timer.start();
//					PopFactory.timer.start();
//					Global.g_move_sp = Global.g_move_sp_bak;
//                }
//				SafeTime.set(500);
//            }
//            temp_index --;
			}
//			else
//			{
//				clearOver();
//			}
			temp_index--;
			if(temp_index<0)
			{
				clearOver();
			}
        }// end function
		
		public static function clearOver():void
		{
//			trace("i2 191: clear over!!!");
			isClearBad=false;
//			clear_timer.removeEventListener(TimerEvent.TIMER, clear);
			EventManager.delEventFn(clear_timer,TimerEvent.TIMER, clear);
//			clear_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, clearOver);
//			if (Global.stop_onoff == 0 && Global.g_move_sp == 0)
//			{
//				TimeCount.count_timer.start();
//				PopFactory.timer.start();
//				Global.g_move_sp = Global.g_move_sp_bak;
//			}
			System.gc();
			SafeTime.setSafe(500);
			
		}
		
		override public function achCount() : void
		{
			DataObj.data[22] ++;
		}// end function
		
    }
}
