package game
{
	import audio.Sounds;
	
	import eff.E1Grow;
	
	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import naga.eff.InOut;
	import naga.eff.Shake;
	import naga.eff.Vision;
	import naga.eff.Zoom;
	import naga.system.DataObj;
	
	import pop.PopFactory;
	import pop.SafeTime;
	import ui.UI;
	
	
	public class ModeO2 extends Mode
	{
		public var gameUI:UI;
		private var hpTimer:Timer=new Timer(0);
		private var hpCount:int;
		public static const HP:int=3;
		public static const HP_S:int=1;
		public static const SILVER_S:int = 700;
		
		public function ModeO2(type:String = TYPE_NORMAL, pop_type:int = 100,miss_type:int=0, move_sp:Number = 3, sp_max:int = 488, sp_min:int = 88,hp:int=HP, silver:int = 0)
		{
			g_mode = MODE_O2;
			super(type, pop_type,miss_type, move_sp, sp_max, sp_min,hp, silver,true);
		}// end function 
		
		override protected function game_init() : void
		{
			//			trace("modeNormal 39:	"+Global.g_move_sp_init+"	"+Global.g_move_sp);
			PopFactory.path=8;
			PopFactory.pathBak=8;
			if(gameUI!=null){
				Global.ui_floor.removeChild(gameUI);
			}
			if (g_mode != null)
			{
				InOut.fadeIn(UI.ui_top);
				UI.ui_top.visible = true;
			}
			UI.initHP(hp_init);
			//			trace("modeNormal 51:	"+Global.g_move_sp_init+"	"+Global.g_move_sp);
			game_state = STATE_PLAY;
		}// end function
		
		override protected function game_play() : void
		{
			if (MttScore.score > DataObj.data[4])
			{
				DataObj.data[4] = MttScore.score;
			}
			//main.game_menu.scores.txt("连击挑战<font size=\'-8\'>模式</font><br><font size=\'+20\' color=\'#" + Color.YELLOW + "\'>" + main.game_combo + "</font>分<br><font size=\'-8\' color=\'#" + Color.YELL_D2 + "\'>（最高纪录：<font size=\'+1\' color=\'#" + Color.YELL_D + "\'>" + DataObj.data[5] + "</font>）</font>");
			if(Global.HP<=0){
				Sounds.play(Se_over);
				game_over();
				over_eff();
				setTimeout(game_end, 2500, g_mode , Global.m_p.getValue("score"),"氧气",Score2Lv.go(Global.m_p.getValue("score"), LvScore), DataObj.data[1], ach.h_score == 1);
				//					Sco2lv.go(MttScore.score, Lv_score), DataObj.data[4], ach.h_combo == 1);
			}
			//			if (main.game_combo < MttScore.score)
			//            {
			//				//连击中断
			//                Sounds.play(Se_over);
			//                game_over();
			//                this.over_eff();
			//                setTimeout(game_end, 2500, " 连 击 中 断 啦 ", "连击挑战<font size=\'-8\'>模式</font>", MttScore.score,"连击", Sco2lv.go(MttScore.score, Lv_combo), DataObj.data[5], ach.h_combo == 1);
			//            }
		}// end function
		
		override protected function over_eff() : void
		{
			var pos_x:int;
			var pos_y:int;
			var b:DisplayObject = Global.eff_floor.getChildByName("bb0");
			SafeTime.isSafe = true;
//			var temp:int = 0;
//			while (temp < Global.eff_floor.numChildren)
//			{
//				if (b.name == "bb1")
//				{
					pos_x = b.x + b.width * 0.5;
					pos_y = b.y + b.height * 0.5;
//					break;
//				}
//				temp = temp + 1;
//			}
			var rec:Rectangle = new Rectangle(0, 0, Global.game_view_w, Global.game_view_h);
			Zoom.add([Global.bg_floor , Global.g_floor, Global.eff_floor], pos_x, pos_y, rec, rec, 2000, 10);
			Shake.add(Global.bg, 1000);
			Vision.add("M_combo", E1Grow, 0, 0, null, 0.8, 500,1,0,false,false,true);
		}// end function
		
		override protected function modeChkAch() : void
		{
			//			if (ach.h_lv == 0 && DataObj.data[8] <= LvUp.lv_ && DataObj.data[5] !=0)
			//			{
			//				Bubble.instance.show(3, Global.game_view_w * 0.5, Global.game_view_h*.3, "最高等级<br><font color=\'#" + Css.ORAN_D + "\' size=\'+5\'>纪录刷新</font>", 80, Css.SIZE);
			//				ach.h_lv = 1;
			//			}
		}// end function
		
		override public function changeHP(num:int):void{
			Global.HP+=num;
			if(Global.HP>=0 && num<0){
				//				hpCount=4-Global.HP;
				//				trace(Global.HP+"   "+num+"    "+i);
				for(var i:int=0;i<-num;i++){
					//					trace("mode 359   :    "+Global.HP+"   "+num+"    "+i);
					UI.hpBar.hpPic[Global.HP-i].visible=false;
				}
				//				trace(hpCount);
				//				hpTimer.stop();
				//				if(hpTimer.hasEventListener(TimerEvent.TIMER)){
				//					hpTimer.removeEventListener(TimerEvent.TIMER,hpDown);
				//				}
				//				hpTimer.addEventListener(TimerEvent.TIMER,hpDown);
				//				hpTimer.repeatCount=hpTimer.currentCount-num;
				//				trace("mode 363     :    "+hpCount+"    "+hpBar.hp[hpCount]+"    "+hpTimer.currentCount+"    "+hpTimer.repeatCount)
				//				hpTimer.start();
			}
			else{
				hpCount=0;
				hpTimer.addEventListener(TimerEvent.TIMER,hpUp);
				hpTimer.start();
				function hpUp():void{
					if(Global.HP>hpCount+1 && UI.hpBar.hpPic[hpCount].visible){
						InOut.fadeIn(UI.hpBar.hpPic[hpCount]);
					}
					hpCount++;
				}
			}
		}
		
		private function hpDown(e:TimerEvent):void{
			//			trace("mode 380     :    "+hpCount+"    "+hpBar.hp[hpCount]+"    "+hpTimer.currentCount+"    "+hpTimer.repeatCount)
			//			if(Global.HP<hpCount+1 && hpBar.hp[hpCount].visible){
			//				E5_move.add(hpBar.hp[hpCount],10,0,-20,1.5,0.1);
			//			}
			UI.hpBar.hpPic[hpCount].visible=false;
			hpCount--;
		}
	}
}
