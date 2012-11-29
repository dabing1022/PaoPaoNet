package view.Level
{
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	import utils.LevelDiscriptionXmlUtils;
	
	public class LevelDiscription extends Sprite
	{
		private var discriptionTxt:TextField;
		private var discription:String;
		private var _themeId:uint;
		private var _levelId:uint;
		public function LevelDiscription(themeId:uint = 1, levelId:uint = 1):void
		{
			super();
			_themeId = themeId;
			_levelId = levelId;
			
			getDiscriptionFromXml(_themeId, _levelId);
			discriptionTxt = new TextField(600, 200, discription, "Verdana", 30, 0x000000, true);
			discriptionTxt.autoScale = true;
			discriptionTxt.hAlign = HAlign.LEFT;
			addChild(discriptionTxt);
		}
		
		private function getDiscriptionFromXml(themeId:uint, levelId:uint):String{
			var list:XMLList = LevelDiscriptionXmlUtils.getInstance().xml.children();
			var len:uint = list.length();
			var i:uint;
			for(i = 0; i < len; i++){
				if(themeId == uint(list[i].@themeId) && levelId == uint(list[i].@levelId)){
					discription = list[i];
					break;
				}
			}
			return discription;
		}
		
		public function update(themeId:uint, levelId:uint):void{
			discriptionTxt.text = getDiscriptionFromXml(themeId, levelId);
		}
	}
}