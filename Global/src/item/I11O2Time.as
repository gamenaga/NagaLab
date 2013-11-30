package item
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import naga.system.EventManager;
	
	import pop.PopFactory;
	import pop.SafeTime;
	
	import ui.O2Bar;

    public class I11O2Time extends Item
    {
		public static var iDoing:Boolean = false;
		private static var timer:Timer = new Timer(50);

        public function I11O2Time(num:int=0, iconID:int=2,isItemActive:Boolean=false)
        {
            super(num, iconID, isItemActive);
        }// end function

        override protected function add() : void
        {
                //Chk_first.chk(41, "道具\\2\\001<font size=\'+5\' color=\'#" + Css.TITLE + "\'>慢吞吞蜗牛</font><br><br><font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'><b>功能说明</b></font>：<br><br>我爬、我爬、我爬<b>...</b><br><font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'>速度变慢</font>、变慢、变慢<b>...</b>", Global.g_mode > -1);

        }// end function

        override public function item_do() : void
        {
        }// end function
		
		public static function go() : void
		{
//							trace("i11 29:	go");
			if(!iDoing)// && !I4AddPop.iDoing)
			{
				iDoing = true;
				O2Bar.changeO2BarRed();
				PopFactory.state = 2;//改变泡泡工厂状态为 欢乐时光状态，泡泡数量无上限
				I2Clear.go();
				I4AddPop.go(20000,9);
//				UI.initO2Bar();
				timer.reset();
				EventManager.AddEventFn(timer,TimerEvent.TIMER,clear);
				timer.start();
			}
		}// end function
		
		private static function clear():void
		{
			SafeTime.isSafe = true;
			O2Bar.changeO2(-10);
//			I2Clear.go();
		}
		
		public static function clearOver():void
		{
			iDoing = false;
			SafeTime.isSafe = false;
			PopFactory.state = 0;
			if(timer.hasEventListener(TimerEvent.TIMER))
			{
				EventManager.delEventFn(timer,TimerEvent.TIMER,clear);
			}
		}
		
		override public function achCount() : void
		{
			DataObj.data[31] ++;
		}// end function
		
    }
}
