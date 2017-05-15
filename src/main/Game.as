package main 
{
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.media.SoundChannel;
	import screens.*;
	import flash.media.Sound;
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
		private var screenLevel3:Level3;
		private var screenChooseLevel:ChooseLevel;
		private var screenGameOver:GameOver;
		private var track:Sound;
		private var channel:SoundChannel;
		
		public function Game() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			track = new Sound();
			channel = new SoundChannel();
			
			track.load(new URLRequest("../media/sound/levelSong.mp3"));	
		}
		
		private function onAddedToStage(e:Event):void 
		{
			
			this.addEventListener(events.NavigationEvent.CHANGE_SCREEN, onChangeScreen);
			
			screenWelcome = new screens.Welcome();
			this.addChild(screenWelcome);
			screenWelcome.initialize();
			
			screenChooseLevel = new ChooseLevel();
			screenChooseLevel.disposeTemporarily();
			this.addChild(screenChooseLevel);
			
			screenGameOver = new GameOver();
			screenGameOver.disposeTemporarily();
			this.addChild(screenGameOver);
			
			channel = track.play();

		}
		
		private function onChangeScreen(e:events.NavigationEvent):void 
		{
			switch(e.params.id){
				case "level1":
					screenChooseLevel.disposeTemporarily();

					screenLevel1 = new Level1();
					addChild(screenLevel1);
					channel.stop();
					break;
					
				case "level2":
					screenChooseLevel.disposeTemporarily();
					screenLevel2 = new Level2();
					addChild(screenLevel2);
					break;
					
				case "level3":
					screenChooseLevel.disposeTemporarily();
					screenLevel3 = new Level3();
					addChild(screenLevel3);
					break;
					
				case "chooseLevel":
					screenWelcome.disposeTemporarily();
					screenChooseLevel.initialize();
					break;
					
				case "gameOver":
					if(screenLevel1 != null){
						removeChild(screenLevel1);
					}
					if (screenLevel2 != null){
						removeChild(screenLevel2);
					}
					if (screenLevel3 != null){
						removeChild(screenLevel3);
					}
					
					screenGameOver.initialize();
					break;
			}
		}
		
	}

}