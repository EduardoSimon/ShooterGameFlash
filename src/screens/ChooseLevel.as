package screens 
{
	import Assets;
	import starling.display.Sprite;
	import events.NavigationEvent;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Marc
	 */
	public class ChooseLevel extends Sprite 
	{
		
		private var btnPlayLevel1:Button;
		private var btnPlayLevel2:Button;
		
		public function ChooseLevel() 
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
			btnPlayLevel1 = new Button(Assets.getTexture("Level1"));
			btnPlayLevel1.scale = .3;
			btnPlayLevel1.x = 300 - btnPlayLevel1.width / 2;
			btnPlayLevel1.y = 300 - btnPlayLevel1.height / 2;
			this.addChild(btnPlayLevel1);

			
			btnPlayLevel2 = new Button(Assets.getTexture("Level2"));
			btnPlayLevel2.scale = .3;
			btnPlayLevel2.x = 500 - btnPlayLevel1.width / 2;
			btnPlayLevel2.y = 300 - btnPlayLevel1.height / 2;
			this.addChild(btnPlayLevel2);
			
			addEventListener(Event.TRIGGERED, onChooseLevelButtonClick);

		}
		
		private function onChooseLevelButtonClick(e:Event):void 
		{
			var buttonClicked:Button = e.target as Button;

			if((buttonClicked as Button) == btnPlayLevel1){
				this.dispatchEvent(new events.NavigationEvent(events.NavigationEvent.CHANGE_SCREEN, {id: "level1"}, true));
			}
			
			if((buttonClicked as Button) == btnPlayLevel2){
				this.dispatchEvent(new events.NavigationEvent(events.NavigationEvent.CHANGE_SCREEN, {id: "level2"}, true));
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