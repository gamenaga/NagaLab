package eff
{
	import naga.global.Css;
	import naga.tool.ChangeColor;

	public class E1GrowGreen extends E1Grow
	{
		
		public function E1GrowGreen()
		{
			
			ChangeColor.go(this, Css.GREEN);
			super();
				
		}
		
	}
}