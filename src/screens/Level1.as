package screens 
{
	import main.Player;
	import objects.Ball;
	import starling.display.Sprite;
	import starling.events.*;
	/**
	 * ...
	 * @author EDUARDO SIMON
	 */
	public class Level1 extends Sprite
	{
		private var ball:objects.Ball;
		private var player:main.Player;
		
		public static const PLAYER_X:Number = 400;
		public static const PLAYER_Y:Number = 300;
		
		public function Level1() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage);
			if (touch)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
					ball = new objects.Ball(PLAYER_X, PLAYER_Y);
					addChildAt(ball, stage.numChildren-1);
					var shootAngle:Number = Math.atan2(touch.globalY - PLAYER_Y, touch.globalX - PLAYER_X);
					ball.SetVelocityWithAngle(shootAngle,touch.globalX, touch.globalY);
				}
			}
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			drawLevel1();
		}
		
		private function drawLevel1():void{
			player = new main.Player();
			addChild(player);
			player.CenterPlayerToStage();
		}
		
		public function disposeTemporarily():void{
			this.visible = false;
		}
		
		public function initialize():void{
			this.visible = true;
		}
		
	}

}