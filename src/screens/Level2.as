package screens 
{
	/**
	 * ...
	 * @author Marc
	 */
	
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
	import utils.Constants;
	
	public class Level2 extends Level 
	{
		private var frozenEnemies:int = 0;
		
		public function Level2() 
		{
			super();
		}
		
		protected override function OnEnterFrame(e:Event):void
		{
			super.OnEnterFrame(e);
			
			if (frozenEnemies == Constants.N_PROJECTILES) 
			{
				EndLevel();
			}
		}
		
		protected override function MoveEntities(pelotas:Vector.<Enemy>,bullets:Vector.<Bullet>):void 
		{
			//if there are balls
			if (pelotas.length > 0)
			{
					for (var i:int = pelotas.length - 1; i >= 0 ; i--)
					{
							
						//check if theres collision with the stage boundaries
						if (physics.TestBoundaries(pelotas[i])) 
						{
							//if there is collision calculate the bounce vector
							physics.bounceWithBoundarie(pelotas[i]);
						}
					
						if (!pelotas[i].Frozen)
						{

							//check for every other ball but without comparing them twice // j < i
							for (var j:int = 0; j < i; j++)
							{
								//check again against the boundaries
								if (physics.TestBoundaries(pelotas[j])) 
								{
									physics.bounceWithBoundarie(pelotas[j]);
								}
								
								if (physics.AreBallsColliding(pelotas[i], pelotas[j]))
								{
									if (!pelotas[i].Frozen && !pelotas[j].Frozen) 
									{
										physics.BounceBetweenBalls(pelotas[i], pelotas[j]);
									}
								}		
							}
							
						}
						
						
						
							//check if there's collision between bullets and enemies
						for (var k:int = bullets.length - 1; k >= 0; k--) 
						{
							if (physics.AreBallsColliding(bullets[k],pelotas[i]))
							{
								if (!pelotas[i].Frozen)
								{
									frozenEnemies += 1;
									pelotas[i].Frozen = true;
									pelotas[i].m_Image.alpha = 0.1;
									pelotas[i].Vx = 0;
									pelotas[i].Vy = 0;
								}
								else 
								{
									frozenEnemies -= 1;
									pelotas[i].Frozen = false;
									pelotas[i].m_Image.alpha = 1;
									pelotas[i].Vx = Constants.SPEED * Math.cos(Math.random());
									pelotas[i].Vy = Constants.SPEED * Math.sin(Math.random());
								}
								
								//TODO add score, this should be done on level class
								//score.AddScore(300);
								
								//remove the enemy
								//removeChild(pelotas[i].removeChild(pelotas[i].m_Image));
								//pelotas.removeAt(i);
								
								//reomve the bullet
								removeChild(bullets[k].removeChild(bullets[k].m_Image));
								bullets.removeAt(k);
								
							}
						}
						

						//Test if they collide with the player
						if (physics.AreBallsColliding(pelotas[i], CANNON))
						{
							physics.bounceWithPlayer(pelotas[i],CANNON);
						}
						
						pelotas[i].update();
						pelotas[i].x = pelotas[i].posX;
						pelotas[i].y = pelotas[i].posY;	
						
					}
					
					
				
				
				MoveBullets(bullets);
			}	
		}
		
	}

}