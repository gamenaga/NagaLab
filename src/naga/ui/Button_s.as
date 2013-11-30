package naga.ui
{
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import naga.global.Css;
	
	public class Button_s extends Sprite
	{
		private var btn_w:int;
		private var btn_h:int;
		private var btn_mode:Boolean=true;
		private var bg_color:String=new String();
		private var bg_alpha:Number=new Number();
		private var txt_color:String=new String();
		public var btn_title:TextField=new TextField();
		
		/**
		 * 
		 * @param title
		 * @param w
		 * @param h
		 * @param b_color
		 * @param b_alpha
		 * @param t_color
		 * @param size
		 * @param pressType 点击类型 0-可点击
		 * @param inputable
		 * 
		 */
		public function Button_s(title:String,w:int=50,h:int=18,b_color:String=Css.BLACK,b_alpha:Number=1,t_color:String=Css.SILV_S,size:int=0,pressType:int=0,inputable:Boolean=false)
		{
			this.name=title;
			if (inputable){
				btn_title.text = title.split("").join("\n");
			}
			else{
				btn_title.text = title;
			}
			if(size == 0)
			{
				size = Css.SIZE;
			}
			var btn_format:TextFormat = new TextFormat("Arial",size,int("0x"+t_color),true);
			btn_title.setTextFormat(btn_format);
			btn_w=btn_title.width=w;
			btn_h=btn_title.height=h;
			btn_title.y = (h-btn_title.height)/2;
			addChild(btn_title);
			bg_color=b_color;
			bg_alpha=b_alpha;
			txt_color=t_color;
			if(pressType == 0){
				btn_title.autoSize=TextFieldAutoSize.CENTER;
				btn_title.mouseEnabled=false;
				mode=true;
			}else{
				btn_title.type=TextFieldType.INPUT
				Color(Css.SILVER,bg_alpha);
			}
		}
		public function Color(b_color:String,b_alpha:Number):void{
			this.graphics.clear();
			this.graphics.beginFill(int('0x'+b_color),b_alpha);
			this.graphics.drawRoundRect(0,0,btn_w,btn_h,5);
			this.graphics.endFill();
			//trace(bg_color.toString(16));
		}
		public function set mode(b_mode:Boolean):void{
			if(b_mode){
				btn_title.textColor = int("0x"+txt_color);
				Color(bg_color,bg_alpha);
				buttonMode=true;
			}else if (!b_mode){
				btn_title.textColor = 0xbbbbbb;
				Color(Css.SILV_S,bg_alpha);
				buttonMode=false;
			}
			btn_mode=b_mode;
		}
		public function get mode():Boolean
		{
			return btn_mode;
		}
		
		private function Apply_filter(obj:Sprite,filter:ColorMatrixFilter):void {
			var filters:Array = new Array();
			filters.push(filter);
			obj.filters = filters;
		}
		
		public function set text(txt:String):void
		{
			btn_title.text = txt;
		}
	}
}