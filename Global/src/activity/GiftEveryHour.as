package activity
{
	import naga.global.Css;
	import naga.global.Global;
	import naga.system.Bubble;
	import naga.system.DataObjShare;
	import naga.ui.Dialog;

	public class GiftEveryHour
	{
		private static var gift_silver:int;
		public function GiftEveryHour()
		{
		}
		
		public static function getSilver():void
		{
			if(DataObjShare.so.data.getGiftHourTime == null)
			{
				DataObjShare.so.data.getGiftHourTime = new Date(0);
			}
			DataObjShare.so.data.actTime = new Date();
			var login_s:uint = (DataObjShare.so.data.actTime as Date).getTime()/1000;
			var get_gift_s:uint = (DataObjShare.so.data.getGiftHourTime as Date).getTime()/1000;
			var login_date:int = (DataObjShare.so.data.actTime as Date).getDate();
			var get_gift_date:int = (DataObjShare.so.data.getGiftHourTime as Date).getDate();
			var login_hour:int = (DataObjShare.so.data.actTime as Date).getHours();
			var get_gift_hour:int = (DataObjShare.so.data.getGiftHourTime as Date).getHours();
//			trace("时间 : ",login_s,get_gift_s,login_date,get_gift_date,login_hour,get_gift_hour);
			if (login_s > get_gift_s && (login_hour != get_gift_hour || login_date != get_gift_date))
			{
				DataObjShare.so.data.getGiftHourTime = DataObjShare.so.data.actTime;
				gift_silver = 500;
				Dialog.add("<p align=\'center\'><font size=\'+"+int(Css.SIZE*.1)+"\'>太棒了！</font></p>" +
					"<br>获得 <font color=\'#" + Css.TITLE + "\' size=\'+"+int(Css.SIZE*.2)+"\'><b>每小时</b></font>奖励" +
					"<br><p align=\'center\'><font size=\'+"+int(Css.SIZE*.2)+"\'>\\1\\011<font size=\'+"+Css.SIZE*.3+"\' color=\'#" + Css.SILVER + "\'>" + gift_silver + "</font></p>" +
					"",null,0,null,null,0,0,0,0,6,["领取",getSilver2]);
			}
		}
		
		private static function getSilver2():void
		{
			DataObj.data[2] += gift_silver;
			Bubble.instance.show("\\2\\011<br><font size=\'+1\' color=\'#" + Css.SILVER + "\'>+" + gift_silver + "</font>", Bubble.TYPE_MONEY,Global.game_view_w*.5, Global.game_view_h*.3, 100, Css.SIZE, Css.SILV_S);
			DataObj.saveData(true);
		}
	}
}