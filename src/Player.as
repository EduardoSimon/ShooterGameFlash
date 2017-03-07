package 
{
	import flash.display.Sprite;
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
		
		[Embed(source = "../img/cannon.png")]
		public static const CannonBitmap:Class;
		
		private var PLAYER_CENTER_X:Number;
		private var PLAYER_CENTER_Y:Number;
		
		private var _mPlayerTexture:Texture;
		private var _mPlayerImage:Image;
		
		public function Player() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(TouchEvent.TOUCH, onTouched);
		}
		
		private function CenterPlayerToStage():void
		{
			_mPlayerImage.x = stage.stageWidth / 2 - PLAYER_CENTER_X;
			_mPlayerImage.y = stage.stageWidth / 2 - PLAYER_CENTER_Y;
			
			
		}
		
		private function onAdded(e:Event):void{
						
			//starling sprite creation
			_mPlayerTexture = Texture.fromBitmap(new CannonBitmap());
			_mPlayerImage = new Image(_mPlayerTexture);
			
			PLAYER_CENTER_X = (_mPlayerImage.width / 2);
			PLAYER_CENTER_Y = (_mPlayerImage.height / 2);
			
			//display it on the stage
			addChild(_mPlayerImage);
			
			CenterPlayerToStage();
			SetPivotToCenter();
			
		}
		
		private function onTouched(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
			if (touch)
			{
				if (touch.phase == TouchPhase.BEGAN) 
				{

					_mPlayerImage.rotation += degreesToRad(20);
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