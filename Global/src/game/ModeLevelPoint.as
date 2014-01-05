package game
{
	import flash.utils.Dictionary;
	
	import naga.global.Global;

	public class ModeLevelPoint
	{
		public var dict:Dictionary = new Dictionary();
		public function ModeLevelPoint()
		{
			dict[101]=Global.m_p.getValue("scroe");
		}
		
	}
}