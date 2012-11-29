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
	
	import utils.ScrollImage;
	public class RecycleBarView extends Sprite
	{
		public var frameBarImg:Image;
		private var contentImg:ScrollImage;
		
		public var numTxt:TextField;
		private var recycleData:RecycleData;
		private var imgHeight:uint;
		public function RecycleBarView()
		{
			super();
			
			recycleData = RecycleData.getInstance();
			recycleData.addEventListener(RecycleEvent.RECYCLE_NUM_CHANGE, onBulletNumChange);
			
			var num:String = recycleData.curBulletNum.toString();
			numTxt = new TextField(50, 50, num, "Verdana", 14, 0x000000, true);
			addChild(numTxt);
			
			frameBarImg = new Image(Assets.getPublicAtlas().getTexture("recycleWallFrame"));
			addChild(frameBarImg);

			var percent:Number = (recycleData.curBulletNum % recycleData.maxBulletNum) / recycleData.maxBulletNum
			contentImg = new ScrollImage(Assets.getPublicAtlas().getTexture("recycleWallContent"));
			imgHeight = contentImg.texture.height;
			contentImg.clipMaskLeft = 0;
			contentImg.clipMaskRight = 15;
			contentImg.clipMaskTop = (1 - percent) * imgHeight; 
			contentImg.clipMaskBottom = imgHeight;
			contentImg.x = 5;
			contentImg.y = 5;
			addChild(contentImg);
			this.touchable = false;
		}
		
		private function onBulletNumChange(event:RecycleEvent):void
		{
			var numShow:uint = uint(event.data) % (recycleData.maxBulletNum);
			numTxt.text = numShow.toString();
			var percent:Number = (recycleData.curBulletNum % recycleData.maxBulletNum) / recycleData.maxBulletNum;
			if(contentImg.clipMask)
				contentImg.clipMaskTop = (1 - percent) * imgHeight; 
		}
	}
}