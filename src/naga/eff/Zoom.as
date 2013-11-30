package naga.eff
{
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import naga.system.EventManager;

    public class Zoom
    {
        private static var sca_end:Number;//缩放比例
        private static var sca_chg:Number;//缩放比例变化量
        private static var t:int;//延时返回
        private static var target:Array;//所有缩放的对象
        private static var state:int = 0;//运行状态 0-待机 1-运行 2-返回
        private static var z_timer:Timer = new Timer(1);
		/**
		 *缩放 
		 * @param obj 缩放对象
		 * @param p_x 缩放对象中的最终焦点位置x坐标
		 * @param p_y 缩放对象中的最终焦点位置y坐标
		 * @param obj_rec 缩放对象的矩形
		 * @param win_rec 窗口的矩形（对象相对窗口进行缩放，如要实现全屏缩放，将窗口矩形设置为屏幕尺寸）
		 * @param time 缩放停留时长，时间结束后还原比例（如果=0，则不还原）
		 * @param sp 缩放速度（帧数）
		 * @param sca 缩放比例
		 * 
		 */
        public static function add(obj:Array, p_x:Number, p_y:Number, obj_rec:Rectangle, win_rec:Rectangle, time:int = 2000, sp:int = 10, sca:Number = 1.5) : void
        {
            if (state == 0)
            {
                state = 1;
                t = time;
                sca_end = sca;
                target = [];
				var end_x:Number = win_rec.width * 0.5;
				var end_y:Number = win_rec.height * 0.5;
                if (p_x * sca < end_x)
                {
                    end_x = p_x * sca;
                }
                else if ((obj_rec.width - p_x) * sca < win_rec.width - end_x)
                {
                    end_x = win_rec.width - (obj_rec.width - p_x) * sca;
                }
                if (p_y * sca < end_y)
                {
                    end_y = p_y * sca;
                }
                else if ((obj_rec.height - p_y) * sca < win_rec.height - end_y)
                {
                    end_y = win_rec.height - (obj_rec.height - p_y) * sca;
                }
				var mov_x:Number = NaN;
				var mov_y:Number = NaN;
				var temp:String = null;
                for (temp in obj)
                {
                    
                    target[temp] = [obj[temp], obj[temp].x, obj[temp].y, obj[temp].scaleX];
                    mov_x = (end_x - target[temp][1] - (p_x - target[temp][1] + obj_rec.x) * sca) / sp;
                    mov_y = (end_y - target[temp][2] - (p_y - target[temp][2] + obj_rec.y) * sca) / sp;
                    target[temp].push(mov_x, mov_y);
                }
                if (sca > 1)
                {
                    sca_chg = (sca - 1) / sp;
//                    z_timer.addEventListener(TimerEvent.TIMER, zoom_in);
					EventManager.AddEventFn(z_timer,TimerEvent.TIMER,zoom_in);
                }
                else
                {
                    sca_chg = (1 - sca) / sp;
//                    z_timer.addEventListener(TimerEvent.TIMER, zoom_out);
					EventManager.AddEventFn(z_timer,TimerEvent.TIMER,zoom_out);
                }
                z_timer.delay = 1;
                z_timer.start();
            }
        }// end function

//		放大
        private static function zoom_in() : void
        {
            var tar:Array = null;
            for each (tar in target)
            {
				var chg:Number = sca_chg * tar[3];
				tar[0].scaleY +=chg;
				tar[0].scaleX +=chg;
                tar[0].x += tar[4];
                tar[0].y += tar[5];
            }
            if (target[0][0].scaleX >= sca_end * target[0][3])
            {
                z_timer.stop();
//                z_timer.removeEventListener(TimerEvent.TIMER, zoom_in);
				EventManager.delEventFn(z_timer,TimerEvent.TIMER,zoom_in);
                if (state == 2)
                {//如果是返回状态，就结束缩放
                    back();
                }
                else
                {//如果不是返回状态，就定时返回
                    setTimeout(z_in_back, t);
                }
            }
            else if (target[0][0].scaleX > sca_end * target[0][3] * 0.9)
            {
                z_timer.delay += 10;
            }
        }// end function

//		放大返回
        private static function z_in_back() : void
        {
            state = 2;
//            z_timer.addEventListener(TimerEvent.TIMER, zoom_out);
			EventManager.AddEventFn(z_timer,TimerEvent.TIMER,zoom_out);
            z_timer.delay = 1;
            z_timer.start();
        }// end function

//		缩小
        private static function zoom_out() : void
        {
            var tar:Array = null;
            for each (tar in target)
            {
//              所有对象 逐个位移
                var chg:Number = sca_chg * tar[3];
                tar[0].scaleY -=chg;
                tar[0].scaleX -=chg;
                tar[0].x -= tar[4];
                tar[0].y -= tar[5];
            }
//			到位停止
            if (target[0][0].scaleX <= target[0][3])
            {
                z_timer.stop();
//                z_timer.removeEventListener(TimerEvent.TIMER, zoom_out);
				EventManager.delEventFn(z_timer,TimerEvent.TIMER,zoom_out);
                if (state == 2)
                {//如果是返回状态，就结束缩放
                    back();
                }
                else
                {//如果不是返回状态，就定时返回
                    setTimeout(z_out_back, t);
                }
            }
            else if (target[0][0].scaleX < target[0][3] * 1.2)
            {
                z_timer.delay += 10;
            }
        }// end function

//		缩小返回
        private static function z_out_back() : void
        {
            state = 2;
//            z_timer.addEventListener(TimerEvent.TIMER, zoom_in);
			EventManager.AddEventFn(z_timer,TimerEvent.TIMER,zoom_in);
            z_timer.delay = 1;
            z_timer.start();
        }// end function

//		结束缩放
        private static function back() : void
        {
            var obj:Array = null;
            state = 0;
            for each (obj in target)
            {
				obj[0].scaleY = obj[3];
				obj[0].scaleX = obj[3];
				obj[0].x = obj[1];
				obj[0].y = obj[2];
            }
        }// end function

    }
}
