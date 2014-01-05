package eff
{
	import flash.display.Sprite;
	
	import naga.system.BitmapClip;
	import naga.system.IPoolable;
	import naga.global.Global;

	public class E2Bomb extends Sprite implements IPoolable
	{
		public var BC:BitmapClip;
		private var _destroyed:Boolean;
		
		public function E2Bomb()
		{
//			trace("e2 16:",BC);
			/* 创建内容 */
				BC=new BitmapClip(new E2Bomb_(),"E2Bomb");
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
//			trace("e2 34:",BC.currentFrame);
			BC.gotoAndPlay(1,false);
//			EventManager.AddEventFn(this,Event.ENTER_FRAME,play);
			
			if (!_destroyed)
			{
				return;
			}
			
//			BC.cacheAsBitmap =true;
//			this.cacheAsBitmap =true;
			
			
			_destroyed = false;
			
		}
		
		public function destroy():void 
		{
			if (_destroyed)
			{
				return;
			}
			if(Global.eff_floor.contains(this))
			{
				BC.stop();
				Global.eff_floor.removeChild(this);
//				trace("e2 60");
			}
			_destroyed = true;
			
			/* 移出场景 */
//			removeChild(BC);
		}
		
		public function dispose():void
		{
			
		}
//		private function play():void
//		{
//						trace("E2 20:	"+BC.currentFrame+"	"+BC.totalFrames);
//			if(BC.currentFrame==BC.totalFrames)
//			{
////				BC.stop();
////				removeEventListener(Event.ENTER_FRAME,play);
//				EventManager.delEventFn(this,Event.ENTER_FRAME,play);
//			}
//		}
	}
}