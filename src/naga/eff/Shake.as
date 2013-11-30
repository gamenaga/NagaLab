package naga.eff
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import naga.system.EventManager;
	import naga.global.Css;

    public class Shake
    {
        private static var s_list:Array = new Array();
        private static var event_obj:Sprite = new Sprite();

        public static function add(obj:DisplayObject, time:int = 500, dis:int = 0, x_able:Boolean = true, y_able:Boolean = true) : void
        {
            if (!obj.hasEventListener(Event.ENTER_FRAME))
            {
				if(dis == 0) dis = Css.SIZE*.2;
                s_list.push(new Array(obj, obj.x, obj.y, dis, x_able, y_able, true));
//                obj.addEventListener(Event.ENTER_FRAME, shaking);//用空事件记录其shake状态
				EventManager.AddEventFn(obj,Event.ENTER_FRAME, shaking);
                if (!event_obj.hasEventListener(Event.ENTER_FRAME))
                {
//                    event_obj.addEventListener(Event.ENTER_FRAME, eff_do);
					EventManager.AddEventFn(event_obj,Event.ENTER_FRAME, eff_do);
                }
                if (time > 0)
                {
                    setTimeout(remove, time, (s_list.length - 1));
                }
            }
        }// end function

        private static function shaking() : void
        {
        }// end function

        public static function remove(num:int) : void
        {
            if (s_list[num] != null)
            {
                s_list[num][6] = false;
                ;
            }
        }// end function

        public static function stop() : void
        {
            var temp:String;
            for (temp in s_list)
            {
                s_list[temp][6] = false;
            }
        }// end function

        private static function eff_do() : void
        {
            var temp:String;
            var num:int = 0;
            for (temp in s_list)
            {
                
                if (s_list[temp][6])
                {
                    if (s_list[temp][4])
                    {
                        s_list[temp][0].x = s_list[temp][1] + (Math.random() - 0.5) * s_list[temp][3];
                    }
                    if (s_list[temp][5])
                    {
                        s_list[temp][0].y = s_list[temp][2] + (Math.random() - 0.5) * s_list[temp][3];
                    }
                    num = num + 1;
                    continue;
                }
                if (s_list[temp][0].hasEventListener(Event.ENTER_FRAME))
                {
//                    s_list[temp][0].removeEventListener(Event.ENTER_FRAME, shaking);
					EventManager.delEventFn(s_list[temp][0],Event.ENTER_FRAME, shaking);
                    s_list[temp][0].x = s_list[temp][1];
                    s_list[temp][0].y = s_list[temp][2];
                }
            }
            if (num == 0)
            {
//                event_obj.removeEventListener(Event.ENTER_FRAME, eff_do);
				EventManager.delEventFn(event_obj,Event.ENTER_FRAME, eff_do);
                s_list = new Array();
            }
        }// end function

    }
}
