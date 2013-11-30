package naga.system
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import naga.eff.Vision;
	import naga.global.Css;
	import naga.global.Global;
	import naga.tool.GetBitmap;
	import naga.tool.String2Font39;

    public class Bubble
    {
		private static var _instance:Bubble;
		public static function get instance():Bubble
		{
			if(_instance == null)
			{
				_instance = new Bubble();
				//            b_txt.multiline = true;
				b_txt.multiline = true;
				b_txt.selectable = false;
			}
			return _instance;
		}
		
        private static var b_txt:TextField = new TextField();
//        private static var b_img:Sprite;
        private var running:Boolean = false;
		private var count:int = 0;
        private var b_frame:int;
		public static const TYPE_SCORE:String="Score";
		public static const TYPE_BAD:String="Bad";
		public static const TYPE_LV_UP:String="LvUp";
		public static const TYPE_ACH:String="Ach";
		public static const TYPE_OTHER:String="Other";
		public static const TYPE_MONEY:String="Money";

        public function show(txt:String, type:String=TYPE_OTHER, pos_x:int=0, pos_y:int=0, frame:int = 80, size:int=0, color:String=null, shadow:Boolean=false) : void
        {
//            if (Mode.g_mode !=null)
//            {
//				先清除同类
				removeBubble(type)
                running = true;
//				trace("bb	33:	"+txt+"	"+size+"	"+color+" bb"+pos_x+"bb"+pos_y);
				if(size == 0) size = Css.SIZE;
				if(color == null) color = Css.ORANGE;
				var b_bmp:Bitmap = create_bubble(txt, size, color, shadow);
                var pos:Point = getPos(pos_x, pos_y, b_bmp.width, b_bmp.height);
				Vision.instance.add("bb"+type, b_bmp, Global.eff_floor, pos.x, pos.y, null, 5, 0, 1, Math.random()*10-5);
				b_bmp.alpha = frame * 0.05;//决定展现的时长
//				b_bmp.addEventListener(Event.ENTER_FRAME, del);
				EventManager.AddEventFn(b_bmp,Event.ENTER_FRAME, del,["bb"+type],true);
//            }
        }// end function
		
		private function get num():int
		{
			count++;
			return count;
		}

        private function getPos(param1:int, param2:int, bb_width:int, bb_height:int) : Point
        {
			var _x:int;
			var _y:int;
            if (param1 - bb_width * 0.5 < 0)
            {
                _x = Math.random() * 30;
            }
            else if (param1 - bb_width * 0.7 >= Global.game_view_w - bb_width)
            {
                _x = Global.game_view_w - bb_width - Math.random() * 30;
            }
            else
            {
                _x = param1 - bb_width * 0.5;
            }
            if (param2 - bb_height * 0.5 < 20)
            {
                _y = 20 + Math.random() * 30;
            }
            else if (param2 - bb_height * 0.5 >= Global.game_view_h - bb_height - 10)
            {
                _y = Global.game_view_h - bb_height - Math.random() * 30;
            }
            else
            {
                _y = param2 - bb_height * 0.5;
            }
			return new Point(_x,_y);
        }// end function

        private function create_bubble(str:String, size:int, color:String ,shadow:Boolean) : Bitmap
        {
            b_txt.htmlText = "<p align=\'center\'><font face=\'"+Css.FONT+"\' size=\'" + size + "\' color=\'#" + color + "\'>" + str + "</font></p>";
			b_txt.width=b_txt.textWidth + size * 0.3;
			b_txt.height = b_txt.textHeight + size * 0.6;
			
			var img:Sprite = new Sprite();
			img.addChild(b_txt);
			Global.eff_floor.addChild(img);
//			trace("bb	80:	"+b_txt+"	img"+img+"	size:"+size+"	color:"+color);
            String2Font39.go(b_txt, img, size, color ,shadow);
			var bmp:Bitmap = GetBitmap.go(img);
			
//			b_bmp = GetBitmap.go(img);
			//			trace(this.numChildren,pan_img.numChildren,pan_img.parent);
			for (var i:int= 0 ; i < img.numChildren; i++)
			{
//				trace(img.getChildAt(i));
				if(img.getChildAt(i) is Bitmap)
				{
					(img.getChildAt(i) as Bitmap).bitmapData.dispose();
				}
				else if(img.getChildAt(i) is Global.icons)
				{
					(img.getChildAt(i)as Global.icons).dispose();
				}
				else
				{
//					img.getChildAt(i) = null;
				}
			}
			img.removeChildren();
			Global.eff_floor.removeChild(img);
			img = null;
//			img=null;
//			Global.eff_floor.addChild(b_bmp);
			return bmp;
        }// end function

        private function del(event:Event, name:String) : void
        {
            event.target.y = event.target.y - Global.g_move_sp * 0.3;
            event.target.alpha = event.target.alpha - Global.g_move_sp / 20;
            if (event.target.alpha < 0.7 && Global.eff_floor.numChildren != 0)
            {
//				trace("bubble 99:	",event.target.y,Global.g_move_sp);
                running = false;
				EventManager.delEventFn(event.target as EventDispatcher,Event.ENTER_FRAME, del);
                if (event.target != null && Global.eff_floor.contains(event.target as Bitmap))
                {
					Vision.instance.remove(name);
//                    Global.eff_floor.removeChild(event.target as Bitmap);
                }
            }
        }// end function
		
		public function removeBubble(type:String):void
		{
			if(Global.eff_floor.getChildByName("bb"+type)){
//				Glo.eff_floor.getChildByName("bb"+type).removeEventListener(Event.ENTER_FRAME, del);
				EventManager.delEventFn(Global.eff_floor.getChildByName("bb"+type),Event.ENTER_FRAME, del);
				Vision.instance.remove("bb"+type);
//				Global.eff_floor.removeChild(Global.eff_floor.getChildByName("bb"+type));
			}
		}

    }
}
