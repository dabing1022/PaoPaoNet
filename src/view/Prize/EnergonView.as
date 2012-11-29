package view.Prize
{
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class EnergonView extends Sprite
	{
        /**颜色ID*/
		private var _colorId:uint;
		private var _color:uint;
		private var img:Image;
		public function EnergonView(colorId:uint)
		{
			super();
			var texture:Texture;
			_colorId = colorId;
			switch(_colorId)
			{
				case 1:
					texture = Assets.getPublicAtlas().getTexture("color1");
					break;
				case 2:
					texture = Assets.getPublicAtlas().getTexture("color2");
					break;
				case 3:
					texture = Assets.getPublicAtlas().getTexture("color3");
					break;
				case 4:
					texture = Assets.getPublicAtlas().getTexture("color4");
					break;
				case 5:
					texture = Assets.getPublicAtlas().getTexture("color5");
					break;
				case 6:
					texture = Assets.getPublicAtlas().getTexture("color6");
					break;
				case 7:
					texture = Assets.getPublicAtlas().getTexture("color7");
					break;
				case 8:
					texture = Assets.getPublicAtlas().getTexture("color8");
					break;
				case 9:
					texture = Assets.getPublicAtlas().getTexture("color9");
					break;
				case 10:
					texture = Assets.getPublicAtlas().getTexture("color10");
					break;
			}
			img = new Image(texture);
			addChild(img);
			this.touchable = false;
		}
		
		/**能量块淡出*/
		public function fadeOut():void{
			var tween:Tween = new Tween(this, 1, Transitions.LINEAR);
			tween.fadeTo(0);
			Starling.juggler.add(tween);
			tween.onComplete = onFinishTween;
		}
		
		private function onFinishTween():void{
			this.removeFromParent(true);
		}

/*-------------------------getter and setter----------------------------------*/
		public function get colorId():uint
		{
			return _colorId;
		}

		public function set colorId(value:uint):void
		{
			_colorId = value;
		}

	}
}
