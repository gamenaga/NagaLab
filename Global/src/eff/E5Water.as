package eff
{
	import flash.display.Sprite;
	
	import naga.system.BitmapClip;
	import naga.system.IPoolable;
	import naga.global.Global;

	public class E5Water extends Sprite implements IPoolable
	{
		private var _destroyed:Boolean;
		public var BC:BitmapClip;
		
		public function E5Water()
		{
				BC=new BitmapClip(new E4Water_(),"E4Water");
				BC.gotoAndStop(int(Math.random()*3.9+1));
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