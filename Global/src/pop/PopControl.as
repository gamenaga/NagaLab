package pop
{
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	
	import game.Mode;
	
	import naga.eff.Vision;
	import naga.global.Css;
	import naga.global.Global;
	import naga.system.Bubble;
	import naga.system.Sounds;

	public class PopControl
	{
		
		public function PopControl()
		{
		}
		
		//		private function click_pop(event:PressAndTapGestureEvent):void
//		public function click_pop(event:TouchEvent):void
		public function click_pop(event:MouseEvent) : void
		{
			//			testTF.text=Global.g_floor.numChildren+"	"+blue_pop+"	"+red_pop+"	"+black_pop+"\nclick!   "+event.target+"	3"+event.target.name;
			//			trace("main 136:	"+SafeTime.isSafe);
//						trace("main 138:	target:"+event.currentTarget+"	"+event.target+"	target.parent:"+event.target.parent);
			var dis:Number = NaN;//触电离泡泡圆心的距离
			if (Main.mode.game_state==Main.mode.STATE_PLAY && event.target.parent is Pop)
			{
				//				testTF.appendText("		good ");
				event.target.parent.bombClick();
				//				Bubble.instance.show(1, root.mouseX, root.mouseY, "<b>囧2</b>", 60, 60, Css.SILV_S);
				//				水渍
				//				dis = Math.sqrt(Math.pow(event.target.x - root.mouseX, 2) + Math.pow(event.target.y - root.mouseY, 2));
				//				trace("main 197:	dis:"+dis+" / "+event.target.pic.width*5);
				//				if (dis > 80)
				//				{
				//					E1_vision.add("water" + event.target.parent.num, E4Water, root.mouseX, root.mouseY, null, Math.random() * 0.3 + 0.5, 3000,1.2);
				//					Sounds.play(Se_bia, 0, 0.2);
				//				}
			}
				//如果没有点到任何东西
			else if(!SafeTime.isSafe)
			{
				//				testTF.appendText("		ho no");
				panComboOver();
				//				trace("main 186	:	miss	"+event.target.parent.parent);
			}
			if(Global.mouse)
			{
				Global.mouse.BC.gotoAndStop(2);
			}
//			Global.gameStage.removeEventListener(TouchEvent.TOUCH_BEGIN, click_pop);
//			Global.gameStage.removeEventListener(MouseEvent.MOUSE_DOWN, click_pop);
			//			EventManager.delEventFn(Global.gameStage,MouseEvent.MOUSE_DOWN, click_pop);
//			Global.gameStage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			//			EventManager.AddEventFn(Global.gameStage,MouseEvent.MOUSE_UP, mouseUp);
			//			stage.addEventListener(KeyboardEvent.KEY_DOWN,UI.go);
		}// end function
		
//		private function mouseUp(event:MouseEvent):void
//		{
//			if(Global.mouse)
//			{
//				Global.mouse.BC.gotoAndStop(1);
//			}
//			Global.gameStage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
//			Global.gameStage.addEventListener(MouseEvent.MOUSE_DOWN, click_pop);
//			//			EventManager.delEventFn(Global.gameStage,MouseEvent.MOUSE_UP, mouseUp);
//			//			EventManager.AddEventFn(Global.gameStage,MouseEvent.MOUSE_DOWN, click_pop,null,false);
//		}
		
		//击空处理
		//		protected function panMiss(event:MouseEvent) : void
		//		{
		//			//			trace("main 155:	囧");
		////			Chk_first.chk(54, "<p align=\'center\'><font color=\'#" + Color.TITLE + "\' size=\'+10\'>Miss</font></p><br>1 .触摸到<b>\"</b>空白处<b>\"</b><br><br>2 .击中了红泡泡<br><br><b>PS: </b>囧=<b>Miss</b><br>（是不是其他部位触到屏幕了？）", Global.g_mode > -1);
		//			E2_shake.add(bg, 300);
		//			Sounds.play(Se_bad);
		//			Bubble.instance.show(1, root.mouseX, root.mouseY, "<b>Miss</b>", 60, 60, Css.SILV_S);
		//			E1_vision.add("miss" + getTimer(), E2_bomb, root.mouseX, root.mouseY, null, 1, 1, 0.3);
		//			panComboOver();
		//		}// end function
		private function panComboOver() : void
		{
			//			trace("main 155:	囧");
			//			Shake.add(Global.bg,500,10);
			Sounds.play(Se_bad,0,0.3);
			if(Main.mode.game_combo >=3)
			{
				Bubble.instance.show("Miss", "PanMiss", Global.gameStage.mouseX, Global.gameStage.mouseY, 160, Css.SIZE*1.5, Css.SILVER);
			}
			Main.mode.combo_over();
		}// end function
		
		public function activateClick():void
		{
			//			Global.gameStage.addEventListener(PressAndTapGestureEvent.GESTURE_PRESS_AND_TAP, click_pop);
//			if(!Global.gameStage.hasEventListener(TouchEvent.TOUCH_BEGIN))
//			{
//				Global.gameStage.addEventListener(TouchEvent.TOUCH_BEGIN, click_pop);
//			}
			if(!Global.gameStage.hasEventListener(MouseEvent.MOUSE_DOWN))
			{
				Global.gameStage.addEventListener(MouseEvent.MOUSE_DOWN, click_pop)
			}
		}
		public function deActivateClick():void
		{
//			Global.gameStage.removeEventListener(TouchEvent.TOUCH_BEGIN, click_pop);
			Global.gameStage.removeEventListener(MouseEvent.MOUSE_DOWN, click_pop);
		}
		
	}
}