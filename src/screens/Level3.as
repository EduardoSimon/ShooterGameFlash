package screens 
{
	
	import gameObjects.*;
	import utils.*;
	import starling.events.Event;
	import starling.display.Image;

	/**
	 * ...
	 * @author Marc
	 */
	public class Level3 extends Level 
	{
		private var frozenEnemies:int = 0;
		
		public function Level3() 
		{
			super();
			backgound = new Image(Assets.getAtlas().getTexture("bg3"));
			this.addChild(backgound);
		}
		
		override protected function OnEnterFrame(e:Event):void 
		{
			super.OnEnterFrame(e);
			
			if (frozenEnemies == Constants.N_PROJECTILES) 
			{
				super.EndLevel();
				return;
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
					
						//check for every other ball but without comparing them twice // j < i
						for (var j:int = 0; j < i; j++)
						{
							//check again against the boundaries
							if (physics.TestBoundaries(pelotas[j])) 
							{
								physics.bounceWithBoundarie(pelotas[j]);
							}
							
							//check if balls are colliding against each other
							if (physics.AreBallsColliding(pelotas[i], pelotas[j]))
							{
								//check if one of the balls is frozen and the other isnt, and viceversa
								if ((pelotas[i].Frozen && !pelotas[j].Frozen) || (!pelotas[i].Frozen && pelotas[j].Frozen)) 
								{
									//if the first ball is frozen
									if (pelotas[i].Frozen) 
									{
										//unfreeze it and decrease the counter
										frozenEnemies -= 1;
										UnfreezeBall(pelotas[i]);
									}
									else
									{
										//unfreeze the other
										frozenEnemies -= 1;
										UnfreezeBall(pelotas[j]);
									}
								}
								else
								{
									physics.BounceBetweenBalls(pelotas[i], pelotas[j]);
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
									//freeze ball if it collides with a bullet
									//TODO : PLAY A SOUND
									frozenEnemies += 1;
									FreezeBall(pelotas[i]);
									score.AddScore(300);
								
									//remove the bullet
									removeChild(bullets[k].removeChild(bullets[k].m_Image));
									bullets.removeAt(k);
								}
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
			
		private function FreezeBall(enemy:Enemy):void
		{
			enemy.Frozen = true;
			enemy.m_Image.alpha = 0.1;
			enemy.Vx = 0;
			enemy.Vy = 0;
		}
		
		private function UnfreezeBall(enemy:Enemy):void
		{
			enemy.Frozen = false;
			enemy.m_Image.alpha = 1;
			enemy.Vx = Constants.BOUNCE_SPEED * Math.cos(Math.random());
			enemy.Vy = Constants.BOUNCE_SPEED * Math.sin(Math.random());
		}
	}

}

