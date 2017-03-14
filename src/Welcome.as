package 
{
	import starling.display.Sprite;
	import starling.events.*;
	/**
	 * ...
	 * @author EDUARDO SIMON
	 */
	public class Welcome extends Sprite
	{
		private var ball:Ball;
		
		public function Welcome() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage);
			if (touch)
			{
				if (touch.phase == TouchPhase.MOVED)
				{
					ball = new Ball(touch.globalX, touch.globalY);
					addChild(ball);
				}
			}
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			var player:Player = new Player();
			addChild(player);
		}
		
	}

}