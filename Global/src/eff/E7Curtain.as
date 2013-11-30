package eff
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import naga.system.BitmapClip;
	import naga.system.EventManager;
	import naga.system.IPoolable;

	public class E7Curtain extends Sprite implements IPoolable
	{
		private var _destroyed:Boolean;
		public var BC:BitmapClip;
		
		public function E7Curtain()
		{
				BC=new BitmapClip(new E7Curtain_(),"E7Curtain");
//				addEventListener(Event.ENTER_FRAME,play);
				EventManager.AddEventFn(this,Event.ENTER_FRAME,play);
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
		
		private function play():void
		{
			if(BC.currentFrame==BC.totalFrames)
			{
				BC.stop();
//				removeEventListener(Event.ENTER_FRAME,play);
				EventManager.delEventFn(this,Event.ENTER_FRAME,play);
			}
		}
	}
}