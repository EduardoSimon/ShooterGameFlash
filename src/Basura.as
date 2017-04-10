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
				
				var temp:Projectile = new Projectile(randomAngle, 5);
				
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
					
					if (TestBoundaries(pelotas[i])) 
					{
						bounceWithBoundarie(pelotas[i]);
					}
					
					pelotas[i].update();
					pelotas[i].x = pelotas[i].posX;
					pelotas[i].y = pelotas[i].posY;
						
				}
			}
			
		}

		private function TestBoundaries(entity:Projectile):Boolean
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
			
			if (boundariesCollisions(entity)) 
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
			
			if (boundariesCollisions(entity)) 
			{
				return true;
			}
			
			return false;
		}
		public function boundariesCollisions(entity:Projectile):Boolean
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
		
		public function bounceWithBoundarie(entity:Projectile):void
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

