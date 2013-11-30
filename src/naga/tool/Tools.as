package naga.tool
{
	import flash.display.Sprite;

	public class Tools
	{
		public function Tools()
		{
			
		}
		
		/**
		 * 左截字符串 
		 * @param text
		 * @param param1
		 * 
		 */
		public  function leftCut(text:String, Index:int):String
		{
			//			text.indexOf(text,Index)
			return text.charAt(Index);
		}
		
		/**
		 * 右截字符串  
		 * @param text
		 * @param param1
		 * 
		 */
		public function RightCut(text:String,Index:int):String
		{
			//			text.lastIndexOf(text,Index)
			return text.charAt(text.length-Index);
		}
		
		
		/**
		 * 中截字符串  
		 * @param text
		 * @param startIndex
		 * @param endIndex
		 * 
		 */
		public function MiddleCut(text:String,startIndex:int,endIndex:int):void
		{
			text.substring(startIndex,endIndex);
		}
		
		/**
		 * 中截字符串  
		 * @param text
		 * @param startIndex
		 * @param endIndex
		 * 
		 */
		public function MiddleCut2(text:String,startIndex:int,length:int):void
		{
			text.substr(startIndex,length);
		}
		
		/**
		 * 中截字符串  
		 * @param text
		 * @param startIndex
		 * @param endIndex
		 * 
		 */
		public function MiddleCut3(text:String,startIndex:int,endIndex:int):void
		{
			text.slice(startIndex,endIndex);
		}
		
		
		/**
		 * 
		 * @param text
		 * @return 
		 * 获取字符串的长度
		 */
		public function getLength(text:String):int
		{
			return  text.length;
		}
		
		/**
		 * 强制转换为数值
		 * @param text
		 * @return 
		 * 
		 */
		public function getVal(text:String):Number
		{
			var value:int=Number(text);
			return  value;
		}
		
		
		/**
		 *判断该字符创是否全是数字 
		 * @param test
		 * @return 
		 * 
		 */
		public function isNumber(test:String):Boolean
		{
			var isNum:Boolean= int(test).toString()== test;
			return isNum;
		}
		
		/**
		 * 将该字符强制转换为字符串 
		 * @param test
		 * @return 
		 * 
		 */
		public function string(test:String):String
		{
			return string(test);
		}
		
		/**
		 *判断是否为空 
		 * @param test
		 * @return 
		 * 
		 */
		public function checkNull(test:String):Boolean
		{
			if(test)return false;
			else{
				return true;
			}
			
		}
		
		/**
		 *字符转小写 
		 * @param test
		 * @return 
		 * 
		 */
		public function LowerCase(test:String):String
		{
			return test.toLowerCase();
		}
		
		/**
		 *字符转大写 
		 * @param test
		 * @return 
		 * 
		 */
		public function UpCase(test:String):String
		{
			return test.toLocaleUpperCase();
		}
		
		/**
		 * 取年 
		 * 
		 */
		public function getYear():Number
		{
			var nowData:Date=new Date();
			return nowData.fullYear;
		}
		
		/**
		 * 取月
		 * 
		 */
		public function getMonth():Number
		{
			var nowData:Date=new Date();
			return nowData.month;
		}
		
		
		/**
		 * 取日 
		 * 
		 */
		public function getDay():Number
		{
			var nowData:Date=new Date();
			return nowData.day;
		}
		
		/**
		 *返回当前日期 
		 * @return 
		 * 
		 */
		public function getNowDate():String
		{
			var nowData:Date=new Date();
			var year:Number=nowData.fullYear;
			var month:Number=nowData.month;
			var day:Number=nowData.date;
			var result:String=year+'-'+month+'-'+day;
			return result;
		}
		
		/**
		 * 判断身份证是否合法 
		 * @param idcard
		 * @return 
		 * 
		 */
		public function checkIdcard(idcard:String):Boolean
		{ 
			var pattern:RegExp = /^\s*|\s*$/;
			if(idcard =="")  
			{  
				trace("输入身份证号码不能为空!");  
				return (false);  
			}  
			
			if (idcard.length != 15 && idcard.length != 18)//必须为15位或者是18位  
			{  
				trace("输入身份证号码格式不正确1!");  
				return (false);  
			}  
			
			var area:Object={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外"};   
//			var areaArray:Array=new Array();
//			areaArray=[11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,
//				63,64,65,71,81,82,91]
//			var areaId:int=parseInt(idcard.substr(0,2));
//			for (var j:int = 0; j < areaArray.length; j++) 
//			{
//				if (areaArray[i]!=areaId)//没有匹配项的话就不合法
//				{
//					trace("身份证号码不正确(地区非法)!");  
//					return (false);  
//				}
//			}
			if(area[parseInt(idcard.substr(0,2))]==null) 
			{  
				trace("身份证号码不正确(地区非法)!");  
				return (false);  
			}   
			if (idcard.length == 15)  
			{  
				pattern= /^\d{15}$/;  
				if (pattern.exec(idcard)==null)
				{  
					trace("15位身份证号码必须为数字！");  
					return (false);  
				}  
				var birth= parseInt("19" + idcard.substr(6,2));  
				var month= idcard.substr(8,2);  
				var day= parseInt(idcard.substr(10,2));  
				switch(month) 
				{  
					case '01':  
					case '03':  
					case '05':  
					case '07':  
					case '08':  
					case '10':  
					case '12':  
						if(day>31) 
						{  
							trace('输入身份证号码不格式正确2!');  
							return false;  
						}  
						break;  
					case '04':  
					case '06':  
					case '09':  
					case '11':  
						if(day>30) 
						{  
							trace('输入身份证号码不格式正确3!');  
							return false;  
						}  
						break;  
					case '02':  
						if((birth % 4 == 0 && birth % 100 != 0) || birth % 400 == 0)//闰年
						{  
							if(day>29) 
							{  
								trace('输入身份证号码不格式正确4!');  
								return false;  
							}  
						} 
						else 
						{  
							if(day>28) {  
								trace('输入身份证号码不格式正确5!');  
								return false;  
							}  
						}  
						break;  
					default:  
						trace('输入身份证号码不格式正确6!');  
						return false;  
				}  
				var nowYear = new Date().fullYear;  
				if(nowYear - parseInt(birth)<0 || nowYear - parseInt(birth)>110)//年龄限制
				{  
					trace('输入身份证号码不格式正确7!');  
					return false;  
				}  
				return (true);  
			}  
			//系数
			var Wi:Array= new Array(  
				7,9,10,5,8,4,2,1,6,  
				3,7,9,10,5,8,4,2  
			);  
			var   lSum:Number  = 0;  
			var   nNum:Number  = 0;  
			var   nCheckSum:Number  = 0;  
			
			for (var i:int = 0; i < 17; ++i)  
			{  
				if ( idcard.charAt(i) < '0' || idcard.charAt(i) > '9' )  
				{  
					trace("输入身份证号码格式不正确8!");  
					return (false);  
				}  
				else  
				{  
					nNum = Number(idcard.charAt(i)); //获得每个位子上的数字 
				}  
				lSum += nNum * Wi[i];  //将这17位数字和系数相乘的结果相加
			}  
			if( idcard.charAt(17) == 'X' || idcard.charAt(17) == 'x')  
			{  
				lSum += 10*Wi[16];  
			}  
			else if ( idcard.charAt(17) < '0' || idcard.charAt(17) > '9' )  
			{  
				trace("输入身份证号码格式不正确9!");  
				return (false);  
			}  
			else  
			{  
				lSum += Number(( idcard.charAt(17))) * Wi[16];  
			}  
			
			var yu:Number=lSum % 11;//用加出来的和除以11，看余数是多少？ 
			
			switch(yu)//余数只可能有0－1－2－3－4－5－6－7－8－9－10这11个数字。
					 //其分别对应的最后一位身份证的号码为1－0－X －9－8－7－6－5－4－3－2 。 
			{
				case 0:
				{  
					return true;  
				}  
				case 1:
				{  
					return true;  
				}  
				case 2:
				{  
					return true;  
				}  
				case 3:
				{  
					return true;  
				}  
				case 4:
				{  
					return true;  
				}  
				case 5:
				{  
					return true;  
				}  
				case 6:
				{  
					return true;  
				}  
				case 7:
				{  
					return true;  
				}  
				case 8:
				{  
					return true;  
				}  
				case 9:
				{  
					return true;  
				}  
				case 10:
				{  
					return true;  
				} 
				default:
				{
					trace("输入身份证号码格式不正确10!");  
					return (false);  
				}
			}
		}
		/**
		 * 去除首尾空格 
		 * @param char
		 * @return 
		 * 
		 */
		public  function trim(test:String):String
		{
			var pattern:RegExp = /^\s*|\s*$/;
			return test.replace(pattern,"");
		}    
		
		/**
		 * 判断字符串中是否有中文 
		 * @param test
		 * @return 
		 * 取出字符串中的每一个字符，然后转换陈unicon编码，然后比较，如果是大于1000的，就是中文
		 */
		public function  ExistChinese(test:String):Boolean
		{  
			for (var i:int = 0; i < test.length; i++) 
			{
				if(test.charCodeAt(i) >= 1000)
				{
					//说明该字符是中文
					return  true;  
				}
			}
			return  false;  
		}  
		
//		public static const NUM_ARR:Array = ["零", "一", "二", "三", "四", "五", "六", "七", "八", "九","十"];  
//		public static const UNITS:Array = ["万","千", "百"];  
//		/**
//		 * 计算中文数值单位 
//		 * @param num
//		 * @return 
//		 * 
//		 */
//		public function toCNUpper(num:Number ):String  
//		{  
//			
//			return ;  
//		} 
		/**
		 *将15位身份证转换成18位身份证 
		 * @param cardId
		 * @return 
		 * 
		 */
		public function idCard18(cardId:String):String
		{
			var   lSum:Number  = 0;  
			var   nNum:Number  = 0;  
			////系数
			var Wi:Array= new Array(  
				7,9,10,5,8,4,2,1,6,  
				3,7,9,10,5,8,4,2,1  
			);  
			//将15位的号码转换位17位
			var cardID17:String= cardId.substring(0,6)+"19"+cardId.substring(6);
			
			for (var i:int = 0; i < 17; ++i)  
			{  
				nNum = Number(cardID17.charAt(i)); //获得每个位子上的数字 				  
				lSum += nNum * Wi[i];  //将这17位数字和系数相乘的结果相加
			}  
			var yu:Number=lSum%11;
			switch(yu)
			{
				case 0:
				{
					return cardID17+"1";
					break;
				}
				case 1:
				{
					return cardID17+"0";
					break;
				}
				case 2:
				{
					return cardID17+"X";
					break;
				}
				case 3:
				{
					return cardID17+"9";
					break;
				}
				case 4:
				{
					return cardID17+"8";
					break;
				}
				case 5:
				{
					return cardID17+"7";
					break;
				}
				case 6:
				{
					return cardID17+"6";
					break;
				}
				case 7:
				{
					return cardID17+"5";
					break;
				}
				case 8:
				{
					return cardID17+"4";
					break;
				}
				case 9:
				{
					return cardID17+"3";
					break;
				}	
				case 10:
				{
					return cardID17+"2";
					break;
				}
				default:
				{
					break;
				}
			}
			return cardID17;
	}
		/**
		 *获取身份证上的日期 
		 * @param idCard
		 * @return 
		 * 
		 */
		public function idCardDate(idCard:String):String
		{
			var date:String;
			if(idCard.length==15)
			{
				var year:String="19"+idCard.substr(6,2);
				var manth:String=idCard.substr(8,2);
				var day:String=idCard.substr(10,2);
				date=year+"-"+manth+"-"+day;
				
			}
			if(idCard.length==18)
			{
				var year1:String=idCard.substr(6,4);
				var manth1:String=idCard.substr(8,2);
				var day1:String=idCard.substr(10,2);
				date=year1+"-"+manth1+"-"+day1;
			}
			return date;
		}
		
		/**
		 * 字符串定位 
		 * @param substring
		 * @param totalstring
		 * @return 
		 * 
		 */
		public function strpos(substring:String,totalstring:String):int
		{
			var pos:int=totalstring.indexOf(substring,0);
			return pos;
		}
		
		/**
		 * 去绝对值 
		 * @param test
		 * @return 
		 * 
		 */
		public function getAbs(test:String):Number
		{
			var newNum:int=Math.abs(Number(test));
			return newNum;
		}
		
		/**
		 * 向下取近似值
		 * @param test
		 * @return 
		 * 
		 */
		public function getFloor(test:String):Number
		{
			var floorNum:Number=Math.floor(Number(test));
			return floorNum;
		}
		
		public static function testPressure(obj:Object):void
		{
			for(var i:int=0;	i<50;	i++)
			{
				var testObj:Sprite	=	new obj();
			}
		}
		
 }
}