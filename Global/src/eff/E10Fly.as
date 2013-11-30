package eff
{
	import flash.display.Sprite;
	
	import naga.global.Global;
	import naga.system.BitmapClip;
	import naga.system.IPoolable;

	public class E10Fly extends Sprite implements IPoolable
	{
		private var _destroyed:Boolean;
		public static var BC:BitmapClip;
		
		public function E10Fly()
		{
				BC=new BitmapClip(new E10Fly_(),"E10Fly");
				BC.stop();
				addChild(BC);
				
				_destroyed = true;
				renew();
				
		}
		
		/* INTERFACE IPoolable */
		
		public function get destroyed():Boolean 
		{
			return _destroyed;
		}
		
		public function renew(...paramenters):void 
		{
			//			trace("e3 33:",BC.currentFrame);
			BC.gotoAndPlay(1,false);
//			addEventListener(Event.ENTER_FRAME,play);
//			EventManager.AddEventFn(this,Event.ENTER_FRAME,play);
			if (!_destroyed)
			{
				return;
			}
			
			_destroyed = false;
			
			/* 创建内容 */
			
		}
		
		public function destroy():void 
		{
			if (_destroyed)
			{
				return;
			}
			if(Global.eff_floor.contains(this))
			{
				Global.eff_floor.removeChild(this);
			}
			_destroyed = true;
			
			/* 移出场景 */
			
		}
		public function dispose():void
		{
			
		}
		
//		private function play():void
//		{
//			//			trace("E3 20:	"+BC.currentFrame+"	"+BC.totalFrame);
//			if(BC.currentFrame==BC.totalFrames)
//			{
////				BC.stop();
////				removeEventListener(Event.ENTER_FRAME,play);
//				EventManager.delEventFn(this,Event.ENTER_FRAME,play);
//			}
//		}
	}
}