package game
{
	import flash.system.System;
	
	import eff.E10Fly;
	import eff.E3FlashPoint;
	import eff.E3FlashRound;
	import eff.E4Ink;
	import eff.E8Cloud;
	
	import item.I11O2Time;
	import item.I2Clear;
	import item.I4AddPop;
	import item.I8Fog;
	
	import naga.eff.Vision;
	import naga.global.Css;
	import naga.global.Global;
	import naga.system.Bubble;
	import naga.system.ObjPool;
	import naga.system.Sounds;
	import naga.tool.String2Font39;
	
	import pop.PopFactory;
	import pop.PopRainbow;
	
	import ui.UI;
	
	public class LvUp
	{
//		public static var content:Array=new Array();
		private static var prizeID:int;
//		private static var shopicon1:Icons=new Icons();
		public static var lv_:int;//等级
		public static var lv2_:int;//达人等级
		public static var tempLv:int;//当前实时等级
		public static var score:int;
		public static const SHOP_LV:Array=[1000];//增量
		
		public function LvUp()
		{
			
		}
		public static function lvChange(lv:int,lv2:int,is_lvUp:Boolean=false):void{
			//			trace("lv up	41:	"+lv_+"/"+lv+"	"+lv2_+"/"+lv2+"	"+shop);
//			trace("lvUp 44;	",Mode.game_type);
			if(Main.mode.game_type==Global.TYPE_NORMAL.name)
			{
				lv_=Math.max(0,lv_+lv);
				if (lv_ > DataObj.data[8])
				{
					DataObj.data[8] = lv_;//更新最高LV纪录
				}
				tempLv=lv_;
			}
			else{
				lv2_=Math.max(0,lv2_+lv2);
				if (lv2_ > DataObj.data[9])
				{
					DataObj.data[9] = lv2_;//更新最高 达人LV纪录
				}
				tempLv=lv2_;
			}
//			trace("lvUp 61:	",lv,lv_,DataObj.data[8],lv2,lv2_,DataObj.data[9],tempLv);
			
			if(tempLv>0){
				UI.tf_lv.htmlText="<font size=\'" + Css.SIZE + "\' color=\'#" + Css.ORAN_S + "\'>Lv\\<font size=\'"+Css.SIZE*1.5+"\' color=\'#" + Css.ORAN_D + "\'>"+tempLv+"</font></font>";
				UI.ui_lv.removeChildren();
				String2Font39.go(UI.tf_lv, UI.ui_lv,Css.SIZE,null,false);
			}
			else if(tempLv==0){
				UI.ui_lv.removeChildren();
			}
			
//			if(PopFactory.path==8)
//			{//首次升级将改变 泡泡的产出方向
				PopFactory.path=PopFactory.PATH_AROUND;
//				PopFactory.pathBak=0;
//			}
			
			if(is_lvUp){
				Sounds.play(Se_lv_up);
				if(!I11O2Time.iDoing)
				{
					I2Clear.go();
					PopFactory.pause(2000,I4AddPop.go,1000,PopFactory.PATH_DOWN,PopFactory.PATH_AROUND);
				}
				else
				{
					I8Fog.over();
				}
				PopFactory.changePopNumMax();
				Global.g_move_sp_lv = (1 + tempLv*0.01);
//				trace("lvUp 75:	"+PopFactory.popNumMax,Math.pow(PopFactory.popNumMax,.5),main.game_combo_level,PopFactory.popNumMaxItem,Global.game_view_w*.5,Global.game_view_h*.5);
//				main.mode.add_pop.go(1500);
//				trace("lvUp 87:	",E10Fly);
//				Vision.instance.add("levelUp",E10Fly, Global.eff_floor, (Global.game_view_w-E10Fly.BC.width)*.5,Global.game_view_h,null,1,7000,1,0,false,false,true);
				Vision.instance.add("levelUp",E3FlashPoint, Global.eff_floor, Global.game_view_w*.5,Global.game_view_h*.5 ,null, .8 ,1000, 3, 0, true,true,true);
				Bubble.instance.show("<font size=\'"+Css.SIZE*1.3+"\' color=\'#"+Css.YELL_D+"\'>Level</font><br><font size=\'"+Css.SIZE*2.2+"\'>"+tempLv+"</font>",Bubble.TYPE_LV_UP,Global.game_view_w*.5,Global.game_view_h*.5, 240,Css.SIZE*3,Css.YELLOW);
				//等级控制内容
//				trace("LvUp 86 :	tempLv:",tempLv);
				switch (tempLv)
				{
					case 2:
					{
//						trace("LvUp 89 :	2");
						ObjPool.instance.registerPool(PopRainbow);
						ObjPool.instance.registerPool(E3FlashRound);
						break;
					}
					case 3:
					{
//						trace("LvUp 95 :	3");
						ObjPool.instance.registerPool(E4Ink);
						ObjPool.instance.registerPool(E8Cloud);
						break;
					}
					default:
					{
					}
				}	
//				openShop(tempLv);
			}
			
		}
//		public static function openShop(lv:int):void{
////			trace("lv up	24:	lv:"+lv_+"	lv2:"+lv2_+"	score:"+score);
//			randItem();
//			Dialog.add("<p align=\'center\'><font color=\'#" + Css.TITLE + "\' size=\'+10\'>升级啦<br><font size=\'-2\' color=\'#" + Css.ORAN_S + "\'>Lv</font>\\<font size=\'+20\' color=\'#" + Css.ORAN_D + "\'>"+lv+"</font></font></p><br>获得道具奖励<br>\\2\\00"+prizeID+"<br>","center",50,null,Css.PAN_WORD,0,0,1,["继续呼吸", null]);
//		}
		
		public static function gameInit():void
		{
			LvUp.lv_=0;
			LvUp.lv2_=0;
			LvUp.score=LvUp.SHOP_LV[0];
			tempLv=0;
		}
		
		public static function setLv():void{
			
		}
		private static function lv():void{
			
		}
//		public static function randItem():void{
//			
////			var content:Array=Array();
//			var rand:int
//			for (var i:int=0;i<1;i++){
//				rand=Math.random()*100;
//				if(rand<40){
//					prizeID=1;//蜗牛
//				}
//				else if(rand<50){
//					prizeID=2;//闪光
//				}
//				else if(rand<75){
//					prizeID=4;//肥皂泡
//				}
//				else{
//					prizeID=5;//定时
//				}
//			}
//			buy(prizeID);
//		}
//		
//		
//		public static function buy(itemID:int):void{
//			Global.item1=itemID;
//			UI.changeItem1(itemID);
//		}
	}
}