package naga.system
{
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	
	public class ObjPool 
	{
		private static var _instance:ObjPool;
		private static var _allowInstantiation:Boolean;
		
		private var _pools:Object;
		
		public static function get instance():ObjPool
		{
			if (!_instance)
			{
				_allowInstantiation = true;
				_instance = new ObjPool();
				_allowInstantiation = false;
			}
			
			return _instance;
		}
		
		public function ObjPool() 
		{
			if (!_allowInstantiation)
			{
				throw new Error("Trying to instantiate a Singleton!");
			}
//			trace("objPool 31:	ok");
			_pools = {};
		}
		
		public function registerPool(objectClass:Class, size:int = 1, label:String=null,isDynamic:Boolean = true,...paramenters):void
		{
//			trace("objPool 37:	"+describeType(objectClass));
			if (!(describeType(objectClass).factory.implementsInterface.(@type == "naga.system::IPoolable").length() > 0))
			{
				throw new Error("Can't pool something that doesn't implement IPoolable!");
				return;
			}
			
			var qualifiedName:String = getQualifiedClassName(objectClass)+label;
			
			if (!_pools[qualifiedName])
			{
//				trace("objPool 48:	new Pool	"+objectClass);
				_pools[qualifiedName] = new PoolInfo(objectClass, size, isDynamic);
			}
		}
		
		public function getObj(objectClass:Class, label:String=null,...paramenters):IPoolable
		{
			var qualifiedName:String = getQualifiedClassName(objectClass)+label;
			
			if (!_pools[qualifiedName])
			{
				registerPool(objectClass,1,label);
//				throw new Error("Can't get an object from a pool that hasn't been registered!");
//				return;
			}
			
			var returnObj:IPoolable;
			
			if (PoolInfo(_pools[qualifiedName]).active == PoolInfo(_pools[qualifiedName]).size)
			{
				if (PoolInfo(_pools[qualifiedName]).isDynamic)
				{
//					trace("objPool 70:	"+objectClass,paramenters);
					returnObj = this["new"+paramenters.length].call(null,objectClass,paramenters);
					
					PoolInfo(_pools[qualifiedName]).size++;
					PoolInfo(_pools[qualifiedName]).items.push(returnObj);
				}
				else
				{
					return null;
				}
			}
			else
			{
				returnObj = PoolInfo(_pools[qualifiedName]).items[PoolInfo(_pools[qualifiedName]).active];
//				var param:Vector.<String>=paramenters
//				trace("objPool 85:	"+returnObj+"	"+paramenters);
				this["renew"+paramenters.length].call(null,returnObj,paramenters);
			}
			PoolInfo(_pools[qualifiedName]).active++;
			return returnObj;	
		}
		private function new0(objectClass:Class, paramenters:Array):IPoolable {return new objectClass();}
		private function new1(objectClass:Class, paramenters:Array):IPoolable {return new objectClass(paramenters);}
		private function new2(objectClass:Class, paramenters:Array):IPoolable {return new objectClass(paramenters[0],paramenters[1]);}
		private function new3(objectClass:Class, paramenters:Array):IPoolable {return new objectClass(paramenters[0],paramenters[1],paramenters[2]);}
		private function new4(objectClass:Class, paramenters:Array):IPoolable {return new objectClass(paramenters[0],paramenters[1],paramenters[2],paramenters[3]);}
		private function new5(objectClass:Class, paramenters:Array):IPoolable {return new objectClass(paramenters[0],paramenters[1],paramenters[2],paramenters[3],paramenters[4]);}
		
		private function renew0(returnObj:IPoolable,paramenters:Array):void{returnObj.renew();}
		private function renew1(returnObj:IPoolable,paramenters:Array):void{returnObj.renew(paramenters);}
		private function renew2(returnObj:IPoolable,paramenters:Array):void{returnObj.renew(paramenters[0],paramenters[1]);}
		private function renew3(returnObj:IPoolable,paramenters:Array):void{returnObj.renew(paramenters[0],paramenters[1],paramenters[2]);}
		private function renew4(returnObj:IPoolable,paramenters:Array):void{returnObj.renew(paramenters[0],paramenters[1],paramenters[2],paramenters[3]);}
		private function renew5(returnObj:IPoolable,paramenters:Array):void{returnObj.renew(paramenters[0],paramenters[1],paramenters[2],paramenters[3],paramenters[4]);}
		
		/**
		 *获取指定Pool的Obj数个数 
		 * 
		 */		
		public function getPoolNum(objectClass:Class, label:String=null):String
		{
			
			var qualifiedName:String = getQualifiedClassName(objectClass)+label;
			
			if (PoolInfo(_pools[qualifiedName]) && PoolInfo(_pools[qualifiedName]).isDynamic)
			{
//				trace("objPool 116:	",PoolInfo(_pools[qualifiedName]).active,PoolInfo(_pools[qualifiedName]).size);
				return PoolInfo(_pools[qualifiedName]).active +"|"+ PoolInfo(_pools[qualifiedName]).size +"|"+ PoolInfo(_pools[qualifiedName]).items.length;
			}
			else
			{
				return "0|0|0";
			}
			
		}
		
		
		
		public function returnObj(obj:IPoolable, label:String=null):void
		{
//			trace("objPool 130:	"+obj);
			var qualifiedName:String = getQualifiedClassName(obj)+label;
			
			if (!_pools[qualifiedName])
			{
				if(obj)
				{
					throw new Error("Can't return an object from a pool that hasn't been registered!");
				}
				return;
			}
			
			var objIndex:int = PoolInfo(_pools[qualifiedName]).items.indexOf(obj);
			//			PoolInfo(_pools[qualifiedName]).items.splice(objIndex, 1);
			//			obj.destroy();
			//			if(PoolInfo(_pools[qualifiedName]).active>0)PoolInfo(_pools[qualifiedName]).active--;
			
			//			trace("objPool 101:	"+obj+"	"+objIndex+" / "+PoolInfo(_pools[qualifiedName]).items.length+"	");
			if (objIndex >= 0)
			{
				if (!PoolInfo(_pools[qualifiedName]).isDynamic)
				{
					PoolInfo(_pools[qualifiedName]).items.fixed = false;
				}
				
				PoolInfo(_pools[qualifiedName]).items.splice(objIndex, 1);
				
				obj.destroy();
				
				PoolInfo(_pools[qualifiedName]).items.push(obj);
				
				if (!PoolInfo(_pools[qualifiedName]).isDynamic)
				{
					PoolInfo(_pools[qualifiedName]).items.fixed = true;
				}
				if(PoolInfo(_pools[qualifiedName]).active>0)PoolInfo(_pools[qualifiedName]).active--;
			}
			
		}
		
		
		public function delObj(obj:IPoolable, label:String=null, delNum:int=1):void
		{
			var qualifiedName:String = getQualifiedClassName(obj)+label;
			
			if (!_pools[qualifiedName])
			{
				if(obj)
				{
					//					trace("objPool 107:	"+obj);
					throw new Error("Can't return an object from a pool that hasn't been registered!");
				}
				return;
			}
			
//			var objIndex:int = PoolInfo(_pools[qualifiedName]).items.indexOf(obj);
//			for (var i:int=1; i<=delNum; i++)
//			{
				PoolInfo(_pools[qualifiedName]).items.splice(PoolInfo(_pools[qualifiedName]).items.length - delNum -1, delNum);
				
				obj.dispose();
//			}
			
		}
		
	}
	
}
import naga.system.IPoolable;

class PoolInfo
{
	public var items:Vector.<IPoolable>;
	public var itemClass:Class;
	public var size:int;
	public var active:int;
	public var isDynamic:Boolean;
	
	public function PoolInfo(itemClass:Class, size:int, isDynamic:Boolean = true)
	{
		this.itemClass = itemClass;
		items = new Vector.<IPoolable>(size, !isDynamic);
		this.size = size;
		this.isDynamic = isDynamic;
		active = 0;
		initialize();
	}
	
	private function initialize():void
	{
		for (var i:int = 0; i < size; i++)
		{
			items[i] = new itemClass();
		}
	}
}