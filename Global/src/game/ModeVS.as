package game
{
	import com.qq.openapi.MttScore;
	
	import flash.utils.setTimeout;
	
	import naga.eff.Vision;
	
	
	import naga.system.Bubble;
	
	import naga.tool.Clock;
	
	public class ModeVS extends Mode
	{
		private var clock:Clock;
		public function ModeVS(mode_type:int = 2, t:int = 100, pop_type:int = 0, move_sp:Number = 1, sp_max:int = 488, sp_min:int = 188, g_type:int = 0, silver:int = 0, show_score:Boolean = true)
		{
			this.clock = new Clock();
			time = t;
			super(mode_type, pop_type, move_sp, sp_max, sp_min, g_type, silver,show_score);
		}// end function
		
		override protected function game_init() : void
		{
			this.clock.go(0, "en", 22);
			this.clock.name = "clock";
			Global.ui_floor.addChild(this.clock);
			this.clock.x = (Global.game_view_w - this.clock.width) * 0.5;
			this.clock.y = Global.game_view_h*.5 - 11;
			game_state = STATE_PLAY;
		}// end function
		
		override protected function game_play() : void
		{
			this.clock.go(Main.mode.time - TimeCount.second, "en", 22, Css.ORANGE);
			if (Global.m_p.getValue("score") > DataObj.data[4])
			{
				DataObj.data[4] = Global.m_p.getValue("score");
			}
			Main.game_menu.scores.txt("百秒冲刺<font size=\'-8\'>模式</font><br><font size=\'+20\' color=\'#" + Css.YELLOW + "\'>" + Global.m_p.getValue("score") + "</font>分<br><font size=\'-8\' color=\'#" + Css.YELL_D2 + "\'>（最高纪录：<font size=\'+1\' color=\'#" + Css.YELL_D + "\'>" + DataObj.data[4] + "</font>）</font>");
			if (TimeCount.second >= time)
			{
				if (Global.g_mode == 0)
				{
					Main.game_menu.guide_over();
				}
				else
				{
					setTimeout(game_end, 500, " 时 间 到 啦 ", "百秒冲刺<font size=\'-8\'>模式</font>", Global.m_p.getValue("score"),"分", Score2Lv.go(Global.m_p.getValue("score"), LvScore100), DataObj.data[4], ach.h_t_score == 1);
				}
				game_over();
				this.over_eff();
			}
		}// end function
		
		override protected function over_eff() : void
		{
			Vision.add("game_over", E7_curtain, 0, 0, "aaaaaa", 0.3, 4000);
		}// end function
		
		override protected function chk_mode_ach() : void
		{
			if (ach.h_t_score == 0 && DataObj.data[4] == MttScore.score && DataObj.data[4] > 2000)
			{
				Bubble.instance.show(3, Global.game_view_w * 0.5, 200, "百秒最高分<br><font color=\'#" + Css.ORAN_D + "\' size=\'+5\'>记录刷新</font>", 80, 30);
				ach.h_t_score = 1;
			}
		}// end function
		
	}
}
