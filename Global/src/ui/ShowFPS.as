package ui
{
		import flash.system.System;
		
		import eff.E2Bomb;
		import eff.E3FlashPoint;
		import eff.E4Ink;
		import eff.E6FlashBlack;
		import eff.E8Cloud;
		
		import game.MyHeart;
		
		import item.I10HP;
		import item.I1SpeedDown;
		import item.I2Clear;
		import item.I3Bad;
		import item.I4AddPop;
		import item.I5Stop;
		import item.I6PopZoom;
		import item.I7Ink;
		import item.I8Fog;
		import item.I9AddSilver;
		
		import naga.eff.Vision;
		import naga.global.Global;
		import naga.system.EventManager;
		import naga.system.ObjPool;
		import naga.system.ShowDebug;
		
		import pop.PopBlack;
		import pop.PopBlue;
		import pop.PopFactory;
		import pop.PopRainbow;
		import pop.PopWhite;

		public class ShowFPS extends ShowDebug
		{
			public var other:*;
			
			public function ShowFPS(otherInfo:*)
			{
				other = otherInfo;
				super();
			}
			
			protected override function timerHandler():void
			{
				//Timer实例调用的方法
				if(System.totalMemory/1024>DataObj.data[10]) DataObj.data[10]=System.totalMemory/1024;
				txt.htmlText="FPS:"+count+" Memory:"+System.totalMemory/1024+" / "+DataObj.data[10]+" k  "+MyHeart.second
					+ "<br>event: " + EventManager.count
					+ "<br>pop: " + ObjPool.instance.getPoolNum(PopWhite) 
					+ " / " + ObjPool.instance.getPoolNum(PopBlack) 
					+ " / " + ObjPool.instance.getPoolNum(PopBlue)  
					+ " / " + ObjPool.instance.getPoolNum(PopRainbow) 
					+ "   icons: " + ObjPool.instance.getPoolNum(Icons) 
					+ "<br>item: " + ObjPool.instance.getPoolNum(I1SpeedDown)  
					+ " / " + ObjPool.instance.getPoolNum(I2Clear) 
					+ " / " + ObjPool.instance.getPoolNum(I3Bad)  
					+ " / " + ObjPool.instance.getPoolNum(I4AddPop) 
					+ " / " + ObjPool.instance.getPoolNum(I5Stop)  
					+ " / " + ObjPool.instance.getPoolNum(I6PopZoom) 
					+ " / " + ObjPool.instance.getPoolNum(I7Ink)  
					+ " / " + ObjPool.instance.getPoolNum(I8Fog) 
					+ " / " + ObjPool.instance.getPoolNum(I9AddSilver) 
					+ " / " + ObjPool.instance.getPoolNum(I10HP)
					+ "<br>eff: " + ObjPool.instance.getPoolNum(E2Bomb)  
					+ " / " + ObjPool.instance.getPoolNum(E3FlashPoint) 
					+ " / " + ObjPool.instance.getPoolNum(E4Ink)  
					+ " / " + ObjPool.instance.getPoolNum(E8Cloud)
					+"<br>g_move_sp: "+Global.g_move_sp+" / "+Global.g_move_sp_init+" / "+Global.g_move_sp_bak
					+"<br>g_sp: "+PopFactory.g_sp+" / "+PopFactory.g_sp_max+" / "+PopFactory.g_sp_min
					+"<br>itemState:"+PopFactory.state+"	max:"+PopFactory.popNumMax+"	maxItem:"+PopFactory.popNumMaxItem+"	Black:"+PopFactory.bad_pop+"/"+PopFactory.popNumMaxBad
					+"<br>all:"+Global.g_floor.numChildren+" / white:"+PopFactory.white_pop+" / blue:"+PopFactory.blue_pop+" / black:"+PopFactory.bad_pop+" / rainbow"+PopFactory.rainbow_pop
					+"<br>state:"+Main.mode.game_state+" vision:"+Vision.instance+ " other:"+other;
				count=0//每隔1秒进行清零
			}
			
		}
		
	}
	 
	 
	//-----------------------------------应用：
	//myTimer.start();可以用快捷键来控制
	//相应的 myTimer.stop();
	 
	 
	//--------------------------------