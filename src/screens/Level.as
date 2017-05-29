package screens 
{
	import events.GameOverEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import com.friendsofed.vector.*;
	import com.friendsofed.utils.TextBox;
	import flash.display.Graphics;
	import flash.geom.Point;
	import flash.text.Font;
	import main.Game;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.*;
	import utils.*;
	import events.NavigationEvent;
	import gameObjects.*;
	import starling.text.TextFieldAutoSize;

	public class Level extends Sprite
	{

		protected var score:Score;
		protected var enemies:Vector.<Enemy>;
		protected var bullets:Vector.<Bullet>; 
		protected var physics:Physics;
		protected var track:Sound;
		protected var channel:SoundChannel;
		protected var doomFont:Font = new Assets.Doom();
		
		public static var CANNON:Cannon;
		public var backgound:Image;


		public function Level() 
		{
			initialize();
		}
		
		protected function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			drawLevel();
		}
		
		protected function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			stage.removeEventListener(TouchEvent.TOUCH, onAddedToStage);
			channel.stop();
		}
		
		protected function OnEnterFrame(e:Event):void 
		{
			score.UpdateScoreWithDelta(Constants.SCORE_DELTA);
			MoveEntities(enemies, bullets);
			
			if (score.ScoreInt <= 0) 
			{
				EndLevel();
			}
		}
		
		
		
		protected function onTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage);
			if (touch)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
					//calculate the angle which we will use to determine the speed in x and y
					var angle:Number = Math.atan2(touch.globalY - Constants.PLAYER_Y, touch.globalX -  Constants.PLAYER_X);
					
					//push to the vector and add to the display list
					var bullet:Bullet = new Bullet(angle, Constants.SPEED);
					//40 is the length of the cannon.
					bullet.SetX = Constants.PLAYER_X + (Math.cos(angle) * 20);
					bullet.SetY = Constants.PLAYER_Y + (Math.sin(angle) * 20);
					bullets.push(bullet);
					addChild(bullet);
					score.AddScore( -100);
					channel = track.play();
				}
			}
		}
				
		private function drawLevel():void
		{
			
			//create and display the enemies
			for (var i:int = 0; i < Constants.N_PROJECTILES; i++)
			{
				//random angle in RADIANS
				var randomAngle:Number = Math.random() * (2 * Math.PI);
				
				var tempEnemy:Enemy = new Enemy(randomAngle, 5);
				
				//select a random x and a random y between the width and the height of the stage.
				tempEnemy.SetX = Math.random() * stage.stageWidth - tempEnemy.width / 2;
				tempEnemy.x = tempEnemy.posX;
				tempEnemy.SetY = Math.random() * stage.stageHeight - tempEnemy.height / 2;
				tempEnemy.y = tempEnemy.posY;
				
				enemies.push(tempEnemy);
				
				addChild(tempEnemy);
			}
			
			//show the score
			addChild(score);
			score.ScoreTextField.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			addChild(physics);
			
			//set the cannon in its correct position
			addChild(CANNON);
			CANNON.CenterPlayerToStage();
			CANNON.SetX = Constants.PLAYER_X;
			CANNON.SetY = Constants.PLAYER_Y;
		}
		
		public function disposeTemporarily():void{
			this.visible = false;
		}
		
		protected function initialize():void
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.ENTER_FRAME, OnEnterFrame);

			score = new Score(Constants.START_SCORE, 0, 0, 80, 60, 2, "", doomFont.fontName, 40, 0x00FF00, false);
			enemies = new Vector.<Enemy>();
			bullets = new Vector.<Bullet>();
			physics = new Physics();
			CANNON = new Cannon();
			track = new Sound(new URLRequest("../media/sound/laser.mp3"));

		}
		
		public function get Visible(): Boolean{
			return this.visible;
		}
		

		protected function MoveEntities(enemigos:Vector.<Enemy>,bullets:Vector.<Bullet>):void 
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
		}
		
		protected function EndLevel():void
		{
			DestroyAllBullets(bullets);
			removeEventListener(Event.ENTER_FRAME, OnEnterFrame);
			this.dispatchEvent(new GameOverEvent(GameOverEvent.GAME_OVER, score, true));
			this.dispatchEvent(new events.NavigationEvent(events.NavigationEvent.CHANGE_SCREEN, {id: "gameOver"}, true));
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
		
		protected function CheckCollisionWithPlayer(balls:Vector.<Enemy>):void
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
		
		protected function DestroyAllBullets(bullets:Vector.<Bullet>):void
		{
			for (var i:int = 0; i < bullets.length; i++) 
			{
				removeChild(bullets[i].removeChild(bullets[i].m_Image));
				bullets.removeAt(i);
			}
		}
		
	}

}