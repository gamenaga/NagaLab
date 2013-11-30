package ui
{
	import naga.system.BitmapClip;
	import naga.system.IPoolable;
	import naga.ui.PicIcons;
	
	public class Icons extends PicIcons implements IPoolable
	{
		private var _destroyed:Boolean;
		
		public function Icons(itemID:int=1)
		{
			frame=itemID;
			mouseChildren=false;
			mouseEnabled=false;
			BC=new BitmapClip(new Icons_(),"Icons");
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
//			trace(BC);
//			if(!BC)
//			{
//			mouseChildren=false;
//			mouseEnabled=false;
//			BC=new BitmapClip(new Icons_(),"Icons");
//			}
//			trace(BC,BC.width);		//null 0
			BC.gotoAndStop(frame);
			
//			BC.cacheAsBitmap =true;
//			this.cacheAsBitmap =true;
			addChild(BC);
			
		}
		
		public function destroy():void 
		{
			if (_destroyed)
			{
				return;
			}
			
			_destroyed = true;
			
			/* 移出场景 */
			if(parent)
			{
				parent.removeChild(this);
			}
		}
		
		public function dispose():void
		{
//			BC.dispose();
			//			trace(BC);
			BC = null;
			if(parent)
			{
				parent.removeChild(this);
			}
		}
		
	}
}