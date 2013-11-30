package eff
{
	import flash.display.Sprite;
	
	import naga.global.Global;
	import naga.system.BitmapClip;
	import naga.system.IPoolable;

	public class E1Grow extends Sprite implements IPoolable
	{
		private var _destroyed:Boolean;
		public var BC:BitmapClip;
		
		public function E1Grow()
		{
				BC=new BitmapClip(new E1Grow_(),"E1Grow");
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
			if (!_destroyed)
			{
				return;
			}
			BC.visible=true;
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
				Global.eff_floor.removeChild(this);
			}
			_destroyed = true;
			
			/* 移出场景 */
			
		}
	}
}