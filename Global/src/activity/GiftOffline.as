package activity
{	
	import naga.global.Css;
	import naga.global.Global;
	import naga.system.Bubble;
	import naga.tool.String2Time;
	import naga.ui.Dialog;

	public class GiftOffline
	{
		private var gift_silver:int;
		public function GiftOffline()
		{
		}
		
		public function getSilver():void
		{
			var save_date:int = String2Time.getDate(DataObj.saveTime);
			var login_date:int = String2Time.getDate(DataObj.serverTime);
//			Dialog.add("时间 : "+save_date+"	"+login_date);
			if (save_date != login_date || save_date == 0)
			{
			gift_silver = 1000;
			Dialog.add("<p align=\'center\'><font size=\'+"+int(Css.SIZE*.1)+"\'>太棒了！</font></p>" +
				"<br>获得 <font color=\'#" + Css.TITLE + "\' size=\'+"+int(Css.SIZE*.2)+"\'><b>每日登录</b></font>奖励" +
				"<br><p align=\'center\'><font size=\'+"+int(Css.SIZE*.2)+"\'>\\1\\011<font size=\'+"+Css.SIZE*.3+"\' color=\'#" + Css.SILVER + "\'>" + gift_silver + "</font></p>" +
				"",null,0,null,null,0,0,0,0,6,["领取",getSilver2]);
			}
		}
		
		private function getSilver2():void
		{
			DataObj.data[2] += gift_silver;
			Bubble.instance.show("\\1\\011<br><font size=\'-"+Css.SIZE*.1+"\' color=\'#" + Css.SILVER + "\'>+" + gift_silver + "</font>", Bubble.TYPE_MONEY,Global.game_view_w*.5, Global.game_view_h*.3, 100, Css.SIZE, Css.SILV_S);
			DataObj.saveData(true);
		}
	}
}