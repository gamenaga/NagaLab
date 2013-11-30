package naga.system
{
	import flash.display.Stage;
	import flash.events.DataEvent;
	import flash.events.Event;
	
	import naga.global.Css;
	import naga.ui.Dialog;
	
	import unit4399.events.RankListEvent;
	import unit4399.events.SaveEvent;
	
	public class DataObj4399
	{
		public static var so:Object=new Object();
		public static var serviceHold:*;
		protected static var loadOverFn:Function;//读档结束后执行函数
		protected static var saveDateTime:String;//获取存档的时间
		protected static var serverCurrentTime:String;//最近获取的 服务器时间
		protected static var getTimeFn:Function;//获取时间后执行函数
		public static var restartFn:Function;//勋章积分需要用到replay方法
		protected static var loginData:Object;//玩家登录信息
		
		protected static function init_(saveDataTitle:String, stage:Stage, mainServiceHold:*, giftOfflineFn:Function):void
		{
			if(mainServiceHold != null)
			{
				serviceHold = mainServiceHold;
				getTimeFn = giftOfflineFn;
				serviceHold.setMouseVisible(false);
//				stage.addEventListener(,saveProcess);
				stage.addEventListener(SaveEvent.SAVE_GET,saveProcess);
				stage.addEventListener(SaveEvent.SAVE_SET,saveProcess);
				stage.addEventListener(SaveEvent.SAVE_LIST,saveProcess);
				stage.addEventListener("medalRestartGame",onRestartGameHandler);
				
				//调用4399存档界面，进行存档时，返回的档索引
				stage.addEventListener("saveBackIndex",saveProcess);
				//网络存档失败
				stage.addEventListener("netSaveError", netSaveErrorHandler, false, 0, true);
				//网络取档失败
				stage.addEventListener("netGetError", netGetErrorHandler, false, 0, true);
				//游戏防多开
				stage.addEventListener("multipleError", multipleErrorHandler, false, 0, true);
				//调用获取游戏是否多开的状态接口时，返回状态值
				stage.addEventListener("StoreStateEvent", getStoreStateHandler, false, 0, true);
				//调用读档接口且该档被封时，则会触发该事件
				stage.addEventListener("getDataExcep", getDataExcepHandler, false, 0, true);
				//获取系统时间
				stage.addEventListener("serverTimeEvent",onGetServerTimeHandler);
				//排行榜
				stage.addEventListener(RankListEvent.RANKLIST_ERROR,onRankListErrorHandler);
				stage.addEventListener(RankListEvent.RANKLIST_SUCCESS,onRankListSuccessHandler);
				
				stage.addEventListener("userLoginOut",onUserLogOutHandler,false,0,true);
			}
			dataInit();
		}
		
		private static function dataInit(isLog:Boolean = false):void
		{
			so.userData = new Array(60);
			var temp:int = 0;
			while (temp < so.userData.length)
			{
				so.userData[temp] = 0;
				temp ++;
			}
			//			so.data.userData["score"] = new Array();
			so.userData[2]=1000;
			so.userData[7]=5;
				
		}
		
		protected static function loadData_():void{
//			trace("dataObj4399 57:	"+serviceHold);
//			Dialog.add(serviceHold);
			if(serviceHold != null)
			{
//				Dialog.add("存档……<br>");
				serviceHold.getData(false, 0);
			}
//			Dialog.add("读档……<br>");
		}
		protected static function saveData_(combo:int, silver:int, lv1:int, lv2:int, rainbow:int, upload:Boolean = true):void{
//			trace(loginData)
			if(loginData != null && upload && serviceHold !=null)
			{
//				Dialog.add("存档……<br>"+combo+" "+silver+" "+lv1+" "+lv2+" "+rainbow);
				serviceHold.saveData("PopPooh",so,false,0);
				serviceHold.submitScoreToRankLists(0,[{rId:674,score:combo},{rId:675,score:silver},{rId:676,score:lv1},{rId:677,score:lv2},{rId:678,score:rainbow}]); 
			}
			//			trace("dataObj	27:	save");
		}
		private static function saveProcess(e:SaveEvent):void{ 
//			Dialog.add("反馈<br>"+e.type+
//				"<br>"+e.ret+
//				"<br>"+e.ret.data);
			switch(e.type){ 
				case SaveEvent.SAVE_GET:
					//读档完成发出的事件
					//index:存档的位置
					//data:存档内容
					//datetime:存档时间
					//title:存档标题
					//e.ret = {"index":0,"data":"abc","datetime":"2010-11-02 16:30:59","title":"标题"}
//								Dialog.add("读取存档反馈"+e.type);
//					Dialog.add("读取存档成功！<br>"+e.ret.title);
					if(e.ret != null)
					{
						so.userData = e.ret.data.userData;
						saveDateTime = e.ret.datetime;
					}
					else
					{
						saveDateTime = "0-0-0 0:0:0";
					}
					loginData = serviceHold.isLog;
					getTime_()
					loadOverFn.call();
					//			trace("dataObj	23:	"+so.data.userData);
					break;
				case SaveEvent.SAVE_SET:
					if(e.ret as Boolean == true){
						//存档成功
//						Dialog.add("存档成功");
					}else{
						//存档失败
//						Dialog.add("存档失败");
					}
					break;
				case "saveBackIndex":
					var tmpObj:Object = e.ret as Object;
					if(tmpObj == null || int(tmpObj.idx) == -1){
//						trace("返回的存档索引值出错了");
						break;
					}
//					trace("返回的存档索引值(从0开始算)："+tmpObj.idx);
					break;
				case SaveEvent.SAVE_LIST:
					var data:Array = e.ret as Array;
					if(data == null) break;
					for(var i:* in data){
						var obj:Object = data[i];
						if(obj == null) continue;
						
						//其中status表示存档状态。"0":正常 "1":临时封 "2":永久封
						//当status为"1"(临时封)或"2"(永久封)时，请在存档列表上加以提示
						//在点击该档位且status为"1"(临时封)时，请加带有申诉功能的提示框，允许玩家向客服申诉处理
						//    申诉入口：http://app.my.4399.com/r.php?app=feedback
						//    提供给玩家举报其他作弊玩家的入口：http://app.my.4399.com/r.php?app=feedback-report
						//在点击该档位且status为"2"(永久封)时，请加提示框且无需做申诉处理的功能
//						var tmpStr:String = "存档的位置:" + obj.index + "存档时间:" + obj.datetime +"存档标题:"+ obj.title +"存档状态:"+ obj.status;
//						trace(tmpStr);
					}
					break;
			}
		}
		
		private static function netSaveErrorHandler(evt:Event):void{
			trace("网络存档失败了！");}
		
		private static function netGetErrorHandler(evt:DataEvent):void{
			var tmpStr:String = "网络取"+ evt.data +"档失败了！";
			trace(tmpStr);
		}
		
		private static function multipleErrorHandler(evt:Event):void{
			trace("游戏多开了！");    
		}
		
		private static function getStoreStateHandler(evt:DataEvent):void{
			//0:多开了，1：没多开，-1：请求数据出错了，-2：没添加存档API的key，-3：未登录不能取状态
			trace(evt.data);
		}
		
		private static function getDataExcepHandler(evt:SaveEvent):void{
			//其中status表示存档状态。"0":正常 "1":临时封 "2":永久封
			//当status为"1"(临时封)时，请加带有申诉功能的提示框，允许玩家向客服申诉处理
			//    申诉入口：http://app.my.4399.com/r.php?app=feedback
			//    提供给玩家举报其他作弊玩家的入口：http://app.my.4399.com/r.php?app=feedback-report
			//当status为"2"(永久封)时，请加提示框且无需做申诉处理的功能
			var obj:Object = evt.ret as Object;
			var tmpStr:String = "存档的位置:" + obj.index +"存档状态:"+ obj.status
			trace(tmpStr);
		}
		
		protected static function submitScore_(score:int):void{
				if(loginData == null)
				{
					loadData_();
				}
				else
				{
					if(serviceHold != null)
					{
						serviceHold.submitScore(score);
						//				serviceHold.showRefer(score); //socre为你的分数变量，类型为int
					}
				}
			//			trace("dataObj	23:	"+so.data.userData);
		}
		//提交积分的结果
		private static function onSubmitScore():void
		{
			//			Open3366Api.removeEventListener(Open3366Event.SCORE_SUBMIT, onSubmitScore);
			//			Dialog.add("积分上传完成");
			//			Dialog.hide();
		}
		private static function stopSubmit1():void
		{
			Dialog.add("<font size=\'+"+int(Css.SIZE*.1)+"\'>分数已经在半路上了<br>请再稍等片刻吧……</font>",null,Css.SIZE,null,Css.PAN_WORD,0,0,25,0,2,[stopSubmit2]);//,["不想上传了",stopSubmit2]);
		}
		private static function stopSubmit2():void
		{
			Dialog.add("分数过分华丽！<br>服务器和它的小伙伴们都惊呆了，<br>所以，反应迟钝了点，请见谅哦。<br>再等一小会，<br>我敢保证，只要一小会<b>……</b>",null,Css.SIZE,null,Css.PAN_WORD,0,0,25,0,2,[stopSubmit3]);//,["服务器君，请加油！",stopSubmit3]);
		}
		private static function stopSubmit3():void
		{
			Dialog.add("<font size=\'+"+int(Css.SIZE*.1)+"\'>10</font>秒倒计时后，绝对<font size=\'+"+int(Css.SIZE*.1)+"\'>OK</font>！<br><br>倒计时：<font size=\'+"+int(Css.SIZE*.1)+"\'>10</font>",null,Css.SIZE,null,Css.PAN_WORD,0,0,25,0,2,[stopSubmit4]);//,["坑爹！倒计时没动！",stopSubmit4]);
		}
		private static function stopSubmit4():void
		{
			Dialog.add("对不起<font size=\'+"+int(Css.SIZE*.1)+"\'>T_T</font>。倒计时出<font size=\'+"+int(Css.SIZE*.1)+"\'>BUG</font>啦！<br>还是不等了……",null,Css.SIZE,null,Css.PAN_WORD,0,0,25,0,2);//,["负分！"]);
		}
		protected static function delData_():void{
			dataInit();
			saveData_(0,0,0,0,0,true);
		}
		
		//获取到系统时间
		protected static function getTime_(fn:Function = null):void{
			if(serviceHold){
//				Dialog.add("getTimeFn : "+getTimeFn);
				if(fn != null)
				{
					getTimeFn = fn;
				}
				serviceHold.getServerTime();
			}
		}
		private static function onGetServerTimeHandler(evt:DataEvent):void{
			// evt.data值的格式如：2011-10-15 9:40:30。如果获取失败，返回值为""。 
//			Dialog.add("系统时间 : "+evt.data);
			if(evt.data != "")
			{
				serverCurrentTime = evt.data;
				if(getTimeFn != null)
				{
					getTimeFn.call();
				}
			}
			else
			{
				getTime_(null);
			}
		}
		
		private static function onRankListErrorHandler(evt:RankListEvent):void{
//			var obj:Object = evt.data;
//			var str:String  = "apiFlag:" + obj.apiName +"   errorCode:" + obj.code +"   message:" + obj.message + "\n";
//			Dialog.add(str);
		}
		
		private static function onRankListSuccessHandler(evt:RankListEvent):void{
			var obj:Object = evt.data;
//			Dialog.add("apiFlag:" + obj.apiName);
			
			var data:* =  obj.data;
			
			switch(obj.apiName){
				case "1":
					//根据用户名搜索其在某排行榜下的信息
				case "2":
					//根据自己的排名及范围取排行榜信息
				case "4":
					//根据一页显示多少条及取第几条数据来取排行榜信息
					decodeRankListInfo(data);
					break;
				case "3":
					//批量提交成绩至对应的排行榜(numMax<=5,extra<=500B)
					decodeSumitScoreInfo(data);
					break;
				case "5":
					//根据用户ID及存档索引获取存档数据
					decodeUserData(data);
					break;
			}
		}
		
		private static function decodeUserData(dataObj:Object):void{
			if(dataObj == null){
//				Dialog.add("没有用户数据！\n");
				return;
			}
//			var str:String = "存档索引：" + dataObj.index+"\n标题:" + dataObj.title+"\n数据："+dataObj.data+"\n存档时间："+dataObj.datetime+"\n";
//			Dialog.add(str);
		}
		
		private static function decodeSumitScoreInfo(dataAry:Array):void{
			if(dataAry == null || dataAry.length == 0){
//				Dialog.add("没有数据,返回结果有问题！\n");
				return;
			}
			
//			for(var i in dataAry){
//				var tmpObj:Object = dataAry[i];
//				var str:String;
////				Dialog.add(i+" "+tmpObj.rId);
//				if (tmpObj.code == "10000" && tmpObj.curRank != 0)
//				{
//					if (tmpObj.rId == 674)
//					{
//						str = "本局最高连击：<font size=\'+"+int(Css.SIZE*.1)+"\' color=\'#" + Css.ORANGE + "\'>Combo\ " + tmpObj.curScore + "</font>";
//						str += "<br>本周世界排名：第<font size=\'+"+int(Css.SIZE*.2)+"\' color=\'#" + Css.YELL_D + "\'>" + tmpObj.curRank + "</font>名<br><br>";
//						if(tmpObj.curRank >100)
//						{
//							str += "一鼓作气！冲进世界百强！";
//						}
//						else if(tmpObj.curRank >10)
//						{
//							str += "太棒了！很快就到世界十强啦！";
//						}
//						else if(tmpObj.curRank >1)
//						{
//							str += "向冠军席位发起挑战吧！";
//						}
//						else
//						{
//							str += "万人敬仰！成功卫冕本周世界冠军！";
//						}
//						str += "<br><br><font size=\'-"+int(Css.SIZE*.5)+"\'>欢迎加入“咕噜交流群”：</font>\\<font size=\'-"+int(Css.SIZE*.4)+"\' color=\'#" + Css.ORANGE + "\'>229395946</font>";
//						Dialog.add(str);
//					}
////					else if (tmpObj.rId == 678)
////					{
////						str = "本局最高连击：<font size=\'+"+int(Css.SIZE*.1)+"\' color=\'#" + Css.ORANGE + "\'>Combo\ " + tmpObj.curScore + "</font>";
////						str += "<br>本周世界排名：第<font size=\'+"+int(Css.SIZE*.2)+"\' color=\'#" + Css.YELL_D + "\'>" + tmpObj.curRank + "</font>名<br><br>";
////						if(tmpObj.curRank >100)
////						{
////							str += "一鼓作气！冲进世界百强！";
////						}
////						else if(tmpObj.curRank >10)
////						{
////							str += "太棒了！很快就到世界十强啦！";
////						}
////						else if(tmpObj.curRank >1)
////						{
////							str += "向冠军席位发起挑战吧！";
////						}
////						else
////						{
////							str += "万人敬仰！成功卫冕本周世界冠军！";
////						}
////						str += "<br><font size=\'-"+int(Css.SIZE*.6)+"\' color=\'#" + Css.ORANGE + "\'>欢迎加入</font><font size=\'-"+int(Css.SIZE*.5)+"\' color=\'#" + Css.ORANGE + "\'>咕噜交流QQ群：<b>229395946</b></font>";
////						Dialog.add(str);
////					}
//				}
////				var str:String = "第" + (i+1) + "条数据。排行榜ID：" + tmpObj.rId + "，信息码值：" +tmpObj.code +"\n";
////				//tmpObj.code == "20005" 表示排行榜已被锁定
////				if(tmpObj.code == "10000"){
////					str += "当前排名:" + tmpObj.curRank+",当前分数："+tmpObj.curScore+",上一局排名："+tmpObj.lastRank+",上一局分数："+tmpObj.lastScore+"\n";
////				}else{
////					str += "该排行榜提交的分数出问题了。信息："+tmpObj.message+"\n";
////				}
////				Dialog.add(str);
//			}
		}
		
		private static function decodeRankListInfo(dataAry:Array):void{
			if(dataAry == null || dataAry.length == 0){
//				Dialog.add("没有用户数据！\n");
				return;
			}
			
			for(var i in dataAry){
				var tmpObj:Object = dataAry[i];
//				var str:String = "第" + (i+1) + "条数据。存档索引：" + tmpObj.index+",用户id:" + tmpObj.uId+",昵称："+tmpObj.userName+",分数："+tmpObj.score+",排名："+tmpObj.rank+",来自："+tmpObj.area+",扩展信息："+tmpObj.extra+"\n";
//				Dialog.add(str);
			}
		}
		
		
		private static function onRestartGameHandler(evt:Event):void{
			//处理游戏重新开始的地方   
			restartFn.call();
		}
		
		
		private static function onUserLogOutHandler(evt:Event):void{
			loginData = null;
		}
	}
}