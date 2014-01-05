package naga.system
{
	/*
	   版本：v1.0
	   0、该类为单例模式，因此创建的各个实例实为同一个实例
	   1、varValue:表示varName该参数的值。类型为Boolean,Number,int,uint
	   2、varName:为防止CE修改器修改的参数名。
	   3、opFun:为对varName这个参数执行计算处理的函数
	   4、setAttribute(),把varName该变量的值varValue保存下来
	   5、getAttribute(),根据varName取保存下来的值。
	   6、setAttributeByFun()会返回一个值。返回值为以varName当前值为参数，经过opFun计算处理后的值,它的类型为Number,Boolean。
	*/
	
	public class MemeryProtect{
		public static var instance:MemeryProtect;
		private var varObj:Object;
		
		public function MemeryProtect():void{
			if(MemeryProtect.instance != null)
				throw new Error("只能实例一次！");
			else
				MemeryProtect.instance = this;
		}
		
		public static function getInstance():MemeryProtect{
			if(instance==null)
				instance = new MemeryProtect();
			return instance;
		}

		public function setValueByFun(varName:String,opFun:Function):Number{
			var tmpVal:*;
			if(isNaN(getValue(varName))){
				tmpVal = 0;
			}else{
				tmpVal = getValue(varName);
			}
			
			var tmpVal2:* = opFun(tmpVal);
			setValue(varName,tmpVal2);
//			trace("mp 41:",getValue(varName));
			return getValue(varName);
		}
		
		//执行了几次设置属性
		private var cout:int = 0;
		public function setValue(varName:String,varValue:*):void
		{
			if(!(varValue is Number) && !(varValue is Boolean)) return;
			var tmpObj:Object = new Object();
			tmpObj = {value:varValue};
			var tmpObj2:Object = new Object();
			for (var i:* in varObj){
				tmpObj2[i] = varObj[i];
			}
			tmpObj2[varName] = tmpObj.value;
			tmpObj = null;
			varObj = null;
			varObj = tmpObj2;
			/*//用于测试对象属性及值有没有错误
			cout++;
			for (var j in varObj){
				trace(cout+"--------------------->"+j,varObj[j]);
			}*/
		}
		
		//Number.NaN:不存在这个属性
		public function getValue(varName:String):*{
			if(varObj==null || varObj[varName]==undefined) return Number.NaN;
			var tmpObj:Object = new Object();
			tmpObj.value = varObj[varName];
			return tmpObj.value;
		}
	}
}