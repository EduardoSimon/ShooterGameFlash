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

		protected var score:Score;
		protected var enemies:Vector.<Enemy>;
		protected var bullets:Vector.<Bullet>; 
		protected var physics:Physics;

		public static var CANNON:Cannon;

		public function Level1() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.ENTER_FRAME, OnEnterFrame);

			score = new Score(5000, 10, 10, 100, 30, 2);
			enemies = new Vector.<Enemy>();
			bullets = new Vector.<Bullet>();
			physics = new Physics();
			CANNON = new Cannon();
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			
			drawLevel();
		}
		
		private function OnEnterFrame(e:Event):void 
		{
			score.UpdateScoreWithDelta(SCORE_DELTA);
			MoveEntities(enemies, bullets);
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
					var bullet:Bullet = new Bullet(angle, 10);
					bullet.SetX = PLAYER_X + (Math.cos(angle) * 40);
					bullet.SetY = PLAYER_Y + (Math.sin(angle) * 40);
					bullets.push(bullet);
					addChild(bullet);
				}
			}
		}
				
		private function drawLevel():void
		{
			
			//create and display the enemies
			for (var i:int = 0; i < N_PROJECTILES; i++)
			{
				var randomAngle:Number = Math.random() * (2 * Math.PI);
				
				var temp:Enemy = new Enemy(randomAngle, 5);
				
				temp.SetX = Math.random() * stage.stageWidth - temp.width / 2;
				temp.x = temp.posX;
				temp.SetY = Math.random() * stage.stageHeight - temp.height / 2;
				temp.y = temp.posY;
				
				enemies.push(temp);
				
				addChild(temp);
			}
			
			//show the score
			addChild(score);
			addChild(physics);
			
			//set the cannon in its correct position
			addChild(CANNON);
			CANNON.CenterPlayerToStage();
			CANNON.SetX = PLAYER_X;
			CANNON.SetY = PLAYER_Y;
		}
		
		public function disposeTemporarily():void{
			this.visible = false;
		}
		
		public function initialize():void{
			this.visible = true;
		}
		

		protected function MoveEntities(pelotas:Vector.<Enemy>,bullets:Vector.<Bullet>):void 


		{
			//if there are balls
			if (enemigos.length > 0)
			{
				for (var i:int = enemigos.length - 1; i >= 0 ; i--)
				{
					//check if theres collision with the stage boundaries
					if (physics.TestBoundaries(enemigos[i])) 
					{
						//if there is collision calculate the bounce vector
						physics.bounceWithBoundarie(enemigos[i]);
					}
					
					 //check for every other ball but without comparing them twice // j < i
					for (var j:int = 0; j < i; j++)
					{
						//check again against the boundaries
						if (physics.TestBoundaries(enemigos[j])) 
						{
							physics.bounceWithBoundarie(enemigos[j]);
						}
						
						if (physics.AreBallsColliding(enemigos[i], enemigos[j]))
						{
							physics.BounceBetweenBalls(enemigos[i], enemigos[j]);
						}		
					}
					
					//check if there's collision between bullets and enemies
					for (var k:int = bullets.length - 1; k >= 0; k--) 
					{
						if (physics.AreBallsColliding(bullets[k],enemigos[i]))
						{
							//TODO add score, this should be done on level class
							score.AddScore(300);
							
							//remove the enemy
							removeChild(enemigos[i].removeChild(enemigos[i].m_Image));
							enemigos.removeAt(i);
							
							//remove the bullet
							removeChild(bullets[k].removeChild(bullets[k].m_Image));
							bullets.removeAt(k);
							

							//this return is preventing the access of an invalid i index
							return;
						}
					}
					
					enemigos[i].update();
					enemigos[i].x = enemigos[i].posX;
					enemigos[i].y = enemigos[i].posY;	
				}
				
				MoveBullets(bullets);
				CheckCollisionWithPlayer(enemigos);
			}
			else
			{
				DestroyAllBullets(bullets);
				ShowLevelEndScore(); // TODO
			}
			
		}
		
		protected function MoveBullets(bullets:Vector.<Bullet>):void
		{
			if (bullets.length > 0) 
			{
				for (var i:int = bullets.length - 1; i >= 0; i-- ) 
				{
					if (!physics.TestBoundaries(bullets[i])) 
					{
						bullets[i].update();
						bullets[i].x = bullets[i].posX;
						bullets[i].y = bullets[i].posY;
					}
					else
					{
						
						removeChild(bullets[i].removeChild(bullets[i].m_Image));
						bullets.removeAt(i);
						
					}
				}
			}
		}
		
		private function CheckCollisionWithPlayer(balls:Vector.<Enemy>):void
		{
			for (var i:int = balls.length - 1; i >= 0; i--) 
			{
				//Test if they collide with the player
				if (physics.AreBallsColliding(balls[i], CANNON))
				{
					physics.bounceWithPlayer(balls[i],CANNON);
				}
			}
		}
		
		private function DestroyAllBullets(bullets:Vector.<Bullet>):void
		{
			for (var i:int = 0; i < bullets.length; i++) 
			{
				removeChild(bullets[i].removeChild(bullets[i].m_Image));
				bullets.removeAt(i);
			}
		}
		
		private function ShowLevelEndScore():void
		{
			//TODO
		}
		
	}

}