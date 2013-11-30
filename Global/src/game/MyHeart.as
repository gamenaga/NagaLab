package game
{
	import flash.events.Event;
	import flash.system.System;
	import flash.utils.setTimeout;
	
	import naga.global.Global;
	import naga.system.EventManager;
	

    public class MyHeart
    {
        public static var running:Boolean = false;
		public static var second:int = 0;
		private static var fps:int=30;
		
		public static function init(FPS:int) : void
		{
			fps = FPS;
//			trace("myHeart 18:	",fps);
		}// end function
		
        public static function go() : void
        {
//			trace("heart 24:	"+second+"	"+seconds+"	");
            second = 0;
			doRun();
        }// end function

        private static function run() : void
        {
//			trace("heart 31:	"+second+"	"+seconds+"	");
            second ++;
			//100秒模式  倒计时
//            if (second >= Main.mode.time - 5 && second < Main.mode.time)
//            {
//				Sounds.play(Se_dida);
//                Bubble.instance.show(Bubble.TYPE_OTHER, Global.game_view_w*.5, Global.game_view_h*.5, "<b>" + (Main.mode.time - second) + "</b>", 200, Css.SIZE*4, Css.YELL_D);
//            }
//			if (second % (2*fps) == 0 && Mode.g_mode !=null)
//			{
//				//				trace("myHeart 39:	",second,fps,Mode.g_mode);
//				//				Tools.testPressure();
//				//				System.gc();
//				//实时存档
//				DataObj.saveData(false);
//				//Chk_first.chk(51, "<p align=\'center\'><font size=\'+5\' color=\'#" + Css.TITLE + "\'>连击</font></p><br>连续的击中泡泡<br><br>连击越高，分数越高、氧气获得越多<br><br>泡泡达人的必修课！<br><br>PS:一旦<font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'>Miss</font>了、<font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'>跑</font>了，则需从头再来。", Main.game_combo >= 14);
//				//Chk_first.chk(52, "<p align=\'center\'><font size=\'+5\' color=\'#" + Css.TITLE + "\'>泡泡<b>\"</b>重叠<b>\"</b></font></p><br>当有<font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'>泡泡层叠</font>在一起时，不要慌乱。<br>仔细看，能分辨出<font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'>最上层</font>的泡泡<br>出手前<b>…</b><br>请睁大美丽的双眼哦<b>!</b>", Global.g_floor.numChildren > Main.pop_num_max);
//				//Chk_first.chk(53, "<p align=\'center\'><font size=\'+5\' color=\'#" + Css.TITLE + "\'>升级</font><b>!</b></p><br><b>\"</b>连击<b>\"</b>达到一定数量时，便会升级<br><br>共有<font color=\'#" + Css.ORAN_D + "\' size=\'+2\'>5个连击等级</font>，<br><br>等级越<font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'>高</font>，速度越<font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'>快</font>，分数加成越<font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'>高</font>。<br><br>当，进入最高等级<b>\"</b>疯狂级<b>\"</b><br><br>将不再降级，<font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'>永久</font>的保持<font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'>高速</font>状态。<br><br>向<font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'>终极泡泡达人</font>迈进吧<b>!</b>", Main.game_combo_level > 0);
//			}
        }// end function

        public static function stop(): void
        {
			doPause();
			DataObj.data[6] = DataObj.data[6] + MyHeart.seconds;
			if (DataObj.data[3] < seconds)
			{
				DataObj.data[3] = seconds;
			}
            second = 0;
			setTimeout(gc,1000);
        }// end function
		
		public static function doPause(): void
		{
			EventManager.delEventFn(Global.gameStage,Event.ENTER_FRAME,run);
			running	=	false;
//			trace("myHeart 63:	",seconds);
		}// end function
		
		public static function doRun(): void
		{
//			trace(Main.mode);
			if(!running && Global.g_mode != null)
			{
				running	=	true;
//				Global.gameStage.addEventListener(Event.ENTER_FRAME, run);
				EventManager.AddEventFn(Global.gameStage,Event.ENTER_FRAME,run);
			}
		}// end function

		public static function get seconds():int
		{
			return second/fps;
		}
		
		private static function gc():void
		{
			System.gc();
		}
		
    }
}
