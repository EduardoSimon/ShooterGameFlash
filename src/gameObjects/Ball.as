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
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			m_Speed = speed;
			
			this.posX = speed * Math.cos(angle);
			this.posY = speed * Math.sin(angle);
			
			m_Radius = radius;
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			m_Image = new Image(Assets.getTexture("BallBitmap"));
			
			this.addChild(m_Image);
					
			m_Image.scale = 0.05;
			
			m_Image.alignPivot();
			
			m_Radius = m_Image.width/2;

		}
		
		public function get Radius():Number
		{
			return m_Radius;
		}
		
	}

}