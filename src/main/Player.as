package main 
{
	import Assets;
	import screens.Level1;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.display.Sprite;
	import starling.events.*;
	/**
	 * ...
	 * @author EDUARDO SIMON
	 */
	public class Player extends Sprite
	{
		
		private var PLAYER_CENTER_X:Number;
		private var PLAYER_CENTER_Y:Number;
		
		private var _mPlayerTexture:Texture;
		private var _mPlayerImage:Image;
		

		
		
		public function Player() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);

		}
		
		public function CenterPlayerToStage():void
		{
			_mPlayerImage.x = screens.Level1.PLAYER_X;
			_mPlayerImage.y = screens.Level1.PLAYER_Y;
		}
		
		private function onAdded(e:Event):void{
						
			//starling sprite creation
			
			_mPlayerImage = new Image(Assets.getTexture("CannonBitmap"));
			
			PLAYER_CENTER_X = (_mPlayerImage.width / 2);
			PLAYER_CENTER_Y = (_mPlayerImage.height / 2);
			
			//display it on the stage
			addChild(_mPlayerImage);
			
			SetPivotToCenter();
						
			stage.addEventListener(TouchEvent.TOUCH, onTouched);
		}
		
		private function onTouched(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
			if (touch)
			{
				if (touch.phase == TouchPhase.HOVER) 
				{
					var op:Number = _mPlayerImage.y - touch.globalY;
					var cont:Number = _mPlayerImage.x - touch.globalX;
					var angleToRotate:Number = Math.atan2(op,cont);
					_mPlayerImage.rotation = angleToRotate;
				}
			}
		}
		
		private function SetPivotToCenter():void
		{
			_mPlayerImage.pivotX = PLAYER_CENTER_X;
			_mPlayerImage.pivotY = PLAYER_CENTER_Y;
		}
		
		private function degreesToRad(degrees:Number):Number
		{
			return degrees * (Math.PI / 180);
		}
		
	}

}