package naga.eff
{
	import flash.system.System;
	
	import naga.global.Global;

    public class GameStop
    {
		private static var gameStopFunc:Function;
		private static var gameRunFunc:Function;
		
		public static function init(gameStopFunction:Function , gameRunFunction:Function):void
		{
			gameStopFunc = gameStopFunction;
			gameRunFunc = gameRunFunction;
		}

        public static function stop(canClick:Boolean = false) : void
        {
			Global.stop_onoff++;
			gameStopFunc.call(null,canClick);
//				PopFactory.timer.stop();
////                TimeCount.count_timer.stop();
//				MyHeart.doPause();
//				Global.g_move_sp = 0;
        }// end function

        public static function run() : void
        {
			System.gc();
			Global.stop_onoff--;
			Global.stop_onoff = Math.max(0, Global.stop_onoff);
            if (Global.stop_onoff == 0)
            {
				gameRunFunc.call();
//				PopFactory.timer.start();
////                TimeCount.count_timer.start();
//				if(Mode.game_state == Mode.STATE_PLAY)
//				{
//					MyHeart.doRun();
//				}
//                Glo.g_move_sp = Glo.g_move_sp_bak;
            }
        }// end function

    }
}
