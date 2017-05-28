package gameObjects 
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import utils.Assets;
	import gameObjects.Ball;
	import screens.Level;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.display.Sprite;
	import starling.events.*;
	import starling.animation.Juggler;
	
	/**
	 * ...
	 * @author EDUARDO SIMON
	 */
	public class Cannon extends Ball
	{
		
		private var PLAYER_CENTER_X:Number;
		private var PLAYER_CENTER_Y:Number;
		private var shieldMovieClip:MovieClip;
		private var shieldSoundChannel:SoundChannel;
		private var shieldTrack:Sound;

		
		public function Cannon() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			shieldSoundChannel = new SoundChannel();
			shieldTrack = new Sound(new URLRequest("../media/sound/shield_loop.mp3"));
		}
		
		private function onRemoved(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			
			shieldSoundChannel.stop();
		}
		

		private function onAdded(e:Event):void
		{
						
			//starling sprite creation
			m_Image = new Image(Assets.getTexture("CannonBitmap"));
			shieldMovieClip = new MovieClip(Assets.getAtlas().getTextures("shield_"), 8);
			Starling.juggler.add(shieldMovieClip);


			PLAYER_CENTER_X = (m_Image.width / 2);
			PLAYER_CENTER_Y = (m_Image.height / 2);
			m_Image.scale *= 0.6;
						
			//display it on the stage
			addChild(m_Image);
			addChild(shieldMovieClip);	
			
			//positionate the shield animation
			shieldMovieClip.alignPivot();
			shieldMovieClip.scale = 0.3;
			shieldMovieClip.x = stage.stageWidth / 2;
			shieldMovieClip.y = stage.stageHeight / 2;
			
			SetPivotToCenter();
						
			//play shield loop
			shieldSoundChannel = shieldTrack.play();
			
			stage.addEventListener(TouchEvent.TOUCH, onTouched);
			
			m_Radius = shieldMovieClip.width/2;
			
			m_Image.visible = true;
		}
		
		private function onTouched(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
			if (touch)
			{
				if (touch.phase == TouchPhase.HOVER) 
				{
					var op:Number = m_Image.y - touch.globalY;
					var cont:Number = m_Image.x - touch.globalX;
					var angleToRotate:Number = Math.atan2(op,cont);
					m_Image.rotation = angleToRotate;
				}
			}
		}
		
		public function CenterPlayerToStage():void
		{
			m_Image.x = 400;
			m_Image.y = 300;
			
			posX = stage.stageWidth/2;
			posY = stage.stageHeight/2;
		}
		
		
		private function SetPivotToCenter():void
		{
			m_Image.pivotX = PLAYER_CENTER_X;
			m_Image.pivotY = PLAYER_CENTER_Y;
		}
		
		private function degreesToRad(degrees:Number):Number
		{
			return degrees * (Math.PI / 180);
		}
		
		public function changeXY(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;	
		}
	
	}

}