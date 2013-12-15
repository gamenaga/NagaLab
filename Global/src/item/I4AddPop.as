package item
{
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import naga.system.Sounds;
	import naga.global.Global;
	
	import pop.PopFactory;

    public class I4AddPop extends Item
    {
		public static var iDoing:Boolean = false;
		private var popPath:int;//生成泡泡的方向
		private static var pathBak:int;
//		private var warnTimer:timer;//警告提示时间

        public function I4AddPop(num:int=0, iconID:int=4,isItemActive:Boolean=false,time:int=0)
        {
            super(num, iconID,isItemActive, time);
        }// end function

        override protected function add() : void
        {
                //Chk_first.chk(43, "道具\\2\\004<font size=\'+5\' color=\'#" + Css.TITLE + "\'>肥皂泡</font><br><br><font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'><b>功能说明</b></font>：<br><br>突然出现许多的泡泡<b>!</b><br>咕噜咕噜的<font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'>飞速冒泡</font>。", Global.g_mode > -1);
            
        }// end function

        override public function item_do() : void
        {
			if (Global.eff_floor.getChildByName("addPopWarn") == null)
			{
				popPath=getPath();
//				var tempY:int;
//				if(popPath==PopFactory.PATH_DOWN)
//				{
//					tempY=Global.game_view_h-50;
//				}
//				else
//				{
//					tempY=50;
//				}
//				Vision.add("addPopWarn",E9warn_,Global.game_view_w*.5,tempY,"000000",1,3000);
//				time_id = setTimeout(warnOver, 3000);
				warnOver();
			}
			item_over();
        }// end function
		
		private function getPath():int
		{
//			PopFactory.pathBak=PopFactory.path;
			var temp:Number=(Math.random()*1.99+1);
//			trace("i4 52:	"+temp+"	"+int(temp));
			return temp;
		}
		
		private function warnOver():void
		{
//			PopFactory.pathBak=PopFactory.path;
//			PopFactory.path=path;
			itemDo(ms+Main.mode.game_combo_level*100);
			//			this.parent.parent.parent.removeChild(this.parent.parent);
//			if(this.parent.parent){
//				InOut.add(this.parent.parent, false);
//			}
		}
		
		private function itemDo(time_ms:int) : void
		{
			if(!iDoing)
			{
				addPop(popPath);
				time_id = setTimeout(over, time_ms);
			}
		}// end function
		
		public static function go(time_ms:int,path:int,pathBak:int=PopFactory.PATH_UP_DOWN) : void
		{
//			trace("i4 89:	"+iDoing);
			if(iDoing)
			{
				over();
			}
				addPop(path,pathBak);
				setTimeout(over, time_ms);
		}// end function
		
		private static function addPop(path:int,path_bak:int=PopFactory.PATH_UP_DOWN):void
		{
//			trace("i4 101:	path:"+path,PopFactory.path,PopFactory.pathBak,getTimer(),PopFactory.g_sp);
			iDoing = true;
//			if(PopFactory.pathBak!=PopFactory.path)
//			{
//				PopFactory.pathBak=PopFactory.path;
//			}
			PopFactory.path = path;
			pathBak = path_bak;
			//速度减缓，并确保不会导致速度持续变缓
			//			trace("i4 85:	"+Global.g_move_sp+"	"+Global.g_sp+"	"+Global.g_move_sp_bak*.9+"	"+Global.g_move_sp_init*(1+PopFactory.popID*.002));
			PopFactory.changeMoveSp(Global.g_move_sp_bak*.95);
			//			trace("i4 88:	"+Global.g_move_sp+"	"+Global.g_sp);
			if(PopFactory.state < 2)
			{
				//如果状态小于 欢乐时光 ， 改为 道具状态（小量突破泡泡上限的状态）
				PopFactory.state = 1;
			}
			Sounds.play(Se_gulu,2);
			PopFactory.pop_type = 10;
//			if(bak_speed >= PopFactory.g_sp)
//			{
				PopFactory.changeSpeed(PopFactory.g_sp_max*.4,1);
//			}
		}
		
		private static function over() : void
		{
//			trace("i4 96:	over",getTimer());
			PopFactory.path=pathBak;
//			PopFactory.pathBak=9;
			PopFactory.pop_type = PopFactory.pop_type_init;
//			trace("i4 96:	bak_speed:"+bak_speed);
			PopFactory.changeSpeed(PopFactory.g_sp_bak,-1);
			PopFactory.state = 0;
			iDoing = false;
		}// end function
		
//		override public function itemCut() : void
//		{
//			if (doing)
//			{
//				I1SpeedDown.change_speed(bak_speed);
//				clearTimeout(time_id);
//				item_over();
//			}
//		}// end function
		
		override public function achCount() : void
		{
			DataObj.data[24] ++;
		}// end function
		
    }
}
