package pop
{
	import flash.display.Sprite;
	
	import naga.system.BitmapClip;
	import naga.system.IPoolable;

	public class PicPop extends Sprite implements IPoolable
	{
		public var popBC:BitmapClip;
		public var pic:Sprite=new Sprite();
		public var pic2:Sprite=new Sprite();
		private var _destroyed:Boolean;
		
		public function PicPop()
		{
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
//				trace("picPop 34:	_destroyed:"+_destroyed);
				return;
			}
			
			
//			trace("picPop 37:	Run renew	"+_destroyed+"	"+Math.random());
			
			//			mouseEnabled = false;
//			if(!popBC)
//			{
//				trace("picPop 45:	new popBC !");
				popBC=new BitmapClip(new PopMc(),"Pop");
				popBC.stop();
				pic.graphics.beginFill(0x000000,1);
				pic.graphics.drawCircle(0,0,popBC.width*.5);
				pic.graphics.endFill();
//			}
			pic2.addChild(popBC);
			addChild(pic2);
//			pic.x=50;
//			pic.y=50;
			addChild(pic);
			pic2.mask=pic;
			
			_destroyed = false;
		}
		
		public function destroy():void 
		{
			if (_destroyed)
			{
				return;
			}
			
			_destroyed = true;
			
			pic2.removeChild(popBC);
//			popBC=null;
			removeChildren();
//			pic2.mask=null;
//			pic2=null;
			pic.graphics.clear();
//			pic=null;
		}
		public function dispose():void
		{
			
		}
	}
	
}