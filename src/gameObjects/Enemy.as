package gameObjects 
{
	/**
	 * ...
	 * @author EDUARDO SIMON
	 */
	public class Enemy extends Ball 
	{
		private var m_isFrozen:Boolean;
		
		public function Enemy(angle:Number=0, speed:Number=20, radius:Number=0) 
		{
			super(angle, speed, radius);
			m_isFrozen = false;
			
		}
		
		public function get Frozen():Boolean
		{
			return m_isFrozen;
		}
		
		public function set Frozen(value:Boolean):void
		{
			m_isFrozen = value;
		}
		
		public override function update():void
		{
			if (!m_isFrozen)
			{
				m_tempX = posX;
				m_tempY = posY;
			
				posX += Vx;
				posY += Vy;
			
				m_previousX = m_tempX;
				m_previousY = m_tempY;
			}
			
		}
	}

}