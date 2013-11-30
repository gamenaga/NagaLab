package naga.tool
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import naga.global.Global;
	import naga.ui.PicIcons;
	
	public class String2Font
	{
		/**
		 * 
		 * @param 使用说明：如果需要让一段字符中部分显示不同颜色和大小，font标签前后要添加\\，标签内要出现color
		 * @param 使用说明：tf中含有空格时，在空格前加\\，标签内内容不能以空格为首。
		 * @param 使用说明：添加icon的格式\\1\\001，1为缩放倍数，001为iconID
		 * @param 注意：不宜使用太大的size(有BUG)
		 * 
		 * 
		 */ 
		public static function go(tf:TextField, obj:Sprite, size:int, color:String = null, shadow:Boolean = false, func:Function = null) : void
		{
//			trace("str2font 18:	tf:"+tf.text+"\n	htmlText:"+tf.htmlText+"\n	obj:"+obj+"	size:"+size+"	color:"+color+"	shadow:"+shadow+"	func:"+func);
			tf.width = tf.textWidth + size * 0.3;
			tf.height = tf.textHeight + size * 0.6;			
//			trace("str2font	23:	tf.width:"+tf.width+"	tf.height:"+tf.height);
				var reg:RegExp = /\\[1-9]\\[0-9]{3}|([\w\.,;:\?\/\'\"&~`!@#$%^\(\)\*\[\]\+={}\|-] *)+|\\/g;
				var img_info:Array = tf.text.match(reg);//记录需要转换图片的信息
				tf.htmlText = tf.htmlText.replace(/<\"\\</g, "<");
//				trace("str2font 32:	reg:"+reg+"\n	img_info:"+img_info+"\n	tf.htmlText:"+tf.htmlText);
				var pos_info:Array = [];//图片位置信息
				for (var idx:String in img_info)
				{
//					trace("str2font 36:	idx:"+idx+"\n	img_info[idx]:"+img_info[idx]);
					//                    \\x\\xxx格式的图标
					if (img_info[idx].charAt(0) == "\\")
					{
						pos_info[idx] = tf.text.search(/\\[1-9]\\/);
						if(pos_info[idx]>=0){
							var icon:PicIcons = new Global.icons();
							icon.BC.gotoAndStop(int(img_info[idx].slice(3)));
							var icon_sca:int = int(img_info[idx].charAt(1));
							icon.scaleY = icon_sca;
							icon.scaleX = icon_sca;
							tf.htmlText = tf.htmlText.replace(img_info[idx], html_space(icon.width + 4, icon.height));
							img_info[idx] = icon;
						}
						else{
							tf.htmlText = tf.htmlText.replace(img_info[idx], "");
							img_info[idx]=null;
						}
						//						trace("str2font 42:	icon_sca:"+icon_sca);
						continue;
					}
				}
				tf.width = tf.textWidth + size * 0.3;
				tf.height = tf.textHeight + size * 0.6;
				//			部署图片
				//				trace("str2font 111:	pos_info:"+pos_info+"\n	img_info:"+img_info+"\n	"+tf.htmlText+"\n	"+tf.text);
				var temp:int = 0;
				var rec:Rectangle;
				while (temp < img_info.length)
				{
					
					if (img_info[temp] is Bitmap || img_info[temp] is PicIcons)
					{
						rec = tf.getCharBoundaries(pos_info[temp]);
//						trace("str2font 127:	:"+temp+"	"+pos_info[temp]+"	rec:"+rec+"	tf:"+tf.text);
						img_info[temp].x = rec.x + tf.x;
						img_info[temp].y = rec.y + tf.y + rec.height * 0.99 - img_info[temp].height;
						obj.addChild(img_info[temp]);
					}
					temp = temp + 1;
				}
			
			//			加阴影
			if (shadow)
			{
				Shadow.go(obj, size * 0.05);
			}
			//			执行结束函数
			if (func != null)
			{
				func();
			}
		}// end function
		
		private static function html_space(w:int, h:int) : String
		{
			var space:String = "<font size='" + h + "'> ";
			var num:int = int((w - h * 0.34) / h);
			var temp:int = 0;
			while (temp < num)
			{
				space += "　";
				temp ++;
			}
			var left:int = int(w - h * 0.34) % h;
			space = space + ("</font><font size='" + left + "'>　</font>");
			return space;
		}// end function
		
	}
}