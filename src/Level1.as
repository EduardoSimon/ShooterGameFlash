package 
{
	import starling.display.Sprite;
	import starling.events.*;
	/**
	 * ...
	 * @author EDUARDO SIMON
	 */
	public class Level1 extends Sprite
	{
		private var ball:Ball;
		private var player:Player;
		
		public static const PLAYER_X:Number = 400;
		public static const PLAYER_Y:Number = 300;
		
		public function Level1() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage);
			if (touch)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
					ball = new Ball(PLAYER_X, PLAYER_Y);
					addChild(ball);
					var shootAngle:Number = Math.atan2(touch.globalY - PLAYER_Y, touch.globalX - PLAYER_X);
					ball.SetVelocityWithAngle(shootAngle,touch.globalX, touch.globalY);
				}
			}
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			player = new Player();
			addChild(player);
			player.CenterPlayerToStage();
		}
		
	}

}