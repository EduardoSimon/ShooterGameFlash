package 
{
	/**
	 * ...
	 * @author EDUARDO SIMON
	 */
	public class Vector2D
	{
		private var m_X:Number
		private var m_Y:Number
		
		public function Vector2D(x:Number, y:Number)
		{
			m_X = x;
			m_Y = y;
		}
		
		public function GetMagnitude():Number
		{
			return Math.sqrt((m_X * m_X) + (m_Y * m_Y));
		}
		
		public function GetDirection():Vector2D
		{
			var tempX:Number = m_X / this.GetMagnitude();
			var tempY:Number = m_Y / this.GetMagnitude();
			
			return new Vector2D(tempX, tempY);
		}
		
		public function GetX():Number
		{
			return m_X;
		}
		
		public function GetY():Number
		{
			return m_Y;
		}
	}

}