package 
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Marc
	 */
	public class Welcome extends Sprite 
	{
		
		public function Welcome() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage(e:Event):void 
		{
			trace("welcome screen initialized");
			var t;
		}
		
	}

}