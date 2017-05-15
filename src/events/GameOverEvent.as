package events 
{
	import starling.events.Event;
	import gameObjects.Score;
	
	/**
	 * ...
	 * @author Marc
	 */
	public class GameOverEvent extends Event 
	{
		public static const GAME_OVER:String = "gameOver";

		public var score:Score;

		public function GameOverEvent(type:String, _score:Score, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles,data);
			this.score = _score;
			
		}
		
	}

}