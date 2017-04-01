package main 
{
	import screens.ChooseLevel;
	import screens.Level1;
	import screens.Welcome;
	import events.NavigationEvent;
	import starling.display.Sprite;
	import starling.events.Event;
	import com.friendsofed.vector.*;
	
	/**
	 * ...
	 * @author Marc
	 */
	public class Game extends Sprite 
	{
		
		private var screenWelcome:screens.Welcome;
		private var screenLevel1:screens.Level1;
		private var screenChooseLevel:screens.ChooseLevel;
		
		public function Game() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage(e:Event):void 
		{
			
			this.addEventListener(events.NavigationEvent.CHANGE_SCREEN, onChangeScreen);

			screenLevel1 = new screens.Level1();
			screenLevel1.disposeTemporarily();
			this.addChild(screenLevel1);
			
			screenWelcome = new screens.Welcome();
			this.addChild(screenWelcome);
			screenWelcome.initialize();
			
			screenChooseLevel = new ChooseLevel()
			screenChooseLevel.disposeTemporarily();
			this.addChild(screenChooseLevel);
			
		}
		
		private function onChangeScreen(e:events.NavigationEvent):void 
		{
			switch(e.params.id){
				case "level1":
					screenChooseLevel.disposeTemporarily();
					screenLevel1.initialize();
					break;
				case "chooseLevel":
					screenWelcome.disposeTemporarily();
					screenChooseLevel.initialize();
					break;
			}
		}
		
	}

}