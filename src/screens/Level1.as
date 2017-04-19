package screens 
{
	import main.Cannon;
	import com.friendsofed.vector.*;
	import com.friendsofed.utils.TextBox;
	import flash.display.Graphics;
	import flash.geom.Point;
	import objects.Ball;
	import objects.Enemy;
	import objects.Bullet;
	import starling.display.Sprite;
	import starling.events.*;

	public class Level1 extends Sprite
	{
				
		public static const N_PROJECTILES:int = 10;
		public static const PLAYER_X:Number = 400;
		public static const PLAYER_Y:Number = 300;
		public static const SCORE_DELTA:Number = 0.2;

		private var score:Score;
		private var bullet:objects.Ball;
		private var enemies:Vector.<Ball>;
		private var bullets:Vector.<Ball>;
		private var physics:Physics;

		public static var CANNON:Cannon;

		public function Level1() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.ENTER_FRAME, OnEnterFrame);

			score = new Score(5000, 10, 10, 100, 30, 2);
			enemies = new Vector.<Ball>();
			bullets = new Vector.<Ball>();
			physics = new Physics();
			CANNON = new Cannon();

		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			drawLevel1();
				
			for (var i:int = 0; i < N_PROJECTILES; i++)
			{
				var randomAngle:Number = Math.random() * (2 * Math.PI);
				
				var temp:Ball = new Ball(randomAngle, 5);
				
				temp.SetX = Math.random() * stage.stageWidth - temp.width / 2;
				temp.x = temp.posX;
				temp.SetY = Math.random() * stage.stageHeight - temp.height / 2;
				temp.y = temp.posY;
				
				enemies.push(temp);
				
				addChild(temp);
			}
			
			addChild(score);
			addChild(physics);
			
			CANNON.SetX = 400;
			CANNON.SetY = 300;

		}
		
		public function OnEnterFrame(e:Event):void 
		{
			score.UpdateScore(SCORE_DELTA);
			physics.MoveBalls(enemies);
			physics.MoveBullets(bullets);
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
					bullet = new Ball(angle, 10);
					bullet.SetX = PLAYER_X + (Math.cos(angle) * 40);
					bullet.SetY = PLAYER_Y + (Math.sin(angle) * 40);
					bullets.push(bullet);
					addChild(bullet);
				}
			}
		}
				
		private function drawLevel1():void{
			addChild(CANNON);
			CANNON.CenterPlayerToStage();
		}
		
		public function disposeTemporarily():void{
			this.visible = false;
		}
		
		public function initialize():void{
			this.visible = true;
		}
		
	}

}