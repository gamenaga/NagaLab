package ui
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import naga.global.Css;
	import naga.global.Global;
	import naga.tool.String2Font39;
	import naga.ui.bitmapFont.BitmapFont;
	import naga.ui.bitmapFont.BitmapTextField;
	import naga.ui.bitmapFont.BitmapTextFormat;
	
	public class UI extends Sprite
	{
//		public static var btnItem1:btnItem=new btnItem();
//		public static var btnShopItem1:btnItem=new btnItem();
//		public static var iconItem1:Icons=new Icons();
		public static var ui_top:Sprite = new Sprite();
		public static var ui_lv:Sprite = new Sprite();
		public static var ui_scoreCombo:Sprite = new Sprite();
//		public static var ui_score:Sprite = new Sprite();
		public static var ui_highScore:Sprite = new Sprite();
		public static var tf_lv:TextField = new TextField();
		public static var tf_scoreCombo:TextField = new TextField();
//		public static var tf_score:TextField = new TextField();
//		public static var tf_highScore:TextField = new TextField();
		public static var hpBar:HpBar;
		public static var o2Bar:O2Bar;
		public static var item_do_x:int;//生效道具位
		public static var item_do_y:int;//生效道具位
		
		public static var tf_score:BitmapTextField = new BitmapTextField(Css.SIZE);
		public static var tf_highScore:BitmapTextField = new BitmapTextField(Css.SIZE);
		
		public function UI()
		{
			mouseEnabled = false;
		}
		
		/**
		 * 
		 * @param hp HP
		 * @param hpBar HP槽
		 * @param lineNormal 氧气条正常状态
		 * @param lineRed 氧气条闪红光状态
		 * @param box 氧气槽的外框
		 * @param bg 氧气槽的背景（也作为 氧气条的Mask）
		 * @param width 氧气槽除去外框厚度的宽度
		 * 
		 */
		public static function init(HP:Class, HPBar:Class, O2BarLineNormal:Class, O2BarLineRed:Class, O2BarBox:Class, Bg:Class, o2Width:int):void
		{
			//			顶部界面
			ui_top.mouseChildren = false;
			ui_top.mouseEnabled = false;
			//			btnItem1.mouseEnabled=true;
			Global.ui_floor.addChild(ui_top);
			tf_lv.x=Global.game_view_w-Css.SIZE*4.2;
			tf_lv.y=Css.SIZE*.5;
			//			score_combo.width=score_combo.textWidth*2;
			//			ui_combo.x = 280;
			//			ui_combo.y = 20;
			tf_score.x= Global.game_view_w-Css.SIZE*7.5;
			tf_score.y = Css.SIZE*.5;
			tf_score.font = "scoreFont";
//			tf_score.
//			trace("ui",68,BitmapFont.getFont(tf_score.font));
			tf_highScore.width=Css.SIZE*5;
			tf_highScore.x=tf_score.x;
			tf_highScore.y=Css.SIZE*1.8;
			tf_highScore.font = "hiScoreFont";
//			trace("ui 57:	"+tf_score.x+"	"+tf_score.y+"	"+tf_highScore.x+"	"+tf_highScore.y);
			ui_top.addChild(tf_lv);
			ui_top.addChild(tf_score);
			ui_top.addChild(tf_highScore);
			//			ui_top.addChild(score_combo);
			ui_top.addChild(ui_lv);
//			ui_top.addChild(ui_score);
			ui_top.addChild(ui_highScore);
			//			ui_top.addChild(ui_scoreCombo);
			//			if (!Global.is_hd)
			//			{
			//				score_combo.y = score_combo.y - 12;
			//				score_.y = score_.y - 12;
			//				ui_top.y = ui_top.y + 10;
			//			}
			item_do_x=Global.game_view_w-Css.SIZE*2.5;//商店道具位1
			item_do_y=Global.game_view_h-Css.SIZE*2.5;//商店道具位1
			
			ui_top.visible = false;
			
			hpBar=new HpBar(HP, HPBar);
			o2Bar=new O2Bar(O2BarLineNormal, O2BarLineRed, O2BarBox, Bg, o2Width);
//			o2Bar.visible = false;
			//道具框
			//			if(Global.item1==0){
			//				btnItem1.visible=false;
			//			}
			//			btnItem1.width=btnItem1.height=btnShopItem1.width=btnShopItem1.height=160;
			//			btnItem1.x=Global.item1_x;
			//			btnShopItem1.x=Global.shop_item1_x;
			//			btnItem1.y=btnShopItem1.y=Global.item1_y;
			//			addChild(btnItem1);
			//道具栏透明度
			//			btnItem1.alpha=.8;
			//			iconItem1.alpha=1/btnItem1.alpha;
			//			iconItem1.gotoAndStop(99);
			//			iconItem1.mouseEnabled=false;
			//			iconItem1.scaleX=iconItem1.scaleY=1.5;
			//			btnItem1.addChild(iconItem1);
			//			addChild(btnShopItem1);
			//			btnShopItem1.addEventListener(MouseEvent.CLICK,useShopItem1);
		}
		
		public static function changeScore(score:int):void{
			tf_score.text = String(score);
			tf_score.render();
//			tf_score.htmlText = "<p align=\'left\'><font face=\'"+Css.FONT+"\' size=\'" + Css.SIZE + "\' color=\'#" + Css.YELLOW + "\'>" + score + "</font></p>";
//			ui_score.removeChildren();
//			String2Font39.go(tf_score, ui_score,Css.SIZE,null,false);
//			trace("ui 120:	",tf_score.width,tf_score.x,tf_score.text,tf_score.textWidth,tf_score.visible,tf_score.alpha);
//			tf_score.x=tf_lv.x-ui_score.width-Css.SIZE*.5;
			
		}
		public static function changeHighScore(highScore:int):void{
			tf_highScore.text = String(highScore);
			tf_highScore.render();
//			tf_highScore.htmlText = "<p align=\'right\'><font face=\'"+Css.FONT+"\' size=\'" + Css.SIZE*.8 + "\' color=\'#"+Css.YELL_D+"\'>" + highScore + "</font></p>";
//			ui_highScore.removeChildren();
//			String2Font39.go(tf_highScore, ui_highScore,Css.SIZE,null,false);			
//			tf_highScore.x=tf_lv.x-ui_highScore.width-Css.SIZE*.5;
		}
		
//		public function changeItem1(id:int):void{
//			//			trace("UI	72:	item id:"+id);
//			iconItem1.gotoAndStop(id);
//			iconItem1.x=(btnItem1.width-5-iconItem1.width)*.5;
//			iconItem1.y=(btnItem1.height-5-iconItem1.height)*.5;
//			btnItem1.addEventListener(MouseEvent.CLICK,useItem1);
//			btnItem1.visible=true;
//			
//		}
//		
//		private function useItem1(e:MouseEvent):void{
//			btnItem1.removeEventListener(MouseEvent.CLICK,useItem1);
//			btnItem1..visible=false;
//			//			E3_in_out.add(btnItem1,false,.1,-1,0,false);
//			var tempItem:Pop=new Pop(0,0);
//			tempItem.x=btnItem1.x+btnItem1.width*.5;
//			tempItem.y=btnItem1.y+btnItem1.height*.5-10;
//			tempItem.p.popBC.visible=false;
//			Global.g_floor.addChild(tempItem);
//			switch(Global.item1){
//				case 1:{
//					tempItem.addItem(1);
//					tempItem.items.item_do();
//					break;
//				}
//				case 2:{
//					tempItem.addItem(2);
//					tempItem.items.item_do();
//					//					I2_clear.call();
//					break;}
//				case 4:{
//					tempItem.addItem(4);
//					tempItem.items.item_do();
//					//					tempItem=new I4_add_pop(0,false);
//					//					tempItem.item_do();
//					break;}
//				case 5:{
//					tempItem.addItem(5);
//					tempItem.items.item_do();
//					//					tempItem=new I5_stop(0,false);
//					//					tempItem.item_do();
//					break;}
//			}
//			Global.item1=0;
//		}
		/**
		 * 游戏开始时的 初始化
		 * @param point 起始HP点数
		 * @param pointMax 起始HP上限
		 * 
		 */		
		public static function gameInit(point:int,pointMax:int):void
		{
			changeScore(0);
			ui_lv.removeChildren();
			ui_top.visible=true;
			initHP(point,pointMax);
			initO2Bar();
		}
		
		/**
		 * 初始化HP槽
		 * @param point 起始HP点数
		 * @param pointMax 起始HP上限
		 * 
		 */		
		public static function initHP(point:int,pointMax:int):void
		{
			if(!ui_top.contains(hpBar))
			{
				hpBar.x= Css.SIZE*.8;
				hpBar.y= Css.SIZE*.8;
				ui_top.addChild(hpBar);
			}
			HpBar.initHPMax(pointMax);
			HpBar.initHP(point);
		}
		
		public static function initO2Bar():void
		{
			if(!ui_top.contains(o2Bar))
			{
				o2Bar.x=Css.SIZE*.8;
				o2Bar.y=Global.game_view_h - o2Bar.height -Css.SIZE*.8;
				ui_top.addChild(o2Bar);
			}
			O2Bar.initO2Bar();
		}
	}
}