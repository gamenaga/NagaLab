package game
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.system.System;
	import flash.utils.setTimeout;
	
	import activity.GiftEveryHour;
	
	import audio.Bgm;
	import audio.Music;
	
	import item.I11O2Time;
	import item.I2Clear;
	import item.I4AddPop;
	import item.I8Fog;
	
	import naga.eff.InOut;
	import naga.eff.Vision;
	import naga.global.Css;
	import naga.global.Global;
	import naga.system.Bubble;
	import naga.system.EventManager;
	import naga.system.Sounds;
	import naga.ui.Dialog;
	
	import pop.Pop;
	import pop.PopFactory;
	import pop.SafeTime;
	
	import ui.HpBar;
	import ui.UI;
	
	public class Mode extends Sprite
	{
		public var g_mode:String;
		public var game_state:int;
		public var hp_init:int;//生命初始化值
		public var hp_:int;//当前生命值/机会次数
		public var HP_max:int;
		public var HP_max_init:int;
		public var game_type:String;
		public var relive_times:int;
		public var relive_silver_init:int;
		public var relive_silver:int;
		public const STATE_TITLE:int = 1;
		public const STATE_INIT:int = 2;
		public const STATE_PLAY:int = 3;
		public const STATE_STOP:int = 4;
		public const STATE_OVER:int = 5;
		public const STATE_END:int = 6;
		public var ach:Object= {};
		public var clear_quest:Boolean;//任务完成，完成任务后，进入休整
//		public const SILVER_COMBO_S:int = 800;
//		public const SILVER_TIME100_S:int = 1000;
//		public const SILVER_RELIVE:int = 1000;
		protected var delay:int;
		public var bomb_time:int;
		public var bomb_gap:int;
//		public var game_combo:int;//连击数
		public var game_combo_level:int;
		public var temp_combo_lv:int;
//		public var hi_combo:int;
		public var mu_combo:int;
//		public var game_seckill:int;//秒杀数
		public var game_seckill_combo:int;//秒杀连击数
		
		public function Mode(type:Object, show_score:Boolean = false)
		{
			
//						trace("mode 61:	type "+type);
			init(type);
			gameReady();
		}// end function
		/**
		 *初始化TYPE参数 
		 * @param type 同一模式下的不同TYPE信息（目前2个模式 仅仅是“生存模式” 的 普通TYPE 和 达人TYPE）
		 * 
		 */		
		public function init(type:Object):void
		{
			game_type = type.name;//二级类型  如 连击模式"加强版"
			Global.g_move_sp_init=type.move_sp *.1;
			Global.g_move_sp_max=type.move_sp_max *.1;
			//			g_move_sp_init = move_sp;
			PopFactory.modeInit(type.create_delay_min, type.create_delay_max, type.pop_type, type.item_type);
//			trace("mode 70:");
			//			Global.show_score = show_score;
			HP_max = HP_max_init = type.hp;
			hp_init=type.hp;
			hp_=type.hp;
//						trace("mode 90:",hp_);
			relive_times = type.relive_times
			relive_silver = type.relive_silver;
			relive_silver_init = type.relive_silver;
		}
		
		protected function game_loop() : void
		{
//			trace(1);
			switch(game_state)
			{
//				case STATE_TITLE:
//				{
//					gamePlay();
//					break;
//				}
				case STATE_INIT:
				{
					gameInit();
					break;
				}
				case STATE_PLAY:
				{
					gameChk();
					break;
				}
				case STATE_STOP:
				{
					gameStop();
					break;
				}
				default:
				{
				}
			}
		}// end function
		
		public function gameReady() : void
		{
			Global.bg.initGame(game_type);
			PopFactory.gameInit();
			//泡泡弹力系数初始化
			Global.spring = .1;//加速度
			Global.vx = .014;
			Global.vy = -.015;
			Global.friction = .97;//摩擦力作用
			//等级初始化
			LvUp.gameInit();
			//获取最高分数据
			if(DataObj.data != null)
			{
				UI.changeHighScore(DataObj.data[1]);//定位——最高纪录在一开始不会更新，显示位置需要先进行一次确定。
			}
			//初始化成就属性 
			if(DataObj.data[1] >0)
			{//如果最高分成就>0  表示不是第一次玩游戏
				ach = {h_score:0, h_time:0, h_t_score:0, h_combo:0, g_combo:0, bg_lv:0,g_pop_num:DataObj.data[11] + DataObj.data[12],h_lv:0};
			}
			else
			{//第一次玩，不检测成就。
				ach = {h_score:1, h_time:1, h_t_score:1, h_combo:1, g_combo:0, bg_lv:0,g_pop_num:DataObj.data[11] + DataObj.data[12],h_lv:0};
			}
			//h_prize:判断最高分是否播报
			//g_pop_num:记录消除泡泡总数的进展
			//score_prize:记录分数奖励的进展
//			Global.m_p.getValue("score") = 0;
			Global.m_p.setValue("score",0);
			bomb_time = 1;
			bomb_gap = 1;
			Global.m_p.setValue("combo",0);
//			game_combo = 0;
			mu_combo = 0;
			game_combo_level = 0;
			temp_combo_lv = 0;
			Global.m_p.setValue("hi_combo",0);
			mu_combo = 0;
			Global.m_p.setValue("seckill",0);
//			game_seckill = 0;
			game_seckill_combo = 0;
			//			UI.btnItem1.visible=false;//隐藏道具栏
			if (g_mode != null)
			{
				MyHeart.go();
				//泡泡移动速度初始化
				Global.g_move_sp_bak = Global.g_move_sp_init;
				Global.g_move_sp = Global.g_move_sp_init;
				Global.g_move_sp_lv = 1;
//				trace("mode 141:	"+Global.g_move_sp_init+"	"+Global.g_move_sp);
//				Global.g_move_sp = 0;
				I8Fog.over();
				Vision.instance.remove_all(Global.eff_floor);
				Bgm.end();
				Sounds.play(Se_begin, 0, 0.4);
				Global.play_times ++;
				I2Clear.go(10);
				PopFactory.pause(1000,I4AddPop.go,1000,PopFactory.PATH_DOWN);
				//				扣银币
////				Bubble.instance.show("\\1\\011<br><font size=\'+1\' color=\'#" + Css.SILVER + "\'>-100</font>", Bubble.TYPE_MONEY,Global.gameStage.mouseX, Global.gameStage.mouseY-Css.SIZE*3, 100,Css.SIZE, Css.SILV_S);
//				if (game_silver > 0 && DataObj.data[2] >= game_silver)
//				{
//					DataObj.data[2] = DataObj.data[2] - game_silver;
//					Bubble.instance.show("\\2\\011<br><font size=\'-"+Css.SIZE*.1+"\' color=\'#" + Css.SILVER + "\'>-" + game_silver + "</font>", Bubble.TYPE_MONEY,Global.gameStage.mouseX, Global.gameStage.mouseY-Css.SIZE*3, 100,Css.SIZE*1.5, Css.SILV_S);
////					Bubble.instance.show("\\1\\011<br><font size=\'-"+Css.SIZE*.1+"\' color=\'#" + Css.SILVER + "\'>-" + game_silver + "</font>", Bubble.TYPE_MONEY,Global.gameStage.mouseX, Global.gameStage.mouseY-Css.SIZE*3, 100,Css.SIZE, Css.SILV_S);
//						//第二次以后，扣银币减半
////					game_silver = game_silver_init * 0.5;
//				}
			}
			else{
				Global.g_move_sp_bak = Global.g_move_sp_init*.3;
				Global.g_move_sp = Global.g_move_sp_init*.3;
			}
			
			if (!hasEventListener(Event.ENTER_FRAME))
			{
//				trace("mode 202:	add event");
				EventManager.AddOnceEventFn(this,Event.ENTER_FRAME, game_loop);
			}
			game_state = STATE_INIT;
		}// end function
		
		public function chkAch() : void
		{
			var achText:String;
			if (ach.h_time == 0 && DataObj.data[3] <= MyHeart.seconds && DataObj.data[6] !=0)
			{
				if(Global.language == 1)
				{
					achText = "<font color=\'#" + Css.ORAN_S + "\' size=\'+"+Css.SIZE*.2+"\'>单局最高时长</font><br>新纪录 诞生<b>!</b>";
				}
				else
				{
					achText = "<font color=\'#" + Css.ORAN_S + "\' size=\'+"+Css.SIZE*.2+"\'>Longest-Time</font><br>New Record!";
				}
				showAch(achText);
				ach.h_time = 1;
			}
//			trace("mode 208:	"+ach.h_score+"	"+DataObj.data[1]+"	"+Global.m_p.getValue("score"));
			if (ach.h_score == 0 && DataObj.data[1] <= Global.m_p.getValue("score"))
			{
				if(Global.language == 1)
				{
					achText = "<font color=\'#" + Css.ORAN_S + "\' size=\'+"+Css.SIZE*.3+"\'>最高分</font><br>新纪录 诞生<b>!</b>";
				}
				else
				{
					achText = "<font color=\'#" + Css.ORAN_S + "\' size=\'+"+Css.SIZE*.3+"\'>Hi-Score</font><br>New Record!";
				}
				showAch(achText);
				ach.h_score = 1;
			}
			if (ach.h_combo == 0 && DataObj.data[5] <= Global.m_p.getValue("combo") && DataObj.data[5] !=0)
			{
				if(Global.language == 1)
				{
					achText = "<font color=\'#" + Css.ORAN_S + "\' size=\'+"+Css.SIZE*.3+"\'>连击数</font><br>新纪录 诞生<b>!</b>";
				}
				else
				{
					achText = "<font color=\'#" + Css.ORAN_S + "\' size=\'+"+Css.SIZE*.3+"\'>Hi-Combo</font><br>New Record!";
				}
				showAch(achText);
				ach.h_combo = 1;
			}
			modeChkAch();
		}
		
		private function showAch(achText:String):void
		{
			Bubble.instance.show(achText, Bubble.TYPE_ACH, Global.game_view_w * 0.5, Global.game_view_h*.3, 180, Css.SIZE*1.5,null,true);
		}
		
		protected function modeChkAch() : void
		{
		}// end function
		
		//各不同模式，有不同的初始化内容。
		protected function gameInit() : void
		{
		}// end function
		
		public function gameChk() : void
		{
		}// end function
		
		public function scores() : void
		{
			//保存纪录
			if (Global.m_p.getValue("combo") > DataObj.data[5])
			{
				DataObj.data[5]=Global.m_p.getValue("combo");//更新最高连击纪录
			}
			if (Global.m_p.getValue("score") > DataObj.data[1])
			{
				DataObj.data[1] = Global.m_p.getValue("score");//更新最高分
			}
			//分数更新
			UI.changeScore(Global.m_p.getValue("score"));
//			trace("mode 276:	"+ach.h_score+"	"+DataObj.data[1]);
			if(ach.h_score == 1)
			{
				UI.changeHighScore(DataObj.data[1]);
			}
				
		}// end function
		
		public function combo_over() : void
		{
			//			mu_combo = 0;
			Global.m_p.setValue("combo",0);
			//			I1_sp_down.change_speed(Global.g_sp + (Global.g_sp_max - Global.g_sp) * 0.1);
			chk_score();
			
			Global.bg.prev();
			//			LvUp.lvChange(0,-1);
		}// end function
		
		public function chk_score(pos_x:int = 0, pos_y:int = 0, score:int = 0) : void
		{
			//			trace("main 192:	"+Math.round(Math.random() +.45));
			scores();//分数更新
			//			当连击等级不为5时  进行等级变化
			//			if (game_combo_level != 5)
			//			{
			if (Global.m_p.getValue("combo") < 25)
			{
				game_combo_level = 0;
			}
			else if (Global.m_p.getValue("combo") < 55)
			{
				game_combo_level = 1;
			}
			else if (Global.m_p.getValue("combo") < 95)
			{
				game_combo_level = 2;
			}
			else if (Global.m_p.getValue("combo") < 155)
			{
				game_combo_level = 3;
			}
			else if (Global.m_p.getValue("combo") < 255)
			{
				game_combo_level = 4;
			}
			else
			{
				game_combo_level = 5;
			}
			
			if (game_combo_level != temp_combo_lv)
			{//等级发生变化时，改变场上eff
				//					移动速度>0时 速度变化，否则仅 备份速度变化 。
				//					Global.g_move_sp_bak = game_combo_level * 0.1 + Global.g_move_sp_init;
				if (Global.g_move_sp > 0)
				{
					//						trace("main 228:	"+Global.g_move_sp+"	"+Global.g_move_sp_bak);
					Global.g_move_sp =	Global.g_move_sp_bak;
				}
				
				//					如果场上有等级特效，先清除
				if (Global.eff_floor.getChildByName("Combo" + temp_combo_lv))
				{
					Vision.instance.remove("Combo" + temp_combo_lv);//,Global.eff_floor);
				}
				
				//					等级特效
				if (game_combo_level == 0)
				{
				}
				else if (game_combo_level == 1)
				{
					//						Sounds.play(Se_lv_up);
					//						E1_vision.add("Combo1", E1_grow, 0, 0, "FFFF99", 0.2, 0, 1, true, true);
					Bubble.instance.show("<font size=\'"+Css.SIZE*1.5+"\' color=\'#"+Css.YELLOW+"\'>Good</font><br>Combo", "ComboDash", pos_x, pos_y, 180, Css.SIZE*1.2);
					//						E1_vision.add("i006", E3FlashPoint, pos_x, pos_y,null,1, 500,3);
				}
				else if (game_combo_level == 2)
				{
					//						Sounds.play(Se_lv_up);
					//						E1_vision.add("Combo2", E1_grow, 0, 0, "FFCC66", 0.2, 0, 1, true, true);
					Bubble.instance.show("<font size=\'"+Css.SIZE*1.6+"\' color=\'#"+Css.YELLOW+"\'>Very Good</font><br>Combo", "ComboDash", pos_x, pos_y, 180, Css.SIZE*1.3);
					//						E1_vision.add("i006", E3FlashPoint, pos_x, pos_y,null, 1, 500,4);
				}
				else if (game_combo_level == 3)
				{
					//						Sounds.play(Se_lv_up);
					//						E1_vision.add("Combo3", E1_grow, 0, 0, "FF3388", 0.2, 0, 1, true, true);
					Bubble.instance.show("<font size=\'"+Css.SIZE*1.7+"\' color=\'#"+Css.ORAN_S+"\'>Wonderful</font><br>Combo", "ComboDash", pos_x, pos_y, 180, Css.SIZE*1.4);
					//						E1_vision.add("i006", E3FlashPoint, pos_x, pos_y,null, 1, 500,5);
				}
				else if (game_combo_level == 4)
				{
					//						Sounds.play(Se_lv_up);
					//						E1_vision.add("Combo4", E1_grow, 0, 0, "663399", 0.25, 0, 1, true, true);
					Bubble.instance.show("<font size=\'"+Css.SIZE*1.8+"\' color=\'#"+Css.ORAN_S+"\'>Perfect</font><br>Combo", "ComboDash", pos_x, pos_y, 180, Css.SIZE*1.5);
					//						E1_vision.add("i006", E3FlashPoint, pos_x, pos_y,null, 1, 500,6);
				}
				else if (game_combo_level == 5)
				{
					//						Sounds.play(Se_lv_up);
					//						E1_vision.add("Combo5", E1_grow, 0, 0, "ff3333", 0.25, 0, 1, true, true);
					Bubble.instance.show("<font size=\'"+Css.SIZE*2+"\' color=\'#"+Css.R_D+"\'>Crazy!</font><br>Combo", "ComboDash", pos_x, pos_y, 180, Css.SIZE*1.6);
					//						E1_vision.add("i006", E3FlashPoint, pos_x, pos_y,null, 1, 500,7);
				}
				//					临时等级更新，作为等级改变的判断
				temp_combo_lv = game_combo_level;
			}
			else if(PopFactory.state != 2)
			{//等级未发生变化时。。。
				show_sc(score);
			}
			//			}
			//			else
			//			{//当前等级=5时
			//				show_sc(score);
			//			}
			function show_sc(score:int):void{
				//				if (game_combo != 0 && game_combo % 10 == 0)
				var size:int;
				size = (game_combo_level + 6) * Css.SIZE*.1 + Css.SIZE * .7;
				var combo_num:int = Global.m_p.getValue("combo");
				if( game_seckill_combo >=1)
				{
					if ( combo_num >2)
					{
						Bubble.instance.show("<font size=\'" + size*1.2 + "\' color=\'#" + Css.YELLOW + "\'>" + combo_num + "</font><br><b>Sec<br>Kill</b>", "secKill", pos_x, pos_y, 180,size*.8 , Css.R_D);
					}
					else
					{
						Bubble.instance.show("<b>Sec<br>Kill</b>", "secKill", pos_x, pos_y, 180,size*.8, Css.R_D);
					}
						
				}
				else if (combo_num >2)
				{//连击数提示
//					size = (game_combo_level + 6) * Css.SIZE*.1 + Css.SIZE * .7;
					Bubble.instance.show("<font size=\'" + size + "\' color=\'#" + Css.YELLOW + "\'>" + combo_num + "</font><br><b>Combo</b>", Bubble.TYPE_SCORE, pos_x, pos_y, 180,size*.6, Css.ORAN_S);
					//记录单局最高连击数
					if(Main.mode.ach.g_combo < Global.m_p.getValue("combo"))
					{
						Main.mode.ach.g_combo = Global.m_p.getValue("combo");
						//					trace("main	365	:	x:"+pos_x+"	y:"+pos_y+"	game_combo:"+game_combo);
					}
				}
				//				else if (Global.show_score && score != 0)//Global.is_hd  && score > 0 &&  && Main.mode.game_type == 0
				//				{//高清、显得分、得分>0、清理道具未启动、游戏为标准模式   时   得分提示
				//					Bubble.instance.show(4, pos_x, pos_y, "<font size=\'" + (game_combo_level + 8) * 6 + "\' color=\'#" + Css.BL_D2 + "\'>" + score + "</font>");
				//				}
			}
			
			//			检测分数更换背景 每5000换1次
			//						trace("main 306:	"+Global.m_p.getValue("score")+"	"+Global.m_p.getValue("score")/100+"	"+Main.mode.ach.bg_lv);
			if (Global.m_p.getValue("score")/1000 > Main.mode.ach.bg_lv+1)
			{//数量大于成就记录数量
//								trace("main 425:	Main.mode.ach.bg_lv:"+Main.mode.ach.bg_lv);
				Main.mode.ach.bg_lv ++;
				
				
			}
			
			//			泡泡数量成就
			var num:int = DataObj.data[11] + DataObj.data[12] + DataObj.data[13] + DataObj.data[14];
			//			trace("main 357:	"+num+"		"+Main.mode.ach.g_pop_num);
			if (num > Main.mode.ach.g_pop_num && num>100)// && Global.g_mode>0)
			{//数量大于成就记录数量
				if(num % 1000 == 3 || (num < 1000 && num % 100 == 3) || (num < 10000 && num % 500 == 3))
				{
					Main.mode.ach.g_pop_num = num;
					if(Global.language == 1)
					{
						Bubble.instance.show("<b>泡泡成就</b><br><font size=\'"+Css.SIZE*2+"\' color=\'#" + Css.YELL_D2 + "\'>" + int((num - 3) * 0.01) * 100 + "</font><b>个<br>达成</b>", Bubble.TYPE_ACH, Global.game_view_w * 0.5, Global.game_view_h*.3, 180, Css.SIZE*1.5, Css.ORAN_S,true);
					}
					else
					{
						Bubble.instance.show("<b>Pop Clean</b><br><font size=\'"+Css.SIZE*2+"\' color=\'#" + Css.YELL_D2 + "\'>" + int((num - 3) * 0.01) * 100 + "</font>", Bubble.TYPE_ACH, Global.game_view_w * 0.5, Global.game_view_h*.3, 180, Css.SIZE*1.5, Css.ORAN_S,true);
					}
				}
			}
			
			gameChk();
		}// end function
		
		
		protected function modeScores():void{
			
		}
		
		protected function gameStop() : void
		{
		}// end function
		
		//游戏死亡确认（给玩家继续的选择权）
		protected function gameDeadChk() : void
		{
			game_state = STATE_OVER;
			if(DataObj.data[2] >= relive_silver)
			{
			Dialog.add("糟糕！红心\\1\\010耗尽……" +
				"<br><br>想使用 银币\\1\\011<font size=\'-"+Css.SIZE*.1+"\' color=\'#" + Css.SILVER + "\'>" + relive_silver + "</font>恢复 红心\\1\\010吗？" +
				"<br><br>（银币\\1\\011余额<font size=\'-"+Css.SIZE*.1+"\' color=\'#" + Css.SILVER + "\'>" + DataObj.data[2] + "</font>）"
				,null,0,null,null,0,0,0,0,0,["是",gameRelive,"否",gameOver]);
			}
			else
			{
				gameOver();
			}
		}
		
		//游戏重生
		protected function gameRelive() : void
		{
			game_state = STATE_PLAY;
			I2Clear.go(10);
			PopFactory.changeMoveSp(Global.g_move_sp_bak*.8);
//			game_state = STATE_PLAY;
			DataObj.data[2] = DataObj.data[2] - relive_silver;
			Bubble.instance.show("\\2\\011<br><font size=\'+1\' color=\'#" + Css.SILVER + "\'>-" + relive_silver + "</font>", Bubble.TYPE_MONEY,Global.game_view_w*.5, Global.game_view_h*.3, 100, Css.SIZE, Css.SILV_S);
			HpBar.changeHP(1);
		}
		
		//游戏结束
		public function gameOver() : void
		{
			game_state = STATE_OVER;
//			EventManager.delEventFn(Global.ui_floor.stage,KeyboardEvent.KEY_DOWN,I11O2Time.go);
			I8Fog.over();
			Global.g_move_sp_bak = Global.POP_MOVE_SP_SLOW;
			Global.g_move_sp = Global.POP_MOVE_SP_SLOW;
			
			var temp:int = 0;
			temp = Global.g_floor.numChildren - 1;
			while (temp > 1)
			{
				
				if (Global.g_floor.numChildren > temp && Global.g_floor.getChildAt(temp)){
					if((Global.g_floor.getChildAt(temp) as Pop).items != null)
					{
						(Global.g_floor.getChildAt(temp) as Pop).items.itemCut();
					}
				}
				temp --;
			}
			
//			EventManager.delEventFn(this,Event.ENTER_FRAME, game_loop);
//			if (Global.m_p.getValue("score") > DataObj.data[1])
//			{
//				DataObj.data[1] = Global.m_p.getValue("score");
//			}
			SafeTime.isSafe = true;
			overEff();
			
		}// end function
		
		//退回主菜单
		public function gameExit() : void
		{
			GiftEveryHour.getSilver();
			Global.g_time = Global.g_time + MyHeart.seconds;
			MyHeart.stop();
			Main.game_menu.f_upload_data(false, Global.m_p.getValue("hi_combo"));//is_new);
		}
		
		protected function overEff() : void
		{
		}// end function
		
		//游戏结算
		protected function gameEndScore(gameType:String, score:int, u:String,lv:String, hi:int, is_new:Boolean) : void
		{
			InOut.fadeOut(UI.ui_top, false);
			Bgm.end();
			Sounds.play(Se_ending);
			System.gc();
			Global.g_move_sp_bak = Global.POP_MOVE_SP_SLOW;
			Global.g_move_sp = Global.POP_MOVE_SP_SLOW;
			
			var str_tp:String = "";
			if (Global.play_times % 3 == 0)
			{
				str_tp = "<br><font size=\'-"+Css.SIZE*.1+"\' color=\'#" + Css.ORANGE + "\'><b>友情提示</b>：</font><br><font size=\'-"+Css.SIZE*.2+"\'>  您已经连续玩了<b>3</b>局，<br>  为了健康，<br>  请转转脖子吧。</font><br>";
			}
			else if (Global.play_times % 2 == 0 && Global.m_p.getValue("score")>DataObj.data[7]*DataObj.data[7]*500 && DataObj.data[7] < Music.music.length - 1)
			{//有几率 增加新音乐
				var mu_num:int = DataObj.data[7] + 1;
				DataObj.data[7] = mu_num;
				str_tp = "<br><font size=\'-"+Css.SIZE*.1+"\'><b>恭喜！</b><font color=\'#" + Css.ORANGE + "\'>获得 “新乐曲”</font><b>!</b></font><br><font size=\'-"+Css.SIZE*.2+"\'>点击泡泡时的音符<br>将更美妙</font><br>";
			}
			else if (Global.total_time < int(Global.g_time / 7200))
			{
				Global.total_time = int(Global.g_time / 7200);
				str_tp = "<br><font size=\'-"+Css.SIZE*.1+"\' color=\'#" + Css.ORANGE + "\'><b>友情提示</b>：</font><br><font size=\'-"+Css.SIZE*.2+"\'>  您连续玩<b>30</b>分钟了，<br>  爱护眼睛，<br>  请闭目<b>10</b>秒吧。</font><br>";
			}
			else
			{
				str_tp = "游戏结束！"
			}
			
			
			var npcID:int;
//			trace("mode 345:	",score);
			if(score<LvScore.D_)
			{npcID=3;}
			else if(score<LvScore.C_)
			{npcID=4;}
			else if(score<LvScore.B_)
			{npcID=5;}
			else if(score<LvScore.S)
			{npcID=6;}
			else
			{npcID=7;}
			Dialog.add(str_tp,null,Css.SIZE,null,Css.PAN_WORD,0,0,25,0,npcID);
			
			
			str_tp = null;
			
			var str_sil:String;
			//获得银币=氧气分数*0.1+连击分数;
			var get_silver:int=Global.m_p.getValue("score") * 0.1 + ach.g_combo;
			DataObj.data[2] = DataObj.data[2] + get_silver;
			if(Global.language == 1)
			{
				str_sil = "<font size=\'-"+Css.SIZE*.5+"\'>银币\\1\\011获得：<font size=\'+1\' color=\'#" + Css.SILVER + "\'>" + get_silver + "</font>个</font>";
			}
			else
			{
				str_sil = "<font size=\'-"+Css.SIZE*.5+"\'>银币\\1\\011获得：<font size=\'+1\' color=\'#" + Css.SILVER + "\'>" + get_silver + "</font>个</font>";
			}
			
			var str_hi:String;
			if (is_new)
			{//如果当前模式记录有更新（非全部记录）
				if(Global.language == 1)
				{
					str_hi = "<font size=\'-"+Css.SIZE*.5+"\' color=\'#" + Css.R_D + "\'>新纪录诞生！</font>";
				}
				else
				{
					str_hi = "<font size=\'-"+Css.SIZE*.5+"\' color=\'#" + Css.R_D + "\'>New Record!</font>";
				}
			}
			else
			{
				if(Global.language == 1)
				{
					str_hi = "<font size=\'-"+Css.SIZE*.8+"\' color=\'#" + Css.R_D + "\'>（最高纪录：<font size=\'+"+Css.SIZE*.1+"\' color=\'#" + Css.RED + "\'>" + hi + "</font>）</font>";
				}
				else
				{
					str_hi = "<font size=\'-"+Css.SIZE*.8+"\' color=\'#" + Css.R_D + "\'>(Hi-Score: <font size=\'+"+Css.SIZE*.1+"\' color=\'#" + Css.RED + "\'>" + hi + "</font>)</font>";
				}
//				if (this.ach.h_combo == 1)
//				{
//					main.game_menu.f_submit();
//				}
			}
			//结算面板
			if(Global.language == 1)
			{
				Main.game_menu.scores.reTxt("<b>"+gameType + "</b><br><font size=\'"+Css.SIZE*2+"\' color=\'#" + Css.YELLOW + "\'>" + score + "</font>"+u+" \<font size=\'+"+Css.SIZE+"\'>" + lv + "</font><br>" + str_hi + "<br><br>" + str_sil);
//				Main.game_menu.createScore("<b>"+gameType + "</b><br><font size=\'"+Css.SIZE*2+"\' color=\'#" + Css.YELLOW + "\'>" + score + "</font>"+u+" \<font size=\'+"+Css.SIZE+"\'>" + lv + "</font><br>" + str_hi + "<br><br>" + str_sil);
			}
			else
			{
//				Main.game_menu.scores.txt("<b>"+gameType + "</b><br><font size=\'"+Css.SIZE*2+"\' color=\'#" + Css.YELLOW + "\'>" + score + "</font>"+u+" \<font size=\'+"+Css.SIZE+"\'>" + lv + "</font><br>" + str_hi + "<br><br>" + str_sil);
			}
			if (Main.game_menu.menu_type != Main.game_menu.MENU_main)
			{
				//				trace("mode 313:	game over!");
				Main.game_menu.show(Main.game_menu.MENU_OVER);
			}
			gameExit();
		}// end function
		
//		public function delLoop():void
//		{
//			if (hasEventListener(Event.ENTER_FRAME))
//			{
//				EventManager.delEventFn(this,Event.ENTER_FRAME, game_loop);
//			}
//		}
	}
}

