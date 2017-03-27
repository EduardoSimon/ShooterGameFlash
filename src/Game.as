package 
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Marc
	 */
	public class Game extends Sprite 
	{
		
		private var screenWelcome:Welcome;
		private var screenLevel1:Level1;
		
		public function Game() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage(e:Event):void 
		{
			
			this.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);

			screenLevel1 = new Level1();
			screenLevel1.disposeTemporarily();
			this.addChild(screenLevel1);
			
			trace("starling framework");
			screenWelcome = new Welcome();
			this.addChild(screenWelcome);
			screenWelcome.initialize();
		}
		
		private function onChangeScreen(e:NavigationEvent):void 
		{
			switch(e.params.id){
				case"play":
					screenWelcome.disposeTemporarily();
					screenLevel1.initialize();
					break;
			}
		}
		
	}

}