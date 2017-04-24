package screens 
{
	import flash.text.TextField;
	import starling.display.Sprite;
	import events.NavigationEvent;
	import Assets;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import com.friendsofed.vector.*;
	import String;
	
	/**
	 * ...
	 * @author Marc
	 */
	public class GameOverShowScore extends Sprite 
	{
		private var score:TextField;
		
		public function GameOverShowScore() 
		{
			super(); 
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{ 
			drawScreen();
		}
		
		private function drawScreen():void 
		{
			score = new TextField();
			score.x = stage.width / 2;
			score.y = stage.height / 2;
			

		}
		
		public function disposeTemporarily():void{
			this.visible = false;
		}
		
		public function initialize():void{
			this.visible = true;
		}
		
	}

}