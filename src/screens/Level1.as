package screens 
{
	import main.Player;
	
	import com.friendsofed.vector.*;
	import com.friendsofed.utils.TextBox;
	import flash.display.Graphics;
	import flash.geom.Point;
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
		private var basura:Basura;
		
		public const N_PROJECTILES:int = 10;

		
		public static const PLAYER_X:Number = 400;
		public static const PLAYER_Y:Number = 300;
		
		public function Level1() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.ENTER_FRAME, OnEnterFrame);
			projectiles = new Vector.<Projectile>();
			basura = new Basura();

		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			drawLevel1();
			
			for (var i:int = 0; i < N_PROJECTILES; i++)
			{
				var randomAngle:Number = Math.random() * (2 * Math.PI);
				
				var temp:Projectile = new Projectile(randomAngle, 5);
				
				temp.SetX = Math.random() * stage.stageWidth - temp.width / 2;
				temp.x = temp.posX;
				temp.SetY = Math.random() * stage.stageHeight - temp.height / 2;
				temp.y = temp.posY;
				
				projectiles.push(temp);
				
				addChild(temp);
				addChild(basura);
			}
		}
		
		public function OnEnterFrame(e:Event):void 
		{
			basura.MoveBalls(projectiles);
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
					ball = new objects.Projectile(angle, 10);
					ball.SetX = PLAYER_X + (Math.cos(angle) * 40);
					ball.SetY = PLAYER_Y + (Math.sin(angle) * 40);
					projectiles.push(ball);
					addChildAt(ball, stage.numChildren - 1);
				}
			}
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