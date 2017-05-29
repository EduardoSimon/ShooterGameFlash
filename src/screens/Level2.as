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
			
			//TODO: cambiar por las pistas que tocan
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
									soundsChannel = freezeTrack.play();
									frozenEnemies += 1;
									pelotas[i].Frozen = true;
									pelotas[i].m_Image.texture = pelotas[i].FrozenImage;
									pelotas[i].Vx = 0;
									pelotas[i].Vy = 0;
									score.AddScore(300);
								}
								else 
								{
									soundsChannel = unfreezeTrack.play();
									frozenEnemies -= 1;
									pelotas[i].Frozen = false;
									pelotas[i].m_Image.texture = pelotas[i].NormalImage;
									pelotas[i].Vx = Constants.BOUNCE_SPEED * Math.cos(Math.random());
									pelotas[i].Vy = Constants.BOUNCE_SPEED * Math.sin(Math.random());
									score.AddScore( -300);
								}

								//remove the bullet
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