package main 
{
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.media.SoundChannel;
	import screens.*;
	import flash.media.Sound;
	import gameObjects.Score;
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
		public static var totalScore:Number;
		
		private var screenWelcome:Welcome;
		private var screenLevel1:Level;
		private var screenLevel2:Level2;
		private var screenLevel3:Level3;
		private var screenChooseLevel:ChooseLevel;
		private var screenGameOver:GameOver;
		
		
		private var channelMain:SoundChannel;
		private var channelLevel:SoundChannel;
		private var ChooseLevelSong:Sound;
		private var Level1Song:Sound;
		private var Level2Song:Sound;
		private var Level3Song:Sound;
		
		public function Game() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			channelMain = new SoundChannel();
			channelLevel = new SoundChannel();
			
			ChooseLevelSong = new Sound(new URLRequest("../media/sound/levelSong.mp3"));
			Level1Song = new Sound(new URLRequest("../media/sound/level1.mp3"));
			Level2Song = new Sound(new URLRequest("../media/sound/level2.mp3"));
			Level3Song = new Sound(new URLRequest("../media/sound/level3.mp3"));
			
			totalScore = 0;
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
			
			channelMain = ChooseLevelSong.play();
		}
		
		private function onChangeScreen(e:events.NavigationEvent):void 
		{
			switch(e.params.id){
				case "level1":
					screenChooseLevel.disposeTemporarily();
					screenLevel1 = new Level1();
					addChild(screenLevel1);
					channelMain.stop();
					channelLevel = Level1Song.play();
					break;
					
				case "level2":
					screenChooseLevel.disposeTemporarily();
					screenLevel2 = new Level2();
					addChild(screenLevel2);
					channelMain.stop();
					channelLevel = Level2Song.play();
					break;
					
				case "level3":
					screenChooseLevel.disposeTemporarily();
					screenLevel3 = new Level3();
					addChild(screenLevel3);
					channelMain.stop();
					channelLevel = Level3Song.play();
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
					channelLevel.stop();
					screenGameOver.initialize();
					channelMain = ChooseLevelSong.play();
					break;
			}
		}
		
	}

}