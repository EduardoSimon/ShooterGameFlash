package gameObjects 
{
	import starling.events.Event;
	import starling.display.Image;
	import utils.*;
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
			addEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
			m_isFrozen = false;
			
		}
		
		private function OnAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
			
			m_Image = new Image(Assets.getAtlas().getTexture("ball_red"));
			
			this.addChild(m_Image);
					
			m_Image.scale = 0.05;
			
			m_Image.alignPivot();
			
			m_Radius = m_Image.width/2;
			
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