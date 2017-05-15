package screens 
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import main.Cannon;
	import com.friendsofed.vector.*;
	import com.friendsofed.utils.TextBox;
	import flash.display.Graphics;
	import flash.geom.Point;
	import mx.core.SoundAsset;
	import objects.Ball;
	import objects.Enemy;
	import objects.Bullet;
	import starling.display.Sprite;
	import starling.events.*;
	import utils.Constants;

	public class Level1 extends Level
	{
		protected var enemyHits:int;
		
		public function Level1() 
		{
			super();
		}

		override protected function OnEnterFrame(e:Event):void 
		{
			super.OnEnterFrame(e);
			
			if (enemyHits == Constants.N_PROJECTILES) 
			{
				super.EndLevel();
				return;
			}
		}
		
		override protected function MoveEntities(enemigos:Vector.<Enemy>,bullets:Vector.<Bullet>):void 
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
							
							//we add a hit to our enemyHits count
							enemyHits += 1;
							

							//this return is preventing the access of an invalid i index
							return;
						}
					}
					
					enemigos[i].update();
					enemigos[i].x = enemigos[i].posX;
					enemigos[i].y = enemigos[i].posY;	
				}
				
				MoveBullets(bullets);
				super.CheckCollisionWithPlayer(enemigos);
			}
		}
	}

}