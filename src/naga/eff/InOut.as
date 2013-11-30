package naga.eff
{
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    
    import naga.system.EventManager;
    import naga.system.IPoolable;
    import naga.system.ObjPool;
    

    public class InOut
    {
		private static var scopeIn:Number;
		private static var maxIn:Number;
		private static var scopeInHalf:Number;
		private static var maxInHalf:Number;
		private static var scopeOut:Number;
		private static var minOut:Number;
		private static var maxOut:Number;
		private static var pool:Boolean;
        private static var del:Boolean;

		/**
		 * 透明淡入
		 * min 默认-1：表示以对象本身alpha为 淡入起始
		 */
		public static function fadeIn(obj:DisplayObject, scope:Number = 0.1, min:Number = -1):void
		{
			scopeIn = scope;
			maxIn = 1;
			if(min!=-1)
			{
				obj.alpha = min;
			}
//			obj.addEventListener(Event.ENTER_FRAME, alphaIn);
			EventManager.AddEventFn(obj,Event.ENTER_FRAME, alphaIn,null,true);
		}
		public static function fadeInHalf(obj:DisplayObject, scope:Number = 0.05, min:Number=-1, max:Number=.5):void
		{
			scopeInHalf = scope;
			maxInHalf = max;
			if(min!=-1)
			{
				obj.alpha = min;
			}
//			obj.addEventListener(Event.ENTER_FRAME, alphaInHalf);
			EventManager.AddEventFn(obj,Event.ENTER_FRAME, alphaInHalf,null,true);
		}
		
		/**
		 * 透明淡出
		 * max 默认-1：表示以对象本身alpha为 淡出起始
		 */
		public static function fadeOut(obj:DisplayObject, scope:Number = 0.1, min:Number = 0, max:Number=1, is_pool:Boolean=false):void
		{
			scopeOut = scope;
			minOut = min;
//			pool=is_pool;
			if(max!=-1)
			{
				maxOut = max;
				obj.alpha = max;
			}
			if(is_pool)
			{
//				obj.addEventListener(Event.ENTER_FRAME, alphaOut2Pool);
				EventManager.AddEventFn(obj,Event.ENTER_FRAME, alphaOut2Pool,null,true);
			}
			else
			{
//				obj.addEventListener(Event.ENTER_FRAME, alphaOut);
				EventManager.AddEventFn(obj,Event.ENTER_FRAME, alphaOut,null,true);
			}
		}
		
//        public static function add(obj:DisplayObject, is_in:Boolean=true, scope:Number = 0.1, min:Number = -1, max:Number = 0,is_pool:Boolean=true, is_del:Boolean = true) : void
//        {
//            e_s = scope;
//			pool=is_pool;
//            del = is_del;
//            if (min == -1)
//            {
//                if (is_in)
//                {
//                    obj.alpha = 0;
//                    obj.addEventListener(Event.ENTER_FRAME, alpha_in);
//                }
//                else
//                {
////                    if (!Glo.is_hd)
////                    {
////                        obj.alpha = 0;
////                    }
////                    else
////                    {
//                        obj.alpha = 1;
////                    }
//                    obj.addEventListener(Event.ENTER_FRAME, alpha_out);
//                }
//            }
//            else
//            {
//                mi = min;
//                mx = max;
//                if (is_in)
//                {
//                    obj.alpha = mi;
////                    obj.addEventListener(Event.ENTER_FRAME, apl_in_half);
//                }
//                else
//                {
////                    if (!Glo.is_hd)
////                    {
////                        obj.alpha = mi;
////                    }
////                    else
////                    {
//                        obj.alpha = mx;
////                    }
//                    obj.addEventListener(Event.ENTER_FRAME, apl_out_half);
//                }
//            }
//        }// end function

//		淡入
        private static function alphaIn(event:Event) : void
        {
            if (event.target.alpha >= maxIn)
            {
//                event.target.removeEventListener(Event.ENTER_FRAME, alphaIn);
				EventManager.delEventFn(event.target as EventDispatcher,Event.ENTER_FRAME, alphaIn);
            }
//			trace("inOut 111:	"+event.target.alpha+"	"+scopeIn);
            event.target.alpha = event.target.alpha + scopeIn;
        }// end function
		private static function alphaInHalf(event:Event) : void
		{
			if (event.target.alpha >= maxInHalf)
			{
//				event.target.removeEventListener(Event.ENTER_FRAME, alphaInHalf);
				EventManager.delEventFn(event.target as EventDispatcher,Event.ENTER_FRAME, alphaInHalf);
			}
//						trace("inOut 111:	"+event.target.alpha+"	"+scopeInHalf);
			event.target.alpha = event.target.alpha + scopeInHalf;
		}// end function

//		淡出
//        private static function alpha_out(event:Event) : void
//        {
//            if (event.target.alpha <= 0)
//            {
//                event.target.removeEventListener(Event.ENTER_FRAME, alpha_out);
//                if (del && event.target.parent != null)
//                {
//					
//					Glo.objectPool.returnObj(event.target);
////                    event.target.parent.removeChild(event.target);
//                }
//            }
//            event.target.alpha = event.target.alpha - e_s;
//        }// end function

//		半透淡入
//        private static function apl_in_half(event:Event) : void
//        {
//            if (event.target.alpha >= mx)
//            {
//                event.target.removeEventListener(Event.ENTER_FRAME, apl_in_half);
//            }
//            event.target.alpha = event.target.alpha + e_s;
//        }// end function

//		半透淡出
        private static function alphaOut(event:Event) : void
        {
            if (event.target.alpha <= minOut)
            {
//                event.target.removeEventListener(Event.ENTER_FRAME, alphaOut);
				EventManager.delEventFn(event.target as EventDispatcher,Event.ENTER_FRAME, alphaOut);
				if(event.target.parent != null)
				{
//					event.target.parent.removeChild(event.target);
					Vision.instance.del(event.target as Object);
				}
            }
            event.target.alpha = event.target.alpha - scopeOut;
        }// end function
		private static function alphaOut2Pool(event:Event) : void
		{
//			trace(191,event.target.alpha);
			if (event.target.alpha <= minOut)
			{
//				event.target.removeEventListener(Event.ENTER_FRAME, alphaOut2Pool);
				EventManager.delEventFn(event.target as EventDispatcher,Event.ENTER_FRAME, alphaOut2Pool);
				if (event.target != null)
				{
					ObjPool.instance.returnObj(event.target as IPoolable);
				}
			}
			event.target.alpha = event.target.alpha - scopeOut;
		}// end function

    }
}
