package naga.tool
{
	public class String2Time
	{
		public function String2Time()
		{
		}
		private static function getTimeArray(timeString:String):Array
		{
			var time_array:Array = timeString.split(/[\s-:]/);
			return time_array;
		}
		
		public static function getMonth(timeString:String):int
		{
			return getTimeArray(timeString)[1];
		}
		
		public static function getDate(timeString:String):int
		{
			return getTimeArray(timeString)[2];
		}
	}
}