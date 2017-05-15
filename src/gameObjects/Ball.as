package gameObjects 
{
	import utils.Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.events.*;	
	/**
	 * ...
	 * @author EDUARDO SIMON
	 */
	public class Ball extends MovingEntity
	{
		public var m_Image:Image;
		public var m_Speed:Number;
		public var m_Radius:Number;
				
		public function Ball(angle:Number = 0, speed:Number = 20, radius:Number = 0)
		{
			
			m_Speed = speed;
			
			this.posX = speed * Math.cos(angle);
			this.posY = speed * Math.sin(angle);
			
			m_Radius = radius;
		}
		
		
		public function get Radius():Number
		{
			return m_Radius;
		}
		
		
	}

}