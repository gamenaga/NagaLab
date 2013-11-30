package item
{
	import flash.display.Sprite;
	
	import naga.system.BitmapClip;
	
	public class PicEffBigSmall extends Sprite
	{
		public var BC:BitmapClip;
		public function PicEffBigSmall()
		{
			mouseChildren=false;
			mouseEnabled=false;
			BC=new BitmapClip(new BigSmall(),"BigSmall");
			addChild(BC);
		}
	}
}