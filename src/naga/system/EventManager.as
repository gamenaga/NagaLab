package naga.system 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;

	/**
	 * EventManager 事件集中管理器
	 * @author 阿伍 2010/4/1
	 */
	public class EventManager 
	{

		private static var FnDict: Dictionary = new Dictionary(false );
		private static var OnceFnDict: Dictionary = new Dictionary(false );
		public static var count:int=0;

		public static function AddEventFn(obj: EventDispatcher,type: String,fn: Function,para: Array = null,eventPara: Boolean = false): void
		{
//						trace("eveM 19",obj,type,fn,eventPara);
			//如果该obj从未注册过
			if(! FnDict[obj])
			{
				FnDict[obj] = {};
			}
			//如果没注册过该事件
			if(! FnDict[obj][type])
			{
				FnDict[obj][type] = [];
				obj.addEventListener(type, onEventCatch );
			}
//			//如果没有相同函数加入到侦听
//			if(FnDict[obj][type][0][fn] != fn)
//			{
				FnDict[obj][type].push([fn,para,eventPara] );
//			}
		}

		//删除事件
		public static function delEventFn(obj: EventDispatcher,type: String,fn: Function): void
		{
//			trace("eveM 36",FnDict[obj][type]);
			if(FnDict[obj] != null && FnDict[obj][type] != null)
			{
				var arr: Array = FnDict[obj][type];//取出 此侦听器 所有的侦听函数
				//			trace("eveM 36:	",obj,type,fn,arr);
				for each(var item:Array in arr)
				{ 
//					trace("eveM 49:	",item);
					if(item[0] == fn)
					{
						FnDict[obj][type].splice(FnDict[obj][type].indexOf(item ), 1 );
						break;
					}
				}
				
				
				//如果obj的这种侦听已经无意义，则删除
				if(! FnDict[obj][type].length)
				{
					obj.removeEventListener(type, onEventCatch );
					delete FnDict[obj][type];
				}
				
			}
		} 

		//删除一个obj的所有type为指定类型的事件
		public static function delEventByType(obj: EventDispatcher,type: String): void
		{
			obj.removeEventListener(type, onEventCatch );  
			delete FnDict[obj][type];
		}

		//删除一个obj所有的事件
		public static function delAllEvent(obj: EventDispatcher): void
		{
			for(var type:String in FnDict[obj])
			{ 
				obj.removeEventListener(type, onEventCatch ); 
			}
			delete FnDict[obj];
		}

		//执行事件
		private static function onEventCatch(e: Event): void
		{
//			trace("eveM 81:	",e);
//			trace("eveM 82:	",e.target);
//			trace("eveM 82:	",e.currentTarget);
//			if(e.target=="[object Sprite]") trace("eveM 83:	",getTimer(),FnDict.length,FnDict[e.target].length,e,e.target,e.type);
//			trace("eveM 84:	",e,e.target,e.type,FnDict[e.target][e.type]);
			var arr: Array = FnDict[e.target][e.type];
			for(var i: int = 0;i < arr.length; i ++)
			{ 
				var fn: Function = arr[i][0];
				if(arr[i][2])
				{
					if(arr[i][1])
					{
						var paras: Array = arr[i][1].concat();
						paras.unshift(e);
						fn.apply(null, paras);
//						trace(paras);
					}
					else
					{
						fn.apply(null, [e]);
					}
				}
				else
				{
					fn.apply(null, arr[i][1] );
				}
			}
			count = i;
		}

		//只执行一次的事件
		public static function AddOnceEventFn(obj: EventDispatcher,type: String,fn: Function,para: Array = null): void
		{
			//如果该obj从未注册过
			OnceFnDict[obj] || (OnceFnDict[obj] = {});
			 
			//如果也没有注册过该事件
			if(! OnceFnDict[obj][type])
			{
				OnceFnDict[obj][type] = [];
				obj.addEventListener(type, onOnceEventCatch );
			}
			OnceFnDict[obj][type].push([fn,para] );
            //obj.adde
		}

		//只执行一次的事件被触发了
		private static function onOnceEventCatch(e: Event): void
		{
			EventDispatcher(e.target ).removeEventListener(e.type, onOnceEventCatch );
			
			var arr: Array = OnceFnDict[e.target][e.type];
			for(var i: int = 0;i < arr.length; i ++)
			{  
				arr[i][0].apply(null, arr[i][1] );
			}
			delete OnceFnDict[e.target][e.type];
		}
	}
}
