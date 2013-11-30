package ui
{
	
	import naga.system.BitmapClip;
	import naga.system.IPoolable;
	import naga.ui.MyMouse;
	
	public class MouseBC extends MyMouse implements IPoolable
	{
		private var _destroyed:Boolean;
		private var frame:int;
		
		public function MouseBC()
		{
			BC=new BitmapClip(new Mouse_(),"Mouse");
			addChild(BC);
			BC.gotoAndStop(1);
			
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
			
		}
		
		public function destroy():void 
		{
			if (_destroyed)
			{
				return;
			}
			
			_destroyed = true;
			
			/* 移出场景 */
			removeChild(BC);
		}
	}
}