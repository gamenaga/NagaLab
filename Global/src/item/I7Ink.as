package item
{
	import eff.E4Ink;
	
	import naga.eff.Vision;
	import naga.global.Global;
	import naga.system.Sounds;

    public class I7Ink extends Item
    {

        public function I7Ink(num:int=0, iconID:int=7, isItemActive:Boolean=false, time:int=8000)
        {
            super(num, iconID, isItemActive, time);
        }// end function

        override protected function add() : void
        {
                //Chk_first.chk(46, "干扰道具\\2\\007<font size=\'+5\' color=\'#" + Css.TITLE + "\'>墨水</font><br><br><font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'><b>功能说明</b></font>：<br><br>溅到屏幕上，会<font color=\'#" + Css.IMPORTANT + "\' size=\'+2\'>遮挡</font>视线。", Global.g_mode > -1);
            
        }// end function

        override public function item_do() : void
        {
            Sounds.play(Se_bia);
            call("i007" + id, parent.x, parent.y, ms);
			item_over();
        }// end function

        public static function call(indexName:String, x:int = 0, y:int = 0, time:int = 0) : void
        {
			var sca:Number=400/(Global.game_view_w*.3);
            Vision.instance.add(indexName, E4Ink,Global.eff_floor, x, y, null, 1, time,sca,Math.random()*360-180,false,true,true);
        }// end function

        public static function over(indexName:String) : void
        {
            Vision.instance.remove(indexName);//,true,true);
        }// end function
		
		override public function achCount() : void
		{
			DataObj.data[27] ++;
		}// end function

    }
}
