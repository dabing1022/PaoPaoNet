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
		private static var gameTextureAtlas:TextureAtlas;
		private static var wingTextureAtlas:TextureAtlas;
		private static var skillSelectedAtlas:TextureAtlas;
		private static var tempCls:Class;
		
		public static function getAtlas():TextureAtlas{
			if(gameTextureAtlas == null){
				var gameTexture:Texture = getTexture("Resource1_AtlasTextureImg");
				tempCls = getClass("Resource1_AtlasTextureXml");
				var xml:XML = XML(new tempCls());
				gameTextureAtlas = new TextureAtlas(gameTexture,xml);
			}
			return gameTextureAtlas;
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