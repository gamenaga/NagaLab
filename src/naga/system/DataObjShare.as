package naga.system
{
	import flash.net.SharedObject;
	
	import open3366.as3.Open3366Event;
	
	public class DataObjShare
	{
		public static var so:SharedObject
		
		protected static function init_(saveDataTitle:String):void
		{
			so= SharedObject.getLocal(saveDataTitle);
			dataInit();
			loadData_();
		}
		
		private static function dataInit():void
		{
			if(so.data.userData==undefined){
				so.data.userData=new Array(60);
				//				so.data.userData["pop"] = new Array();
				//				so.data.userData["item"] = new Array();
				//				so.data.userData["first"] = new Array();
				var temp:int = 0;
				while (temp < so.data.userData.length)
				{
					so.data.userData[temp] = 0;
					temp ++;
				}
//				so.data.userData["score"] = new Array();
				so.data.userData[2]=1000;
				so.data.userData[7]=5;
				so.data.getGiftHourTime = new Date(1970);
			}
		}
		
		protected static function loadData_():void{
//			trace("dataObj	23:	"+so.data.userData);
		}
		protected static function saveData_(upload:Boolean = true):void{
			so.flush();
//			trace("dataObj	27:	save");
		}
		protected static function submitScore_(score:int):void{
			//			trace("dataObj	23:	"+so.data.userData);
		}
		//提交积分的结果
		private static function onSubmitScore(evt:Open3366Event):void
		{
		}
		protected static function delData_():void{
			so.clear();
		}
	}
}