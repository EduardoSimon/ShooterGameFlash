package screens 
{
	/**
	 * ...
	 * @author Marc
	 */
	
	import com.friendsofed.vector.*;
	import com.friendsofed.utils.TextBox;
	import flash.display.Graphics;
	import flash.geom.Point;
	import gameObjects.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.*;
	import starling.display.Sprite;
	import starling.events.*;
	import utils.*;
	import starling.display.Image;

	
	public class Level2 extends Level 
	{
		private var frozenEnemies:int = 0;
		private var soundsChannel:SoundChannel;
		private var freezeTrack:Sound;
		private var unfreezeTrack:Sound;
		
		public function Level2() 
		{
			super();
			
			backgound = new Image(Assets.getAtlas().getTexture("bg2"));
			this.addChild(backgound);
		
			soundsChannel = new SoundChannel();
			freezeTrack = new Sound(new URLRequest("../media/sound/fx_freeze.mp3"));
			unfreezeTrack = new Sound(new URLRequest("../media/sound/fx_unfreeze.mp3"));
		}
		
		protected override function OnEnterFrame(e:Event):void
		{
			super.OnEnterFrame(e);
			
			if (frozenEnemies == Constants.N_PROJECTILES) 
			{
				super.EndLevel();
				return;
			}
		}
		

		protected override function MoveEntities(enemies:Vector.<Enemy>,bullets:Vector.<Bullet>):void 
		{
			//if there are balls
			if (enemies.length > 0)
			{
					for (var i:int = enemies.length - 1; i >= 0 ; i--)
					{
							
						//check if theres collision with the stage boundaries
						if (physics.TestBoundaries(enemies[i])) 
						{
							//if there is collision calculate the bounce vector
							physics.bounceWithBoundarie(enemies[i]);
						}
					
						if (!enemies[i].Frozen)
						{

							//check for every other ball but without comparing them twice // j < i
							for (var j:int = 0; j < i; j++)
							{
								//check again against the boundaries
								if (physics.TestBoundaries(enemies[j])) 
								{
									physics.bounceWithBoundarie(enemies[j]);
								}
								
								if (physics.AreBallsColliding(enemies[i], enemies[j]))
								{
									//theres bounce between balls only when none of both is frozen
									if (!enemies[i].Frozen && !enemies[j].Frozen) 
									{
										physics.BounceBetweenBalls(enemies[i], enemies[j]);
									}
								}		
							}
							
						}
						
							//check if there's collision between bullets and enemies
						for (var k:int = bullets.length - 1; k >= 0; k--) 
						{
							if (physics.AreBallsColliding(bullets[k],enemies[i]))
							{
								//if we hit an enemy with a bullet we freeze it
								if (!enemies[i].Frozen)
								{
									Freeze(enemies[i]);
								}
								else 
								{
									Unfreeze(enemies[i]);
								}

								//remove the bullet
								removeChild(bullets[k].removeChild(bullets[k].m_Image));
								bullets.removeAt(k);
							}
						}
						

						//Test if they collide with the player
						if (physics.AreBallsColliding(enemies[i], CANNON))
						{
							physics.bounceWithPlayer(enemies[i],CANNON);
						}
						
						enemies[i].update();
						enemies[i].x = enemies[i].posX;
						enemies[i].y = enemies[i].posY;	
						
					}
					
					
				
				
				MoveBullets(bullets);
			}	
		}
		
		private function Freeze(e:Enemy):void
		{
			//we check the frozen flag and add 1 to the counter
			soundsChannel = freezeTrack.play();
			frozenEnemies += 1;
			e.Frozen = true;
			
			//in order to change the image's texture on run-time, we have to access its public texture setter
			e.m_Image.texture = e.FrozenImage;
			e.Vx = 0;
			e.Vy = 0;
			
			//we add score too if we freeze an enemy
			score.AddScore(300);
		}
		
		private function Unfreeze(e:Enemy):void
		{
			soundsChannel = unfreezeTrack.play();
			frozenEnemies -= 1;
			e.Frozen = false;
			
			e.m_Image.texture = e.NormalImage;
			e.Vx = Constants.BOUNCE_SPEED * Math.cos(Math.random());
			e.Vy = Constants.BOUNCE_SPEED * Math.sin(Math.random());
			
			score.AddScore( -300);
		}
		
	}

}