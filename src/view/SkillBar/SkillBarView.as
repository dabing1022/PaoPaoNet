package view.SkillBar
{
	import flash.geom.Point;
	
	import starling.display.Sprite;
	
	public class SkillBarView extends Sprite
	{
		private var _bulletBoxView1:BulletBoxView;
		private var _bulletBoxView2:BulletBoxView;
		private var _bulletBoxView3:BulletBoxView;
		public static const BULLET_COORD1:Point = new Point(42,12);
		public static const BULLET_COORD2:Point = new Point(120,12);
		public static const BULLET_COORD3:Point = new Point(202,12);
		private var _boxVec:Vector.<BulletBoxView>;
		public function SkillBarView():void
		{
			super();
			init();
		}
		
		private function init():void{
			_boxVec = new Vector.<BulletBoxView>();
			
			_bulletBoxView1 = new BulletBoxView();
			_bulletBoxView1.x = BULLET_COORD1.x;
			_bulletBoxView1.y = BULLET_COORD1.y;
			
			_bulletBoxView2 = new BulletBoxView();
			_bulletBoxView2.x = BULLET_COORD2.x;
			_bulletBoxView2.y = BULLET_COORD2.y;
			
			_bulletBoxView3 = new BulletBoxView();
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
