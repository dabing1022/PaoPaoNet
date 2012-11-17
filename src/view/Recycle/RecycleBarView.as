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
	
	public class RecycleBarView extends Sprite
	{
		public var frameBarImg:Image;
		private var contentImg:Image;
		
		public var numTxt:TextField;
		private var recycleData:RecycleData;
		public function RecycleBarView()
		{
			super();
			
			recycleData = RecycleData.getInstance();
			recycleData.addEventListener(RecycleEvent.RECYCLE_NUM_CHANGE, onBulletNumChange);
			
			var num:String = recycleData.curBulletNum.toString();
			numTxt = new TextField(50, 50, num, "Verdana", 14, 0x000000, true);
			addChild(numTxt);
			
			contentImg = new Image(Assets.getAtlas().getTexture("recycleWallContent"));
			contentImg.x = contentImg.pivotX = 7.5;
			contentImg.y = contentImg.pivotY = 356;
			contentImg.scaleY = (recycleData.curBulletNum % recycleData.maxBulletNum) / recycleData.maxBulletNum;
			trace("contentImg.scaleY -----------------" + contentImg.scaleY);
			addChild(contentImg);
			
			frameBarImg = new Image(Assets.getAtlas().getTexture("recycleWallFrame"));
			addChild(frameBarImg);
		}
		
		private function onBulletNumChange(event:RecycleEvent):void
		{
			var numShow:uint = uint(event.data) % (recycleData.maxBulletNum);
			numTxt.text = numShow.toString();
			contentImg.scaleY = (recycleData.curBulletNum % recycleData.maxBulletNum) / recycleData.maxBulletNum;
			trace("contentImg.scaleY -----------------" + contentImg.scaleY);
		}
	}
}