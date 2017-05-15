package 
{
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author Marc
	 */
	public class Assets 
	{
		
		[Embed(source = "../img/welcomeScreen/bgWelcome.jpg")]
		public static const BgWelcome:Class;
		
		[Embed(source = "../img/welcomeScreen/welcome_title.png")]
		public static const WelcomeTitle:Class;
		
		[Embed(source = "../img/welcomeScreen/welcome_hero.png")]
		public static const WelcomeHero:Class;
		
		[Embed(source = "../img/welcomeScreen/welcome_playButton.png")]
		public static const WelcomePlayBtn:Class;
		
		[Embed(source="../img/level/ball_red.png")]
		public static const BallBitmap:Class;
		
		[Embed(source = "../img/level/cannon.png")]
		public static const CannonBitmap:Class;
		
		[Embed(source = "../img/chooseLevel/level1.png")]
		public static const Level1:Class;
		
		[Embed(source = "../img/chooseLevel/level2.png")]
		public static const Level2:Class;
		
		[Embed(source = "../img/chooseLevel/level3.png")]
		public static const Level3:Class;
		
		
		
		
		private static var gameTextures:Dictionary = new Dictionary();
		
		public static function getTexture(name:String):Texture
		{
			if (gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name]=Texture.fromBitmap(bitmap);
			}
		
		return gameTextures[name];
		}
	}
	
	

}