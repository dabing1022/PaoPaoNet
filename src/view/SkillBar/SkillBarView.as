package view.SkillBar
{
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class SkillBarView extends Sprite
	{
		private var _bulletBoxView1:BulletBoxView;
		private var _bulletBoxView2:BulletBoxView;
		private var _bulletBoxView3:BulletBoxView;
		public static const BULLET_COORD1:Point = new Point(14, 10);
		public static const BULLET_COORD2:Point = new Point(84,10);
		public static const BULLET_COORD3:Point = new Point(156,10);
		private var _boxVec:Vector.<BulletBoxView>;
		private var _skillBarBg:Image;
		public function SkillBarView():void
		{
			super();
			init();
		}
		
		private function init():void{
			_boxVec = new Vector.<BulletBoxView>();
			
			_skillBarBg = new Image(Assets.getPublicAtlas().getTexture("skillBg"));
			addChild(_skillBarBg);
			
			_bulletBoxView1 = new BulletBoxView(1);
			_bulletBoxView1.x = BULLET_COORD1.x;
			_bulletBoxView1.y = BULLET_COORD1.y;
			
			_bulletBoxView2 = new BulletBoxView(2);
			_bulletBoxView2.x = BULLET_COORD2.x;
			_bulletBoxView2.y = BULLET_COORD2.y;
			
			_bulletBoxView3 = new BulletBoxView(3);
			_bulletBoxView3.x = BULLET_COORD3.x;
			_bulletBoxView3.y = BULLET_COORD3.y;
			
			addChild(_bulletBoxView1);
			addChild(_bulletBoxView2);
			addChild(_bulletBoxView3);
			
			_boxVec.push(_bulletBoxView1);
			_boxVec.push(_bulletBoxView2);
			_boxVec.push(_bulletBoxView3);
		}

/*------------------------getter and setter------------------------------*/
		public function get bulletBoxView1():BulletBoxView
		{
			return _bulletBoxView1;
		}

		public function get bulletBoxView2():BulletBoxView
		{
			return _bulletBoxView2;
		}

		public function get bulletBoxView3():BulletBoxView
		{
			return _bulletBoxView3;
		}

		public function get boxVec():Vector.<BulletBoxView>
		{
			return _boxVec;
		}

		public function set boxVec(value:Vector.<BulletBoxView>):void
		{
			_boxVec = value;
		}
	}
}
