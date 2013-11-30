package pop
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import naga.system.EventManager;

	public class SafeTime
	{
		private static var safe_time:Timer=new Timer(0,1);
		public static var isSafe:Boolean=false;
		 
		//		触摸保护
		public static function setSafe(time:int):void{
//			Main.mode.safePan.visible=true;
			isSafe=true;
			safe_time.stop();
			safe_time.delay=time;
			//			if(!safe_time.running){
			safe_time.start();
			//			}
			//			safe_time.addEventListener(TimerEvent.TIMER,t);
			if(!safe_time.hasEventListener(TimerEvent.TIMER_COMPLETE)){
//				safe_time.addEventListener(TimerEvent.TIMER_COMPLETE,unsafe);
				EventManager.AddEventFn(safe_time,TimerEvent.TIMER_COMPLETE,unSafe);
			}
			//			clearTimeout(safe_time);
			//			safe_time=setTimeout(unsafe,500);
//			trace("safe 12:	safe!!	"+isSafe);
		}
		private static function unSafe():void{
//			safe_time.removeEventListener(TimerEvent.TIMER_COMPLETE,unsafe);
			EventManager.delEventFn(safe_time,TimerEvent.TIMER_COMPLETE,unSafe);
//			Main.mode.safePan.visible=false;
			isSafe=false;
//			trace("safe 27:	safe over!!	"+isSafe);
			//			safe_time.removeEventListener(TimerEvent.TIMER,t);
			//			trace(safe_time.hasEventListener(TimerEvent.TIMER_COMPLETE));
		}
		private static function t():void{
//			trace(safe_time.repeatCount);
		}
	}
	
}