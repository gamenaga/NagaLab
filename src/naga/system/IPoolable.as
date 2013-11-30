package naga.system
{
	
	public interface IPoolable 
	{
		function get destroyed():Boolean;
		
		function renew(...paramenters):void;
		function destroy():void;
		function dispose():void;
			
	}
	
}