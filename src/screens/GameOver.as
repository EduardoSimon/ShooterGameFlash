package screens 
{
	import flash.text.TextField;
	import main.Game;
	import starling.display.Sprite;
	import utils.*;
	import gameObjects.*;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import com.friendsofed.vector.*;
	import String;
	import events.*;
	
	/**
	 * ...
	 * @author Marc
	 */
	public class GameOver extends Sprite 
	{
		private var score:Score;
		private var backgound:Image;
		private var backToMenu:Button;
		
		public function GameOver() 
		{
			super(); 
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			
		}
			
		private function onAddedToStage(e:Event):void 
		{ 
			stage.addEventListener(GameOverEvent.GAME_OVER, onGameOver);
			
		}
		
		private function onGameOver(e:GameOverEvent):void 
		{
			
			score = e.score;
			Game.totalScore += score.ScoreInt;
			score.SetScoreInt(Game.totalScore);
			addChild(score);
			score.x = 100;
			score.y = 100;
			score.scale = 1.5;
			drawScreen();
			
			this.addEventListener(Event.TRIGGERED, onBackToMenuClick);
		}
		
		private function onBackToMenuClick(e:Event):void 
		{
			var buttonClicked:Button = e.target as Button;

			if((buttonClicked as Button) == backToMenu){
				this.dispatchEvent(new events.NavigationEvent(events.NavigationEvent.CHANGE_SCREEN, {id: "chooseLevel"}, true));
				removeChild(score);
			}
			
			backToMenu.visible = false;
			backgound.visible = false;
			removeEventListener(Event.TRIGGERED, onBackToMenuClick);
		}
		
		private function drawScreen():void 
		{	
			backgound = new Image(Assets.getAtlas().getTexture("bgWelcome"));
			this.addChild(backgound);
			backToMenu = new Button(Assets.getAtlas().getTexture("welcome_playButton"));
			backToMenu.x = 500;
			backToMenu.y = 360;
			this.addChild(backToMenu);

		}
		
		public function disposeTemporarily():void{
			this.visible = false;
		}
		
		public function initialize():void{
			this.visible = true;
		}
		
	}

}