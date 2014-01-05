package naga.global 
{	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import naga.system.MemeryProtect;
	import naga.ui.Backgroud;
	import naga.ui.MyMouse;
	
//	import starling.display.Sprite;

	public class Global
	{
		/**
		 * 1 = 中文
		 * 2 = English
		 */
		public static var language:int=1;
		public static var game_view_x:int;
		public static var game_view_y:int;
		public static var game_view_w:int;
		public static var game_view_h:int;
		public static var stage_w:int;
		public static var stage_h:int;
		public static var gameStage:Sprite=new Sprite();
		public static var mouse_floor:Sprite;
		public static var tp_floor:Sprite;
		public static var ui_floor:Sprite;
		public static var eff_floor:Sprite;
		public static var g_floor:Sprite;
		public static var bg_floor:Sprite;
		public static var mouse:MyMouse;
		public static var bg:Backgroud;
		public static var icons:Class;
		//		public static var touch_pan:Sprite;
		//		public static var bg_pan:Sprite;//判断鼠标是否击中游戏层
		//		public static var objectPool:ObjectPool=new ObjectPool();
		
		//		玩家数据
		public static var m_p:MemeryProtect = MemeryProtect.getInstance();
		public static var user_info:Object = {load_succes:false, name:"游客", rank:0, friend_num:0, frieds_score:[]};//玩家信息
		//		public static var user_data:Array = new Array(60);//玩家数据
//		public static var g_score:int;//游戏得分
		//		public static var gO2:int;
		public static var play_times:int = 0;//游戏次数
		public static var g_time:int = 0;//游戏单局时长
		public static var total_time:int = 0;//游戏总时长 （打开游戏）
		public static var item1:int=0;//临时道具位1
		public static var shop_item1:int=0;//商店道具位1
		
		//		游戏参数
		//		public static var is_hd:Boolean;
		public static var g_mode:Object;
		public static var g_move_sp_init:Number;
		public static var g_move_sp_max:Number;
		public static var g_move_sp:Number = 1;
		public static var g_move_sp_bak:Number = 1;
		public static const POP_MOVE_SP_SLOW:Number = .4;
		public static var g_move_sp_lv:Number = 1;
		//		public static var show_score:Boolean = false;//显示得分提示
		public static var spring:Number;//加速度
		public static var vx:Number;
		public static var vy:Number;
		public static var friction:Number;//摩擦力作用
		//		public static var gravity:Number = .1;//重力
		//		public static var valume
		
		//		监测
		public static var stop_onoff:int = 0;//游戏暂停状态
		public static var submit_onoff:Boolean = false;//是否可提交积分
		
		//		配置文件
		//		public static var item1_x:int=20;//奖励道具位1
		//		public static var item1_y:int=stage_h-180;//奖励道具位1
		//		public static var shop_item1_x:int=150;//商店道具位1
		//		public static var shop_item1_y:int=stage_h-180;//商店道具位1
		public static const INIT_POP_NUM:int=3;//初始的 白色泡泡数量 实际要-1 为bg_pan
		
	}
}