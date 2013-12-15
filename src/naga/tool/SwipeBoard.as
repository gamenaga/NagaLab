package naga.tool
{
//	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
//	import com.greensock.TweenLite;
	
	/**
	 *	仿手机手势滑动图集
	 * @author Theodore
	 * @QQ 675555967
	 * 
	 * 构造方法参数：_sourceList图片信息XML ， _limitWidth限定的屏幕宽度，_limitHeight限定的屏幕高度
	 * 
	 * 使用方法：将一个xml资源列表（格式见附件list.xml）传给构造方法作为参数。本来尚有优化空间（可改为逐张加载等），本人懒得改了。
	 * 
	 * 三个可以调节效果的属性：
	 * 		proportion：手势幅度，在移动图片超过屏幕指定比例之后，才触发翻动。
	 * 		tweenSpeed：滑动速度，图片滑动的速度，也就是TweenLite的执行时间。
	 * 		typeDelay：移动和翻页的切换延迟，这个表述不清楚，可以更改看效果。
	 */	
	public class SwipeBoard extends Sprite
	{
		private var proportion:Number = 0.4;
		private var tweenSpeed:Number = 0.5;
		private var typeDelay:Number = 0.3;
		
		private var sourceList:XML;
		private var limitWidth:int;
		private var limitHeight:int;
		
		private var itemArray:Array;
		private var itemContainer:Sprite;
		private var interval:int;
		private var tweenInterval:int;
		private var gesture:String = "swipe";
		private var downPosX:Number = 0;
		private var upPosX:Number = 0;
		private var distance:Number = 0;
		private var direct:int;
		private var limitNumber:int;
		
		private var currentItem:int = 0;
		public function SwipeBoard(_sourceList:XML , _limitWidth:int , _limitHeight:int)
		{
			super();
			sourceList = _sourceList;
			limitWidth = _limitWidth;
			limitHeight = _limitHeight;
			limitNumber = _sourceList.img.length()-1;
			
			initElements();
		}
		
		private function initElements():void
		{
			itemContainer = new Sprite();
			addChild(itemContainer);
			
			for(var i:int = 0;i<sourceList.img.length();i++)
			{
				var si:SwipeItem = new SwipeItem(sourceList.img.@url[i] , limitWidth , limitHeight);
				itemContainer.addChild(si);
				si.x = i*limitWidth;
			}
			
			itemContainer.addEventListener(MouseEvent.MOUSE_DOWN , mouseDownHandler);
			itemContainer.addEventListener(MouseEvent.MOUSE_UP , mouseUpHandler);
		}
		
		protected function mouseUpHandler(event:MouseEvent):void
		{
			itemContainer.stopDrag();
			upPosX = mouseX;
			distance = upPosX - downPosX;
			direct = distance>0?1:-1;
			clearTimeout(interval);
			clearTimeout(tweenInterval);
			if(gesture == "swipe")
			{
				
//				TweenLite.to(itemContainer , tweenSpeed , {x:limitWidth*getLimitNumber((currentItem+direct),limitNumber)});
			}
			else
			{	
				if(Math.abs(distance)>limitWidth*proportion)
				{
					direct = distance>0?1:-1;
				}
				else
				{
					direct = 0;
				}
				trace((currentItem+direct));
				trace(getLimitNumber((currentItem+direct),limitNumber));
//				TweenLite.to(itemContainer , tweenSpeed , {x:limitWidth*getLimitNumber((currentItem+direct),limitNumber)});
			}
			tweenInterval = setTimeout(overTweenFun , tweenSpeed*1000);
		}
		
		private function overTweenFun():void
		{
			currentItem+=direct;
		}		
		
		
		protected function mouseDownHandler(event:MouseEvent):void
		{
			gesture = "swipe";
			itemContainer.startDrag(false,new Rectangle(limitWidth,0,-itemContainer.width-limitWidth,0));
			downPosX = mouseX;
			interval = setTimeout(myIntervalFun , typeDelay*1000);
		}
		
		private function myIntervalFun():void
		{
			trace("进入move阶段");
			gesture = "move";
		}
		
		private function getLimitNumber(_current:int , _limit:int):int
		{
			if(_current>0)
			{
				_current = 0;
			}
			if(_current<-_limit)
			{
				_current = -_limit;
			}
			return _current;
		}
	}
	
}

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;

class SwipeItem extends Sprite
{
	private var siWidth:int;
	private var siHeight:int;
	private var bg:Bitmap;
	private var image:Bitmap;
	
	public function SwipeItem(_imageURL:String , _siWidth:int , _siHeight:int)
	{
		siWidth = _siWidth;
		siHeight = _siHeight;
		bg = new Bitmap(new BitmapData(_siWidth , _siHeight , false , 0));
		addChild(bg);
		
		loadImg(_imageURL);
	}
	
	private function loadImg(_imageURL:String):void
	{
		var loader:Loader = new Loader();
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE,imgComplete);
		loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,imgError);
		loader.load(new URLRequest(_imageURL));
	}
	
	protected function imgError(event:IOErrorEvent):void
	{
		trace("image load Error!!");
		
	}
	
	protected function imgComplete(event:Event):void
	{
		trace("image load Complete!!");
		image = event.target.content as Bitmap;
		setScale(image);
		addChild(image);
		image.x = (siWidth-image.width)*0.5;
		image.y = (siHeight-image.height)*0.5;
	}
	
	private function setScale(_bitmap:Bitmap):void
	{
		var ratio:Number = _bitmap.width/siWidth;
		_bitmap.width = siWidth;
		_bitmap.height = int(_bitmap.height/ratio);
	}
	
}