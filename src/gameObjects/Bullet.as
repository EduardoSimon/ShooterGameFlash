package gameObjects 
{
	import starling.events.Event;
	import starling.display.Image;
	import utils.Assets;
	/**
	 * ...
	 * @author EDUARDO SIMON
	 */
	public class Bullet extends Ball 
	{
		
		public function Bullet(angle:Number=0, speed:Number=20, radius:Number=0) 
		{
			super(angle,speed,radius);
			
			addEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
		}
		
		private function OnAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
			
			m_Image = new Image(Assets.getAtlas().getTexture("ball_blue"));
			
			this.addChild(m_Image);
					
			m_Image.scale = 0.03;
			
			m_Image.alignPivot();
			
			m_Radius = m_Image.width/2;
		}
		
		
		
	}

}