package naga.system
{
	
	import open3366.as3.Open3366Api;
	import open3366.as3.Open3366Event;
	
	public class DataObj3366
	{
		private static var _index:int;
		private static var _pageId:int;
		private static var _title:String;
		private static var _current:int = 0;
		public static var so:Object=new Object();
		
		public static function init_(saveDataTitle:String):void
		{
			_title = saveDataTitle;
			Open3366Api.addEventListener(Open3366Event.STORE_GET, onLoad);
			Open3366Api.addEventListener(Open3366Event.STORE_SET, onSetDate);
			Open3366Api.addEventListener(Open3366Event.SEND_MSG_TO_FLASH, onLoginBack);
			dataInit();
			loadData_();
		}
		
		private static function dataInit():void
		{
			so.data.userData=new Array(60);
			var temp:int = 0;
			while (temp < so.data.userData.length)
			{
				so.data.userData[temp] = 0;
				temp ++;
			}
//			so.data.userData["score"] = new Array();
			so.userData[2]=1000;
			so.data.userData[7]=5;
		}
		
		private static function onLoginBack(evt:Open3366Event):void
		{
//			Dialog.add("onLoginBack");
			if(evt.data.result == 0)
			{
				switch(_current)
				{
					case 1:Open3366Api.getData(_index, _pageId);break;
					case 2:Open3366Api.setData(_title, so, _index, _pageId);break;
					case 3:Open3366Api.getDataList(_pageId);break;
				}
				_current = 0;
			}
		}
		
		public static function loadData_(index:int = 1, pageId:int = 1):void
		{
			_index = index;
			_pageId = pageId;
			Open3366Api.getData(index, pageId);
//			Bubble.instance.show("",Glo.stage_w*.5,Glo.stage_h*.5,"读档……");
		}
		private static function onLoad(evt:Open3366Event):void
		{
//			Dialog.add("读取存档反馈"+evt.data.result);
			if(evt.data.result == 0)
			{
//				Dialog.add("读取存档成功！<br>"+evt.data.data);
				so=evt.data.data;
			}else if(evt.data.result == 10002)
			{
//				trace("由于未登录，存档列表失败，弹登录框");
				_current = 1;
				Open3366Api.showLogin();
			}else {
				loadData_();
				}
//			trace("dataObj	23:	"+so.data.userData);
		}
		
		public static function saveData_(upload:Boolean = true, index:int = 1, pageId:int = 1):void
		{
			if(upload)
			{
				Open3366Api.setData(_title, so, index, pageId);
			}
//			Dialog.add("存档……"+so);
		}
		private static function onSetDate(evt:Open3366Event):void
		{
//			Dialog.add("存档反馈");
			if(evt.data.result == 0)
			{
//				Dialog.add("存档成功");
//				trace("存档成功");
			}else if(evt.data.result == 10002)
			{
//				trace("由于未登录，存档列表失败，弹登录框");
				_current = 2;
				Open3366Api.showLogin();
			}else
			{
			}
		}
		
		protected static function submitScore_(score:int):void
		{
			Open3366Api.addEventListener(Open3366Event.SCORE_SUBMIT, onSubmitScore);
			//			EventManager.AddOnceEventFn(Open3366Api as EventDispatcher,Open3366Event.SCORE_SUBMIT,onSubmitScore);
			//			Dialog.hide();
			Open3366Api.submitScore(score);
		}
		private static function onSubmitScore(evt:Open3366Event):void
		{
			//			Open3366Api.removeEventListener(Open3366Event.SCORE_SUBMIT, onSubmitScore);
			//			Dialog.add("积分上传完成");
			//			Dialog.hide();
		}
		
		public static function delData_():void
		{
			dataInit();
			Open3366Api.setData(_title, so, _index, _pageId);
			//			Dialog.add("存档……");
		}
		
	}
}