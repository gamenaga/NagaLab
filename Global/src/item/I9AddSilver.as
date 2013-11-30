package item
{
	import naga.system.Bubble;
	
	import naga.global.Css;
	
	import pop.PopFactory;

    public class I9AddSilver extends Item
    {//d道具触发时，会导致泡泡不被remove   不再生产泡泡 
        private static var is_run:Boolean = false;

        public function I9AddSilver(num:int=0, iconID:int=9,isItemActive:Boolean=false,time:int=0)
        {
            super(num, iconID,isItemActive, time);
        }// end function

        override protected function add() : void
        {
        }// end function

        override public function item_do() : void
        {
			var silver:int=PopFactory.popID*.1;
			DataObj.data[2] = DataObj.data[2] + silver;
			Bubble.instance.show("\\2\\011<br><font size=\'+1\' color=\'#" + Css.SILVER + "\'>+" + silver + "</font>", Bubble.TYPE_MONEY,parent.x, parent.y, 100,Css.SIZE*1.5, Css.SILV_S);
			
			item_over();
			
        }// end function
		
		override public function achCount() : void
		{
			DataObj.data[29] ++;
		}// end function
		
    }
}
