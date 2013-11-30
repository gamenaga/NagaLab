package naga.eff
{
	import flash.display.DisplayObject;
	import flash.events.Event;

	public class Pudding
	{
		private static var spring:Number = 0.1;
		private static var vx:Number = 50;
		private static var vy:Number = 0;
		private static var friction:Number = 0.95;
		private static var gravity:Number = 5;
		
		public function Pudding()
		{
			
		}
		
//		public static function add(name:String,obj:DisplayObject):void
//		{
//			obj.name=name;
//			obj.addEventListener(Event.ENTER_FRAME,pudding);
//		}
		
		private static function pudding(e:Event):void
		{
			var dx:Number = 1 - e.target.scaleX;
			var dy:Number = 1 - e.target.scaleY;
			var ax:Number = dx * spring;//加速度
			var ay:Number = dy * spring;
			vx +=  ax;
			vy +=  ay;
			vx *=  friction;//摩擦力作用
			vy *=  friction;
			vy += gravity;//重力
			e.target.scaleX +=  vx;
			e.target.scaleY +=  vy;
		}
	}
}