package view.Recycle
{
	import events.RecycleEvent;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	
	import model.RecycleData;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class RecycleBarView extends Sprite
	{
		private var frameLine:Shape;
		private var frameBmpd:BitmapData;
		private var squareQuad:Quad;
		public var frameBarImg:Image;
		
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
			
			squareQuad = new Quad(10,300,0xff0000);
			squareQuad.x = squareQuad.pivotX = 5;
			squareQuad.y = squareQuad.pivotY = 300;
			squareQuad.scaleY = (recycleData.curBulletNum % recycleData.maxBulletNum) / recycleData.maxBulletNum;
			addChild(squareQuad);
			
			frameLine = new Shape();
			frameLine.graphics.lineStyle(5, 0x990000);
			frameLine.graphics.drawRect(0, 0, 10, 300);
			
			frameBmpd = new BitmapData(10, 300, true, 0x000000);
			frameBmpd.draw(frameLine);
			var texture:Texture = Texture.fromBitmapData(frameBmpd);
			frameBarImg = new Image(texture);
			addChild(frameBarImg);
		}
		
		private function onBulletNumChange(event:RecycleEvent):void
		{
			var numShow:uint = uint(event.data) % (recycleData.maxBulletNum);
			numTxt.text = numShow.toString();
			squareQuad.scaleY = (recycleData.curBulletNum % recycleData.maxBulletNum) / recycleData.maxBulletNum;
		}
	}
}