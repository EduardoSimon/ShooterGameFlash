package screens 
{
	import events.NavigationEvent;
	import utils.*;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import com.friendsofed.vector.*;
	import com.greensock.TweenLite;
	
	/**
	 * ...
	 * @author Marc
	 */
	public class Welcome extends Sprite 
	{
		private var bg:Image;
		private var title:Image;
		private var hero:Image;
		
		private var playBtn:Button;
		private var aboutBtn:Button;
		
		public function Welcome() 
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
			bg = new Image(Assets.getAtlas().getTexture("bgWelcome"));
			this.addChild(bg);
			
			playBtn = new Button(Assets.getAtlas().getTexture("welcome_playButton"));
			playBtn.x = 500;
			playBtn.y = 360;
			this.addChild(playBtn);
			
			this.addEventListener(Event.TRIGGERED, onMainMenuClick);
			
		}
		
		private function onMainMenuClick(e:Event):void 
		{
			var buttonClicked:Button = e.target as Button;
			
			//if the button we clicked was the play one we dispatch the navigation event
			if((buttonClicked as Button) == playBtn){
				this.dispatchEvent(new events.NavigationEvent(events.NavigationEvent.CHANGE_SCREEN, {id: "chooseLevel"}, true));
			}
			
		}
		
		public function disposeTemporarily():void{
			this.visible = false;
		}
		
		public function initialize():void{
			this.visible = true;
		}
		
	}

}