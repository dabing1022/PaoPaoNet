package view.Recycle
{
	import events.RecycleEvent;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	
	import model.RecycleData;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	import utils.Scale3Image;
	import utils.Scale3Textures;
	
	public class RecycleBarView extends Sprite
	{
		public var frameBarImg:Image;
		private var contentImg:Scale3Image;
		
		public var numTxt:TextField;
		private var recycleData:RecycleData;
		private var scale3Texture:Scale3Textures;
		public function RecycleBarView()
		{
			super();
			
			recycleData = RecycleData.getInstance();
			recycleData.addEventListener(RecycleEvent.RECYCLE_NUM_CHANGE, onBulletNumChange);
			
			var num:String = recycleData.curBulletNum.toString();
			numTxt = new TextField(50, 50, num, "Verdana", 14, 0x000000, true);
			addChild(numTxt);
			
			frameBarImg = new Image(Assets.getAtlas().getTexture("recycleWallFrame"));
			addChild(frameBarImg);
			
			scale3Texture = new Scale3Textures(Assets.getAtlas().getTexture("recycleWallContent"), 0, 0, Scale3Textures.DIRECTION_VERTICAL);
			contentImg = new Scale3Image(scale3Texture, 0);
			contentImg.pivotX = 7.5;
			contentImg.pivotY = 0;
//			contentImg.pivotY = 356;
			contentImg.x = 12.5;
			contentImg.y = 361;
			contentImg.scaleY = (recycleData.curBulletNum % recycleData.maxBulletNum) / recycleData.maxBulletNum;
//			contentImg.textureScale = (recycleData.curBulletNum % recycleData.maxBulletNum) / recycleData.maxBulletNum;
			contentImg.readjustSize();
			addChild(contentImg);
		}
		
		private function onBulletNumChange(event:RecycleEvent):void
		{
			var numShow:uint = uint(event.data) % (recycleData.maxBulletNum);
			numTxt.text = numShow.toString();
			contentImg.scaleY = (recycleData.curBulletNum % recycleData.maxBulletNum) / recycleData.maxBulletNum;
//			contentImg.textureScale = (recycleData.curBulletNum % recycleData.maxBulletNum) / recycleData.maxBulletNum;
			contentImg.readjustSize();
		}
	}
}