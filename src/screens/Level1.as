package screens 
{
	import main.Cannon;
	
	import com.friendsofed.vector.*;
	import com.friendsofed.utils.TextBox;
	import flash.display.Graphics;
	import flash.geom.Point;
	import objects.Ball;
	import starling.display.Sprite;
	import starling.events.*;
	/**
	 * ...
	 * @author EDUARDO SIMON
	 */
	public class Level1 extends Sprite
	{
		private var ball:objects.Ball;
		private var player:main.Cannon;
		private var projectiles:Vector.<Ball>;
		private var basura:Physics;
		
		public const N_PROJECTILES:int = 10;
	
		public static const PLAYER_X:Number = 400;
		public static const PLAYER_Y:Number = 300;
		
		public function Level1() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.ENTER_FRAME, OnEnterFrame);
			projectiles = new Vector.<Ball>();
			basura = new Physics();

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
					ball = new objects.Ball(angle, 10);
					ball.SetX = PLAYER_X + (Math.cos(angle) * 40);
					ball.SetY = PLAYER_Y + (Math.sin(angle) * 40);
					projectiles.push(ball);
					addChildAt(ball, stage.numChildren - 1);
				}
			}
		}
				
		private function drawLevel1():void{
			player = new main.Cannon();
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