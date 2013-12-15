package item
{
	import eff.E8Cloud;
	
	import naga.eff.GameStop;
	import naga.eff.Vision;
	import naga.global.Global;
	import naga.system.Sounds;

    public class I8Fog extends Item
    {
        public static var iDoing:Boolean = false;

        public function I8Fog(num:int=0, iconID:int=8,isItemActive:Boolean=false,time:int=0)
        {
            super(num, iconID, isItemActive, time);
        }// end function

        override protected function add() : void
        {
                //Chk_first.chk(47, "干扰道具\\2\\008<font size=\'+5\' color=\'#" + Css.TITLE + "\'>黑洞</font><br><br><font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'><b>功能说明</b></font>：<br><br>天空被黑暗笼罩<br>视线变得<font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'>模糊</font>。<br><br>PS:一般情况，<b>    可以用道具圣光\\1\\002消除。", Global.g_mode > -1);
            
        }// end function

        override public function item_do() : void
        {
            if (!iDoing)
            {
				iDoing = true
                Sounds.play(Se_wu);
                call("i008", ms);
            }
			item_over();
        }// end function

        private static function call(name:String, time:int = 0) : void
        {
//			trace(38,iDoing);
            Vision.instance.add(name, E8Cloud,Global.eff_floor, 0, 0, null, .4, time,1,0,true,true,true);
        }// end function
		
		public static function over() : void
		{
			if (iDoing)
			{
//				trace(46,iDoing);
				Vision.instance.remove("i008");
				iDoing=false;
			}
		}// end function
		
//        public static function over(param1:String) : void
//        {
//            Vision.remove(param1);
//        }// end function
		
		override public function achCount() : void
		{
			DataObj.data[28] ++;
		}// end function
		
    }
}
