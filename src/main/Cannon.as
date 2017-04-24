package main 
{
	import Assets;
	import objects.Ball;
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
	public class Cannon extends Ball
	{
		
		private var PLAYER_CENTER_X:Number;
		private var PLAYER_CENTER_Y:Number;
		
		private var _mPlayerTexture:Texture;
		private var _mPlayerImage:Image;
		
		
		public function Cannon() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			
		}
		
		public function CenterPlayerToStage():void
		{
			_mPlayerImage.x = 400;
			_mPlayerImage.y = 300;
			
			posX = stage.stageWidth/2;
			posY = stage.stageHeight/2;
		}
		
		private function onAdded(e:Event):void{
						
			//starling sprite creation
			
			_mPlayerImage = new Image(Assets.getTexture("CannonBitmap"));
			
			PLAYER_CENTER_X = (_mPlayerImage.width / 2);
			PLAYER_CENTER_Y = (_mPlayerImage.height / 2);

			_mPlayerImage.scale *= 0.6;
						
			//display it on the stage
			addChild(_mPlayerImage);
			
			SetPivotToCenter();
						
			stage.addEventListener(TouchEvent.TOUCH, onTouched);
			
			m_Radius = _mPlayerImage.width / 2;
			
			m_Image.visible = false;
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
		
		public function changeXY(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;	
		}
	
	}

}