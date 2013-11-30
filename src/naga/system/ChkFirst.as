package naga.system
{
	import naga.global.Css;
	import naga.ui.Dialog;

    public class ChkFirst
    {
		private static var data_:Array;
		
		public static function init(data:Array):void
		{
			data_ = data;
		}
		
        public static function chk(key:int, alert:String, condition:Boolean = true, btn_func:Array = null) : void
        {
//			trace("DataObj.so.data.userData    "+key +" "+DataObj.so.data.userData[key]);
			
			if (data_[key] == 0 && condition)
//			if (DataObj4399.so.userData[key] == 0 && condition)
            {
                if (btn_func == null)
                {
					btn_func = ["知道了", null];
                }
                Dialog.add(alert, null, Css.SIZE,null,Css.PAN_WORD,0,0,0,0,0, btn_func);
				data_[key] = 1;
//				DataObj4399.so.userData[key] = 1;
            }
        }// end function

    }
}
