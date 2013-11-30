package naga.system
{
	import flash.display.Sprite;
	
	import naga.global.Global;
	import naga.system.IPoolable;
	

    public class AlphaPan extends Sprite implements IPoolable
    {
		private var _destroyed:Boolean;
        public function AlphaPan(color:int=0xffffff, alpha:Number=0, width:int=0, height:int= 0)
        {
			var w:int;
			var h:int;
			graphics.beginFill(color);
			if(width==0)
			{
				w = Global.stage_w+20;
				h = Global.stage_h+40;
				graphics.drawRect(-10,-10,w,h);
			}
			else
			{
				w = width;
				h = height;
				graphics.drawRect(0,0,w,h);
			}
			graphics.endFill();
			_destroyed = true;
			renew(alpha);
//			trace("alphaPan 14:	"+height+"	"+Global.game_view_h);
        }// end function

		
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
//			trace("alphaPan 32:	",paramenters);
			this.alpha=paramenters[0];
			_destroyed = false;
			
			/* 创建内容 */
			
		}
		
		public function destroy():void 
		{
			if (_destroyed)
			{
				return;
			}
			if(this.parent.contains(this))
			{
//				trace("alphaPan 51:	",this);
				this.parent.removeChild(this);
			}
			_destroyed = true;
			
			/* 移出场景 */
			
		}
		
		public function dispose():void
		{
			
		}
	}
}