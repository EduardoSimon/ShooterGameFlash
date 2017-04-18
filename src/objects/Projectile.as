package objects 
{
	import Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.events.*;
	import utils.Vector2D;
	
	/**
	 * ...
	 * @author EDUARDO SIMON
	 */
	public class Projectile extends MovingEntity
	{
		private var m_Image:Image;
		private var m_Speed:Number;
		private var m_Radius:Number;
		
		
		public function Projectile(angle:Number,speed:Number = 20)
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			m_Speed = speed;
			
			this.posX = speed * Math.cos(angle);
			this.posY = speed * Math.sin(angle);
			
			m_Radius = 0;
		}
	
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			m_Image = new Image(Assets.getTexture("BallBitmap"));
			
			addChild(m_Image);
					
			m_Image.scale = 0.05;
			
			m_Image.alignPivot();
			
			m_Radius = m_Image.width/2;

		}
		
		public function get Radius():Number
		{
			return m_Radius;
		}
		
		
		/*
		override public function update():void
		{
			super.update();
			
			m_Image.x = posX;
			m_Image.y = posY;
		}*/
	}

}