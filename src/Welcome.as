package 
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
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
			trace("welcome screen initialized");
			
			drawScreen();
			
		}
		
		private function drawScreen():void 
		{
			bg = new Image(Assets.getTexture("BgWelcome"));
			this.addChild(bg);
			
			title = new Image(Assets.getTexture("WelcomeTitle"));
			title.x = 440;
			title.y = 60;
			this.addChild(title);
			
			hero = new Image(Assets.getTexture("WelcomeHero"));
			this.addChild(hero);
			
			playBtn = new Button(Assets.getTexture("WelcomePlayBtn"));
			playBtn.x = 500;
			playBtn.y = 360;
			this.addChild(playBtn);
			
			this.addEventListener(Event.TRIGGERED, onMainMenuClick);
			
		}
		
		private function onMainMenuClick(e:Event):void 
		{
			var buttonClicked:Button = e.target as Button;

			if((buttonClicked as Button) == playBtn){
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
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