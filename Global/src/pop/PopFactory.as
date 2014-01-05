package pop
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import game.LvUp;
	
	import item.I11O2Time;
	
	import naga.global.Global;
	import naga.system.EventManager;
	import naga.system.ObjPool;

	public class PopFactory
	{
		public static var popID:int;
		public static var pop_type:int;
		public static var pop_type_init:int;
		public static var popNumMax:int;//同屏最大泡泡数量
		public static var popNumMaxItem:int;//道具状态 生产更多泡泡的上限
		public static var popNumMaxBad:int;//红泡泡上限
		public static const PATH_NONE:int=0;
		public static const PATH_DOWN:int=1;
		public static const PATH_UP:int=2;
		public static const PATH_RIGHT:int=3;
		public static const PATH_LEFT:int=4;
		public static const PATH_LEFT_RIGHT:int=7;
		public static const PATH_UP_DOWN:int=8;
		public static const PATH_AROUND:int=9;
		/**
		 * 0-不移动 1-向下 2-上 3-左 4-右 8-上下 9-上下左右
		 */
		public static var path:int=PATH_UP_DOWN;//0不移动 1单个方向   8上下 9上下左右
//		public static var path:int;//0不移动 11～14单个方向 
		public static var sca_eff:Number;
		public static var white_pop:int = 0;
		public static var white_item:int = 0;
		public static var blue_pop:int = 0;
		public static var rainbow_pop:int = 0;
		public static var bad_pop:int = 0;
		/**
		 *泡泡工厂的状态
		 * 0 正常：数量上限正常
		 * 1 暴走状态：数量上限提升
		 * 2 欢乐时光状态：无上限限制 
		 */
		public static var state:int = 0;//当前道具的状态
		public static var g_sp_max:int;
		public static var g_sp_min:int;
		public static var g_sp:int;
		public static var g_sp_bak:int = 9999;
		public static var timer:Timer = new Timer(g_sp_max);//泡泡产出速度控制器
		public static var spLock:int = 0;
		public static var isPathLock:Boolean = false;
		
		public function PopFactory()
		{
		}
		
		public static function init() : void
		{
			//			timer.addEventListener(TimerEvent.TIMER, addPop);
			EventManager.AddEventFn(timer,TimerEvent.TIMER, addPop);
			timer.start();
		}// end function
		
		public static function addPop() : void
		{
//			trace("popFactory 50:	"+(Global.g_floor.numChildren-(red_pop+blue_pop+black_pop))+" / "+popNumMaxItem+" / "+popNumMax+" / "+Main.game_combo_level);
			//			当 泡泡数量在限定范围内  或者  当前为道具状态     生产泡泡
//						trace("popFactory	60:	"+Global.g_floor.numChildren,white_pop,blue_pop,red_pop);
			if (white_pop < popNumMax-blue_pop-rainbow_pop || (state > 0 && Global.g_floor.numChildren < popNumMaxItem + bad_pop))// || (state == 2 && Global.g_floor.numChildren < popNumMaxItem * 1.5))
			{
				
				var path_:int=getPath();
				//				trace("popFactory 60：	"+path+"	"+path_);
				var p:Pop = null;
//				测试用
//				p = ObjPool.instance.getObj(PopRainbow,null,popID, path_) as Pop;
//				popID ++;
//				/*
//				o2 = o2 - 10;//产生泡泡 氧气自减
//				生产方式判断
				var temp:int;
				if (pop_type == 0)
				{//随机生产
					temp = Math.random()*100;
				}
				else if (pop_type == 100)
				{//提高蓝泡泡概率
					temp = Math.random()*50 + 50;
				}
				else
				{//指定生产
					temp = pop_type;
				}
				//				trace("main	229:	pop_type:"+pop_type+"	"+temp);
				
				//				根据概率生产泡泡
				if (temp < 80-Main.mode.game_combo_level)
				{//如果随机值<80  或者 场上有2个以上蓝泡泡   生产白泡泡
					p = ObjPool.instance.getObj(PopWhite,null,popID, path_) as Pop;
					popID ++;
				}
				else if (temp < 85-Main.mode.game_combo_level && blue_pop ==0)
				{//如果随机值<90  或者 场上有2个以上红泡泡   生产蓝泡泡
					p = ObjPool.instance.getObj(PopBlue,null,popID, path_) as Pop;
//					p.init(popID, path_);
//					trace("popFactory 85:	"+p.x+"	"+p.y+"	"+p.visible+"	"+p.width+"	"+p.height+"	"+p.alpha+"	"+p.scaleX+"	");
					popID ++;
				}
				else if (rainbow_pop<1 && temp >= 102- Math.min(8,Global.m_p.getValue("score")*.001))
				{//每1000分 黑泡泡出现概率提升1%
					p = ObjPool.instance.getObj(PopRainbow,null,popID, path_) as Pop;
//					p.init(popID, path_);
					popID ++;
				}
				else if(bad_pop<popNumMaxBad)
				{
					p = ObjPool.instance.getObj(PopBlack,null,-popID, path_,E9warn_,2000) as Pop;
//					p.init(0, path_,E9warn_);
				}
				else
				{
					p = ObjPool.instance.getObj(PopWhite,null,popID, path_) as Pop;
					popID ++;
//					return;
				}
//				*/
				
				
				Global.g_floor.addChild(p);
				
				//				如果游戏速度未到最快 且 模式为正常    生产泡泡的速度加快
				if (g_sp > g_sp_min)
				{
					g_sp --;
//					trace("popFactory 92:	"+Global.g_sp);
					timer.delay = g_sp*.1;
				}
				
				if(Global.g_move_sp_bak < Global.g_move_sp_max && Main.mode.game_state==Main.mode.STATE_PLAY && !I11O2Time.iDoing)
				{
//					trace("popFactory 104	:"+Global.g_move_sp_bak);
					changeMoveSp(Global.g_move_sp_bak + 0.005);
//					Global.spring+=.001;
//					Global.vx+=.0001;
//					Global.vy+=.0001;
				}
			}
			else if(state != 2)// && Global.g_floor.numChildren < popNumMaxItem * 1.5)
			{
				pause(g_sp*.2);
			}
		}// end function
		
		/**
		 *获取泡泡生产的方向 
		 * @return 方向ID
		 * 
		 */		
		private static function getPath():int
		{
			if(path==PATH_AROUND)
			{
				return (popID % 4 + 1);
//				trace("popFactory 100:	"+popID);
			}
			else if(path>0 && path<=4)
			{
				return path;
			}
			else if(path==PATH_UP_DOWN)
			{
				return popID % 2 + 1;
			}
			else if(path==PATH_LEFT_RIGHT)
			{
				return popID % 2 + 3;
			}
			else
			{
				return 0;
			}
		}
		/**
		 *暂停生产泡泡 
		 * @param time 时长
		 * @param endFunction 暂停结束后执行的函数
		 * @param param 执行函数所需参数
		 * 
		 */		
		public static function pause(time:int,endFunction:Function=null,...param):void
		{
			timer.stop();
			var endFunc:Function = function () : void
			{
				timer.start();
				if(endFunction)
				{
					if(param.length == 1)
					{endFunction(param[0]);}
					else if(param.length == 2)
					{endFunction(param[0],param[1]);}
					else
					{endFunction(param[0],param[1],param[2]);}
				}
			}
			setTimeout(endFunc,time);
		}
		/**
		 *模式创建时的 初始化 
		 * 
		 */		
		public static function modeInit(sp_min:int,sp_max:int,p_type:int, item_type:int):void
		{
			g_sp_max = sp_max *10;
			g_sp_min = sp_min *10;
			g_sp = sp_max *10;
			pop_type = p_type;
			pop_type_init = p_type;
		}
		/**
		 *游戏开始时的 初始化 
		 * 
		 */		
		public static function gameInit():void
		{
			popID = 1;
			path=PATH_UP_DOWN;
//			pathBak=PATH_UP_DOWN;
			popNumMax = Global.INIT_POP_NUM;
			popNumMaxItem= popNumMax * 2;
			popNumMaxBad = 1;
			sca_eff = 1;
			g_sp	=	g_sp_max;
		}
		/**
		 * 根据等级改变泡泡数量上限
		 * @param lv 等级
		 * 
		 */		
		public static function changePopNumMax():void
		{
//			popNumMax = Global.INIT_POP_NUM + Math.pow(LvUp.tempLv,.25);
//			popNumMaxItem = popNumMax + Math.pow(popNumMax + Main.mode.game_combo_level,.5);
			popNumMaxItem = popNumMax + Math.pow(popNumMax + Main.mode.game_combo_level,.5);
			
			popNumMaxBad = Math.min(Math.pow(LvUp.tempLv,.5) +1,5);
		}
		/**
		 * 改变泡泡生成速度
		 * @param sp 改变速度值
		 * @param spLock 加锁操作 1加锁 -1解锁(锁全部解完时，才改变速度)
		 * 
		 */
		public static function changeSpeed(speed:int,lock:int=0) : void
		{
//			trace("popFactory 234:	",speed,lock,spLock);
			if(spLock == 0 || spLock+lock == 0){
				g_sp_bak = g_sp;
				if (speed < g_sp_max)
				{
					g_sp = speed;
				}
				else
				{
					g_sp = g_sp_max;
				}
				timer.delay = g_sp*.1;
			}
			spLock	+=	spLock;
		}
		
		public static function changeMoveSp(moveSp:Number,doItNow:Boolean=true) : void
		{
			var temp_move_sp:Number = Global.g_move_sp_init * (1 + Math.pow(LvUp.tempLv, .5)/10);
//			trace("PopFactory 267:	" + moveSp,Global.g_move_sp,Global.g_move_sp_bak,temp_move_sp);
			if (moveSp < Global.g_move_sp_bak && Global.g_move_sp_bak < temp_move_sp)
			{}
//			else if(moveSp > Global.g_move_sp && Global.g_move_sp < temp_move_sp)
//			{
//				Global.g_move_sp_bak = moveSp;
//			}
			else 
			{
				Global.g_move_sp_bak = Math.max(moveSp,temp_move_sp);
				if (Global.g_move_sp > 0)
				{
					Global.g_move_sp = Global.g_move_sp_bak;
				}
			}
		}
		
//		public static function changePath(path:int,pathLock:int=0) : void
//		{
//			if(!isPathLock || pathLock == 2){
//					PopFactory.g_sp = pathLock;
//			}
//			if(pathLock == 1)
//			{
//				isPathLock	=	true;
//			}
//			else if(pathLock == 2)
//			{
//				isPathLock	=	false;
//			}
//		}
	}
}