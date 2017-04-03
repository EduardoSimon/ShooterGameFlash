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
		
		
		public function Projectile(angle:Number = 0,speed:Number = 20)
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			m_Speed = speed;
			
			this.posX = speed * Math.cos(angle);
			this.posY = speed * Math.sin(angle);
		}
	
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			m_Image = new Image(Assets.getTexture("BallBitmap"));
			
			addChild(m_Image);
					
			m_Image.scale = 0.1;
			
			m_Image.alignPivot();

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