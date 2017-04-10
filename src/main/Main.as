package main
{
	import main.Game;
	import objects.Projectile;
	import screens.Welcome;
	import starling.core.Starling;
	import starling.events.*;
	import starling.display.Sprite;
	import flash.display.*;
	
	/**
	 * ...
	 * @author EDUARDO SIMON
	 */
	
	 [SWF(width = "800", height = "600", framerate = "50", backgroundColor = "#00b3b3")]
	public class Main extends flash.display.Sprite
	{
		private var _starling:Starling;
		
		public function Main()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//entry point
			_starling = new Starling(Basura, stage);
			_starling.antiAliasing = 2;
			_starling.start();
		}
		
	}
	
}