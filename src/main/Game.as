package main 
{
	
	import screens.*;
	import screens.Welcome;
	import events.NavigationEvent;
	import starling.display.Sprite;
	import starling.events.Event;
	import com.friendsofed.*;
	
	/**
	 * ...
	 * @author Marc
	 */
	public class Game extends Sprite 
	{
		
		private var screenWelcome:Welcome;
		private var screenLevel1:Level;
		private var screenLevel2:Level2;
		private var screenChooseLevel:ChooseLevel;
		private var screenGameOver:GameOver;
		
		public function Game() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage(e:Event):void 
		{
			
			this.addEventListener(events.NavigationEvent.CHANGE_SCREEN, onChangeScreen);

			screenLevel1 = new Level();
			screenLevel1.disposeTemporarily();
			this.addChild(screenLevel1);
			
			screenLevel2 = new screens.Level2();
			screenLevel2.disposeTemporarily();
			this.addChild(screenLevel2);
			
			screenWelcome = new screens.Welcome();
			this.addChild(screenWelcome);
			screenWelcome.initialize();
			
			screenChooseLevel = new ChooseLevel();
			screenChooseLevel.disposeTemporarily();
			this.addChild(screenChooseLevel);
			
			screenGameOver = new GameOver();
			screenGameOver.disposeTemporarily();
			this.addChild(screenGameOver);
			
			
			
		}
		
		private function onChangeScreen(e:events.NavigationEvent):void 
		{
			switch(e.params.id){
				case "level1":
					screenChooseLevel.disposeTemporarily();
					removeChild(screenLevel1);
					screenLevel1 = new Level();
					addChild(screenLevel1);
					break;
					
				case "level2":
					screenChooseLevel.disposeTemporarily();
					removeChild(screenLevel2);
					screenLevel2 = new Level2();
					addChild(screenLevel2);
					break;
					
				case "chooseLevel":
					screenWelcome.disposeTemporarily();
					screenChooseLevel.initialize();
					break;
					
				case "gameOver":
					if(screenLevel1.Visible){
						screenLevel1.disposeTemporarily();
					}
					else if (screenLevel2.Visible){
						screenLevel2.disposeTemporarily();
					}
					screenGameOver.initialize();
					break;
			}
		}
		
	}

}