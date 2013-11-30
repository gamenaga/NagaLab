package naga.system
{
		import flash.display.Sprite;
		import flash.text.TextField;
		import flash.utils.Timer;
		
		import naga.global.Global;
		import naga.system.EventManager;

		public class ShowDebug extends Sprite
		{
			public var txt:TextField;
			protected var count:int=0;
			protected var numObject:int=0;
			
			public function ShowDebug()
			{
				init();
			}
			
			protected function init():void
			{
				txt=new TextField();//创建文本实例
				txt.textColor=0xff0000;//设置文本颜色
				txt.width=Global.game_view_w;
				txt.height=200;
				txt.multiline=true;
//				txt.mouseEnabled=false;
				this.mouseEnabled=false;
				this.mouseChildren=false;
//				txt.autoSize=TextFieldAutoSize.RIGHT;
				addChild(txt)//加载这个文本
				var myTimer:Timer = new Timer(1000);//Timer类挺好使，类似于setInterval,参数是循环间隔时间，单位是毫秒
//				myTimer.addEventListener("timer", timerHandler);//注册事件
//				this.addEventListener("enterFrame",countHandler)//注册事件，这里相当于2.0的onEnterFrame
				EventManager.AddEventFn(myTimer,"timer", timerHandler);//注册事件
				EventManager.AddEventFn(this,"enterFrame",countHandler)//注册事件，这里相当于2.0的onEnterFrame
				myTimer.start();//Timer实例需要start来进行启动
			}
			
			protected function timerHandler():void
			{
				//Timer实例调用的方法
				txt.htmlText="";
				count=0//每隔1秒进行清零
			}
			
			protected function countHandler():void
			{
				//真循环调用的方法
				count++//数值递加
			}
			
			protected function countObject():void
			{
				var i:int;
				var num:int = Global.gameStage.numChildren
				for(i = 0; i<num; i++)
				{
					
				}
				//真循环调用的方法
				count++//数值递加
			}
			
		}
		
	}
	 
	 
	//-----------------------------------应用：
	//myTimer.start();可以用快捷键来控制
	//相应的 myTimer.stop();
	 
	 
	//--------------------------------