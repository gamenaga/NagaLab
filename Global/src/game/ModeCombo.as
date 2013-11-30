package game
{
	import audio.Sounds;
	
	import com.qq.openapi.MttScore;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	
	import naga.eff.Vision;
	import naga.eff.Shake;
	import naga.eff.Zoom;
	import naga.system.Bubble;
	

    public class ModeCombo extends Mode
    {
		public function ModeCombo(mode_type:int = 1, pop_type:int = 0,miss_type:int=1, move_sp:Number = 3, sp_max:int = 488, sp_min:int = 188, g_type:int = 0, silver:int = 0)
        {
            super(mode_type, pop_type,miss_type, move_sp, sp_max, sp_min, g_type, silver,true);
        }// end function

        override protected function game_init() : void
        {
            Main.game_combo = 1;
            MttScore.score = 1;
            game_state = STATE_PLAY;
			Global.HP=3;
			hpBar.getHP();
			gameUI.addChild(hpBar);
			hpBar.x=30;
			hpBar.y=30;
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
				this.over_eff();
				setTimeout(game_end, 2500, "机 会 耗 尽", "普通模式", Global.m_p.getValue("score"),"氧气",Score2Lv.go(Global.m_p.getValue("score"), LvScore100), DataObj.data[4], ach.h_t_score == 1);
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
            var b:DisplayObject;
            Global.touch_pan.visible = true;
			var temp:int = 0;
            while (temp < Global.eff_floor.numChildren)
            {
                b = Global.eff_floor.getChildAt(temp);
                if (b.name == "bb1")
                {
                    pos_x = b.x + b.width * 0.5;
                    pos_y = b.y + b.height * 0.5;
                    break;
                }
                temp = temp + 1;
            }
            var rec:Rectangle = new Rectangle(0, 0, Global.game_view_w, Global.game_view_h);
            Zoom.add([Global.g_floor, Global.eff_floor], pos_x, pos_y, rec, rec, 2000, 10);
            Shake.add(Main.bg, 1000);
            Vision.add("M_combo", E1_grow, 0, 0, null, 0.8, 500);
        }// end function

        override protected function modeChkAch() : void
        {
            if (ach.h_combo == 0 && DataObj.data[5] == Main.game_combo && DataObj.data[5] > 50)
            {
                Bubble.instance.show(3, Global.game_view_w * 0.5, 200, "连击挑战分<br><font color=\'#" + Css.ORAN_D + "\' size=\'+5\'>记录刷新</font>", 80,Css.SIZE);
                ach.h_combo = 1;
            }
        }// end function
    }
}
