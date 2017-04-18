package 
{
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.events.*;

	/**
	 * ...
	 * @author EDUARDO SIMON
	 */
	public class Score extends Sprite
	{
		private var score:TextField;
		private var scoreInt:int;
		private var scale:Number;
		private var posX:Number;
		private var posY:Number;
		
	
		public function Score(maxScore:int,x:int,y:int, width:int, height:int, scale:Number, text:String= "", font:String = "Verdana", size:int = 10, color:int = 0x0, bold:Boolean = false) 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			score = new TextField(width, height, text, font, size, color, bold);
			
			this.scale = scale;
			this.posX = x;
			this.posY = y;

		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);

			addChild(score);
			
			score.scale = scale;
			score.x = posX;
			score.y = posY;
		}
		
		public function UpdateScore(delta:Number):void
		{
			scoreInt -= delta;
			score.text = scoreInt.toString();
		}
		
		
	}

}