package naga.eff
{
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.utils.Dictionary;
    
    import naga.system.EventManager;
    import naga.system.IPoolable;
    import naga.system.ObjPool;
    

    public class InOut
    {
//		private static var scopeIn:Number;
//		private static var maxIn:Number;
//		private static var scopeInHalf:Number;
//		private static var maxInHalf:Number;
//		private static var scopeOut:Number;
//		private static var minOut:Number;
//		private static var maxOut:Number;
//		private static var pool:Boolean;
//        private static var del:Boolean;
		
		private static var list:Object={};

		
		private static function chkEvent(obj:DisplayObject):void
		{
			if( list[obj.name] != null)
			{
				EventManager.delAllEvent(obj);
				list[obj.name] = null;
			}
		}
		/**
		 * 透明淡入
		 * min 默认-1：表示以对象本身alpha为 淡入起始
		 */
		public static function fadeIn(obj:DisplayObject, scope:Number = 0.1, min:Number = -1, max:Number=1):void
		{
			chkEvent(obj);
			var key:String = obj.name;
			list[key] = {};
			list[key].obj = obj;
			list[key].scopeIn = scope;
			list[key].maxIn = max;
			if(min!=-1)
			{
				obj.alpha = min;
			}
//			obj.addEventListener(Event.ENTER_FRAME, alphaIn);
			EventManager.AddEventFn(obj,Event.ENTER_FRAME, alphaIn,[key],true);
		}
//		public static function fadeInHalf(obj:DisplayObject, scope:Number = 0.05, min:Number=-1, max:Number=.5):void
//		{
//			chkEvent(obj);
//			var key:String = obj.name;
//			list[key] = {};
//			list[key].obj = obj;
//			list[key].scopeInHalf = scope;
//			list[key].maxInHalf = max;
//			if(min!=-1)
//			{
//				obj.alpha = min;
//			}
////			obj.addEventListener(Event.ENTER_FRAME, alphaInHalf);
//			EventManager.AddEventFn(obj,Event.ENTER_FRAME, alphaInHalf,[key],true);
//		}
		
		/**
		 * 透明淡出
		 * max 默认-1：表示以对象本身alpha为 淡出起始
		 */
		public static function fadeOut(obj:DisplayObject, scope:Number = 0.1, min:Number = 0, max:Number=1, is_pool:Boolean=false):void
		{
			chkEvent(obj);
			var key:String = obj.name;
			list[key] = {};
			list[key].obj = obj;
			list[key].scopeOut = scope;
			list[key].minOut = min;
//			list[key].pool=is_pool;
			if(max!=-1)
			{
//				list[key].maxOut = max;
				obj.alpha = max;
			}
			if(is_pool)
			{
				EventManager.AddEventFn(obj,Event.ENTER_FRAME, alphaOut2Pool,[key],true);
			}
			else
			{
				EventManager.AddEventFn(obj,Event.ENTER_FRAME, alphaOut,[key],true);
			}
		}

		
		//执行 淡入淡出
		
//		淡入
        private static function alphaIn(event:Event, key:String) : void
        {
            if (event.target.alpha >= list[key].maxIn)
            {
//				dispose(key);
				EventManager.delEventFn(event.target as EventDispatcher,Event.ENTER_FRAME, alphaIn);
				list[key] = null;
            }
			else{
				//			trace("inOut 111:	"+event.target.alpha+"	"+scopeIn);
				event.target.alpha = event.target.alpha + list[key].scopeIn;
			}
        }// end function
//		private static function alphaInHalf(event:Event, key:String) : void
//		{
//			if (event.target.alpha >= list[key].maxInHalf)
//			{
////				dispose(key);
//				EventManager.delEventFn(event.target as EventDispatcher,Event.ENTER_FRAME, alphaInHalf);
//				list[key] = null;
//			}
//			else{
//				//						trace("inOut 111:	"+event.target.alpha+"	"+scopeInHalf);
//				event.target.alpha = event.target.alpha + list[key].scopeInHalf;
//			}
//		}// end function

//		半透淡出
        private static function alphaOut(event:Event, key:String) : void
        {
            if (event.target.alpha <= list[key].minOut)
            {
//				dispose(key);
				EventManager.delEventFn(event.target as EventDispatcher,Event.ENTER_FRAME, alphaOut);
				if(event.target.parent != null)
				{
//					event.target.parent.removeChild(event.target);
					Vision.instance.del(event.target as Object);
				}
				list[key] = null;
            }
			else{
				event.target.alpha = event.target.alpha - list[key].scopeOut;
			}
        }// end function
		private static function alphaOut2Pool(event:Event, key:String) : void
		{
//			trace(191,event.target.alpha);
			if (event.target.alpha <= list[key].minOut)
			{
//				dispose(key);
				EventManager.delEventFn(event.target as EventDispatcher,Event.ENTER_FRAME, alphaOut2Pool);
				if (event.target != null)
				{
					ObjPool.instance.returnObj(event.target as IPoolable);
				}
				list[key] = null;
			}
			else{
				event.target.alpha = event.target.alpha - list[key].scopeOut;
			}
		}// end function

//		private static function dispose(key: String):void
//		{
//			EventManager.delAllEvent(list[key].obj);
//			list[key] = null;
//		}
    }
}
