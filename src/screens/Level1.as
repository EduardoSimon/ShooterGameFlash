package screens 
{
	import main.Player;
	import objects.Projectile;
	import starling.display.Sprite;
	import starling.events.*;
	/**
	 * ...
	 * @author EDUARDO SIMON
	 */
	public class Level1 extends Sprite
	{
		private var ball:objects.Projectile;
		private var player:main.Player;
		private var projectiles:Vector.<Projectile>;
		
		public static const PLAYER_X:Number = 400;
		public static const PLAYER_Y:Number = 300;
		
		public function Level1() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.ENTER_FRAME, OnEnterFrame);
			projectiles = new Vector.<Projectile>();
			
		}
		
		public function OnEnterFrame(e:Event):void 
		{
			for (var i:int = 0; i < projectiles.length; i++) 
			{
				projectiles[i].update();
				
				projectiles[i].x = projectiles[i].posX;
				projectiles[i].y = projectiles[i].posY;
			}
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage);
			if (touch)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
					//calculate the angel which we will use to determine the speed in x and y
					var angle:Number = Math.atan2(touch.globalY - PLAYER_Y, touch.globalX - PLAYER_X);
					
					//push to the vector and add to the display list
					ball = new objects.Projectile(angle, 4);
					projectiles.push(ball);
					addChildAt(ball, stage.numChildren - 1);
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