package eff
{
	import flash.display.Sprite;
	
	import naga.system.BitmapClip;
	import naga.system.IPoolable;
	import naga.global.Global;

	public class E3FlashRound extends Sprite implements IPoolable
	{
		private var _destroyed:Boolean;
		public var BC:BitmapClip;
		
		public function E3FlashRound()
		{
				BC=new BitmapClip(new E3FlashRound_(),"E3FlRound");
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
			BC.gotoAndPlay(1,false);
//			addEventListener(Event.ENTER_FRAME,play);
//			EventManager.AddEventFn(this,Event.ENTER_FRAME,play);
			if (!_destroyed)
			{
				return;
			}
//			BC.cacheAsBitmap =true;
//			this.cacheAsBitmap =true;
			
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
				BC.stop();
				Global.eff_floor.removeChild(this);
			}
			_destroyed = true;
			
			/* 移出场景 */
			
		}
		public function dispose():void
		{
			
		}
	}
}