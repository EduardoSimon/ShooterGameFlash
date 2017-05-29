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
	import starling.text.TextFieldAutoSize;
	import flash.text.Font;
	/**
	 * ...
	 * @author Marc
	 */
	public class GameOver extends Sprite 
	{
		private var score:Score;
		private var infoText:starling.text.TextField;
		private var doomFont:Font = new Assets.Doom();
		
		private var backToMenu:Button;
		private var background:Image;
		
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

			drawScreen();

			//we draw the score on top of everything else
			addChild(score);
			score.ScoreTextField.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			score.ScoreTextField.fontSize = 180;
			score.x = 100;
			score.y = 200;

			infoText = new starling.text.TextField(200, 100, "TOTAL SCORE: ", doomFont.fontName, 130, 0x00FF00);
			infoText.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			infoText.x = 100;
			infoText.y = 50;
			addChild(infoText);
			
			
			this.addEventListener(Event.TRIGGERED, onBackToMenuClick);
		}
		
		private function onBackToMenuClick(e:Event):void 
		{
			var buttonClicked:Button = e.target as Button;

			if((buttonClicked as Button) == backToMenu){
				this.dispatchEvent(new events.NavigationEvent(events.NavigationEvent.CHANGE_SCREEN, {id: "chooseLevel"}, true));
				removeChild(score);
			}
			
			infoText.visible = false;
			backToMenu.visible = false;
			background.visible = false;
			removeEventListener(Event.TRIGGERED, onBackToMenuClick);
		}
		
		private function drawScreen():void 
		{	
			background = new Image(Assets.getAtlas().getTexture("bg1"));
			background.alignPivot();
			background.x = stage.stageWidth / 2;
			background.y = stage.stageHeight / 2;
			this.addChild(background);
			
			backToMenu = new Button(Assets.getAtlas().getTexture("welcome_playButton"));
			backToMenu.x = 610;
			backToMenu.y = 420;
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