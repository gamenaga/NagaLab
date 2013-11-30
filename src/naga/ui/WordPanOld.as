package naga.ui
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	
	import naga.global.Css;
	import naga.global.Global;
	import naga.tool.GetBitmap;
	import naga.tool.Sprite2Bitmap;
	import naga.tool.String2Font;
	import naga.tool.String2Font39;
	
	public class WordPanOld extends Sprite
	{
		private var pan_w:int;
		private var pan_h:int;
		private var bg_color:String;
		private var bg_alpha:Number;
		private var sizeType:Boolean;//自适应类型
		public var txt_size:int;
		public var txt_color:String;
		private var txt_align:String;
		public var pan:MovieClip;
		public var pan_img:Sprite;
		public var pan_title:TextField;
		private var a_x:int;
		private var btnNum:int;
		public static var wordPanClass:Class;
		
		public function WordPan(word:String, p_color:String = null , alp:Number = 1, isAutoSize:Boolean = false, width:int = 0, height:int = 0, align:String = "center", t_color:String = null, size:int = 0, arrow_x:int = 0,has_btn:int=-1)
		{
			pan_img = new Sprite();
			pan_title = new TextField();
			pan_title.multiline = true;
//			pan_title.mouseEnabled = false;
			if(size == 0) 
			{
				txt_size = Css.SIZE;
			}
			else
			{
				txt_size = size;
			}
			if(t_color == null) t_color = Css.PAN_WORD;
			txt_color = t_color;
			txt_align = align;
			sizeType=isAutoSize;
			a_x = arrow_x;//arrow_x=0 则没有箭头
			btnNum=has_btn;
			txt(word);
			pan_img.mouseEnabled = false;
			pan_img.mouseChildren = false;
			bg_color = p_color;
			bg_alpha = alp;
			//			trace("wp 40:	bg_color:"+bg_color+"	txt_color:"+txt_color);
			pan_img.addChild(pan_title);
			addChild(pan_img);
//			if (a_x == 0)
//			{
//				pan = new W_pan();
//			}
//			else
//			{
			pan = new wordPanClass();
//			}
			if (sizeType)
			{//随内容自适应大小的类型
				pan_title.x = size ;
				pan_title.y = size;
//				draw_box(bg_color, bg_alpha);
//				txt_pos();
			}
			else
			{//固定大小的类型
//				trace("wordPan 61:	",pan_title.textWidth);
				if(width == 0) width = pan_title.textWidth + Css.SIZE*.5;//Css.SIZE*4;
				if(height == 0) height = pan_title.textHeight;
				pan_w = width;
				pan_h = height;
//				String2Font39.go(pan_title, pan_img, txt_size , txt_color, false , draw_box);
				draw_box(bg_color, bg_alpha);
				txt_pos();
			}
		}// end function
		
		public function re_draw_box() : void
		{
			if (!sizeType)
			{//固定大小的类型
			}
			else
			{//随内容变化大小的类型
				pan_w = pan_title.textWidth + txt_size * 2;
//				var h:int=0;
//				if(btn>0){
//					h=Css.SIZE*3;
//				}
				pan_h = pan_title.height + txt_size * 1.5;
			}
			draw_box(bg_color, bg_alpha);
//			if(true){
//				x = x-txt_size * 2;
//				y = y-txt_size * 2;
//			}
//			else{
//				x = (Glo.stage_w - pan.width) * 0.5;
//				y = (Glo.stage_h - pan.height) * 0.5;
//			}
//			GetBitmap.go(this);
			Sprite2Bitmap.go(this);
		}// end function
		
		public function reTxt(word:String):void
		{
			txt(word);
			var num:int = pan_img.numChildren - 1;
			//					trace("menu 273:	",num,scores.pan_title.text);
			while (num > 0)
			{
				pan_img.removeChild(pan_img.getChildAt(num));
				num --;
			}
			String2Font39.go(pan_title, pan_img, txt_size, txt_color, false, txt_pos);
		}
		
		private function txt(word:String) : void
		{
			pan_title.htmlText = "<P ALIGN=\'" + txt_align + "\'><font face=\'"+Css.FONT+"\' SIZE=\'" + txt_size + "\' COLOR=\'#" + txt_color + "\'>" + word + "</FONT></P>";
			if (pan_title.textWidth + txt_size * 3 > Global.game_view_w)
			{
				txt_size = txt_size * (Global.game_view_w / (pan_title.textWidth + txt_size * 3));
				pan_title.htmlText = "<P ALIGN=\'" + txt_align + "\'><FONT FACE=\'"+Css.FONT+"\' SIZE=\'" + txt_size + "\' COLOR=\'#" + txt_color + "\'>" + word + "</FONT></P>";
			}
			pan_title.width = pan_title.textWidth + txt_size * 0.3;
			pan_title.height = pan_title.textHeight + txt_size;
		}// end function
		
		public function txt_pos() : void
		{
//			trace("wordPan 118:	",pan.t_.height * 2.8,(pan.height - pan.a_.height + pan.b_.height*.2 - pan_title.textHeight) * 0.5,(pan.height - pan.a_.height + pan.b_.height*.2),pan_img.height,pan_title.height,pan_title.textHeight);
			var pan_l_t_width:Number = pan.l_t.width
			pan_img.x = pan_l_t_width*.25 + (pan.width - pan_img.width - pan_l_t_width*.8) * 0.5;
//			var h:int = (pan.height - pan.a_.height + pan.b_.height*.1 - pan_title.textHeight) * 0.5;
//			trace("wordPan 144 :	",pan.l_b.y,pan_l_t_width * 2.8);
//			pan_img.y = Math.min(pan_l_t_width * 2.8, Css.SIZE*.2);
			if(pan.l_b.y < pan_l_t_width * 6)
			{
				pan_img.y = Css.SIZE*.2;
			}
			else
			{
				pan_img.y = pan_l_t_width * 2.8;
			}
//			String2Font39.go(pan_title, pan_img,txt_size,txt_color);
		}// end function
		
		private function draw_box(color:String = null, alp:Number = 1) : void
		{
//			trace("wordPan 122 ：	",btn,pan_title.text);
			if(btnNum!=0){
				//btn>0 时 无需关闭按钮    btn<0 时 强制隐藏关闭按钮
				pan.r_t.iconClose.visible=false;
			}
			if(btnNum>0 && sizeType){
				pan_h += Css.SIZE*1.5;
			}
			pan_h = pan_h - pan.t_.height*.5;
			if(pan_h<0)
			{
				pan_h = 0;
			}
//			var conner_w:int = pan.l_t.height;
			var temp:int;
			
			temp = Math.max(0, pan_w);
//			trace("wordPan 108:	",temp);
			pan.t_.width = temp;
			pan.c_.width = temp;
			pan.b_.width = temp;
			pan.t_.x = pan.b_.x = pan.l_t.width;
//			trace("w_pan 106	:	pan.t_.x="+pan.t_.x+"	pan.t_.width="+pan.t_.width+"	pan.c_.width="+pan.c_.width);
			pan.r_t.x=pan.t_.x+pan.t_.width+pan.r_.width;
			pan.r_.x=pan.r_b.x=pan.r_t.x;
			pan.r_.y=pan.t_.height;
			pan.r_.height=pan_h-pan.r_t.height-pan.r_b.height;
//			trace("w_pan 110	:	pan.r_t.x="+pan.r_t.x+"	pan.l_.height="+pan.l_.height);
			
			
			temp = Math.max(0, pan_h);
			pan.l_.height = temp;
			pan.c_.height = temp;
			pan.r_.height = temp;
			pan.l_.y=pan.l_t.height;
			pan.l_.x=pan.l_b.x=pan.l_t.x;
//			trace("w_pan 118	:	pan.l_.x="+pan.l_.x+"	temp="+temp+"	pan.l_.height="+pan.l_.height+"	pan.c_.height="+pan.c_.height);
			
			pan.l_b.y=pan.l_.y+pan.l_.height;
			
//			temp = Math.max(0, pan_w-pan.l_b.width-pan.r_b.width);
			pan.b_.x=pan.l_b.x+pan.l_.width;
			pan.b_.y=pan.l_b.y+pan.b_.height;
//			trace("w_pan 124	:	pan.b_.x="+pan.b_.x+"	pan.b_.width="+pan.b_.width);
			
			pan.r_b.y=pan.l_b.y;
			
			pan.c_.x=pan.t_.height;
			pan.c_.y=pan.l_.width;
			if(a_x>0){
				pan.a_.x = (pan_w + pan.l_t.width) * a_x * 0.01;
				pan.a_.y = pan.l_b.y - 1;
			}
				else{
					pan.a_.visible=false;
				}

			if(color!=null){
				pan.transform.colorTransform = new ColorTransform(int("0x" + color.slice(0, 2)) / 255, int("0x" + color.slice(2, 4)) / 255, int("0x" + color.slice(4, 6)) / 255, alp, 0, 0, 0, 0);
			}
			addChild(pan);
			setChildIndex(pan, 0);
//			trace("w_pan	153	:	"+temp);
			
		}// end function
//		老版本draw_box
//        private function draw_box(color:String, alp:Number) : void
//        {
//            var conner_w:int = pan.l_t.height;
//			var temp:int;
//            pan.scaleX = pan.scaleY = 2;
//            pan_w = pan_w / pan.scaleX - conner_w * 2;
//            pan_h = pan_h / pan.scaleX - conner_w * 2;
//			
//            pan.t_.x = pan.b_.x = conner_w;
//			
//            temp = Math.max(0, pan_w);
//            pan.b_.width = temp;
//            pan.t_.width = temp;
//			
//			temp = conner_w * 2 + pan_w;
//            pan.r_b.x = temp;
//            pan.r_.x = temp;
//            pan.r_t.x = temp;
//            pan.l_.y = conner_w;
//            pan.r_.y = conner_w;
//			
//			temp = Math.max(0, pan_h);
//            pan.l_.scaleX = temp;
//            pan.r_.scaleX = temp;
//			
//			temp = Math.max(conner_w * 2 - 2, conner_w * 2 + pan_h);
//            pan.l_b.y = temp;
//            pan.b_.y = temp;
//            pan.r_b.y = temp;
//			
//            pan.a_.x = (pan_w + conner_w) * a_x * 0.01;
//            pan.a_.y = pan.l_b.y - 1;
//						if(color!=null){
//							pan.transform.colorTransform = new ColorTransform(int("0x" + color.slice(0, 2)) / 255, int("0x" + color.slice(2, 4)) / 255, int("0x" + color.slice(4, 6)) / 255, alp, 0, 0, 0, 0);
//						}
//						
//			addChild(pan);
//            setChildIndex(pan, 0);
//            
//			graphics.beginGradientFill("linear", [int("0x" + color), int("0x" + color)], [alp * 0.5, alp], [0, 255], null, "pad");
//            graphics.drawRoundRect(pan.scaleX, pan.scaleX, Math.max((conner_w - 2) * 2, pan_w + conner_w * 2 - 2) * 2, Math.max((conner_w - 2) * pan.scaleX, pan_h + conner_w * 2 - 2) * pan.scaleX, conner_w * 2 * pan.scaleX, conner_w * 2 * pan.scaleX);
//            graphics.endFill();
//        }// end function

		public function dispose():void
		{
			
		}
    }
}
