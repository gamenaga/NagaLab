package pop
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import audio.Music;
	
	import eff.E2Bomb;
	import eff.E6Flash;
	import eff.E6FlashBlack;
	
	import game.LvUp;
	import game.ModeNormal;
	
	import item.I10HP;
	import item.I12HPMax;
	import item.I1SpeedDown;
	import item.I2Clear;
	import item.I3Bad;
	import item.I4AddPop;
	import item.I5Stop;
	import item.I6PopZoom;
	import item.I7Ink;
	import item.I8Fog;
	import item.I9AddSilver;
	import item.Item;
	
	import naga.eff.Flash;
	import naga.eff.Vision;
	import naga.global.Css;
	import naga.global.Global;
	import naga.system.Bubble;
	import naga.system.DataObj4399;
	import naga.system.EventManager;
	import naga.system.IPoolable;
	import naga.system.ObjPool;
	import naga.system.Sounds;
	
	import ui.HpBar;

    public class Pop extends Sprite implements IPoolable
    {
        public var p:PicPop;
        public var num:int;
        protected var sp:Number;//泡泡移动变速系数
		protected var speed2:int;//泡泡偏向移动系数
        protected var path:int;
		protected var warn:Class;
		protected var warntime:int;
		protected var scale:Number;
		protected var vx:Number;
		protected var vy:Number;
        protected var color:String;
        protected var score:int;
        protected const POP_WHITE:int = 10;//白色泡泡分值
        protected const POP_BLUE:int = 50;
        protected const POP_RED:int = -100;
		private var state:int;// 泡泡的状态
		private const STATE_INIT:int = 0;
		private const STATE_MOVE:int = 1;
        public var items:Item = null;//有无道具
        public var bomb_chk:int = 1;
        public var missed:Boolean = false;
        public var is_bomb:Boolean = false;
        private var is_out:Boolean = false;
        private const move_rand:Number = 0.4;//移动偏移量
        private const move_rand2:Number = -0.45;
		protected var warnTimer:Timer=new Timer(0,1);//警示计时器
		protected var _destroyed:Boolean;

        public function Pop(id:int,movePath:int,warnMC:Class=null,warnTime:int=0)
        {
//			trace("pop 62:	"+arguments.length);
//            add(id,movePath,warnMC,warnTime);
			_destroyed = true;
			renew(id,movePath,warnMC,warnTime);
        }// end function
		
		/* INTERFACE IPoolable */
		
		public function get destroyed():Boolean 
		{
			return _destroyed;
		}
		
		public function renew(...paramenters):void 
		{
//			trace("pop 72:	"+this,paramenters+"	"+paramenters[1]);
			if(paramenters[1]!=0)
			{
				num=paramenters[0];//id;
				path=paramenters[1];//movePath;
				
				warn=paramenters[2];//warnMC;
				warntime=paramenters[3];//warnTime;
//				trace("pop 80:	"+this,num+"	"+path+"	"+warn+"	"+warntime);
				mouseEnabled = false;
				//			mouseChildren=false;
				//            num = id;
				//			path = movePath;
				sp = (Math.random()*3 + 2/path)*PopFactory.sca_eff;
				//随机出现高速泡泡
				if(Math.random() > .1)
				{
					sp = sp*2;
				}
				speed2=2*PopFactory.sca_eff;
				//			scale=1;
				//			items = null;//有无道具
				bomb_chk = 1;
				state = STATE_INIT;
				missed = false;
				is_bomb = false;
				is_out = false;
				alpha=1;
				vx=Global.vx;
				vy=Global.vy;
				scale = (1.3 + Math.random() * 0.5) * PopFactory.sca_eff;
//				trace(scale);
				if(p==null) 
				{
//					trace("pop 110:	"+this+"	ID:"+p);
					p=new PicPop();
				}
				else
				{
					//				for(var i:int=0;i< p.numChildren;i++)
					//				{
					//					trace("pop 93:	"+p.getChildAt(i));
					//				}
					//				trace("pop 95:	pic2:"+p.pic2.visible+"	ID:"+num+"	numChildren:"+p.numChildren);
					if(!p.pic2.visible) p.pic2.visible=true;
//					if(items)
//					{
//						if(p.contains(items))
//							{
////							items.del();
//							ObjPool.instance.returnObj(items);
////								p.removeChild(items);
//							}
//						items=null;
//					}
				}
				//			trace("pop 86:	"+p.scaleX+"	"+p.alpha+"	"+p.visible);
				p.mouseEnabled = true;
				//			trace("pop 84:	"+this+"	"+PopFactory.sca_eff+"	"+scale)
				//            p = Global.objectPool.getObj(PicPop) as PicPop;
				//			p=ObjPool.instance.getObj(PicPop) as PicPop;
				p.popBC.alpha = 1;
				p.mouseChildren = false;
				p.scaleX = scale;
				p.scaleY = scale;
				value();
				//			p.pic.visible = false;
				//			trace("pop 72	path:"+path);
				this["create"+path].call();
				if (!contains(p))
				{
					addChild(p);
				}
				if(warn)
				{
					warning();
				}
				else
				{
//					p.addEventListener(Event.ENTER_FRAME, this["come_in_" + path]);
					seckilling();
					EventManager.AddEventFn(p,Event.ENTER_FRAME, this["come_in_" + path]);
				}
			}
			
			if (!_destroyed)
			{
				return;
			}
			
			_destroyed = false;
			
			/* 创建内容 */
			//			add();
			
		}
		
		public function destroy():void 
		{
			
			//检测各模式的成就
			Main.mode.chkAch();
			/* 移出场景 */
			if(p!=null)
			{
				if(p.hasEventListener(Event.ENTER_FRAME))
				{
					EventManager.delAllEvent(p);
//					EventManager.delEventFn(p,Event.ENTER_FRAME, this["move_" + path]);
//					EventManager.delEventFn(p,Event.ENTER_FRAME, this["come_in_" + path]);
				}
				if(warn)
				{
					warn = null;
					Vision.instance.remove("warn"+num);//,true,true);
					//					warnTimer.stop();
//					warnTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,warnOver);
					EventManager.delEventFn(warnTimer,TimerEvent.TIMER_COMPLETE,warnOver);
				}
				//			trace("pop 533:	id:"+num+"	hasEvent:"+p.hasEventListener(Event.ENTER_FRAME));
				//            if (!is_out)
				//            {
				//            }
				if(items)
				{
					if(p.contains(items))
					{
						//							items.del();
						ObjPool.instance.returnObj(items);
					}
					items=null;
				}
//				if (contains(p))
//				{
//					removeChild(p);
					//				p=null;
					//				Global.objectPool.returnObj(p);
					//				ObjPool.instance.returnObj(p);
					parent.removeChild(this);
					//				parent.getChildByName(this.name)=null;
					//				this.visible=false;
//				}
			}
			if (_destroyed)
			{
				return;
			}
			_destroyed = true;
		}
		
		//产出泡泡前，警示
		protected function warning():void
		{
			warnTimer.reset();
			warnTimer.delay=warntime;
			EventManager.AddEventFn(warnTimer,TimerEvent.TIMER_COMPLETE,warnOver);
			warnTimer.start();
			//警告提示图标坐标
			var x:int;
			var y:int;
			if(p.x<50)
			{
				x=50;
			}
			else if(p.x>Global.game_view_w-50)
			{
				x=Global.game_view_w-50;
			}
			else
			{
				x=p.x;
			}
			if(p.y<150)
			{
				y=150;
			}
			else if(p.y>Global.game_view_h-50)
			{
				y=Global.game_view_h-50;
			}
			else
			{
				y=p.y;
			}
//						trace("pop 102:	warning	id"+PopFactory.popID,num+"	"+warntime);
			Vision.instance.add("warn"+num,warn,Global.eff_floor,x,y,null,1,0,1,0,true);
		}
		
		//产出泡泡前，是否需要先警示
		protected function warnOver():void
		{
			warn = null;
			Vision.instance.remove("warn"+num);//,true,true);
//			warn = null;
//			warnTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,warnOver);
			EventManager.delEventFn(warnTimer,TimerEvent.TIMER_COMPLETE,warnOver);
//			p.addEventListener(Event.ENTER_FRAME, this["come_in_" + path]);
			EventManager.AddEventFn(p,Event.ENTER_FRAME, this["come_in_" + path]);
		}
		
		private function seckilling():void
		{
			warnTimer.reset();
			warnTimer.delay=500;
			EventManager.AddEventFn(warnTimer,TimerEvent.TIMER_COMPLETE,seckillOver);
			warnTimer.start();
		}
		private function seckillOver():void
		{
			EventManager.delEventFn(warnTimer,TimerEvent.TIMER_COMPLETE,seckillOver);
			state = STATE_MOVE;
		}

        public function addItem(id:int, sca:Number = 1) : void
        {
			//指定生产道具
            if (id == 1)
            {
                items = ObjPool.instance.getObj(I1SpeedDown,null,num,id,true)as Item;//new I1SpeedDown(num,true);
//				items
            }
            else if (id == 2)
            {
                items = ObjPool.instance.getObj(I2Clear,null,num,id,true)as Item;// new I2Clear(num,true);
            }
            else if (id == 3)
            {
                items = ObjPool.instance.getObj(I3Bad,null,num,id,false) as Item;
            }
            else if (id == 4)
            {
                items = ObjPool.instance.getObj(I4AddPop,null,num,id,true,3000+num*2)as Item;// new I4AddPop(num,false,3000+num*2);
            }
            else if (id == 5)
            {
                items = ObjPool.instance.getObj(I5Stop,null,num,id,true,2000)as Item;// new I5Stop(num,true);
            }
            else if (id == 6)
            {
                items = ObjPool.instance.getObj(I6PopZoom,null,num,id,false,8000)as Item;//new I6PopZoom(num,false);
            }
            else if (id == 7)
            {
                items = ObjPool.instance.getObj(I7Ink,null,num,id,false,8000)as Item;//new I7Ink(num,false);
            }
            else if (id == 8)
            {
                items = ObjPool.instance.getObj(I8Fog,null,num,id,false)as Item;//new I8Fog(num,false);
            }
			else if (id == 9)
			{
				items = ObjPool.instance.getObj(I9AddSilver,null,num,id,false)as Item;//new I9AddSilver(num,false);
			}
			else if (id == 10)
			{
				items = ObjPool.instance.getObj(I10HP,null,num,id,false)as Item;
			}
			else if (id == 12)
			{
				items = ObjPool.instance.getObj(I12HPMax,null,num,id,false)as Item;
			}
            items.scaleY = sca;
            items.scaleX = sca;
            items.x = (-items.width) * 0.5;
            items.y = (-items.height) * 0.5;
            p.addChild(items);
			p.setChildIndex(items,0);//道具置底
//			trace("pop 366:	"+this+"	ID:"+num+"	numChildren:"+p.numChildren);
        }// end function
		

        protected function value() : void
        {
        }// end function

        public function bombClick(event:Event = null) : void
        {
			bomb_click();
			chkBomb();
        }// end function
		protected function bomb_click() : void
		{
		}// end function
		
		protected function out() : void
		{
//			p.removeEventListener(Event.ENTER_FRAME, this["move_" + path]);
			EventManager.delAllEvent(p);
			is_bomb = true;
			whenDel();
			is_out = true;
			miss();
//			if (items)
//			{
//				ObjPool.instance.returnObj(items);
//			}
//			else
//			{
				ObjPool.instance.returnObj(this);
//			}
		}// end function
		
		protected function miss() : void
		{
			missed = true;
			if (Main.mode.game_state==Main.mode.STATE_PLAY && !SafeTime.isSafe)
			{
				Sounds.play(Se_bad);
				Main.mode.combo_over();
				HpBar.changeHP(-1);
				ModeNormal.overX=p.x;
				ModeNormal.overY=p.y;
//				Vision.instance.add("Out" + num, E6FlashBlack,Global.eff_floor, 0, 0, null, 0.3, 500,1,0,false,true,true);
				Flash.instance.go(0, false,  "000000");
				Bubble.instance.show("<b>呀！跑了</b>", Bubble.TYPE_SCORE, p.x, p.y, 160, Css.SIZE, Css.SILVER,true);
			}
		}// end function
		
		protected function popBombEff() : void
		{
//			Vision.instance.add("Out" + num, E6Flash,Global.eff_floor, 0, 0, null, scale*.1, 10,1,0,false,true,true);
			if(PopFactory.state != 2)
			{
				Vision.instance.add("bomb" + num, E2Bomb,Global.eff_floor, p.x, p.y, "ffffff", 1, 500, scale,0,false,false,true);
				
			}
			else
			{
				var rand:int = int(Math.random()*7);
//				trace(rand);
				var color : String;
				switch (rand)
				{
					case 0 : 
						color = "553D83";
						break;
					case 1 : 
						color = "3B60BB";
						break;
					case 2 : 
						color = "33A0FA";
						break;
					case 3 : 
						color = "43CD86";
						break;
					case 4 : 
						color = "FFDE64";
						break;
					case 5 : 
						color = "FFA132";
						break;
					default : 
						color = "EA1600";
				}
				Flash.instance.go(0, false, color);
				Vision.instance.add("bomb" + num, E2Bomb,Global.eff_floor, p.x, p.y, color, 1, 500, scale*1.5, 0, false,false,true);
			}
		}
		
        public function pop_bomb() : void
        {
			if( !is_bomb )
			{
				is_bomb = true;
				whenDel();
				if(p!=null)
				{
					EventManager.delAllEvent(p);
					//				trace("pop 373:	"+p.hasEventListener(Event.ENTER_FRAME));
					//				EventManager.delEventFn(p,Event.ENTER_FRAME,pudding);
					//				if(p.hasEventListener(Event.ENTER_FRAME))
					//				{
					//					EventManager.delEventFn(p,Event.ENTER_FRAME, this["move_" + path]);
					//				}
					//			Safe_t.safe();
					achCount();
					if(score>0 || !missed)
					{
						var score2:int;
						score2 = int(score + Math.sqrt(Main.mode.game_combo));
						
						if(state == STATE_INIT)
						{
							score2 *= 1.5;
						}
						if(Main.mode.game_type == Global.TYPE_TALENT.name)
						{
							score2 *= 2;
						}
						Global.m_p.setValueByFun("score",changeScore);
						//					trace("pop 391: ",score,Global.m_p.getValue("score"))
						function changeScore(value:*):int
						{
							if(value+score2>0){
								value = value + score2;
								if(DataObj4399.serviceHold){
									DataObj4399.serviceHold.changeScore(value); //socre为当前总分数变量，类型为int    
								}
							}
							else{
								value=0;
							}
							return value
						}
					}
					//				MttScore.score = Global.m_p.getValue("score");
					//			Main.o2 = Main.o2 + Math.sqrt(Main.game_combo * 2);
					// 连击计算
					if(score2>0)
					{
						if(PopFactory.state != 2)
						{
							if(state == STATE_INIT)
							{
								Main.mode.game_seckill ++;
								Main.mode.game_seckill_combo ++;
							}
							else
							{
								Main.mode.game_seckill_combo =0;
								Main.mode.game_combo ++;
								if(Main.mode.game_combo > Main.mode.hi_combo)
								{
									Main.mode.hi_combo = Main.mode.game_combo;
								}
							}
						}
						Main.mode.chk_score(p.x, p.y, score2);
					}
					popBombEff();
					//				trace("pop 399:	",items,missed);
					if (items)
					{
						p.mouseEnabled = false;
						p.pic2.visible=false;
						if(!missed)
						{
							items.achCount();
							items.item_do();
						}
						else
						{
							ObjPool.instance.returnObj(this);
						}
					}
					else{
						ObjPool.instance.returnObj(this);
					}
				}
				else
				{
					ObjPool.instance.returnObj(this);
				}
			}
        }// end function

//        protected function popDel() : void
//        {
//			whenDel();
//			p.removeEventListener(Event.ENTER_FRAME, this["come_in_" + path]);
//			if(warnTimer)
//			{
//			warnTimer.stop();
//			warnTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,warnOver);
//			}
////			trace("pop 400:	id:"+num+"	hasEvent:"+p.hasEventListener(Event.ENTER_FRAME));
////            if (!is_out)
////            {
////            }
//            if (items != null && !missed)
//            {
////				trace("pop   367:    "+items.isItemActive+"     parent:"+parent);
////				if(items.isItemActive){
////					E6_moveTo.add(this,10,Global.item1_x,Global.item1_y,1,1.5);
////				}
////				else{
////				trace("poop 350	:	items:"+items.icon.currentFrame);
//				items.item_do();
////				}
////                p.mouseChildren = false;
//				p.mouseEnabled = false;
////                p.pic2.visible = false;
//				p.removeChild(p.pic2);
//            }
//            else if (contains(p))
//            {
//				removeChild(p);
////				p=null;
////				Global.objectPool.returnObj(p);
////				ObjPool.instance.returnObj(p);
//                parent.removeChild(this);
////				parent.getChildByName(this.name)=null;
////				this.visible=false;
//            }
//        }// end function

//		计数
        protected function achCount() : void
        {
        }// end function

//		泡泡删除时，各种泡泡的一些特殊处理项目
        protected function whenDel() : void
        {
        }// end function
		
		
		
		/**
		 * 泡泡弹性效果*/
		protected function pudding(e:Event):void
		{
			var dx:Number = scale - e.target.scaleX;
			var dy:Number = scale - e.target.scaleY;
			var ax:Number = dx * Global.spring;
			var ay:Number = dy * Global.spring;
			vx +=  ax;
			vy +=  ay;
			vx *=  Global.friction;
			vy *=  Global.friction;
//			vy += gravity;
			e.target.scaleX +=  vx*scale;
			e.target.scaleY +=  vy*scale;
//			trace("pop 303:	"+e.target,dx,dy,ax,ay,vx,vy,e.target.scaleX,e.target.scaleY);
		}
		
		//创建泡泡的初始位置
		private function create0() : void
		{
			p.x = Math.random() * (Global.game_view_w);// - p.width) + p.width * 0.5;
			p.y = Global.game_view_h + p.height * 0.5;
		}
		private function create1() : void
		{
			p.x = Math.random() * (Global.game_view_w - p.width*.6) + p.width * 0.3;
			p.y = Global.game_view_h + p.height * 0.5;
			//			trace("pop 87	:"+p.x+"	"+p.y);
		}
		private function create2() : void
		{
			p.x = Math.random() * (Global.game_view_w - p.width*.6) + p.width * 0.3;
			p.y = (-p.height) * 0.5;
		}
		private function create3() : void
		{
			p.x = Global.game_view_w + p.width * 0.5;
			p.y = Math.random() * (Global.game_view_h - p.height*.6) + p.height*.3;
		}
		private function create4() : void
		{
			p.x = (-p.width) * 0.5;
			p.y = Math.random() * (Global.game_view_h - p.height*.6) + p.height*.3;
		}
		
		private function come_in_0(event:Event=null) : void
		{
		}// end function
		
		private function come_in_1(event:Event=null) : void
		{
			p.y = p.y - (Global.g_move_sp * 10);
			if (p.y < Global.game_view_h - p.height * 0.3)
			{
				come_o();
			}
		}// end function
		
		private function come_in_2(event:Event=null) : void
		{
			p.y = p.y + (Global.g_move_sp * 10);
			if (p.y > p.height * 0.3)
			{
				come_o();
			}
		}// end function
		
		private function come_in_3(event:Event=null) : void
		{
			p.x = p.x - (Global.g_move_sp * 10);
			if (p.x < Global.game_view_w - p.width * 0.3)
			{
				come_o();
			}
		}// end function
		
		private function come_in_4(event:Event=null) : void
		{
			p.x = p.x + (Global.g_move_sp * 10);
			if (p.x > p.width * 0.3)
			{
				come_o();
			}
		}// end function
		
		private function come_o() : void
		{
//			p.removeEventListener(Event.ENTER_FRAME, this["come_in_" + path]);
			EventManager.delEventFn(p,Event.ENTER_FRAME, this["come_in_" + path]);
//			p.addEventListener(Event.ENTER_FRAME, this["move_" + path]);
			if(PopFactory.state == 2)
			{
				popClear();
			}
			else
			{
			EventManager.AddEventFn(p,Event.ENTER_FRAME, this["move_" + path]);
			if(bomb_chk>1 || Global.g_move_sp < Global.TYPE_NORMAL.move_sp*2.3) {
//				p.addEventListener(Event.ENTER_FRAME,pudding);
				EventManager.AddEventFn(p,Event.ENTER_FRAME,pudding,null,true);
			}
			}
		}// end function
		
		public function popClear():void
		{
			Music.play();
			state = STATE_MOVE;
			missed = true;
			pop_bomb();
		}
		
		public function move_0(event:Event=null) : void
		{
			
//			p.removeEventListener(Event.ENTER_FRAME, this["move_" + path]);
			EventManager.delEventFn(p,Event.ENTER_FRAME, this["move_" + path]);
		}
		public function move_1(event:Event=null) : void
		{
			if (p.y < (-p.height) * 0.5)
			{
				out();
				return;
			}
			p.y = p.y - sp * Global.g_move_sp * Global.g_move_sp_lv ;
			if (p.x <= Global.game_view_w * 0.5)
			{
				//获得0或1 —— Math.round(Math.random() - move_rand2)
				p.x = p.x + (Math.random() - move_rand) * speed2 * Math.round(Math.random() - move_rand2) * Global.g_move_sp;
			}
			else
			{
				p.x = p.x + ((Math.random() - 1) + move_rand) * speed2 * Math.round(Math.random() - move_rand2) * Global.g_move_sp;
			}
			
		}// end function
		
		public function move_2(event:Event=null) : void
		{
			if (p.y > Global.game_view_h + p.height * 0.5)
			{
				out();
				return;
			}
			p.y = p.y + sp * Global.g_move_sp * Global.g_move_sp_lv ;
			if (p.x <= Global.game_view_w * 0.5)
			{
				p.x = p.x + (Math.random() - move_rand) * speed2 * Math.round(Math.random() - move_rand2) * Global.g_move_sp;
			}
			else
			{
				p.x = p.x + ((Math.random() - 1) + move_rand) * speed2 * Math.round(Math.random() - move_rand2) * Global.g_move_sp;
			}
			
		}// end function
		
		public function move_3(event:Event=null) : void
		{
			
			if (p.x < (-p.width) * 0.5)
			{
				out();
				return;
			}
			p.x = p.x - sp * Global.g_move_sp * Global.g_move_sp_lv ;
			if (p.y <= Global.game_view_h * 0.5)
			{
				p.y = p.y + (Math.random() - move_rand) * speed2 * Math.round(Math.random() - move_rand2) * Global.g_move_sp;
			}
			else
			{
				p.y = p.y + ((Math.random() - 1) + move_rand) * speed2 * Math.round(Math.random() - move_rand2) * Global.g_move_sp;
			}
			
		}// end function
		
		public function move_4(event:Event=null) : void
		{
			if (p.x > Global.game_view_w + p.width * 0.5)
			{
				out();
				return;
			}
			p.x = p.x + sp * Global.g_move_sp * Global.g_move_sp_lv ;
			if (p.y <= Global.game_view_h * 0.5)
			{
				p.y = p.y + (Math.random() - move_rand) * speed2 * Math.round(Math.random() - move_rand2) * Global.g_move_sp;
			}
			else
			{
				p.y = p.y + ((Math.random() - 1) + move_rand) * speed2 * Math.round(Math.random() - move_rand2) * Global.g_move_sp;
			}
			
		}// end function
		
		protected function chkBomb():void
		{
			if (bomb_chk <= 0)
			{
//				trace("pop 647 :	chkBomb !");
				pop_bomb();
			}
		}
		
		public function dispose():void
		{
			
		}
    }
}
