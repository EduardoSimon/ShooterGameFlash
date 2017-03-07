package
{
	import flash.display.*;
	import starling.events.*;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author EDUARDO SIMON
	 */
	
	 [SWF(width = "800", height = "600", framerate = "50", backgroundColor = "#00b3b3")]
	public class Main extends Sprite 
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
			_starling = new Starling(Player,stage);
			_starling.antiAliasing = 2;
			_starling.start();
		}
	}
	
}