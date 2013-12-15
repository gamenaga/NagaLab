package naga.system
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	public class BitmapClip extends Bitmap
	{
		/**
		 * 管理素材的素材内存池 
		 * 工作原理 当每次切完这个素材序列动画的时候 
		 * 将该动画序列存到内存池中管理
		 * 下次切图的时候必须先检查内存中是否已经存在
		 * 如果已经存在 直接拿出来不切了
		 * key:Class value:Vector.<BitmapData>
		 */ 
		private static var sourceDic:Dictionary;
		
		/**
		 * 存储切出来的位图, 对应 sourceDic 的 value
		 */ 
		private var bmdList:Vector.<ClipVo>;
		private var bmdKey:String;
		
		
		
		/**
		 * 
		 * @param mc 目标mc
		 * 
		 * @param key 存储 key 例如角色行走， 这些可以对应在配置文件中 ROLE_MOVE，
		 * 
		 * 假如二次加载 则会判断此key已经存在, 则直接play()
		 * 
		 */ 
		public function BitmapClip(mc:MovieClip, key:String)
		{
			// super(bitmapData, pixelSnapping, smoothing);
			smoothing = true;
			bmdKey = key;
			cutMap(mc,key);
		}
		
		/**
		 * 对影片的每一帧进行遍历 将内部的矢量图装换成位图
		 * @param typeClass
		 */
		public function cutMap(mc:MovieClip,key:String):void
		{
			if(!sourceDic)sourceDic = new Dictionary();
//			trace(55,sourceDic["Icons"]);
//			var className:String = getQualifiedClassName(key);
			bmdList = sourceDic[key];
			//无论是否有存过先从内存中提取下
			if(bmdList)
			{
				play();
//				trace("bitmapClip 60:	重用了类型 "+ mc+"		className:"+key);
				return;
			}
			bmdList = sourceDic[key] = new Vector.<ClipVo>();
//			trace(66,sourceDic["Icons"]);
			//生成一个动画数组实例 并且在内存池中存入一份引用
//			trace("bitmapClip 65:	"+mc+"	totalFrames:"+mc.totalFrames);
			for(var i:int = 1 ; i <= mc.totalFrames ; i++)
			{
				mc.gotoAndStop(i);
//				trace("bitmapClip 67:	",key,mc.width,mc.height);
				if(mc.width == 0 || mc.height == 0)
				{
					//注：空帧上获取的宽度和高度都是0
					//会导致绘制的bitmapData为无效对象
					//如果当前是空帧 存入空值即可
					//跳出当前循环
					bmdList.push(null);
					continue;
				}
				var cvo:ClipVo = new ClipVo();
				var boundsRect:Rectangle = mc.getRect(null); 
				//获取子对象位于容器的绝对区域(可以获取偏移点)
				var offsetX:int = cvo.offsetX = boundsRect.x;
				var offsetY:int = cvo.offsetY = boundsRect.y;
				var matrix:Matrix = new Matrix(1,0,0,1,-offsetX,-offsetY);
				var bitmapData:BitmapData = cvo.data = new BitmapData(mc.width,mc.height,true,0x00000000);
				bitmapData.draw(mc,matrix);
				bmdList.push(cvo);
			}
//			trace(91,sourceDic["Icons"]);
			draw();
//			trace(94,width);
//			play(); //切完图默认就开始播放 根据具体需求是否进行播放
		}
		
		/**
		 * 在当前帧上进行播放
		 */ 
		public function play(isLoop:Boolean = true):void
		{
//			addEventListener(Event.ENTER_FRAME,loopHandler);
			EventManager.AddEventFn(this,Event.ENTER_FRAME,loopHandler,[isLoop]);
		}
		/**
		 * 跳到目标帧上并播放
		 * @param frame
		 */ 
		public function gotoAndPlay(frame:int , isLoop:Boolean = true):void
		{
			setFrame(frame);
			play(isLoop);
		}
		/**
		 * 检查目标帧是否不规矩
		 * @param frame
		 */ 
		private function setFrame(frame:int):void
		{
			index = frame - 1;
			if(index < 0)
			{
				index = 0;
			}
			else if(index > bmdList.length - 1)
			{
				index = bmdList.length - 1;
			}
		}
		/**
		 * 跳到目标帧上并停止
		 * @param frame
		 */
		public function gotoAndStop(frame:int):void
		{
			EventManager.delEventFn(this,Event.ENTER_FRAME,loopHandler);
			setFrame(frame);
			stop();
		}
		/**
		 * 在当前帧上停止
		 */ 
		public function stop():void
		{
//			trace("BC 131:	",index,bmdList.length,hasEventListener(Event.ENTER_FRAME));
			EventManager.delEventFn(this,Event.ENTER_FRAME,loopHandler);
			draw(); //避免一开始运行就移除 没有任何渲染
		}
		
		private var index:int;
		//播放的帧 从 0 -- (bmdList.length - 1)
		
		/**
		 * 帧循环对每帧进行渲染 
		 * 改变数组的索引值对下一张位图进行渲染
		 * 当超过最大值后要归零 
		 * @param e
		 */ 
		private function loopHandler(isLoop:Boolean = true):void
		{
//			trace("BC 150:	",bmdList,isLoop,index,bmdList.length);
			draw();
			index ++;
			if(index > bmdList.length - 1)
			{
				index = 0;
				if(!isLoop)
				{
//					removeEventListener(Event.ENTER_FRAME,loopHandler);
					EventManager.delEventFn(this,Event.ENTER_FRAME,loopHandler);
				}
			}
		} 
		/**
		 * 对目标索引位置的位图进行绘制
		 */ 
		private function draw():void
		{
			var cvo:ClipVo = bmdList[index];
//			trace("bc 181:",index);
			if(cvo)
			{
				bitmapData = cvo.data;
				super.x = _x + cvo.offsetX;
				super.y = _y + cvo.offsetY;
			}
			else
			{
				//如果是空帧 直接不渲染
				bitmapData = null;
			}
		}
		
		/**
		 * 必须覆盖这些设置位置信息 否则在draw()方法中无法实现注册点偏移
		 */ 
		private var _x:Number = 0.0;
		public override function set x(value:Number):void
		{
			_x = value;
			draw();
		}
		public override function get x():Number
		{
			return _x;
		}
		private var _y:Number = 0.0;
		public override function set y(value:Number):void
		{
			_y = value;
			draw();
		}
		public override function get y():Number
		{
			return _y;
		}
		
		public function get totalFrames():int{
			return bmdList.length;
		}
		public function get currentFrame():int{
			return index+1;
		}
		
		public function dispose():void
		{
			for each(var i:ClipVo in bmdList)
			{
				if(i && i.data)
				{
					i.data.dispose();
					i.data = null;
				}
			}
			sourceDic[bmdKey] = null;
			bmdList = null;
			bitmapData.dispose();
			
		}
		
	}
	
	
}
import flash.display.BitmapData;

/**
 * 存储位图数据和偏移
 * @author Administrator
 */
class ClipVo{
	public var data:BitmapData;
	public var offsetX:int;
	public var offsetY:int;
}