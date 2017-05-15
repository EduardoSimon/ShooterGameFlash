package gameObjects
{
	import starling.display.Sprite;
	/**
	 * ...
	 * @author ...
	 */
	public class MovingEntity extends Sprite
	{
		protected var m_tempX:Number;
		protected var m_tempY:Number;
		protected var m_previousX:Number;
		protected var m_previousY:Number;
		
		public var posX:Number;
		public var posY:Number;
		
		public function MovingEntity() 
		{
			m_tempX = 0;
			m_tempY = 0;
			m_previousX = 0;
			m_previousY = 0;
			posX = 0;
			posY = 0;
		}
		
		public function update():void
		{
			m_tempX = posX;
			m_tempY = posY;
			
			posX += Vx;
			posY += Vy;
			
			m_previousX = m_tempX;
			m_previousY = m_tempY;
		}
		
		public function get Vx():Number
		{
			return posX - m_previousX;
		}
		
		public function get Vy():Number
		{
			return posY - m_previousY;
		}
		
		public function set Vx(value:Number):void
		{
			m_previousX = posX - value;
		}
		
		public function set Vy(value:Number):void
		{
			m_previousY = posY - value;
		}
		
		public function set SetX(value:Number):void
		{
			m_previousX = value - Vx;
			posX = value;
		}
		
		public function set SetY(value:Number):void
		{
			m_previousY = value - Vy;
			posY = value;
		}
		
		
	}

}