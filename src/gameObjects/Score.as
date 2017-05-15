package gameObjects
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
		private var scaleFactor:Number;
		private var posX:Number;
		private var posY:Number;
		
	
		public function Score(maxScore:int,x:int,y:int, width:int, height:int, scaleToApply:Number, text:String= "", font:String = "Verdana", size:int = 10, color:int = 0x0, bold:Boolean = false) 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			score = new TextField(width, height, text, font, size, color, bold);
			
			this.scaleFactor = scaleToApply;
			this.posX = x;
			this.posY = y;
			this.scoreInt  = maxScore;

		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			addChild(score);
			
			score.scale = scaleFactor;
			score.x = posX;
			score.y = posY;
		}
		
		public function UpdateScoreWithDelta(delta:Number):void
		{
			scoreInt -= delta;
			score.text = scoreInt.toString();
		}
		
		public function AddScore(delta:Number): void
		{
			scoreInt += delta;
			score.text = scoreInt.toString();
		}
		
		public function get ScoreInt():int{
			return this.scoreInt;
		}
		
	}

}