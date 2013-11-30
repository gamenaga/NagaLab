package item
{
    import flash.display.Sprite;
    import flash.utils.clearTimeout;
    
    import naga.eff.InOut;
    import naga.system.IPoolable;
    import naga.system.ObjPool;
    
    import ui.Icons;

    public class Item extends Sprite implements IPoolable
    {
		public var icon:Icons;
		/**道具是否启动，用与打断道具的判定		 */
        public var isChkCut:Boolean = false;
        protected var id:int;
		/**计时器ID  中断时，需要中断计时器，使道具失效		 */
        protected var time_id:int;
        protected var ms:int;//延续时间
		/**是否作为 道具栏中的 主动触发道具		 */
		public var isItemActive:Boolean;//
		private var _destroyed:Boolean;

        public function Item(num:int=0, iconID:int=0, isItemActive:Boolean=false, time:int=3000)
        {
			_destroyed = true;
			renew(num,iconID,isItemActive,time);
			
		}
		
		//获得
		protected function add() : void
		{
		}// end function
		
		//成就累计
		public function achCount() : void
		{
		}// end function
		
		//道具触发
        public function item_do() : void
        {
        }// end function

		//道具效果
        protected function item_buff() : void
        {
        }// end function

		//中断，通常时被其他事件打断
        public function itemCut() : void
        {
            if (isChkCut)
            {
				clearTimeout(time_id);
				item_over();
            }
        }// end function

		//清除道具的母体泡泡
        protected function removePop() : void
        {
			//			trace("item 70:		"+this.parent.parent);
			if(parent.parent){
				InOut.fadeOut(parent.parent, .1,0,1,true);
			}
        }// end function
		
		//道具结束时的处理 
		protected final function item_over():void
		{
			isChkCut = false;
			removePop();
//			ObjPool.instance.returnObj(this);
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
				//				trace("item 90:	"+this+"	"+icon.numChildren);
				//				if(icon.numChildren>1) icon.removeChildren(1);
				return;
			}
//			trace("item 88:	"+this+"	"+paramenters+"	"+paramenters[0]);
			id = paramenters[0];
			isItemActive=paramenters[2];
			ms = paramenters[3];
			
			/* 创建内容 */
			mouseChildren = false;
			mouseEnabled = false;
			
			icon = ObjPool.instance.getObj(Icons) as Icons;
			icon.BC.gotoAndStop(paramenters[1]);
			addChild(icon);
			
			_destroyed = false;
		}
		
		public function destroy():void 
		{
			
			if (_destroyed)
			{
				return;
			}
			
			/* 移出场景 */
			ObjPool.instance.returnObj(icon);
			parent.removeChild(this);
			_destroyed = true;
			
		}
		
		
		public function dispose():void
		{
		}
		
//		public function del():void
//		{
//			ObjPool.instance.returnObj(icon);
//			parent.removeChild(this);
//		}
    }
}
