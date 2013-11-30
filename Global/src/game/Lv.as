package game
{
	internal interface Lv
	{
		function get lv():int
		function set lv():void
		function renew(...paramenters):void;
		function destroy():void;
	}
}