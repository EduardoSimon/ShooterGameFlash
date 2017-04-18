package 
{
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.events.*;

	/**
	 * ...
	 * @author EDUARDO SIMON
	 */
	public class TextUI extends Sprite
	{
		public var score:TextField ;
		
		private var scoreInt:int = 5000;
		
	
		public function TextUI() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			score = new TextField(100,30, "", "Verdana", 18, 0x78,true);

		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);

			addChild(score);
			
			score.scale = 1.5;
			
			score.x = 0;
			score.y = 0;	
		}
		
		private function onEnterFrame(e:Event):void 
		{
			scoreInt -= 0.2;
			score.text = scoreInt.toString();
		}
		
	}

}