package naga.tool
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import naga.global.Global;
	import naga.system.FontEn9;
	import naga.ui.PicIcons;
	
	public class String2Font9
	{
		
		public static function go(tf:TextField, obj:Sprite, size:int, color:String = null, shadow:Boolean = false, func:Function = null) : void
		{
//			trace("str2font 18:	tf:"+tf.text+"\n	htmlText:"+tf.htmlText+"\n	obj:"+obj+"	size:"+size+"	color:"+color+"	shadow:"+shadow+"	func:"+func);
			tf.width = tf.textWidth + size * 0.3;
			tf.height = tf.textHeight + size * 0.5;
				var reg:RegExp = /\\[1-9]\\[0-9]{3}|([\w\.,;:\?\/\'\"&~`!@#$%^\(\)\*\[\]\+={}\|-] *)+|\\/g;
				var img_info:Array = tf.text.match(reg);//记录需要转换图片的信息
				tf.htmlText = tf.htmlText.replace(/<\"\\</g, "<");
//				trace("str2font 26:	reg:"+reg+"\n	img_info:"+img_info+"\n	tf.htmlText:"+tf.htmlText);
				var pos_info:Array = [];//图片位置信息
				for (var idx:String in img_info)
				{
//					trace("str2font 30:	idx:"+idx+"\n	img_info[idx]:"+img_info[idx]);
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
						//					转换html中的特殊符号
					else
					{
						var html_temp:String = img_info[idx].replace(/(\W)/g, "\\$1");//特殊字符转义
						pos_info[idx] = tf.text.search(html_temp);//在原内容中查找字符串出现的位置，特殊字符需要转义
						
//						trace("str2font 50:	html:"+html_temp+"	pos_info:"+pos_info[idx]);
						var html_txt:String = img_info[idx].replace(/\&/g, "&amp;");
						html_txt = html_txt.replace(/\"/g, "&quot;");
						html_txt = html_txt.replace(/\'/g, "&apos;");
						var pos_html:int = tf.htmlText.search(">" + html_txt.replace(/(\W)/g, "\\$1")) + 1;
						var word_s:int = size;
						var word_c:String = color;
//						trace("str2font 57:	pos_html:"+pos_html);
						if (tf.htmlText.substr(pos_html - 2, 2) == "\">"){
							var info:Array = [];
							//					<b>x</b>格式的英数字符
							info = tf.htmlText.slice(pos_html - 50, pos_html).split(/SIZE=\"|\" COLOR=\"#|\" LETTERSPACING.+>|\">/g);
//							trace("str2font 62:	info:"+info+"	"+info[info.length - 2]);
							if (info[info.length - 2].length == 6)
							{
								word_s = info[info.length - 3];
								word_c = info[info.length - 2];
							}
						}
//						else
//						{
//							word_s;
//							word_c;
//						}
					}
//					trace("str2font 18:	word_c:"+word_c+"	"+int("0x"+word_c));
					if (int("0x"+word_c) < 0x222222)
					{
						word_c = null;
					}
					info = null;
//					trace("str2font 79:	word_s:"+word_s+"	word_c:"+word_c);
					var img_sca:Number = word_s * 0.125;
					var w:Array = img_info[idx].split("");
					var img_w:int = 1;
					for (var temp1:String in w)
					{
						img_w = img_w + (FontEn9.font_width[w[temp1].toString().charCodeAt(0) - 31] - 1);
					}
					tf.htmlText = tf.htmlText.replace(">" + html_txt, ">" + html_space(img_w * img_sca + 3, word_s));
					//					trace("str2font 89:	tf.htmlText:"+tf.htmlText+"\n	");
					//					合并生成字符串图片
					var bmp:Bitmap = new Bitmap(new BitmapData(img_w, 9, true, 0));
					var temp_x:int = 1;
					var w_idx:int;
					var temp_w:int;
					var bmpd:BitmapData;
					for each (var t_w:String in w)
					{
						w_idx = t_w.toString().charCodeAt(0) - 31;
						temp_w = FontEn9.font_width[w_idx];
						bmpd = FontEn9.char(w_idx, word_c);
						bmp.bitmapData.copyPixels(bmpd, bmpd.rect, new Point((temp_x - 1), 0), null, null, true);
						temp_x = temp_x + (temp_w - 1);
					}
					bmp.scaleY = img_sca;
					bmp.scaleX = img_sca;
					img_info[idx] = bmp;
					w = null;
				}
							tf.width = tf.textWidth + size * 0.3;
							tf.height = tf.textHeight + size * 0.4;
				//			部署图片
//				trace("str2font 111:	pos_info:"+pos_info+"\n	img_info:"+img_info+"\n	"+tf.htmlText+"\n	"+tf.text);
				var temp:int = 0;
				var rec:Rectangle;
				while (temp < img_info.length)
				{
					
					if (img_info[temp] is Bitmap || img_info[temp] is PicIcons)
					{
						rec = tf.getCharBoundaries(pos_info[temp]);
//						trace("str2font 127:	:"+temp+"	"+pos_info[temp]+"	rec:"+rec);
						img_info[temp].x = rec.x + tf.x;
						img_info[temp].y = rec.y + tf.y + rec.height * 0.99 - img_info[temp].height;
						obj.addChild(img_info[temp]);
					}
					temp = temp + 1;
				}
			
			//			加阴影
			if (shadow)
			{
				Shadow.go(obj, size * 0.06);
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
