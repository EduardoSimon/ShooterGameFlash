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
		private var m_Image_frozen:Image;

		
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
			
			m_Image_frozen = new Image(Assets.getAtlas().getTexture("ballfrost"));
			
			this.addChild(m_Image);
					
			m_Image.scale = .5;
			m_Image_frozen.scale = .5;
			
			m_Image.alignPivot();
			m_Image_frozen.alignPivot();
			
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