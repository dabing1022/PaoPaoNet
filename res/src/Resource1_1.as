package
{
	import flash.display.Sprite;
	import flash.system.Security;
	
	public class Resource1_1 extends Sprite
	{
		[Embed(source="../graphics/SkillSelectedAni.png")]
		public static const SkillSelectedAni:Class;
		
		[Embed(source="../graphics/SkillSelectedAni.xml",mimeType="application/octet-stream")]
		public static const SkillSelectedAniXml:Class;
		
		[Embed(source="../graphics/AtlasTexture.png")]
		public static const AtlasTextureImg:Class;
		
		[Embed(source="../graphics/bg.jpg")]
		public static const bg:Class;        //注意类名仅仅是资源名字去掉逗号和文件后缀 ，方便后边读取该类名
		
		[Embed(source="../graphics/AtlasTexture.xml",mimeType="application/octet-stream")]
		public static const AtlasTextureXml:Class;
		
		[Embed(source="../fonts/desyrel.png")]
		public static const ScoreFontImg:Class;
		
		[Embed(source="../fonts/desyrel.fnt",mimeType="application/octet-stream")]
		public static const ScoreFontXml:Class;
		
		[Embed(source="../sounds/bgm.mp3")]
		public static const bgm:Class;
		
		[Embed(source="../sounds/shoot.mp3")]
		public static const shoot:Class;
		
		[Embed(source="../sounds/mute.mp3")]
		public static const mute:Class;
		
		[Embed(source="../sounds/hurt.mp3")]
		public static const hurt:Class;
		
		[Embed(source="../sounds/dispear.mp3")]
		public static const dispear:Class;
		
		[Embed(source="../particle/texture.png")]
		public static const Particle:Class;
		
		[Embed(source="../particle/particle.pex",mimeType="application/octet-stream")]
		public static const ParticleXml:Class;
		
	}
}