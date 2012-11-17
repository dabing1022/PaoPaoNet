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
	
	import utils.LevelConfigXmlUtils;
	
	public class BulletBoxView extends Sprite
	{
        /**技能框背景*/
		private var bulletBoxBg:Quad;
        /**技能框的长宽*/
		private static const LEN:uint = 56;
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
		public function BulletBoxView()
		{
			super();
			bulletData = new BulletData();
			drawBulletBoxBg();
			drawNumTxt();
			drawSkillSelectedAni();
		}
		
		private function drawNumTxt():void
		{
			_numTxt = new TextField(LEN, 15, "", "Courier New", 10, 0xffffff, true);
			_numTxt.autoScale = true;
			_numTxt.hAlign = HAlign.RIGHT;
			_numTxt.x = 0;
			_numTxt.y = 40;
			addChild(_numTxt);
		}
		
		private function drawSkillSelectedAni():void
		{
			skillSelectedAni = new MovieClip(Assets.getSkillSelectedAtlas().getTextures("skillAni"), 24);
			addChild(skillSelectedAni);
			skillSelectedAni.x = -2;
			skillSelectedAni.y = -2;
			Starling.juggler.add(skillSelectedAni);
			skillSelectedAni.stop();
			skillSelectedAni.visible = false;
		}
		
		private function drawBulletBoxBg():void
		{
			bulletBoxBg = new Quad(LEN, LEN, 0x0066ff);
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
				if(_specialBulletImg && contains(_specialBulletImg))
					removeChild(_specialBulletImg);
			}else{
				isEmpty = false;
				if(!contains(_specialBulletImg))
					addChild(_specialBulletImg);
			}
		}
		
		public function set specialBulletImg(value:Texture):void
		{
			if(_specialBulletImg == null){
				_specialBulletImg = new Image(value);
			}else{
				_specialBulletImg.texture = value;
			}
			_specialBulletImg.scaleX = _specialBulletImg.scaleY = 0.5;
			_specialBulletImg.x = 4;
			_specialBulletImg.y = 4;
			_isEmpty = false;
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
