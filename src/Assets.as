package
{
	import flash.display.Bitmap;
	import flash.errors.IllegalOperationError;
	import flash.media.Sound;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
		private static var gameTextures:Dictionary = new Dictionary();
		private static var skillSelectedAtlas:TextureAtlas;
		private static var tempCls:Class;
		private static var publicGameTextureAtlas:TextureAtlas;
		private static var themeGameTextureAtlas:TextureAtlas;
		public static function getPublicAtlas():TextureAtlas{
			if(publicGameTextureAtlas == null){
				var gameTexture:Texture = getTexture("PublicResource_AtlasTextureImg");
				tempCls = getClass("PublicResource_AtlasTextureXml");
				var xml:XML = XML(new tempCls());
				publicGameTextureAtlas = new TextureAtlas(gameTexture,xml);
			}
			return publicGameTextureAtlas;
		}
		
		public static function getThemeAtlas(themeId:uint):TextureAtlas{
			if(themeGameTextureAtlas == null){
				var gameTexture:Texture = getTexture("Theme" + themeId + "Resource" + "_AtlasTextureImg");
				tempCls = getClass("Theme" + themeId + "Resource" + "_AtlasTextureXml");
				var xml:XML = XML(new tempCls());
				themeGameTextureAtlas = new TextureAtlas(gameTexture,xml);
			}
			return themeGameTextureAtlas;
		}
		
		public static function getSkillSelectedAtlas():TextureAtlas{
			if(skillSelectedAtlas == null){
				var texture:Texture = getTexture("Resource1_SkillSelectedAni");
				tempCls = getClass("Resource1_SkillSelectedAniXml");
				var xml:XML = XML(new tempCls());
				skillSelectedAtlas = new TextureAtlas(texture,xml);
			}
			return skillSelectedAtlas;
		}
		
		public static function getTexture(name:String):Texture
		{
			if (gameTextures[name] == undefined)
			{
				tempCls = getClass(name);
				var bitmap:Bitmap = new tempCls() as Bitmap;
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
		
		
		private	static var soundDic:Dictionary = new Dictionary();
		public static function getSound(name:String):Sound{
			if(soundDic[name] == undefined){
				tempCls = getClass(name);
				var tempSound:Sound = new tempCls() as Sound;
				soundDic[name] = tempSound;
			}
			return soundDic[name];
		}
		
		public static function getClass(name:String):Class{
			try{
				return ApplicationDomain.currentDomain.getDefinition(name) as Class;
			}catch(e:IllegalOperationError){
				throw e;
			}
			return null;
		}
	}
}