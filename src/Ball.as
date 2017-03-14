package 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.events.*;
	
	/**
	 * ...
	 * @author EDUARDO SIMON
	 */
	public class Ball extends Sprite
	{
		[Embed(source="../img/ball_red.png")]
		public static const BallBitmap:Class;
		
		private var _mTouchData:Touch;
		private var _mTexture:Texture;
		private var _mImage:Image;
		private var _mPosX:Number;
		private var _mPosY:Number;
		
		
		public function Ball(x:Number, y:Number)
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			_mPosX = x;
			_mPosY = y;
			
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			_mTexture = Texture.fromBitmap(new BallBitmap());
			_mImage = new Image(_mTexture);
			
			addChild(_mImage);
			
						
			_mImage.scale = 0.1;
			
			
			_mImage.x = _mPosX - _mImage.width / 2;
			_mImage.y = _mPosY - _mImage.height / 2;

		}
		
		public function set SetX(x:Number):void
		{
			_mPosX = x;
		}
		
		public function set SetY(y:Number):void{
			_mPosY = y;
		}
		
	}

}