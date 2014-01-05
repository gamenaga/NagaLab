package ui
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import game.LevelPointType;
	
	import naga.eff.InOut;
	import naga.global.Css;
	import naga.global.Global;

	public class TaskBar extends Sprite
	{
		//目标显示文本框
		private var point1:TextField = new TextField();
		private var point2:TextField;
		private var point3:TextField;
		//目标字段名称
		public var field1:String;
		public var field2:String;
		public var field3:String;
		//目标名称字符串
		public var name_str1:String;
		public var name_str2:String;
		public var name_str3:String;
		//目标字符串
		public var value_str1:String;
		public var value_str2:String;
		public var value_str3:String;
		//目标值
		public var value1:int;
		public var value2:int;
		public var value3:int;
		
		private var tag_bar_c:uint = int("0x"+Css.ORAN_S);
//		private var tag_bar_c2:uint = 0xbbdddd;
		private var tag_bar_w:int = Css.SIZE * 10;
		private var tag_bar_h:int = Css.SIZE * 1.3;
		private var tag_bar1:TagBar;
		private var tag_bar2:TagBar;
		private var tag_bar3:TagBar;
		
		private var size:int;
		private var num:int;
		private var num_complete:int;
		private var complete:Array;
		
		
		public function TaskBar()
		{
			tag_bar1 = new TagBar(tag_bar_c, tag_bar_w, tag_bar_h);
			point1.mouseEnabled = false;
			point1.width= tag_bar1.width;
			point1.height= tag_bar1.height;
			addChild(tag_bar1);
			addChild(point1);
			
		}
		
		public function init(level:Array):void//p1:String, v1:int, p2:String = null, v2:int = 0, p3:String = null, v3:int = 0):void
		{
			var dis_h:int = Css.SIZE*.2;
			size = point1.height -dis_h*2;
			num = level.length*.5;
			num_complete = 0;
			complete = [false,false,false];
			
			point1.x = size*.5;
			point1.y = dis_h;
			tag_bar1.alpha = 1;
			field1 = level[0];
			value1 = level[1];
			name_str1 = "<p><font size=\'" +size+ "\' color=\'#" +Css.YELL_D2+ "\'><b>" +LevelPointType[field1]+ "</b>: <font size=\'+" +size*.1+ "\' color=\'#" +Css.YELLOW+ "\'>";
			value_str1 = "</font> / "+value1+"</font></p>";
			point1.htmlText = name_str1 + 0 + value_str1;
//			trace("lvBar 42:",level ,point1.parent, point1.parent.parent, point1.htmlText,point1.x,point1.y,point1.height);
			//显示point2
			if(num>1)
			{
				if(!point2)
				{
					tag_bar2 = new TagBar(tag_bar_c, tag_bar_w, tag_bar_h);
					tag_bar2.y = tag_bar1.y + tag_bar1.height + dis_h;
					point2 = new TextField();
					point2.width = point1.width;
					point2.height = tag_bar2.height;
					point2.x = point1.x;
					point2.y = tag_bar2.y + dis_h;
					point2.mouseEnabled = false;
					addChild(tag_bar2);
					addChild(point2);
				}
				tag_bar2.alpha = 1;
				field2 = level[2];
				value2 = level[3];
				name_str2 = "<p><font size=\'" +size+ "\' color=\'#" +Css.YELL_D2+ "\'><b>" +LevelPointType[field2]+ "</b>: <font size=\'+" +size*.1+ "\' color=\'#" +Css.YELLOW+ "\'>";
				value_str2 = "</font> / "+value2+"</font></p>";
				point2.htmlText = name_str2 + 0 + value_str2;
				//显示point3
				if(num>2)
				{
					if(!point3)
					{
						tag_bar3 = new TagBar(tag_bar_c, tag_bar_w, tag_bar_h);
						tag_bar3.y = tag_bar2.y + tag_bar2.height + dis_h;
						point3 = new TextField();
						point3.width = point1.width;
						point3.height = tag_bar3.height;
						point3.x = point1.x;
						point3.y = tag_bar3.y + dis_h;
						point3.mouseEnabled = false;
						addChild(tag_bar3);
						addChild(point3);
					}
					tag_bar3.alpha = 1;
					field3 = level[4];
					value3 = level[5];
					name_str3 = "<p><font size=\'" +size+ "\' color=\'#" +Css.YELL_D2+ "\'><b>" +LevelPointType[field3]+ "</b>: <font size=\'+" +size*.1+ "\' color=\'#" +Css.YELLOW+ "\'>";
					value_str3 = "</font> / "+value3+"</font></p>";
					point3.htmlText = name_str3 + 0 + value_str3;
				}
				else if(point3)
				{
					removeChild(point3);
					point3 = null;
					tag_bar3.dispose();
					tag_bar3 = null;
				}
			}
			else if(point2)
			{
				removeChild(point2);
				point2 = null;
				tag_bar2.dispose();
				tag_bar2 = null;
				if(point3)
				{
					removeChild(point3);
					point3 = null;
					tag_bar3.dispose();
					tag_bar3 = null;
				}
			}
		}
		
		/**
		 * 
		 * @return 任务是否全部完成 
		 * 
		 */		
		public function update():Boolean
		{
			var i:int;
			for(i=1; i<=num; i++)
			{
//				trace("LvBar 139:", i
//					, this["point"+i]
//					, this["name_str"+i]
//					, this["field"+i]
//					, this["value_str"+i]);
				var point_value:int = Global.m_p.getValue(this["field"+i]);
				if(!complete[i+1] && point_value >= this["value"+i])
				{
					complete[i+1] = true;
					num_complete ++;
					InOut.fadeOut(this["tag_bar"+i], false, .1, .3, 1);
//					this["tag_bar"+i].rander(tag_bar_c2);
				}
				this["point"+i].htmlText = this["name_str"+i] + point_value + this["value_str"+i];
				
			}
			//判定任务全部完成
			if(num_complete == num)
			{
				return true;
			}
			
			return false;
		}
		
		public function dispose():void
		{
			removeChild(point1);
			point1 = null;
			tag_bar1.dispose();
			tag_bar1 = null;
			if(point2)
			{
				removeChild(point2);
				point2 = null;
				tag_bar2.dispose();
				tag_bar2 = null;
				if(point3)
				{
					removeChild(point3);
					point3 = null;
					tag_bar3.dispose();
					tag_bar3 = null;
				}
			}
		}
	}
}

import flash.display.GradientType;
import flash.display.Sprite;
import flash.geom.Matrix;

import naga.global.Global;

class TagBar extends Sprite
{
	public function TagBar(color:uint, w:int, h:int)
	{
		rander(color, w, h);
	}
	public function rander(color:uint, w:int=0, h:int=0):void
	{
//		trace("lvBar 118:",this.width);
		if(this.width >0)
		{
			if(w==0)
			{
				w = this.width;
				h = this.height;
			}
			dispose();
		}
		graphics.beginGradientFill(GradientType.RADIAL, [color,color], [.8,0], [50,255], new Matrix(w/Global.stage_w, 0 ,0 ,.1, -h, h));
		graphics.drawRoundRect(0, 0, w, h, 0);
		graphics.endFill();
	}
	public function dispose():void
	{
		graphics.clear();
	}
}