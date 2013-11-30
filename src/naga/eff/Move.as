package naga.eff
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import naga.system.EventManager;

	public class Move
	{
		private static var obj_:DisplayObject;
		private static var move_x:Number;//x每帧移动量
		private static var move_y:Number;//y
//		private static var frame:int;//几帧完成移动
		private static var sca:Number;//每帧缩放的比例
		private static var sca_e:Number;//结束时的比例
		private static var moveTimer:Timer=new Timer(100);
		public static function add(obj:DisplayObject,frame:int,x:Number,y:Number,sca_begin:Number,sca_end:Number):void
		{
//			frame=frame;
			obj_=obj;
			moveTimer.repeatCount=frame;
//			trace("move 19     :    "+moveTimer.currentCount);
			move_x=(x)/frame;
			move_y=(y)/frame;
			sca=(sca_end-sca_begin)/frame;
			sca_e=sca_end;
			obj_.scaleX=sca_begin;
			obj_.scaleY=sca_begin;
//			moveTimer.addEventListener(TimerEvent.TIMER,moveTo);
//			moveTimer.addEventListener(TimerEvent.TIMER_COMPLETE,moveEnd);
			EventManager.AddEventFn(moveTimer,TimerEvent.TIMER,moveTo);
			EventManager.AddEventFn(moveTimer,TimerEvent.TIMER_COMPLETE,moveEnd);
			moveTimer.start();
//			obj.addEventListener(Event.ENTER_FRAME,moveTo);
		}
		private static function moveTo():void{
			obj_.x+=move_x;
			obj_.y+=move_y;
			obj_.scaleX+=sca;
			obj_.scaleY+=sca;
//			if(e.target.scaleX=sca_e){}
		}
		private static function moveEnd():void{
			
//			moveTimer.removeEventListener(TimerEvent.TIMER,moveTo);
//			moveTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,moveEnd);
			EventManager.delEventFn(moveTimer,TimerEvent.TIMER,moveTo);
			EventManager.delEventFn(moveTimer,TimerEvent.TIMER_COMPLETE,moveEnd);
		}
	}
}