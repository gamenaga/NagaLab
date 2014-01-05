package game
{
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	
	import naga.eff.InOut;
	import naga.eff.Shake;
	import naga.eff.Zoom;
	import naga.global.Global;
	import naga.system.Sounds;
	
	import ui.UI;
	
	
	public class ModeLevel extends Mode
	{
		public var gameUI:UI;
		public static var overX:int;
		public static var overY:int;
//		private var levelPoint:ModeLevelPoint = new ModeLevelPoint();
		private var level_id:int;//关卡ID
		private var time:int;//时间限制
		private var price:int;//过关奖励银币
		private var level_point:Array;
		private var level_point_num:int;
		
		public function ModeLevel(type:Object)
		{
			g_mode = ModeType.MODE_LEVEL;
			level_id = type.id;
			time = type.time;
			price = type.price;
			level_point = [];
			level_point[0] = type.point1;
			level_point[1] = type.value1;
			if (type.point2)
			{
				level_point[2] = type.point2;
				level_point[3] = type.value2;
				if (type.point3)
				{
					level_point[4] = type.point3;
					level_point[5] = type.value3;
				}
			}
			level_point_num = level_point.length*.5;
			super(type,true);
		}// end function 
		
		override protected function gameInit() : void
		{
//						trace("modeNormal 33:	"+Global.g_move_sp_init+"	"+Global.g_move_sp);
			if(gameUI != null){
				Global.ui_floor.removeChild(gameUI);
			}
			if (g_mode != null)
			{
				InOut.fadeIn(UI.ui_top);
				UI.ui_top.visible = true;
			}
			UI.gameInit(hp_init, HP_max_init, level_point);
			LvUp.lvChange(DataObj.data[10],0,false);
//						trace("modeNormal 43:	"+Global.g_move_sp_init+"	"+Global.g_move_sp);
			game_state = STATE_PLAY;
		}// end function
		
		override public function gameChk() : void
		{
			if(game_state == STATE_PLAY)
			{
				if(UI.task_bar.update())
				{
//					trace("modeLevel 71:完成");
					gameOver();
					DataObj.data[10] ++;
				}
				//				trace("modeLv 50",level_point[i*2],Global.m_p.getValue(level_point[i*2]),level_point[i*2+1],Global.m_p.getValue(level_point[i*2+1]));
				
				if(hp_<=0){
					//				trace("modeN 53:	",hp_);
					Sounds.play(Se_over);
					gameDeadChk();
				}
			}
			
		}// end function
		
		private function point(id:int):*
		{
//			trace(Global.m_p.getValue("score"));
			return Global.m_p.getValue("score");
		}
		
		override protected function overEff() : void
		{
//			var pos_x:int;
//			var pos_y:int;
//			pos_x = overX;//b.x + b.width * 0.5;
//			pos_y = overY;//b.y + b.height * 0.5;
//			var rec:Rectangle = new Rectangle(0, 0, Global.game_view_w, Global.game_view_h);
//			Zoom.add([Global.bg_floor , Global.g_floor, Global.eff_floor], pos_x, pos_y, rec, rec, 2000, 10);
//			Shake.add(Global.bg, 1000);
			setTimeout(gameEndScore, 500, game_type , Global.m_p.getValue("score"),"分",Score2Lv.go(Global.m_p.getValue("score"), LvScore), DataObj.data[1], ach.h_score == 1);
			
		}// end function
		
		override protected function modeChkAch() : void
		{
			//			if (ach.h_lv == 0 && DataObj.data[8] <= LvUp.lv_ && DataObj.data[5] !=0)
			//			{
			//				Bubble.instance.show(3, Global.game_view_w * 0.5, Global.game_view_h*.3, "最高等级<br><font color=\'#" + Css.ORAN_D + "\' size=\'+5\'>纪录刷新</font>", 80, Css.SIZE);
			//				ach.h_lv = 1;
			//			}
		}// end function
	}
}
