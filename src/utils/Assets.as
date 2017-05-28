package utils
{
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	import flash.display.Bitmap;
	import starling.textures.TextureAtlas;

	public class Assets 
	{
		
		[Embed(source = "/../media/img/welcomeScreen/bgWelcome.jpg")]
		public static const BgWelcome:Class;
		
<<<<<<< HEAD
		[Embed(source = "/../media/img/welcomeScreen/welcome_title.png")]
		public static const WelcomeTitle:Class;
		
		[Embed(source = "/../media/img/welcomeScreen/welcome_hero.png")]
		public static const WelcomeHero:Class;
		
		[Embed(source = "/../media/img/welcomeScreen/welcome_playButton.png")]
		public static const WelcomePlayBtn:Class;
		
		[Embed(source="/../media/img/level/ball_red.png")]
		public static const BallBitmapEnemy:Class;
		
		[Embed(source="../../media/img/level/ball_blue.png")]
		public static const BallBitmapBullet:Class;
		
		[Embed(source = "/../media/img/level/cannon.png")]
		public static const CannonBitmap:Class;
		
		[Embed(source = "/../media/img/chooseLevel/level1.png")]
		public static const Level1:Class;
		
		[Embed(source = "/../media/img/chooseLevel/level2.png")]
		public static const Level2:Class;
		
		[Embed(source = "/../media/img/chooseLevel/level3.png")]
		public static const Level3:Class;
				
		[Embed(source = "/../media/img/level/shield_atlas.png")]
		public static const ShieldAtlas:Class;
		
		[Embed(source = "/../media/img/level/mySpritesheet.xml", mimeType = "application/octet-stream")]
		public static const ShieldAtlasXML:Class;
		
		private static var gameTextures:Dictionary = new Dictionary(); 
		private static var gameTextureAtlas:TextureAtlas;
		
		public static function getAtlas():TextureAtlas
		{
			if (gameTextureAtlas == null)

			{

				var texture:Texture = getTexture("ShieldAtlas");

				var xml:XML = XML(new ShieldAtlasXML());

				gameTextureAtlas=new TextureAtlas(texture, xml);

			}

			return gameTextureAtlas;

		}
=======
		[Embed(source="/../media/img/mySpritesheet.png")]
		public static const AtlasTextureGame:Class;
		
		[Embed(source="/../media/img/mySpritesheet.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlGame:Class;
		
		
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		
		/**
		 * Returns the Texture atlas instance.
		 * @return the TextureAtlas instance (there is only oneinstance per app)
		 */
>>>>>>> origin/master
		
		public static function getAtlas():TextureAtlas
		{
			if (gameTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasTextureGame");
				var xml:XML = XML(new AtlasXmlGame());
				gameTextureAtlas=new TextureAtlas(texture, xml);
			}
			
			return gameTextureAtlas;
		}
				
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