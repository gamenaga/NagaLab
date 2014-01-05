package ui
{	
	import flash.display.Sprite;
	
	import game.Mode;
	
	import naga.eff.Shake;
	import naga.global.Css;
	import naga.system.Sounds;
	
	
	public class HpBar extends Sprite
	{
		public static var hpPic:Array=new Array();
		public static var hpMaxPic:Array=new Array();
		public var dis:int;
		/**
		 * 
		 * @param hp HP
		 * @param hpBar HP槽
		 * 
		 */
		public function HpBar(hp:Class, hpBar:Class)
		{
			this.mouseChildren=false;
			this.mouseEnabled=false;
//			Mode.hp_init=hp;
			hpPic=[new hp(),new hp(),new hp(),new hp(),new hp()];
			hpMaxPic=[new hpBar(),new hpBar(),new hpBar(),new hpBar(),new hpBar()];
			dis=hpPic[0].width*1.3;
			for(var temp:int=0 ;temp<4;temp++){
				hpPic[temp+1].x=hpPic[temp].x+dis;
				hpMaxPic[temp+1].x=hpPic[temp+1].x;
			}
			for(temp=0 ;temp<5;temp++){
				addChild(hpMaxPic[temp]);
				addChild(hpPic[temp]);
			}
			//			return this;
		}
		
		public static function initHPMax(point:int):void{
			
			for(var i:int=0;i<5;i++){
				if(i<point){
					hpMaxPic[i].visible=true;
				}
				else{
					hpMaxPic[i].visible=false;
				}
			}
		}
		public static function initHP(point:int):void{
			
//			trace("hp 55:",point);
			Main.mode.hp_=point;
			for(var i:int=0;i<5;i++){
				if(i<point){
					hpPic[i].visible=true;
				}
				else{
					hpPic[i].visible=false;
				}
			}
		}
		
		public static function changeHP(num:int):void{
			//			trace("modeN 115:	",hp_,HP_max,num);
			var i:int;
			if(num<0){
				for(i=0;i<-num;i++){
					if(Main.mode.hp_>0){
						Main.mode.hp_ --;
						Main.mode.gameChk();
						hpPic[Main.mode.hp_].visible=false;
						Shake.add(hpMaxPic[Main.mode.hp_],800,Css.SIZE*.3);
						O2Bar.changeO2(100);
					}
				}
			}
			else{
				for(i=0;i<num;i++){
					if(Main.mode.hp_ < Main.mode.HP_max){
						Sounds.play(Se_lv_up);
						Main.mode.hp_ ++;
						hpPic[Main.mode.hp_-1].visible=true;
						Shake.add(hpPic[Main.mode.hp_-1],800,Css.SIZE*.3);
					}
				}
			}
//			trace("hpBar 88:	",Mode.hp_);
		}
		public static function changeHPMax(num:int):void{
			var i:int;
			if(num<0){
				for(i=0;i<-num;i++){
					if(Main.mode.HP_max>1){
						Main.mode.HP_max --;
						hpPic[Main.mode.HP_max].visible=false;
						hpMaxPic[Main.mode.HP_max].visible=false;
					}
				}
			}
			else{
				for(i=0;i<num;i++){
					if(Main.mode.HP_max<5){
						Sounds.play(Se_lv_up);
						Main.mode.HP_max ++;
						hpMaxPic[Main.mode.HP_max-1].visible=true;
						Shake.add(hpMaxPic[Main.mode.HP_max-1],500,Css.SIZE*.3);
					}
				}
			}
		}
	}
}