package 
{
	import com.friendsofed.vector.*;
	import com.friendsofed.utils.TextBox;
	import flash.display.Graphics;
	import flash.geom.Point;
	import objects.Projectile;
	import starling.display.Sprite;
	import starling.events.*;
	
	public class Basura extends Sprite 
	{
		public const N_PROJECTILES:int = 30;
		private var pelotas:Vector.<Projectile>;
		private var v1:VectorModel;
		private var v2:VectorModel;
		private var v3:VectorModel;
		private var spoke:VectorModel;
		
		public function Basura() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void 
		{
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			pelotas = new Vector.<Projectile>();
			v1 = new VectorModel();
			v2 = new VectorModel();
			v3 = new VectorModel();
			spoke = new VectorModel();
			
			for (var i:int = 0; i < N_PROJECTILES; i++)
			{
				var randomAngle:Number = Math.random() * (2 * Math.PI);
				
				var temp:Projectile = new Projectile(randomAngle, 20);
				
				temp.SetX = Math.random() * stage.stageWidth - temp.width / 2;
				temp.x = temp.posX;
				temp.SetY = Math.random() * stage.stageHeight - temp.height / 2;
				temp.y = temp.posY;
				
				pelotas.push(temp);
				
				addChild(temp);
			}
		}
		
		private function onEnterFrame(e:Event):void 
		{
			if (pelotas.length > 0)
			{
				for (var i:int = 0; i < pelotas.length; i++)
				{
						boundariesCollisions(pelotas[i]);
						pelotas[i].update();
						pelotas[i].x = pelotas[i].posX;
						pelotas[i].y = pelotas[i].posY;
						
				}
			}
		}
		
		public function boundariesCollisions(entity:Projectile):void
		{

			if (v1.b.x <= 0)
			{
				//Vector pared izquierda
				v2.update(0, 0, 0, stage.stageHeight);
				spoke.update(entity.posX,
							entity.posY, 
							entity.posX + v2.rn.dx * entity.Radius, 
							entity.posY + v2.rn.dy * entity.Radius);
			}
			else if(v1.b.x >= stage.stageWidth)
			{
				//Vector pared derecha
				v2.update(stage.stageWidth, stage.stageHeight , stage.stageWidth , 0)
				spoke.update(entity.posX,
							entity.posY, 
							entity.posX + v2.ln.dx * entity.Radius, 
							entity.posY + v2.ln.dy * entity.Radius);
			}
						
			else if (v1.b.y < 0)
			{
				//Vector pared superior
				v2.update(0, 0, stage.stageWidth, 0);
				spoke.update(entity.posX,
							entity.posY, 
							entity.posX + v2.ln.dx * entity.Radius, 
							entity.posY + v2.ln.dy * entity.Radius);
			}
			else
			{
				//Vector pared inferior
				v2.update(stage.stageWidth, stage.stageHeight, 0, stage.stageHeight);
				spoke.update(entity.posX,
							entity.posY, 
							entity.posX + v2.rn.dx * entity.Radius, 
							entity.posY + v2.rn.dy * entity.Radius);
			}
			
			
			//actualizamos el v1 para que salga a partir del final del radio
			v1.update(spoke.b.x, spoke.b.y, spoke.b.x + entity.Vx, spoke.b.y + entity.Vy);
			
			v3.update(v1.a.x, v1.a.y, v2.a.x, v2.a.y);
			
			var dp1:Number = VectorMath.dotProduct(v3, v2);
			var dp2:Number = VectorMath.dotProduct(v3, v2.ln);
			
			var collisionForce_Vx:Number;
			var collisionForce_Vy:Number;
			
			if (dp1 > -v2.m && dp1 < 0)
			{				
				if (dp2 <= 0)
				{
					collisionForce_Vx = v1.dx * Math.abs(dp2);
					collisionForce_Vy = v1.dy * Math.abs(dp2);
					
					entity.SetX = v1.a.x - collisionForce_Vx;
					entity.SetY = v1.a.y - collisionForce_Vy;
					
					entity.Vx = 0;
					entity.Vy = 0;
					
					var dp3:Number = VectorMath.dotProduct(v1, v2);
					
					var p1_Vx:Number = dp3 * v2.dx;
					var p1_Vy:Number = dp3 * v2.dy;
					
					var dp4:Number = VectorMath.dotProduct(v1, v2.ln);
					
					var p2_Vx:Number = dp4 * v2.ln.dx;
					var p2_Vy:Number = dp4 * v2.ln.dy;
					
					p2_Vx *= -1;
					p2_Vy *= -1;
					
					var bounce_Vx:Number = p1_Vx + p2_Vx;
					var bounce_Vy:Number = p1_Vy + p2_Vy;
					
					entity.Vx = bounce_Vx * 1;
					entity.Vy = bounce_Vy * 1;
				}
			}
		
		
		}
	}
}

