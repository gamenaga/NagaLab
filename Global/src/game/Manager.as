package game
{
	import flash.utils.setTimeout;
	
	import naga.global.Global;
	
	import pop.PopFactory;

	public class Manager
	{
		public function Manager()
		{
		}
		
		public static function gameStop(canClick:Boolean = false):void
		{
			PopFactory.timer.stop();
			MyHeart.doPause();
			Global.g_move_sp = 0;
			if(!canClick)
			{
				Main.popControl.deActivateClick();
			}
		}
		
		public static function gameContine():void
		{
			PopFactory.timer.start();
			if(Main.mode.game_state == Main.mode.STATE_PLAY)
			{
				MyHeart.doRun();
			}
			Global.g_move_sp = Global.g_move_sp_bak;
			setTimeout(Main.popControl.activateClick,100);
		}
	}
}