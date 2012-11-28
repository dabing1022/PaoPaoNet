package view.Prize
{
	import flash.display.Bitmap;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import model.PrizeData;
	import model.UserData;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.utils.deg2rad;
	
	import utils.LevelConfigXmlUtils;
	import utils.ShakeObjUtils;
	import utils.SoundManager;
	import utils.Vector2D;
	
	import view.InfoBoard.FloatScoreManager;
	import view.InfoBoard.InfoBoardViewManager;
	import view.SkillBar.BulletBoxView;
	import view.SkillBar.SkillBarManager;
	
	public class PrizeView extends Sprite
	{
		private var _prizeImg:Image;
		public var prizeData:PrizeData;
		private var _energonContainer:Sprite;         //存放能量块的容器
		private var _energonVec:Vector.<EnergonView>;
		private var _energonColorIdVec:Vector.<uint>;
		/**用来碰撞检测的矩形方块*/
		public var hitRect:Quad;
		private var _position:Vector2D;  //位置
		private var _velocity:Vector2D;  //速度大小、方向
		/**
		 * _type: 飞行物所属类别
		 * "prize": 飞行物为奖品
		 * "bullet": 飞行物为子弹  关卡配置文件中，若飞行物为子弹，名字后面需要附带1
		 * */
		private var _type:String;
		public var mass:uint = 1;
		public var maxSpeed:Number;
		public var maxForce:Number = 0.05;
		private var _steeringForce:Vector2D;
		private var _arrivalThreshold:Number = 5;
		public var pathIndex:uint;
		private var _pathThreshold:uint = 60;
		private var _pathArr:Array;
		public static const FACTOR:Number = 0.5;
		public function PrizeView(prizeData:PrizeData):void
		{
			super();
			this.prizeData = prizeData;
			_energonVec = new Vector.<EnergonView>();
			_energonColorIdVec = new Vector.<uint>;
			_position = new Vector2D();
			_velocity = new Vector2D();
			_steeringForce = new Vector2D();
			_pathArr = new Array();
			maxSpeed = prizeData.speed * FACTOR;
            /**根据名字后缀检测飞行物的类型
             * 后缀带1为特殊子弹
             * 没带1为普通飞行物
             */
			if(prizeData.prizeName.charAt(prizeData.prizeName.length - 1) == "1"){
				_type = "bullet";
			}else{
				_type = "prize";
			}
			//add prizeImg
			_prizeImg = new Image(Assets.getThemeAtlas(UserData.getInstance().themeId).getTexture(prizeData.prizeName));
			addChild(_prizeImg);
			
			drawEnergonContainer();
			drawHitRect();
			this.touchable = false;
		}
		
		private function drawEnergonContainer():void
		{
			_energonContainer = new Sprite();
			_energonContainer.x = 20;
			_energonContainer.y = 80;
			addChild(_energonContainer);
			
			/**
			 * 11,22-----> split(",")------>arr = [11,22]
			 * */
			var arr:Array = this.prizeData.energon.split(",");
			var energonRowsNum:uint = arr.length;
			for(var i:uint = 0 ; i < energonRowsNum; i++){
				var id:uint = uint(arr[i].substr(0, 1));
				var energonNum:uint = arr[i].length;
				addEnergons(i, id, energonNum);
				for(var j:uint = 0; j < energonNum; j++){
					_energonColorIdVec.push(id);
				}
			}
		}
		
		//当泡泡打中道具的时候，对能量块进行处理
		public function processEnergon(colorId:uint):Boolean{
			if(hasThisColor(colorId) && _energonVec){
				moveOut(colorId);
				return true;
			}else{
				return false;   //当所有能量块都被打完，则不必处理
			}
		}
		
		//当满足打中条件的时候，移除能量块
		/**是否还有能量块*/
		private function moveOut(colorId:uint):void{
			var id:String = colorId.toString();
			var index:int = _energonColorIdVec.lastIndexOf(id);
			if(index == -1)         //没有找到
				return;
			_energonColorIdVec.splice(index,1);
			var e:EnergonView = _energonVec[index];
			_energonVec.splice(index,1);
			e.fadeOut();
			e = null;
			//shake
			if(_energonColorIdVec.length > 0 &&_energonColorIdVec.lastIndexOf(id) == -1){
				SoundManager.getInstance().playSound("hurt", false);
				shake();
			}else{
				SoundManager.getInstance().playSound("dispear", false);
			}
		}

        /**淡出销毁处理*/
        public function fadeOutAndDestroy():void{
			var scoreAdd:uint = this.prizeData.price * 10;       //分数按照价格的10倍处理
			InfoBoardViewManager.getInstance().score += scoreAdd;
			FloatScoreManager.getInstance().showFloatScore(this.x, this.y, scoreAdd);
				
			var tween:Tween = new Tween(this, 1.0, Transitions.EASE_OUT);
			tween.fadeTo(0);   
			Starling.juggler.add(tween);
			tween.onComplete = destroy;
        }

        private function destroy():void{
            this.removeFromParent(true);
        }

        public function shake():void{
			ShakeObjUtils.getInstance().shakeObj(this, 1, 100, deg2rad(20));
        }
		/**
		 * 当飞行物为特殊子弹被打下来的时候，保存到技能栏
		 */
		public function getEndCoord(bulletId:uint):Vector2D{
			var endX:int;
			var endY:int;
			var vec:Vector.<BulletBoxView> = SkillBarManager.getInstance().skillBar.boxVec;
			for(var i:uint = 0; i < 3; i++){
				if(vec[i].bulletData.bulletId == bulletId){
					switch(i){
						case 0:
							endX = Const.SKILL_BAR_BUBBLE1_X;
							endY = Const.SKILL_BAR_BUBBLE1_Y;
							break;       
						case 1:
							endX = Const.SKILL_BAR_BUBBLE2_X;
							endY = Const.SKILL_BAR_BUBBLE2_Y;
							break;
						case 2:
							endX = Const.SKILL_BAR_BUBBLE3_X;
							endY = Const.SKILL_BAR_BUBBLE3_Y;
							break;
					}
					break;
				}
				if(vec[i].isEmpty){
					switch(i){
						case 0:
							endX = Const.SKILL_BAR_BUBBLE1_X;
							endY = Const.SKILL_BAR_BUBBLE1_Y;
							break;       
						case 1:
							endX = Const.SKILL_BAR_BUBBLE2_X;
							endY = Const.SKILL_BAR_BUBBLE2_Y;
							break;
						case 2:
							endX = Const.SKILL_BAR_BUBBLE3_X;
							endY = Const.SKILL_BAR_BUBBLE3_Y;
							break;
					}
					break;
				}
			}
			return new Vector2D(endX, endY);
		}
		
		private function hasThisColor(colorId:uint):Boolean{
			if(this.prizeData.energon.indexOf(colorId.toString()) != -1)
				return true;
			return false;
		}

		private function addEnergons(row:uint, id:uint, energonNum:uint):void
		{
			var hSpace:uint = 2;          //水平间隙
			var vSpace:uint = 1;           //竖直间隙
			for(var i:uint = 0; i < energonNum; i++){
				var e:EnergonView = new EnergonView(id);
				e.x = (e.width + hSpace) * i;
				e.y = (e.height + vSpace) * row;
				_energonContainer.addChild(e);
				_energonVec.push(e);
			}
		}
		
		private function drawHitRect():void{
			hitRect = new Quad(50, 50, 0x000000, true);
			hitRect.alpha = 0;
			hitRect.x = _prizeImg.x + (_prizeImg.width - hitRect.width) * 0.5;
			hitRect.y = _prizeImg.y + (_prizeImg.height - hitRect.height) * 0.5;
			addChild(hitRect);
		}
		
		public function update():void{
			_steeringForce.truncate(maxForce);
			_steeringForce = _steeringForce.divide(mass);
			_velocity = _velocity.add(_steeringForce);
			_steeringForce = new Vector2D();
			
			_velocity.truncate(maxSpeed);
			_position = _position.add(_velocity);
			x = _position.x;
			y = _position.y;
		}
		
		public function seek(target:Vector2D):void{
			var desiredVelocity:Vector2D = target.subtract(_position);
			desiredVelocity.normalize();
			desiredVelocity = desiredVelocity.multiply(maxSpeed);
			var force:Vector2D = desiredVelocity.subtract(_velocity);
			_steeringForce = _steeringForce.add(force);
		}

		public function followPath(path:Array, loop:Boolean = true):void{
			var wayPoint:Vector2D = path[pathIndex];
			if(wayPoint == null)	return;
			if(_position.dist(wayPoint) < _pathThreshold){
				if(pathIndex >= path.length - 1){
					if(loop){
						pathIndex = 0;
					}else{
						pathIndex = path.length;
					}
				}else{
					pathIndex ++;
				}
			}
			seek(wayPoint);
		}

/*-----------------------------------getter and setter-----------------------------------*/
		public function get energonVec():Vector.<EnergonView>
		{
			return _energonVec;
		}

		public function set energonVec(value:Vector.<EnergonView>):void
		{
			_energonVec = value;
		}

		public function get position():Vector2D
		{
			return _position;
		}

		public function set position(value:Vector2D):void
		{
			_position = value;
			x = _position.x;
			y = _position.y;
		}

		public function get velocity():Vector2D
		{
			return _velocity;
		}

		public function set velocity(value:Vector2D):void
		{
			_velocity = value;
		}
        
		public function set prizeImg(value:Image):void
		{
			_prizeImg = value;
		}

		public function get arrivalThreshold():Number
		{
			return _arrivalThreshold;
		}

		public function set arrivalThreshold(value:Number):void
		{
			_arrivalThreshold = value;
		}

		public function get pathArr():Array
		{
			return _pathArr;
		}

		public function set pathArr(value:Array):void
		{
			_pathArr = value;
		}

		
	}
}
