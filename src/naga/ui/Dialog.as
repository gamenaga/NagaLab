package naga.ui
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import naga.eff.Flash;
	import naga.eff.GameStop;
	import naga.eff.InOut;
	import naga.global.Css;
	import naga.global.Global;
	import naga.system.EventManager;
	import naga.system.Sounds;
	import naga.tool.Sprite2Bitmap;
	import naga.tool.String2Font;
	import naga.tool.String2Font39;
	import naga.ui.DialogNPC;

    public class Dialog
    {
        private static var list:Array = new Array();
        private static var timer:Timer= new Timer(100);
//		private static var npc:Sprite=new E3_flash_o();
		private static var npc:DialogNPC;
		private static var npcCurrentID:int = 0;
		private static var delay_time:int;
		private static var to_id:int;
		private static var alert_str:String;
		public static var alert_text:WordPan;
//		private static var alert_pan:AlphaPan;//对话框弹出时的遮挡板
		private static var bg_pan_color:String;//对话框弹出时的遮挡板 的颜色
//		private static var btn_close:Icon_close = new Icon_close();
		private static var bt_num:int;
		private static var end_function:Array;
		public static var running:Boolean = false;
		
		public static function init(pan_class:Class ,alpha_pan_color:String, npc_class:Class):void{
			WordPan.wordPanClass = pan_class;
			npc = new npc_class();
			bg_pan_color = alpha_pan_color;
//			alert_pan = new AlphaPan(alpha_pan_color);
//			trace("dialog 42:	",alert_pan.alpha);
			EventManager.AddEventFn(timer,TimerEvent.TIMER, run);
		}
		/**
		 * @param alertTxt 弹框内容
		 * @param align 内容对其方式 "center" "left" "right"
		 * @param size 内容字体大小
		 * @param pan_color 弹框面板颜色
		 * @param t_color 弹框文字颜色
		 * @param arrow_x 对话箭头位置百分比（如：25 = 25%）
		 * @param time 弹框停留时长（毫秒，默认为0 = 永久）
		 * @param btn_num 按钮个数必须与btn_func长度相匹配（PS：btn_num * 2 = btn_func长度）
		 * @param btn_func ["",func1,"",func2...]
		 * @param shadow 文字是否带有阴影（默认为false）
		 * @param picFont 是否启用图片字体（默认为true）
		 * 
		 */
        public static function add(alertTxt:String, align:String = null, size:int = 0, pan_color:String = null, t_color:String = null, width:int = 0, height:int = 0, arrow_x:int = 0, time:int = 0, npcID:int = 0, btn_func:Array = null, shadow:Boolean = false,picFont:Boolean=true):void
        {
			if(alertTxt != alert_str)
			{
				if(size == 0) size = Css.SIZE;
				if(t_color == null) t_color = Css.PAN_WORD;
				list.push([alertTxt, align, size, pan_color, t_color, width, height, arrow_x, time, npcID, btn_func, shadow, picFont]);
				//			trace("dialog 46:	LIST:"+list+"	running:"+timer.running+"	alert_pan:"+alert_pan+"	"+alert_pan.width+"	"+alert_pan.height+"	"+alert_pan.alpha);
				if (!timer.running)
				{
//					if(!Global.tp_floor.contains(alert_pan))
//					{
//						Global.tp_floor.addChild(alert_pan);
//					}
					timer.start();
				}
			}
        }// end function

        private static function run() : void
        {
//			trace("dialog 46:	list.length:"+list.length+"	running"+running);
            if (list.length > 0)
            {
                if (!running)
                {
					running = true;
					Flash.instance.go(-1, true, bg_pan_color, 50);
					alert_str = list[0][0];
//					trace("dialog 80:	",alert_pan.alpha,list[0][7]);
					//						Glo.tp_floor.setChildIndex(alert_pan, 0);
					if(list[0][9]>0 && !Global.tp_floor.contains(npc)){
						npcCurrentID=list[0][9];
						npc.BC.gotoAndStop(npcCurrentID)
						//						npc.scaleY = 5;
						//						npc.scaleX = 5;
						npc.x = -npc.width;
						npc.y = Global.game_view_h;
						Global.tp_floor.addChild(npc);
						//						trace("dialog 85:	",npc.width,npc.height,npc.x,npc.y);
						//						Glo.tp_floor.addEventListener(Event.ENTER_FRAME, npc_in);
						EventManager.AddEventFn(Global.tp_floor,Event.ENTER_FRAME, npc_in);
					}
					else
					{
						show(list[0][0], list[0][1], list[0][2],list[0][3], list[0][4], list[0][5], list[0][6], list[0][7], list[0][8], list[0][9], list[0][10], list[0][11], list[0][12]);
						list.shift();
					}
//					trace("dialog 70:	list.length:"+list.length);
                }
            }
            else
            {
                timer.stop();
            }
        }// end function

        private static function npc_in() : void
        {
//			trace("dialog 100:	",npc.x,npc.y,npc.width * 0.1,npc.height*.1);
            if (npc.x >= (-npc.width) * 0.2)
            {
//				Glo.tp_floor.removeEventListener(Event.ENTER_FRAME, npc_in);
				EventManager.delEventFn(Global.tp_floor,Event.ENTER_FRAME, npc_in);
				show(list[0][0], list[0][1], list[0][2],list[0][3], list[0][4], list[0][5], list[0][6], list[0][7], list[0][8], list[0][9], list[0][10], list[0][11], list[0][12]);
				list.shift();
            }
			npc.x = npc.x + npc.width * 0.2;
			npc.y = npc.y - npc.height * 0.2;
        }// end function
		private static function show(alert:String, align:String = null, size:int = 0, p_color:String = null, t_color:String = null, width:int=0, height:int=0, arrow_x:int = 0, time:int = 0, npcID:int=0, btn_func:Array = null, shadow:Boolean = true,picFont:Boolean=true) : void
		{
			if(t_color == null) t_color = Css.PAN_WORD;
			GameStop.stop();
			delay_time = time;
//			trace("dialog 94:	Glo.tp_floor.contains(alert_pan):"+Glo.tp_floor.contains(alert_pan)+"	running"+running);
//			if (Glo.tp_floor.contains(alert_pan))
//			{
//				hide();
//			}
//			Glo.tp_floor.addChild(alert_pan);
//			Glo.tp_floor.setChildIndex(alert_pan, 0);
			if(btn_func==null){
				bt_num=0;
			}
			else if(btn_func.length == 1)
			{
//				trace("dialog 137:	",(btn_func[0] is String));
				if(btn_func[0] is String)
				{
					bt_num=1;
				}
				else
				{
					bt_num=0;
				}
			}
			else
			{
				bt_num = btn_func.length*.5;
			}
			end_function = btn_func;
			alert = "<br>" + alert + "<br>";
//			if (bt_num > 0)
//			{
//				alert = alert + "<br>";
//			}
			alert_text = new WordPan(alert, p_color, 1, (width==0),width,height, align, t_color, size , arrow_x, bt_num);
			alert_text.mouseEnabled = false;
			alert_text.alpha = 0;
//			trace("dialog 148:	",alert_text.x,alert_text.y);
			Global.tp_floor.addChild(alert_text);
			if(picFont){
				String2Font39.go(alert_text.pan_title, alert_text.pan_img, size , t_color, shadow , alert_text.re_draw_box);
			}
			else{
				String2Font.go(alert_text.pan_title, alert_text.pan_img, size , t_color, shadow , alert_text.re_draw_box);
			}
			//			trace("dialog 137:	",npcID);
			if(npcID==0 || arrow_x==0)
			{//没有NPC时，弹窗位置在屏幕中央
				alert_text.x = (Global.game_view_w - alert_text.width) * 0.5;
				alert_text.y = (Global.game_view_h - alert_text.height) * 0.5;
			}
			else
			{//有NPC时，弹窗靠近NPC
				alert_text.x = npc.x + npc.width*.8 - alert_text.width*arrow_x*.01;
				alert_text.y = Math.max(npc.y - alert_text.height - Css.SIZE , -Css.SIZE);
			}
			EventManager.AddEventFn(Global.tp_floor,Event.ENTER_FRAME, alert_in ,[size]);
//			alert_in(size);
			if(Global.tp_floor.contains(npc))
			{
				Global.tp_floor.setChildIndex(npc,Global.tp_floor.numChildren-1);
			}
		}// end function
		
//		缓冲进入
		private static function alert_in(btnSize:int) : void
		{
			alert_text.alpha = alert_text.alpha + 0.2;
//			if (alert_pan.alpha < 0.3)
//			{
//				alert_pan.alpha = alert_pan.alpha + 0.1;
//			}
//			trace("dialog 196:	",Global.tp_floor.contains(alert_pan),alert_pan.alpha);
			alert_text.y -= Css.SIZE*.04;
			if (alert_text.alpha >= 1)
			{
//				Glo.tp_floor.removeEventListener(Event.ENTER_FRAME, alert_in);
				EventManager.delEventFn(Global.tp_floor,Event.ENTER_FRAME, alert_in);
				if (delay_time == 0)
				{
					to_id = setTimeout(click, 300, btnSize);
				}
				else if(delay_time == -1)
				{
				}
				else
				{
					to_id = setTimeout(hide, delay_time);
				}
			}
		}// end function
		
//		点击
		private static function click(btnSize:int) : void
		{
//			trace("dialog 222:	",bt_num);
//			var sca:Number = alert_text.pan.scaleX;
//			var l_h:Number = 15;
//			var a_h:Number = alert_text.pan.a_.height * alert_text.pan.scaleX;
			if (bt_num == 0)// && end_function !=null)
			{
//				Glo.gameStage.addEventListener(MouseEvent.MOUSE_DOWN, hide);
				EventManager.AddEventFn(Flash.instance.pan, MouseEvent.MOUSE_DOWN, hide);
//				btn_close.x = alert_text.x + alert_text.width * alert_text.scaleX - btn_close.width * 0.5 - l_h;
//				btn_close.y = alert_text.y + alert_text.height - l_h - a_h;
//				btn_close.scaleY = 3;
//				btn_close.scaleX = 3;
//				btn_close.mouseEnabled = false;
//				btn_close.mouseChildren = false;
//				if (!Glo.tp_floor.contains(btn_close))
//				{
//					E3_in_out.add(btn_close, true, 0.2);
//					Glo.tp_floor.addChild(btn_close);
//				}
				if(end_function != null){
					end_function[0];
				}
			}
			else
			{
				var temp:int = 0;
				while (temp <= (end_function.length - 1))
				{
//					trace("dialog 166:	"+end_function[temp]+"	"+end_function[temp].length+"	"+end_function[temp].replace(/<[\w \/\"\'#=]+>/g,"")+"	"+end_function[temp+1]);
					end_function[temp] = Sprite2Bitmap.go(new WordPan(end_function[temp],Css.ORAN_D,1,false,0,0,"center",null,btnSize));
					end_function[temp].x = alert_text.x + alert_text.width * (temp * 0.5 + 1) / (bt_num + 1) - end_function[temp].width * 0.5;
					end_function[temp].y = alert_text.y + alert_text.pan.l_b.y - end_function[temp].pan.l_b.y * 2;// - a_h;
//					trace("dialog 254:	",end_function[temp].y,alert_text.y,alert_text.height,alert_text.pan.l_b.y,end_function[temp].height,end_function[temp].pan.l_b.y);
					InOut.fadeIn(end_function[temp], 0.2);
					Global.tp_floor.addChild(end_function[temp]);
//					end_function[temp].addEventListener(MouseEvent.MOUSE_DOWN, hide);
					EventManager.AddEventFn(end_function[temp],MouseEvent.MOUSE_DOWN, hide ,null,true);
					temp += 2;
				}
			}
		}// end function
		
		public static function hide(event:MouseEvent = null) : void
		{
			if (running)
			{
				alert_str = "";
				if (event != null)
				{
					Sounds.play(Se_bia, 0, 0.3);
				}
				running = false;
//							trace("dialog 269:	"+running,bt_num);
				clearTimeout(to_id);
				GameStop.run();
				if (bt_num == 0)
				{
					if (end_function != null)
					{
						end_function[0].call();
					}
//					if (alert_pan.hasEventListener(MouseEvent.MOUSE_DOWN))
//					{
//						//					Glo.gameStage.removeEventListener(MouseEvent.MOUSE_DOWN, hide);
//						EventManager.delEventFn(alert_pan,MouseEvent.MOUSE_DOWN, hide);
//					}
					//				if (Glo.tp_floor.contains(btn_close))
					//				{
					//					Glo.tp_floor.removeChild(btn_close);
					//				}
				}
				else
				{
					var temp:int = 0;
					while (temp <= end_function.length - 1)
					{
						//					trace("dialog 272:	",temp,event.target,event.currentTarget,end_function[temp],end_function[temp+1]);
						if (event != null && event.currentTarget == end_function[temp] && end_function[(temp + 1)] != null)
						{
							(end_function[(temp + 1)] as Function).call();
						}
						//					end_function[temp].removeEventListener(MouseEvent.MOUSE_DOWN, hide);
						EventManager.delEventFn(end_function[temp],MouseEvent.MOUSE_DOWN, hide);
						Global.tp_floor.removeChild(end_function[temp]);
						end_function[temp].dispose();
						end_function[temp+1] = null;
						temp += 2;
					}
				}
				end_function=null;
				//			trace("dialog 309:	",alert_text);
				if(alert_text && Global.tp_floor.contains(alert_text))
				{
					alert_text.dispose();
//					Global.tp_floor.removeChild(alert_text);
				}
				if(list.length==0){
//					InOut.fadeOut(alert_pan,.1,0,-1);
					Flash.instance.goBack();
				}
				hide_npc();
			}
		}// end function

        private static function hide_npc() : void
        {
			if(Global.tp_floor.contains(npc)){
//				trace("dialog		 230:	list.length:"+list.length)
				if(list.length==0 || list[0][9]!=npcCurrentID){
					Global.tp_floor.removeChild(npc);
				}
			}
        }// end function

    }
}
