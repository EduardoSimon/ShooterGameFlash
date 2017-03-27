package 
{
	/**
	 * ...
	 * @author Marc
	 */
	public class Assets 
	{
		
		public function Assets() 
		{
			[Embed(source = "../img/svg/bgWelcome.jpg")]
			public static const BgWelcome:Class;
			
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

}