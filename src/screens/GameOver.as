package screens 
{
	import flash.text.TextField;
	import starling.display.Sprite;
	import Assets;
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
		
		private var backToMenu:Button;
		
		public function GameOver() 
		{
			super(); 
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
			
		private function onAddedToStage(e:Event):void 
		{ 
			stage.addEventListener(GameOverEvent.GAME_OVER, onGameOver);
			trace('stb');
		}
		
		private function onGameOver(e:GameOverEvent):void 
		{
			score = e.score;
			drawScreen();
			
			this.addEventListener(Event.TRIGGERED, onBackToMenuClick);
		}
		
		private function onBackToMenuClick(e:Event):void 
		{
			var buttonClicked:Button = e.target as Button;

			if((buttonClicked as Button) == backToMenu){
				this.dispatchEvent(new events.NavigationEvent(events.NavigationEvent.CHANGE_SCREEN, {id: "chooseLevel"}, true));
			}
			
			backToMenu.visible = false;
			removeEventListener(Event.TRIGGERED, onBackToMenuClick);
		}
		
		private function drawScreen():void 
		{
			
			addChild(score);
			
			backToMenu = new Button(Assets.getTexture("WelcomePlayBtn"));
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