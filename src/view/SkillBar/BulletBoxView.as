package view.SkillBar
{
    /**
     * 子弹技能框图形
     */
	import model.BulletData;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	
	import utils.LevelDiscriptionXmlUtils;
	
	public class BulletBoxView extends Sprite
	{
        /**技能框背景*/
		private var bulletBoxBg:Image;
        /**技能框的长宽*/
		private static const LEN:uint = 56;
		private static const H_LEN:uint = 56;
		private static const V_LEN:uint = 65;
        /**当选中该技能时，技能框上的动画*/
		private var skillSelectedAni:MovieClip;
        /**技能->特殊子弹的个数*/
		private var _num:uint = 0;
        /**子弹个数文本*/
		private var _numTxt:TextField;
		private var _isSelected:Boolean = false;
		private var _isEmpty:Boolean = true;
        /**特殊子弹图*/
		private var _specialBulletImg:Image;
		public var bulletData:BulletData;
		private var _keyboardIndex:uint;
		private var _keyboardIndexImg:Image;
		public function BulletBoxView(keyIndex:uint)
		{
			super();
			bulletData = new BulletData();
			_keyboardIndex = keyIndex;
			drawBulletBoxBg();
			drawSkillSelectedAni();
			drawNumTxt();
			drawKeyIndexInfo();
			this.touchable = false;
		}
		
		private function drawNumTxt():void
		{
			if(_numTxt)	return;
			_numTxt = new TextField(LEN, LEN, "", "Courier New", 40, 0xffffff, true);
			_numTxt.alpha = 0.5;
			_numTxt.autoScale = true;
			_numTxt.hAlign = HAlign.LEFT;
			_numTxt.x = 20;
			_numTxt.y = 20;
			addChild(_numTxt);
		}
		
		private function drawKeyIndexInfo():void{
			switch(_keyboardIndex){
				case 1:
					_keyboardIndexImg = new Image(Assets.getPublicAtlas().getTexture("key1"));
					break;
				case 2:
					_keyboardIndexImg = new Image(Assets.getPublicAtlas().getTexture("key2"));
					break;
				case 3:
					_keyboardIndexImg = new Image(Assets.getPublicAtlas().getTexture("key3"));
					break;
			}
			addChild(_keyboardIndexImg);
			_keyboardIndexImg.x = 50;
			_keyboardIndexImg.y = 50;
		}
		
		private function drawSkillSelectedAni():void
		{
			skillSelectedAni = new MovieClip(Assets.getPublicAtlas().getTextures("skillAnime"), 10);
			addChild(skillSelectedAni);
			skillSelectedAni.x = -2;
			skillSelectedAni.y = -2;
			Starling.juggler.add(skillSelectedAni);
			skillSelectedAni.stop();
			skillSelectedAni.visible = false;
		}
		
		private function drawBulletBoxBg():void
		{
			bulletBoxBg = new Image(Assets.getPublicAtlas().getTexture("skillBoxBg"));
			addChild(bulletBoxBg);
		}		
		
		public function get num():uint
		{
			return _num;
		}

		public function set num(value:uint):void
		{
			_num = value;
			_numTxt.text = _num.toString();
			if(_num == 0){
				isEmpty = true;
				_numTxt.text = "";
				if(_specialBulletImg && contains(_specialBulletImg)){
					_specialBulletImg.removeFromParent(true);
					_specialBulletImg = null;
				}
					
			}else{
				isEmpty = false;
			}
		}
		
		public function set specialBulletImg(value:Texture):void
		{
			if(_specialBulletImg == null){
				_specialBulletImg = new Image(value);
			}else{
				_specialBulletImg.texture = value;
			}
			_specialBulletImg.x = -4;
			_specialBulletImg.y = -10;
			_isEmpty = false;
			if(!contains(_specialBulletImg)){
				addChild(_specialBulletImg);
				this.swapChildren(_numTxt, _specialBulletImg);
			}
		}

        /**该技能框是否为空-是否存放了特殊子弹*/
		public function get isEmpty():Boolean
		{
			return _isEmpty;
		}

		public function set isEmpty(value:Boolean):void
		{
			_isEmpty = value;
		}

		public function get isSelected():Boolean
		{
			return _isSelected;
		}

		public function set isSelected(value:Boolean):void
		{
			_isSelected = value;
			if(_isSelected){
				skillSelectedAni.visible = true;
				skillSelectedAni.play();
			}else{
				if(skillSelectedAni.visible)
					skillSelectedAni.visible = false;
				if(skillSelectedAni.isPlaying)
					skillSelectedAni.stop();
			}
		}
	}
}
