package naga.ui
{
	import flash.display.DisplayObject;
	
	import naga.global.Global;
	import naga.system.EventManager;

	public class UIDisplay
	{
		
		public static function removeUI():void
		{
			var children:int = Global.ui_floor.numChildren;
			var i:int;
			for(i = children-1; i >= 0; i --)
			{
				var obj:DisplayObject = Global.ui_floor.getChildAt(i);
				EventManager.delAllEvent(obj);
				Global.ui_floor.removeChild( obj );
				obj = null;
			}
		}
	}
}