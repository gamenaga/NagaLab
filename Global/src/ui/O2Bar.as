package ui
{	
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	
	import item.I11O2Time;
	
	import naga.global.Global;
	import naga.system.BitmapClip;
	import naga.system.EventManager;
	
	
	public class O2Bar extends Sprite
	{
		public static var o2:int;
		private static var o2Max:int = 1000;
		private static var o2barLine:Sprite = new Sprite();
		private static var o2barLineNormal:BitmapClip;
		private static var o2barLineRed:BitmapClip;
//		public static var o2barTips:TextField = new TextField();
		private static var o2BoxWidth:int;
		/**
		 * 
		 * @param lineNormal 氧气条正常状态
		 * @param lineRed 氧气条闪红光状态
		 * @param box 氧气槽的外框
		 * @param bg 氧气槽的背景
		 * @param width 氧气槽除去外框厚度的宽度
		 * 
		 */		
		public function O2Bar(lineNormal:Class, lineRed:Class, box:Class, bg:Class, width:int)
		{
			mouseChildren=false;
			mouseEnabled=false;
			var o2barLineMask:BitmapClip = new BitmapClip(new bg,"o2barMask");
			
			var o2barBox:BitmapClip = new BitmapClip(new box,"o2barBox");
			o2BoxWidth = width;//o2barBox.width-24;217
			
			var o2barBoxBg:BitmapClip = new BitmapClip(new bg,"o2barBg");
			
//			o2barTips.width = o2barBox.width;
//			o2barTips.htmlText = "<p align=\'center\'>开启 欢乐时光（空格键）</p> ";
//			o2barTips.height = o2barBox.height;
			
			o2barLineNormal = new BitmapClip(new lineNormal,"o2barLine");
			o2barLine.addChild(o2barLineNormal);
			o2barLineRed = new BitmapClip(new lineRed,"o2barLineRed");
			o2barLine.addChild(o2barLineRed);
			o2barLine.mask = o2barLineMask;
			
			addChild(o2barBoxBg);
			addChild(o2barLine);
			addChild(o2barLineMask);
			addChild(o2barBox);
//			addChild(o2barTips);
			
		}//end
		
		/**
		 *氧气槽初始化 数值归0 位置归0 状态回归正常 
		 * 
		 */		
		public static function initO2Bar():void
		{
//			EventManager.delEventFn(Global.ui_floor.stage,KeyboardEvent.KEY_DOWN,I11O2Time.go);
			o2 = 0;
			moveO2Line();
			changeO2BarNormal();
		}//end
		
		/**
		 *氧气槽变成红色激活状态 
		 * 
		 */		
		public static function changeO2BarRed():void
		{
			if(!o2barLineRed.visible)
			{
			o2barLineNormal.visible = false;
			o2barLineRed.play();
			o2barLineRed.visible = true;
//			o2barTips.visible = true;
			}
		}//end
		/**
		 *氧气槽变成正常状态 
		 * 
		 */		
		private static function changeO2BarNormal():void
		{
			if(o2barLineRed.visible)
			{
				o2barLineNormal.visible = true;
				o2barLineRed.stop();
				o2barLineRed.visible = false;
//				o2barTips.visible = false;
			}
		}//end
		
		public static function changeO2(point:int):void
		{
			if(point>0)
			{
				if(!o2barLineRed.visible)
				{
					if(o2 != 1000)
					{
						if(o2 + point < 1000)
						{
							o2 += point;
						}
						else
						{
							o2 = 1000;
//							EventManager.AddEventFn(Global.ui_floor.stage,KeyboardEvent.KEY_DOWN,I11O2Time.go);
						}
						moveO2Line();
					}
				}
			}
			else
			{
				if(o2 + point > 0)
						{
							o2 += point;
							moveO2Line();
//							changeO2BarRed();
						}
						else
						{
							initO2Bar();
							I11O2Time.clearOver();
						}
			}
			
		}//end
		
		private static function moveO2Line():void
		{
//			trace("o2bar 105：	",o2,o2*o2BoxWidth/o2Max,o2BoxWidth);
//			MoveTo.add(o2barLine,5,o2*o2BoxWidth/o2Max,0);
			TweenLite.to(o2barLine, 1, {x:o2*o2BoxWidth/o2Max, y:0});
		}//end
		
		
	}
}