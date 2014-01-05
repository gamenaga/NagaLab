package naga.eff
{
    import flash.display.Bitmap;
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.utils.Dictionary;
    import flash.utils.setTimeout;
    
    import naga.system.IPoolable;
    import naga.system.ObjPool;
    import naga.tool.ChangeColor;

    public class Vision
    {
		private static var _instance:Vision ;
		public var list:Object = {};
		
		public static function get instance():Vision{
			if(!_instance) _instance = new Vision();
			return _instance ;
		}

		

        public function add(name:String, effObj:*, parentObj:Sprite, pos_x:int, pos_y:int, color:String = null, alpha:Number = 1, time:int = 0, scale:Number = 1,rotation:int=0, is_buf_in:Boolean = false, is_buf_out:Boolean = false,is_pool:Boolean=false) : void
        {
//			trace("vision 16:	",parentObj);
            remove(name);
//            var eff:DisplayObject = Glo.objectPool.getObj(ef) as DisplayObject;
//			var eff:DisplayObject;
			list[name] = {obj:null,bufOut:is_buf_out,pool:is_pool};
			if (effObj is Class)
			{
				if (is_pool) list[name].obj = ObjPool.instance.getObj(effObj) as DisplayObject;
				else list[name].obj= new effObj();
			}
			else
			{
				list[name].obj = effObj;
			}
			
//			list[name].name = name;
			list[name].obj.x = pos_x;
			list[name].obj.y = pos_y;
            if (scale != 1)
            {
				list[name].obj.scaleX = scale;
				list[name].obj.scaleY = scale;
            }
			if(rotation!=0)
			{
				list[name].obj.rotation=rotation;
			}
            if (color != null)
            {
                ChangeColor.go(list[name].obj, color, 1);
//				trace("vision 33:	"+(eff as DisplayObject).transform);
            }
            if (is_buf_in)
            {
                InOut.fadeIn(list[name].obj, alpha * 0.1,alpha);
            }
            else
            {
				list[name].obj.alpha = alpha;
            }
			parentObj.addChild(list[name].obj);
            if (time > 0)
            {
                setTimeout(remove, time, name);
            }
        }// end function

        public function remove(name:String) : void
        {
//			trace("vision 56:	",parentObj);
//				if(parentObj.getChildByName(name).toString()=="[object E3FlashPoint]")
//				{
////					trace("vision 60:	",parentObj.getChildByName(name),name);
//				}
				removeObj(list[name] as Object);
        }// end function
		
		private function removeObj(obj:Object):void
		{
			
			if (obj != null)
			{
			if (obj.bufOut)
			{
				var max:Number = obj.obj.alpha;
				//                    if (max < 1)
				//                    {
				//                        min = 0;
				//                    }
				//					trace("vision 60 :	"+name+	"	"+is_pool+"	alpha:"+max);
				InOut.fadeOut(obj.obj, true, max * 0.1,0,max,obj.pool);
			}
			else if(obj.pool)
			{
				//					trace("vision 73:	",parentObj.getChildByName(name));
				ObjPool.instance.returnObj(obj.obj as IPoolable);
			}
			else
			{
				//					parentObj.removeChild(parentObj.getChildByName(name));
				del(obj);
			}
			}
		}

        public function remove_all(parentObj:Sprite) : void
        {
			if (list)
			{
			for each(var i:Object in list)
			{
				removeObj(i);
			}
			}
//            var num:int = parentObj.numChildren;
//                while (num > 0)
//                {
//                    InOut.fadeOut(parentObj.getChildAt((num - 1)));
//                    num --;
//                }
        }// end function
		
		public function del(obj:Object):void
		{
//			trace("vision 127 :",obj,
//				obj.obj,
//				obj.obj.parent);
			if(obj && obj.obj && obj.obj.parent != null)
			{
				obj.obj.parent.removeChild(obj.obj);
			}
			if(obj.obj is Bitmap)
			{
				obj.obj.bitmapData.dispose();
			}
			obj.obj = null;
			obj = null;
		}

    }
}
