package naga.global
{
	import flash.display.BitmapData;
	
	import naga.ui.bitmapFont.BitmapFont;

    public class Css
    {
		public static var SIZE:int;//标准字体大小
		public static var FONT:String="黑体";//标准字体大小
		public static var BUBBLE_WORD:String = "a84200";//面板文字颜色
		public static var PAN_WORD:String = "a84200";//面板文字颜色
		public static var TITLE:String = "eb6100";//标题颜色 
		public static var IMPORTANT:String = "005286";//重要文字颜色
		
        public static const ORAN_S:String = "fd9c00";//浅橘色
        public static const ORANGE:String = "ff6409";//橘黄色
        public static const ORAN_D:String = "f6bf00";//深橘色
        public static const BLUE:String = "005286";//蓝色
        public static const BL_S:String = "000099";//浅蓝
        public static const BL_D:String = "a9e0fe";//深蓝 特殊字
        public static const BL_D2:String = "e4f5ff";//深蓝2
        public static const SILVER:String = "cccccc";//银色 银币
        public static const SILV_S:String = "888888";//暗银色
        public static const YELLOW:String = "ffd754";//黄色
        public static const YELL_D:String = "f7ffbe";//深黄色
        public static const YELL_D2:String = "f7ffce";//深黄色2
        public static const RED:String = "FF3333";//红色 强调警告
		public static const BLACK:String = "111111";//红色 强调警告
        public static const R_D:String = "FF2222";//深红色
		public static const GREEN:String = "66ff33";//绿色
//        public static const PAN_BLUE:String = "e8f6ff";//面板蓝色
//        public static const PAN_RED:String = "fff3f3";//面板红色
		
		[Embed(source="../../../../../Pop/Pop_O2/2/PopO2en/res/ui/scoreFont.png")]
		public static const SCORE_FONT:Class;
		[Embed(source="../../../../../Pop/Pop_O2/2/PopO2en/res/ui/scoreFont.xml",mimeType="application/octet-stream")]
		public static const SCORE_FONT_FNT:Class;
		[Embed(source="../../../../../Pop/Pop_O2/2/PopO2en/res/ui/hiScoreFont.png")]
		public static const HI_SCORE_FONT:Class;
		[Embed(source="../../../../../Pop/Pop_O2/2/PopO2en/res/ui/hiScoreFont.xml",mimeType="application/octet-stream")]
		public static const HI_SCORE_FONT_FNT:Class;
		
		public static function init(size:int,font:String="黑体",color_bubble_words:String = "a84200",color_pan_words:String = "a84200",color_title:String = "eb6100",color_important:String = "005286"):void
		{
			SIZE=size;
			FONT=font;
			BUBBLE_WORD = color_bubble_words;
			PAN_WORD = color_pan_words;
			TITLE = color_title;
			IMPORTANT = color_important;
			BitmapFont.registerFont(new BitmapFont(new SCORE_FONT().bitmapData,XML(new SCORE_FONT_FNT())));
			BitmapFont.registerFont(new BitmapFont(new HI_SCORE_FONT().bitmapData,XML(new HI_SCORE_FONT_FNT())));
//			trace(BitmapFont.getFont("gamefont"));
			
		}
    }
	
}
