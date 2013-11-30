package naga.tool
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import naga.global.Css;
	import naga.global.Global;
	import naga.system.FontEn39;
	import naga.ui.PicIcons;
	
	public class OldString2Font39
	{
		private static var pan_title:TextField = new TextField();
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
//			txt(tf.text);
//			trace("str2font 27:	tf:"+tf.text+"\n	htmlText:"+tf.htmlText+"\n	obj:"+obj+"	size:"+size+"	color:"+color+"	shadow:"+shadow+"	func:"+func);
			tf.width = tf.textWidth + size * 0.3;
			tf.height = tf.textHeight + size * 0.6;			
//			trace("str2font	30:	tf:"+tf.text+"	tf.height:"+tf.height);
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
						//					转换html中的特殊符号
					else
					{
						var html_temp:String = img_info[idx].replace(/(\W)/g, "\\$1");//特殊字符转义
						pos_info[idx] = tf.text.search(html_temp);//在原内容中查找字符串出现的位置，特殊字符需要转义
						
//						trace("str2font 63:	html:"+html_temp+"	pos_info:"+pos_info[idx]);
						var html_txt:String = img_info[idx].replace(/\&/g, "&amp;");
						html_txt = html_txt.replace(/\"/g, "&quot;");
						html_txt = html_txt.replace(/\'/g, "&apos;");
//						trace("str2font 67:	html_txt");
						var pos_html:int = tf.htmlText.search(">" + html_txt.replace(/(\W)/g, "\\$1")) + 1;
						var word_s:int = size;
						var word_c:String = color;
//						trace("str2font 70:	pos_html:"+pos_html);
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
//					trace("str2font 89:	word_s:"+word_s+"	word_c:"+word_c+"	"+int("0x"+word_c));
					if (int("0x"+word_c) < 0x222222)
					{
						word_c = null;
					}
					info = null;
					var img_sca:Number = word_s/35;
					var w:Array = img_info[idx].split("");
//					trace("str2font 90:	word:"+w+"	word_s:"+word_s+"	word_c:"+word_c);
					var img_w:int = 1;//计算 字符图宽度总和
					for (var temp1:String in w)
					{
						img_w = img_w + (FontEn39.font_width[w[temp1].toString().charCodeAt(0) - 31] - 1);//使用39号字体
					}
					tf.htmlText = tf.htmlText.replace(">" + html_txt, ">" + html_space(img_w * img_sca + 3, word_s));
//					tf.width = tf.textWidth + size * 0.3;
//					tf.height = tf.textHeight + size * 0.6;
//					trace("str2font	101:	tf.width:"+tf.width+"	tf.height:"+tf.height);
//										trace("str2font 89:	tf.htmlText:"+tf.htmlText+"\n	");
					//					合并生成字符串图片
					var bmp:Bitmap = new Bitmap(new BitmapData(img_w, 39, true, 0));//图片高度=字符高度=39
					var temp_x:int = 1;
					var w_idx:int;
					var temp_w:int;
					var bmpd:BitmapData;
					for each (var t_w:String in w)
					{
						w_idx = t_w.toString().charCodeAt(0) - 31;
						temp_w = FontEn39.font_width[w_idx];
						bmpd = FontEn39.char(w_idx, word_c);
						bmp.bitmapData.copyPixels(bmpd, bmpd.rect, new Point((temp_x - 1), 0), null, null, true);
						temp_x = temp_x + (temp_w - 1);
					}
					bmp.scaleY = img_sca;
					bmp.scaleX = img_sca;
					bmp.smoothing = true;
					img_info[idx] = bmp;
					w = null;
				}
				tf.width = tf.textWidth + size * 0.3;
				tf.height = tf.textHeight + size * 0.6;
				//			部署图片
//								trace("str2font 133:	pos_info:"+pos_info+"\n	img_info:"+img_info+"\n	"+tf.width,tf.height);
				var temp:int = 0;
				var rec:Rectangle;
				while (temp < img_info.length)
				{
					
					if (img_info[temp] is Bitmap || img_info[temp] is PicIcons)
					{
						rec = tf.getCharBoundaries(pos_info[temp]);
//						trace("str2font 127:	:"+temp+"	"+pos_info[temp],tf.length+"	rec:"+rec+"	tf:"+img_info[temp]);
						img_info[temp].x = rec.x + tf.x;
						img_info[temp].y = rec.y + tf.y + rec.height * 0.99 - img_info[temp].height;
						obj.addChild(img_info[temp]);
//						trace("str2font 146:	:"+img_info[temp].x,img_info[temp].y,img_info[temp],rec.x,tf.x);
					}
					temp = temp + 1;
				}
			
			//			加阴影
			if (shadow)
			{
				Shadow.go(obj, size * 0.03);
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