package utils
{
	import com.friendsofed.vector.*;
	import com.friendsofed.utils.TextBox;
	import flash.display.Graphics;
	import flash.geom.Point;
	import gameObjects.*;
	import starling.display.Sprite;
	import starling.events.*;
	import screens.*;
	import utils.Constants;
	
	public class Physics extends Sprite 
	{
		//private var pelotas:Vector.<Projectile>;

		private var v0:VectorModel;
		private var v1:VectorModel;
		private var v2:VectorModel;
		private var v3:VectorModel;
		private var v4:VectorModel;
		private var spoke:VectorModel;

		public function Physics() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void 
		{			
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			v0 = new VectorModel();
			v1 = new VectorModel();
			v2 = new VectorModel();
			v3 = new VectorModel();
			v4 = new VectorModel();
			spoke = new VectorModel();
		}
		
		//check if theres collision between balls and calculates the bounce 
		public function AreBallsColliding(b1:Ball, b2:Ball):Boolean
		{
			v0.update(b1.posX, b1.posY, b2.posX, b2.posY);

			var totalRadio:Number = b1.Radius + b2.Radius;
			
			if (v0.m < totalRadio)
			{
				return true;
			}
			
			return false;
		}
		
		public  function CheckCollisionWithBoundary(entity:Ball):Boolean
		{
			spoke.update(entity.posX,
							entity.posY, 
							entity.posX + v2.ln.dx * entity.Radius, 
							entity.posY + v2.ln.dy * entity.Radius);
							
			//actualizamos el v1 para que salga a partir del final del radio
			v1.update(spoke.b.x, spoke.b.y, spoke.b.x + entity.Vx, spoke.b.y + entity.Vy);
			
			v3.update(v1.a.x, v1.a.y, v2.a.x, v2.a.y);
			
			var dp1:Number = VectorMath.dotProduct(v3, v2);
			var dp2:Number = VectorMath.dotProduct(v3, v2.ln);
			
			if (dp1 > -v2.m && dp1 < 0)
			{				
				if (dp2 <= 0)
				{
					return true;
				}
			}
			
			return false;
		}
		
		
		public  function TestBoundaries(entity:Ball):Boolean
		{
			if (entity.Vx < 0)
			{
				//Vector pared izquierda
				v2.update(0, stage.stageHeight,0 ,0);		
			}
			else
			{
				//Vector pared derecha
				v2.update(stage.stageWidth,0, stage.stageWidth , stage.stageHeight)
			}
			
			if (CheckCollisionWithBoundary(entity))
			{
				return true;
			}
			
			else if (entity.Vy < 0)
			{
				//Vector pared superior
				v2.update(0, 0, stage.stageWidth, 0);
			}
			else
			{
				//Vector pared inferior
				v2.update(stage.stageWidth, stage.stageHeight, 0, stage.stageHeight);
			}
			
			if (CheckCollisionWithBoundary(entity)) 
			{
				return true;
			}
			
			return false;
		}
		
		public  function BounceBetweenBalls(b1:Ball, b2:Ball):void
		{
			
			var totalRadio:Number = b1.Radius + b2.Radius;
			
			var overlap:Number = totalRadio - v0.m;
				
			var collision_Vx:Number = Math.abs(v0.dx * overlap);
			var collision_Vy:Number = Math.abs(v0.dy * overlap);
				
			var xSide:int;
			var ySide:int;
				
			b1.posX > b2.posX ? xSide = 1 : xSide = -1;
			b1.posY > b2.posY ? ySide = 1 : ySide = -1;
				
			b1.SetX = b1.posX + (collision_Vx * xSide);
			b1.SetY = b1.posY + (collision_Vy * ySide);
				
			b2.SetX = b2.posX + (collision_Vx * -xSide);
			b2.SetY = b2.posY + (collision_Vy * -ySide);
				
			v1.update(b1.posX, b1.posY, b1.posX + b1.Vx, b1.posY + b1.Vy);
			v2.update(b2.posX, b2.posY, b2.posX + b2.Vx, b2.posY + b2.Vy);
				
			var p1a:VectorModel = VectorMath.project(v1, v0);
			var p1b:VectorModel = VectorMath.project(v1, v0.ln);
				
			var p2a:VectorModel = VectorMath.project(v2, v0);
			var p2b:VectorModel = VectorMath.project(v2, v0.ln);
				
			var bouceB1:VectorModel = new VectorModel(0, 0, 0, 0, p1b.vx + p2a.vx, p1b.vy + p2a.vy);
			var bouceB2:VectorModel = new VectorModel(0, 0, 0, 0, p1a.vx + p2b.vx, p1a.vy + p2b.vy);
				
			b1.Vx = Constants.BOUNCE_SPEED*bouceB1.dx;
			b1.Vy = Constants.BOUNCE_SPEED*bouceB1.dy;
			b2.Vx = Constants.BOUNCE_SPEED*bouceB2.dx;
			b2.Vy = Constants.BOUNCE_SPEED*bouceB2.dy;

				
		}	
		
		
		public function bounceWithPlayer(b:Ball, cannon:Ball):void 
		{
			var totalRadii:Number = b.Radius + cannon.Radius;
			var overlap:Number = totalRadii - v0.m;
			
			b.SetX = b.posX - (overlap * v0.dx);
			b.SetY = b.posY - (overlap * v0.dy);
			
			v1.update(b.posX, b.posY, b.posX + b.Vx, b.posY + b.Vy);
			
			var bounce:VectorModel = VectorMath.bounce(v1, v0.ln);
			
			b.Vx = bounce.vx;
			b.Vy = bounce.vy;
		}

		public  function bounceWithBoundarie(entity:Ball):void
		{
			var overlap:Number;
			overlap = entity.Radius - spoke.m;
			
			entity.SetX = entity.posX - (overlap * spoke.dx);
			entity.SetY = entity.posY - (overlap * spoke.dy);
			
			var motion:VectorModel = new VectorModel(entity.posX, entity.posY, entity.posX + entity.Vx , entity.posY + entity.Vy);
			
			var bounce:VectorModel = VectorMath.bounce(motion, spoke.rn);
			
			entity.Vx = bounce.vx;
			entity.Vy = bounce.vy;
		}
	}
}

