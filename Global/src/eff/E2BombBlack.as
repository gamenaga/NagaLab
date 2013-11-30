package eff
{
	import naga.tool.ChangeColor;
	import naga.global.Css;

	public class E2BombBlack extends E2Bomb
	{
		public function E2BombBlack()
		{
			
			ChangeColor.go(this, Css.BLACK);
			super();
				
		}
	}
}