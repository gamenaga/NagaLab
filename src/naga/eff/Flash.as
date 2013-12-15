package naga.eff
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import naga.global.Global;
	import naga.system.AlphaPan;
	import naga.system.EventManager;
	import naga.tool.ChangeColor;

	public class Flash extends Sprite
	{
		private static var _instance:Flash;
		public static function get instance():Flash
		{
			if (!_instance)
			{
				_instance = new Flash();
			}
			return _instance;
		}
		public var pan:AlphaPan = new AlphaPan();
		private var going:Boolean = false;
		private var delay_time:int;
		private var clo:String;
		private var alp:int;
		private var alp_in:int;
		
		public function Flash()
		{
			pan.x = -10;
			pan.y = -10;
			pan.alpha = 0;
		}
		/**
		 * 
		 * @param time 延续的时长（毫秒） 如果<0，表示永久，需手动执行goBack
		 * @param color
		 * @param alpha
		 * 
		 */		
		public function go(time:int = 0, mouseEnable:Boolean = false, color:String = "ffffff", alpha:int = 20, alphaIn:int = 5):void
		{
			if(!Global.tp_floor.contains(pan))
			{
				Global.tp_floor.addChild(pan);
			}
			delay_time = time;
			pan.mouseEnabled = mouseEnable;
			alp = alpha;
			alp_in = alphaIn;
			var temp_alp:int;
			if(time >= 0 || clo != color)
			{
				temp_alp = 0;
			}
			else
			{
				temp_alp = pan.alpha * 100;
			}
//			trace(60,clo,color,temp_alp);
			if(clo != color || temp_alp == 0)
			{
				clo = color;
				ChangeColor.go(pan, color, 0);
			}
			else
			{
				ChangeColor.go(pan, color, temp_alp*.01);
			}
			
			if(going)
			{
				EventManager.delAllEvent(pan);
			}
			else
			{
				going = true;
			}
			EventManager.delAllEvent(pan);
			EventManager.AddEventFn(pan,Event.ENTER_FRAME, next);
		}
		private function next():void
		{
//			trace(pan.alpha);
			if(pan.alpha < alp*.01)
			{
				pan.alpha += alp_in * .01;
			}
			else
			{
				pan.alpha = alp*.01;
				EventManager.delEventFn(pan,Event.ENTER_FRAME,next);
				if(delay_time >= 0)
				{
					setTimeout(goBack, delay_time);
				}
			}
		}
		public function goBack(mouseEnable:Boolean = false):void
		{
			pan.mouseEnabled = mouseEnable;
			EventManager.AddEventFn(pan,Event.ENTER_FRAME, prev);
		}
		
		private function prev():void
		{
//			trace(pan.alpha)
			if(pan.alpha > 0)
			{
				pan.alpha -= alp_in * .01;
			}
			else
			{
				EventManager.delEventFn(pan,Event.ENTER_FRAME, prev);
				going = false;
				pan.alpha = 0;
//				trace(115,Global.tp_floor.contains(pan));
				if(Global.tp_floor.contains(pan))
					{
						Global.tp_floor.removeChild(pan);
					}
//				trace(115,Global.tp_floor.contains(pan));
			}
		}
	}
}