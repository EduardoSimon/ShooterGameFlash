package objects 
{
	import Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.events.*;
	import utils.Vector2D;
	
	/**
	 * ...
	 * @author EDUARDO SIMON
	 */
	public class Ball extends Sprite
	{
		private var _mImage:Image;
		private var _mPosX:Number;
		private var _mPosY:Number;
		private var _mVelocity:utils.Vector2D;
		private var _mSpeed:Number;
		
		
		public function Ball(x:Number, y:Number)
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.ENTER_FRAME, OnEnterFrame);
			_mPosX = x;
			_mPosY = y;
			
		}
		
		private function OnEnterFrame(e:Event):void 
		{
			this.UpdatePosition();
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			_mImage = new Image(Assets.getTexture("BallBitmap"));
			
			addChild(_mImage);
			
						
			_mImage.scale = 0.1;
			
			
			_mImage.x = _mPosX - _mImage.width / 2;
			_mImage.y = _mPosY - _mImage.height / 2;

			_mVelocity = new utils.Vector2D(1, 1);
			_mSpeed = 10;
		}
		
		public function set SetX(x:Number):void
		{
			_mPosX = x;
		}
		
		public function set SetY(y:Number):void{
			_mPosY = y;
		}
		
		private function UpdatePosition():void
		{
			this.x += _mVelocity.GetX() * _mSpeed;
			this.y += _mVelocity.GetY() * _mSpeed;
		}
		
		public function SetVelocity(vel:utils.Vector2D):void
		{
			_mVelocity = vel;
		}
		
		public function SetVelocityWithAngle(angle:Number, x:Number, y:Number):void
		{
			var temp:utils.Vector2D = new utils.Vector2D(x, y);
			
			var _x:Number = temp.GetMagnitude() * Math.cos(angle);
			var _y:Number = temp.GetMagnitude() * Math.sin(angle);
			
			_mVelocity = new utils.Vector2D(_x, _y).GetDirection();
		}
	}

}