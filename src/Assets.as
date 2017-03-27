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
		
		[Embed(source = "../img/bgWelcome.jpg")]
		public static const BgWelcome:Class;
		
		[Embed(source = "../img/welcome_title.png")]
		public static const WelcomeTitle:Class;
		
		[Embed(source = "../img/welcome_hero.png")]
		public static const WelcomeHero:Class;
		
		[Embed(source = "../img/welcome_playButton.png")]
		public static const WelcomePlayBtn:Class;
		
		
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