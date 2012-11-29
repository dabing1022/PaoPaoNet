package view.SkillBar
{
	import model.BulletData;
	import model.Data;
	import model.UserData;
	
	import starling.core.starling_internal;
	import starling.display.Stage;
	import starling.events.EventDispatcher;
	import starling.events.KeyboardEvent;
	
	import utils.LayerUtils;
	import utils.LevelDiscriptionXmlUtils;
	
	import view.Battery.BatteryManager;
	import view.Bullet.BulletForTipView;
	import view.FireBulletVO;
	import view.Prize.PrizeView;
	
	public class SkillBarManager extends EventDispatcher
	{
		private static var _instance:SkillBarManager;
		private var _skillBar:SkillBarView;
		public function SkillBarManager()
		{
			super();
		}
		
		public static function getInstance():SkillBarManager{
			return _instance ||= new SkillBarManager();
		}
		
		public function start(stage:Stage):void{
			FireBulletVO.fireState = FireBulletVO.SYSTEM_STATE;
			_skillBar = new SkillBarView();
			LayerUtils.getInstance().frameLayer.addChild(_skillBar);
			_skillBar.x = Const.SKILL_BAR_X;
			_skillBar.y = Const.SKILL_BAR_Y;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
		}
		
		public function end(stage:Stage):void{
			LayerUtils.getInstance().frameLayer.removeChild(_skillBar);
			clearBulletsInBar();
			_skillBar.dispose();
			_skillBar = null;
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
		}
		
		private function onKeyDownHandler(e:KeyboardEvent):void
		{
			switch(e.keyCode){
				case 49:   //键盘1号键
					if(_skillBar.bulletBoxView1.isEmpty)
						return;
					if(_skillBar.bulletBoxView2.isSelected)	{
						disShowSelectedAni(1);
						_skillBar.bulletBoxView2.isSelected = false;
					}
					if(_skillBar.bulletBoxView3.isSelected) {
						disShowSelectedAni(2);
						_skillBar.bulletBoxView3.isSelected = false;
					}
					_skillBar.bulletBoxView1.isSelected = !_skillBar.bulletBoxView1.isSelected;
					FireBulletVO.fireState = _skillBar.bulletBoxView1.isSelected ? FireBulletVO.SKILLBAR_STATE : FireBulletVO.SYSTEM_STATE;
					if(FireBulletVO.fireState == FireBulletVO.SYSTEM_STATE){
						BatteryManager.getInstance().nextBulletData = Data.getInstance().bulletVec[0];
					}else{
						BatteryManager.getInstance().nextBulletData = _skillBar.bulletBoxView1.bulletData;
					}
					break;
				case 50:   //键盘2号键
					if(_skillBar.bulletBoxView2.isEmpty)
						return;
					if(_skillBar.bulletBoxView1.isSelected)	{
						disShowSelectedAni(0);
						_skillBar.bulletBoxView1.isSelected = false;
					}
					if(_skillBar.bulletBoxView3.isSelected) {
						disShowSelectedAni(2);
						_skillBar.bulletBoxView3.isSelected = false;
					}
					_skillBar.bulletBoxView2.isSelected = !_skillBar.bulletBoxView2.isSelected;
					FireBulletVO.fireState = _skillBar.bulletBoxView2.isSelected ? FireBulletVO.SKILLBAR_STATE : FireBulletVO.SYSTEM_STATE;
					if(FireBulletVO.fireState == FireBulletVO.SYSTEM_STATE){
						BatteryManager.getInstance().nextBulletData = Data.getInstance().bulletVec[0];
					}else{
						BatteryManager.getInstance().nextBulletData = _skillBar.bulletBoxView2.bulletData;
					}
					break;
				case 51:   //键盘3号键
					if(_skillBar.bulletBoxView3.isEmpty)
						return;
					if(_skillBar.bulletBoxView1.isSelected)	{
						disShowSelectedAni(0);
						_skillBar.bulletBoxView1.isSelected = false;
					}
					if(_skillBar.bulletBoxView2.isSelected){
						disShowSelectedAni(1);
						_skillBar.bulletBoxView2.isSelected = false;
					}
					_skillBar.bulletBoxView3.isSelected = !_skillBar.bulletBoxView3.isSelected;
					FireBulletVO.fireState = _skillBar.bulletBoxView3.isSelected ? FireBulletVO.SKILLBAR_STATE : FireBulletVO.SYSTEM_STATE;
					if(FireBulletVO.fireState == FireBulletVO.SYSTEM_STATE){
						BatteryManager.getInstance().nextBulletData = Data.getInstance().bulletVec[0];
					}else{
						BatteryManager.getInstance().nextBulletData = _skillBar.bulletBoxView3.bulletData;
					}
					break;
			}
			BatteryManager.getInstance().showNextBulletTip();
		}
		
		private function disShowSelectedAni(bulletBoxId:uint):void{
				_skillBar.boxVec[bulletBoxId].isSelected = false;
		}
		
		//当飞行的特殊子弹被打下来后，道具栏里对应的数量加1
		public function addBullet(bulletData:BulletData):void{
			if(_skillBar){ //如果打下来刚好切换关卡，_skillBar被置为null，不用添加子弹
				for(var i:uint = 0;i < 3; i++){
					if(_skillBar.boxVec[i].bulletData.bulletId == bulletData.bulletId){
						_skillBar.boxVec[i].num ++;
						break;
					}
					if(_skillBar.boxVec[i].isEmpty){
						_skillBar.boxVec[i].specialBulletImg = Assets.getThemeAtlas(UserData.getInstance().themeId).getTexture(bulletData.bulletName + "1");
						_skillBar.boxVec[i].bulletData = bulletData;
						_skillBar.boxVec[i].num ++;
						break;
					}else{
						continue;
					}
				}
			}
		}
		
		//当打出去某种特殊子弹的时候，数量减1
		public function subBullet(bulletData:BulletData):void{
			for(var i:uint = 0;i < 3;i++){
				if(_skillBar.boxVec[i].bulletData == null)	continue;
				if(_skillBar.boxVec[i].bulletData.bulletId == bulletData.bulletId){
					_skillBar.boxVec[i].num--;
					disShowSelectedAni(i);
					FireBulletVO.fireState = FireBulletVO.SYSTEM_STATE;
					break;
				}
			}
		}
		
		private function clearBulletsInBar():void{
			for(var i:uint = 0;i < 3;i++){
				if(!_skillBar.boxVec[i].isEmpty){
					_skillBar.boxVec[i].num = 0;
				}
			}
		}
		
/*--------------------------------getter and setter----------------------------*/
		public function get skillBar():SkillBarView
		{
			return _skillBar;
		}
	}
}
