package
{
	import com.adobe.serialization.json.JSON;
	
	import events.LevelChooseEvent;
	import events.PrizeEvent;
	import events.UserEvent;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.net.Socket;
	import flash.net.URLLoader;
	import flash.system.ApplicationDomain;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import model.BulletData;
	import model.Data;
	import model.LevelConfigData;
	import model.LoginData;
	import model.PrizeData;
	import model.RecycleData;
	import model.ThemeData;
	import model.UserData;
	
	import starling.animation.Juggler;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	import utils.CommunicateUtils;
	import utils.LayerUtils;
	import utils.LevelConfigXmlUtils;
	import utils.SocketUtil;
	import utils.SoundManager;
	import utils.Vector2D;
	
	import view.Battery.BatteryManager;
	import view.Bullet.BulletManager;
	import view.Bullet.BulletView;
	import view.FireBulletVO;
	import view.InfoBoard.FloatScoreManager;
	import view.InfoBoard.InfoBoardViewManager;
	import view.Level.LevelContainer;
	import view.Level.LevelLoadingScreen;
	import view.Level.LevelUnit;
	import view.Level.ThemeContainer;
	import view.Level.ThemeUnit;
	import view.Level.WaitingNextLevelScreen;
	import view.Prize.PrizeManager;
	import view.Prize.PrizeView;
	import view.Recycle.RecycleBarView;
	import view.Recycle.RecycleManager;
	import view.SkillBar.SkillBarManager;
	import view.login.LoginScreen;
	
	public class Main extends Sprite
	{
		private var socket:Socket;
		private var host:String = "192.168.1.213";
		private var port:uint = 6667;
//		private var ipLoader:URLLoader;
//		private var ipURL:String = "http://192.168.1.212:8080/ddz/jsp/getIP.jsp";
		/**反复连接状态*/
		private var reconnectOrNot:Boolean = false; //当没连接上时候，默认没有反复连接
		/**socket是否连接*/
		private var socketConnected:Boolean = false;
		//心跳
		private var heartBeat:int = getTimer();
		private var preload:PreloadScreen;
		/**登录界面*/
		private var loginScreen:LoginScreen;
		private var starlingStage:Touch;
		/**游戏中关卡背景图*/
		private var bgImg:Image;
		/**是否装载子弹完毕*/
		private var reloadComplete:Boolean = true;
		/**是否在发射子弹，在这里等价于是否鼠标已经按下*/
		private var isFiring:Boolean = false;
		/**定时装载子弹，以避免无间断连发*/
		private var reloadTimer:Timer;
		/**子弹装载速度，以时间计量*/
		private var reloadSpeed:uint = 400;
		private var bulletFiredNum:uint;
		private var waitingNextLevelScreen:WaitingNextLevelScreen;//暂时用伪加载画面过度到下一关卡
		private var gameTimer:Timer;
		public function Main()
		{
			super();
			addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:starling.events.Event):void
		{
			removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			init();
		}
		
		private function init():void{
			LayerUtils.getInstance().start(stage);
			
			connectServer();
			CommunicateUtils.getInstance().sendMessage(socket,Command.HEARTBEAT,"",false);
			preload = new PreloadScreen();
			addChild(preload);
			preload.addEventListener(starling.events.Event.COMPLETE,onLoadComplete);
		}
		
		private function connectServer():Socket
		{
			if (socket == null){
				socket = new Socket();
				socket.timeout = 40000;			
				SocketUtil.currentSocket = socket;
				socket.addEventListener(flash.events.Event.CONNECT, onConnect);
				socket.addEventListener(flash.events.ProgressEvent.SOCKET_DATA, onSocketData);
//				socket.addEventListener(flash.events.Event.CLOSE, onClose);
				socket.addEventListener(flash.events.IOErrorEvent.IO_ERROR, onIoError);
//				socket.addEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			}
			if (!socket.connected)
			{ 
				socket.connect(host, port);
			}
			return socket;
		}
		
		/**
		 * 在出现输入/输出错误并导致发送或加载操作失败时调度
		 */
		private function onIoError(event:flash.events.IOErrorEvent):void{
			trace("IO错误: = " + event.text);
			tryReconnect();
		}
		
		private var reconnect:Boolean = false;
		private var reconnectTimer:Timer;
		private var isTryingConnect:Boolean = false;
		private function tryReconnect():void{
			if(isTryingConnect){
				return;
			}
			if(reconnectTimer != null){
				return;
			}
			
			isTryingConnect = true;
			reconnect = false;
			
//			clearGameRes();
			reconnectTimer = new Timer(1000);
			reconnectTimer.addEventListener(TimerEvent.TIMER,tryReconnectTimer);
			reconnectTimer.start();
		}
		
		private function tryReconnectTimer(e:TimerEvent):void{
			if(!reconnect){//未连接上
				try{
					connectServer();
					CommunicateUtils.getInstance().sendMessage(socket,Command.HEARTBEAT,"",false);
				}catch(e:Error){}
			}else{//连接上了
				reconnectTimer.removeEventListener(TimerEvent.TIMER,tryReconnectTimer);
				reconnectTimer.stop();
				reconnectTimer = null;
			}
		}
		
		private function onConnect(event:flash.events.Event):void
		{
			reconnectOrNot = true;
			trace("连接成功！");
		}		
		
		private var len:int = 0;
		private var cmd:String = "";
		private var content:String = "";
		private var run:Boolean = false;
		private function onSocketData(event:flash.events.ProgressEvent):void{
			try{
				if(len == 0 && socket.bytesAvailable){
					len = socket.readInt();
				}
				
				while(len != 0 && len <= socket.bytesAvailable && !run){
					run = true;
					cmd = socket.readUTFBytes(Command.COMMANDLENGTH);
					content = socket.readUTFBytes(len - Command.COMMANDLENGTH);
					trace("cmd = " + cmd + " content = " + content);
					processMessage(cmd,content);
					
					if(socket.bytesAvailable){
						len = socket.readInt();
						run = false;
					}else{
						len = 0;
						run = false;
					}
				}
			}catch(error:Error){
				trace(error.message);
			}
			
		}
		
		private function processMessage(cmd:String, content:String):void{
			switch(cmd){
				case Command.HEARTBEAT:
					onHeartBeat();
					break;
				case Command.LOGIN:
					onUserLogin(content);
					break;
				case Command.CONNECT:
					onInitChooseTheme(content);
					break;
				case Command.CHOOSE_THEME:
					onChooseTheme(content);
					break;
				case Command.CHOOSE_LEVEL:
					onChooseLevel(content);
					break;
				case Command.SUPPLY_BULLETS://每打10发后请求服务器，服务器返回10发子弹
					onSupplyBullets(content);
					break;
				case Command.ENTER_GAME:
					onEnterGame(content);
					break;
				case Command.FIRE_BULLET://更新金币点等操作
					onFreshGameCoin(content);
					break;
				case Command.PRIZE_OVER:
					onPrizeOver(content);
					break;
				case Command.BULLET_OVER:
					onBulletOver(content);
					break;
				case Command.LEVEL_OVER:
					onLevelOver(content);
					break;
				case Command.BULLET_EXCHANGE_MONEY:
					onBulletExchangeMoney(content);
					break;
			}
		}
		
		//当关卡结束后，S-->C
		private function onLevelOver(content:String):void
		{
			var obj:Object = com.adobe.serialization.json.JSON.decode(content);
			UserData.getInstance().themeId = obj.nextThemeId;
			UserData.getInstance().levelId = obj.nextLevelId;
			UserData.getInstance().levelIndex = obj.nextLevelIndex;
			UserData.getInstance().money = obj.money;
			RecycleData.getInstance().curBulletNum = obj.reBulletNum;
			
			clearGameRes();
			var nextLevelObj:Object = new Object();
			nextLevelObj.username = UserData.getInstance().userName;
			nextLevelObj.themeId = UserData.getInstance().themeId;
			nextLevelObj.levelId = UserData.getInstance().levelId;
			CommunicateUtils.getInstance().sendMessage(socket, Command.CHOOSE_LEVEL, nextLevelObj);
			//暂时isPass没用
		}
		
		private function addWaiingNextLevelScreen(nextThemeId:uint, nextLevelIndex:uint):void
		{
			if(waitingNextLevelScreen == null){
				waitingNextLevelScreen = new WaitingNextLevelScreen(nextThemeId, nextLevelIndex);
			}
			if(!waitingNextLevelScreen.parent){
				LayerUtils.getInstance().frameLayer.addChild(waitingNextLevelScreen);
				waitingNextLevelScreen.addEventListener(starling.events.Event.COMPLETE, onWaitingNextLevelAniComplete);
				waitingNextLevelScreen.setLevelName(nextThemeId, nextLevelIndex);
			}
		}
		
		private function clearGameRes():void{
			bgImg.removeFromParent(true);
			bgImg = null;
			
			BulletManager.getInstance().end();
			BatteryManager.getInstance().end();
			RecycleManager.getInstance().end();
			PrizeManager.getInstance().end();
			PrizeManager.getInstance().removeEventListener(PrizeEvent.FLY_AWAY, onPrizeFlyAway);
			SkillBarManager.getInstance().end(stage);
			FloatScoreManager.getInstance().end();
			InfoBoardViewManager.getInstance().end();
			SoundManager.getInstance().stopSound("bgm", true);
			gameTimer.stop();
			isFiring = false;
			firingRad = 0;
			Data.getInstance().bulletVec.splice(0, Data.getInstance().bulletVec.length);
			
			stage.removeEventListener(TouchEvent.TOUCH, onTouch);
			stage.removeEventListener(UserEvent.MUTE, onMute);
			stage.removeEventListener(UserEvent.UNMUTE, onUnmute);
			stage.removeEventListener(UserEvent.CHOOSE_THEME, onInGameChooseTheme);
			stage.removeEventListener(UserEvent.REPLAY, onInGameReplayLevel);
		}
		
		
		private function onBulletExchangeMoney(content:String):void
		{
			var obj:Object = com.adobe.serialization.json.JSON.decode(content);
			UserData.getInstance().money = obj.money;
			InfoBoardViewManager.getInstance().money = UserData.getInstance().money;
		}
		
		//特殊子弹被打下来
		private function onBulletOver(content:String):void
		{
			var obj:Object = com.adobe.serialization.json.JSON.decode(content);
			var bulletData:BulletData = new BulletData();
			bulletData.bulletId = obj.bulletId;
			bulletData.bulletName = obj.bulletName;
			bulletData.speed = obj.speed;
			bulletData.price = obj.price;
			
			if(!PrizeManager.getInstance())	return;//防止出现收到Bullt-over命令和Level—over命令引起的PrizeManager为空
			//被击落的特殊子弹将放到技能栏里面
			var len:uint = PrizeManager.getInstance().prizeVec.length;
			var i:uint;
			for(i = 0; i < len; i++){
				if(PrizeManager.getInstance().prizeVec[i].prizeData.primaryKey == obj.prizeId){
					var prize:PrizeView = PrizeManager.getInstance().prizeVec[i];
					trace("&&&&&&&&&&&&&&&&Main 342-----------------" + prize);
					var des:Vector2D = prize.getEndCoord(bulletData.bulletId);
					var tween:Tween = new Tween(prize, 1.0, Transitions.EASE_OUT);
					tween.animate("x", des.x);
					tween.animate("y", des.y);
					tween.scaleTo(0.5);
					tween.fadeTo(0);   
					Starling.juggler.add(tween);
					tween.onComplete = onFinishTweenBar;
					tween.onCompleteArgs = [prize,bulletData];
					PrizeManager.getInstance().prizeVec.splice(i,1);
					break;
				}
			}
		}
		
		private function onFinishTweenBar(prize:PrizeView, bulletData:BulletData):void{
			trace("----------特殊子弹被打中--------------------");
			if(!SkillBarManager.getInstance())	return;
			SkillBarManager.getInstance().addBullet(bulletData);
		}
		
		
		private function onPrizeOver(content:String):void
		{
			var obj:Object = com.adobe.serialization.json.JSON.decode(content);
			//score更新
			//money更新
			UserData.getInstance().money = obj.userMoney;
			InfoBoardViewManager.getInstance().money = UserData.getInstance().money;
			//淡出移除被击落的一般飞行物
			var len:uint = PrizeManager.getInstance().prizeVec.length;
			var i:uint;
			for(i = 0; i < len; i++){
				if(PrizeManager.getInstance().prizeVec[i].prizeData.primaryKey == obj.prizeId){
					trace("找到被击中的了！！！！");
					PrizeManager.getInstance().prizeVec[i].fadeOutAndDestroy();
					PrizeManager.getInstance().prizeVec.splice(i,1);
					break;
				}
			}
		}
		
		private function onChooseTheme(content:String):void
		{
			var obj:Object = com.adobe.serialization.json.JSON.decode(content);
			
			themeContainer.visible = false;
			if(levelContainer == null){
				levelContainer = new LevelContainer(obj as Array);
				levelContainer.x = 200;
				levelContainer.y = 100;
				LayerUtils.getInstance().gameLayer.addChild(levelContainer);
			}
			if(!levelContainer.hasEventListener(LevelChooseEvent.BACK_TO_THEME))
				levelContainer.addEventListener(LevelChooseEvent.BACK_TO_THEME, onBackToTheme);
			if(!levelContainer.hasEventListener(LevelChooseEvent.LEVEL_CHOOSE))
				levelContainer.addEventListener(LevelChooseEvent.LEVEL_CHOOSE, onLevelChoose);
		}
		
		/**选择关卡*/
		private function onLevelChoose(event:LevelChooseEvent):void
		{
			UserData.getInstance().themeId = event.data.themeId;
			UserData.getInstance().levelIndex = event.data.levelIndex;
			UserData.getInstance().levelId = event.data.levelId;
			
			var obj:Object = new Object();
			obj.username = UserData.getInstance().userName;
			obj.themeId = event.data.themeId;
			obj.levelId = event.data.levelId;
			CommunicateUtils.getInstance().sendMessage(socket, Command.CHOOSE_LEVEL, obj);
		}
		
		private function onChooseLevel(content:String):void{
			var obj:Object = com.adobe.serialization.json.JSON.decode(content);
			var arr:Array = obj as Array;
			Data.getInstance().initBulletVec(arr);
			
			if(themeLevelBg && themeLevelBg.parent){
				themeLevelBg.removeFromParent(true);
				themeLevelBg = null;
			}
			if(themeContainer && themeContainer.parent){
				themeContainer.removeFromParent(true);
				themeContainer = null;
			}
			if(levelContainer && levelContainer.parent){
				levelContainer.removeFromParent(true);
				levelContainer = null;
			}
			
			if(!ApplicationDomain.currentDomain.hasDefinition("Theme" + UserData.getInstance().themeId + "Resource_bg")){
				loadingLevel(UserData.getInstance().themeId, UserData.getInstance().levelIndex);//真实加载
			}else{
				addWaiingNextLevelScreen(UserData.getInstance().themeId, UserData.getInstance().levelIndex)//伪读条用于过渡
			}
		}
		
		private function onFreshGameCoin(content:String):void{
			var obj:Object = com.adobe.serialization.json.JSON.decode(content);
			UserData.getInstance().money = obj.money;
			InfoBoardViewManager.getInstance().money = UserData.getInstance().money;
		}
		
		/**包含了舞台飞行物的信息*/
		private function onEnterGame(content:String):void{
			var obj:Object = com.adobe.serialization.json.JSON.decode(content);
			var arr:Array = obj as Array;
			var len:uint = arr.length;
			var i:uint;
			for(i = 0; i < len; i++){
				var prizeData:PrizeData = new PrizeData();
				prizeData.init(Object(arr[i]));
				PrizeManager.getInstance().addPrize(prizeData);
			}
		}
		
		/**初始化游戏界面*/
		private function initGame():void{
			bulletFiredNum = 0;
			addInGameBg();//加入游戏背景
			BulletManager.getInstance().start();
			RecycleManager.getInstance().start();
			PrizeManager.getInstance().start();
			BatteryManager.getInstance().start(Data.getInstance().bulletVec[0]);
			BatteryManager.getInstance().nextBulletData = Data.getInstance().bulletVec[0];
			BatteryManager.getInstance().addBattery();
			PrizeManager.getInstance().addEventListener(PrizeEvent.FLY_AWAY, onPrizeFlyAway);
			SkillBarManager.getInstance().start(stage);
			FloatScoreManager.getInstance().start();
			InfoBoardViewManager.getInstance().start();
			InfoBoardViewManager.getInstance().money = UserData.getInstance().money;
			InfoBoardViewManager.getInstance().updateLevelInfo(UserData.getInstance().themeId,UserData.getInstance().levelIndex);
			SoundManager.getInstance().playSound("bgm", true, int.MAX_VALUE);
			
			var obj:Object = new Object();
			obj.username = UserData.getInstance().userName;
			obj.themeId = UserData.getInstance().themeId;
			obj.levelId = UserData.getInstance().levelId;
			CommunicateUtils.getInstance().sendMessage(socket, Command.ENTER_GAME, obj);
			
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			stage.addEventListener(UserEvent.MUTE, onMute);
			stage.addEventListener(UserEvent.UNMUTE, onUnmute);
			stage.addEventListener(UserEvent.CHOOSE_THEME, onInGameChooseTheme);
			stage.addEventListener(UserEvent.REPLAY, onInGameReplayLevel);
			if(gameTimer == null){
				gameTimer = new Timer(1000 / 60);
				gameTimer.addEventListener(TimerEvent.TIMER, gameLoop);
			}
			gameTimer.start();
		}
		
		private function onMute():void{
			SoundManager.getInstance().muteSound();
		}
		
		private function onUnmute():void{
			SoundManager.getInstance().muteSound();
		}
		
		private function onInGameChooseTheme(event:UserEvent):void
		{
			clearGameRes();
			
			var obj:Object = new Object();
			obj.username = UserData.getInstance().userName;
			obj.themeId = UserData.getInstance().themeId;
			obj.levelId = UserData.getInstance().levelId;
			CommunicateUtils.getInstance().sendMessage(socket, Command.INTERRUPT_GAME, obj);
			var objConnect:Object = new Object();
			objConnect.username = UserData.getInstance().userName;
			CommunicateUtils.getInstance().sendMessage(socket, Command.CONNECT, objConnect);
		}
		
		private function onInGameReplayLevel(event:UserEvent):void
		{
			clearGameRes();
			
			var obj:Object = new Object();
			obj.username = UserData.getInstance().userName;
			obj.themeId = UserData.getInstance().themeId;
			obj.levelId = UserData.getInstance().levelId;
			CommunicateUtils.getInstance().sendMessage(socket, Command.INTERRUPT_GAME, obj);
			CommunicateUtils.getInstance().sendMessage(socket, Command.CHOOSE_LEVEL, obj);
		}
		
		private function onPrizeFlyAway(event:PrizeEvent):void
		{
			var obj:Object = new Object();
			obj.themeId = UserData.getInstance().themeId;
			obj.prizeId = event.data;
			CommunicateUtils.getInstance().sendMessage(socket, Command.PRIZE_FLY_AWAY, obj);
		}
		
		private function onSupplyBullets(content:String):void{
			var obj:Object = com.adobe.serialization.json.JSON.decode(content);
			var arr:Array = obj as Array;
			var newAddBulletVec:Vector.<BulletData> = Data.getInstance().initNewAddBulletVec(arr);
			Data.getInstance().bulletVec = Data.getInstance().bulletVec.concat(newAddBulletVec);
		}
		
		private var levelLoadingScreen:LevelLoadingScreen;
		private function loadingLevel(themeId:uint, levelIndex:uint):void{
			if(levelLoadingScreen == null){
				levelLoadingScreen = new LevelLoadingScreen(themeId, levelIndex);
				LayerUtils.getInstance().frameLayer.addChild(levelLoadingScreen);
				levelLoadingScreen.addEventListener(starling.events.Event.COMPLETE, onLevelLoadingComplete);
			}
		}
		
		private function onLevelLoadingComplete(event:starling.events.Event):void
		{
			levelLoadingScreen.removeEventListener(starling.events.Event.COMPLETE, onLevelLoadingComplete);
			levelLoadingScreen.removeFromParent(true);
			levelLoadingScreen = null;
			initGame();
		}
		
		private function onWaitingNextLevelAniComplete(event:starling.events.Event):void
		{
			waitingNextLevelScreen.removeEventListener(starling.events.Event.COMPLETE, onWaitingNextLevelAniComplete);
			LayerUtils.getInstance().frameLayer.removeChild(waitingNextLevelScreen);
			
			initGame();
		}
		
		private function addInGameBg():void{
			//同一个主题的关卡使用相同的背景
			var bgName:String = "Theme" + UserData.getInstance().themeId + "Resource" + "_bg";
			bgImg = new Image(Assets.getTexture(bgName));
			LayerUtils.getInstance().baseLayer.addChild(bgImg);
		}
		
		
		private function gameLoop(event:TimerEvent):void{
			checkAndFire();
			checkRecycleCollision();
			checkCollision();
			sendHeartBeat();
		}
		
		private var temp1:int;
		private var temp2:int;
		private function sendHeartBeat():void
		{
			temp1 = getTimer() - temp2;
			if(socket && socket.connected && temp1 > 7000){
				temp2 = getTimer();
				CommunicateUtils.getInstance().sendMessage(socket,Command.HEARTBEAT,"",false);
			}
		}
		
		private function checkRecycleCollision():void
		{
			var recycleBarNum:uint = 2;
			var bulletNum:uint = BulletManager.getInstance().bulletVec.length;
			for(var i:uint = 0; i < recycleBarNum; i++){
				var recycleBar:RecycleBarView = RecycleManager.getInstance().recycleBarVec[i];
				for(var j:int = bulletNum - 1; j >= 0; j--){
					var bullet:BulletView = BulletManager.getInstance().bulletVec[j]; 
					var collide:Boolean = recycleBar.frameBarImg.getBounds(recycleBar.parent).intersects(bullet.getBounds(bullet.parent));
					if(collide){
						trace("垃圾回收中...");
						BulletManager.getInstance().bulletVec.splice(j,1);
						bulletNum --;
						var obj:Object = new Object();
						obj.bulletId = bullet.bulletData.bulletId;
						RecycleData.getInstance().curBulletNum ++;
						CommunicateUtils.getInstance().sendMessage(socket, Command.RECYECLE_BULLET_NUM_ADD, obj);
						bullet.removeFromParent(true);
						bullet = null;
					}
				}
			}
			
		}
		
		//单击舞台过快的时候，炮台动画不能够完整的播放完，待修改 --------to be finished
		private function checkAndFire():void{
			if(Data.getInstance().bulletVec){
				if(reloadComplete && isFiring){
					BatteryManager.getInstance().gunBang();
					creatBullet();
				}
				if(!isFiring){
					BatteryManager.getInstance().stopFire();
				}
			}
		}
		
		private function checkCollision():void
		{
			var prizeNum:uint = PrizeManager.getInstance().prizeVec.length;
			var bulletNum:uint = BulletManager.getInstance().bulletVec.length;
			for(var i:int = prizeNum-1;i >= 0; i--){
				var p:PrizeView = PrizeManager.getInstance().prizeVec[i];
				for(var j:int = bulletNum-1; j>=0; j--){
					var bullet:BulletView = BulletManager.getInstance().bulletVec[j]; 
					var root:Sprite = LayerUtils.getInstance().gameLayer;
					var collide:Boolean = p.hitRect.getBounds(root).intersects(bullet.getBounds(root));
					if(collide){
						BulletManager.getInstance().bulletVec.splice(j,1);
						bulletNum --;
						//能量块的消失
						var hasEnergon:Boolean = p.processEnergon(bullet.bulletData.bulletId);
						if(hasEnergon){
							var obj:Object = new Object();
							obj.prizeId = p.prizeData.primaryKey;
							obj.bulletId = bullet.bulletData.bulletId;
							obj.themeId = UserData.getInstance().themeId;
							CommunicateUtils.getInstance().sendMessage(socket, Command.EFFECTIVE_HIT_PRIZE, obj);
						}
						bullet.destroy();
						bullet = null;
						if(p.energonVec.length == 0)
							prizeNum --;
					}
				}
			}
		}
		
		private function creatBullet():void
		{
			bulletFiredNum ++;
			SoundManager.getInstance().playSound("shoot", false, 1, 0, 0.5);
			var x1:Number = Const.BATTERY_X + Const.GUN_LEN * Math.cos(firingRad);
			var y1:Number = Const.BATTERY_Y + Const.GUN_LEN * Math.sin(firingRad);
			BulletManager.getInstance().addBullets(x1,y1,starlingStage.globalX, starlingStage.globalY, BatteryManager.getInstance().nextBulletData);
			
			var fireObj:Object = new Object();
			fireObj.username = UserData.getInstance().userName;
			fireObj.levelId = UserData.getInstance().levelId;
			if(Data.getInstance().bulletVec.length > 0)
				fireObj.bulletId = Data.getInstance().bulletVec[0].bulletId;
			CommunicateUtils.getInstance().sendMessage(socket, Command.FIRE_BULLET, fireObj);
			
			Data.getInstance().bulletVec.shift();
			trace("当前子弹数目为： " + Data.getInstance().bulletVec.length);
			if(bulletFiredNum % 10 == 0){ //每打10发子弹
				trace("又打10发子弹了，准备向服务器请求新批子弹。。。。");
				var obj:Object = new Object();
				obj.username = UserData.getInstance().userName;
				obj.themeId = UserData.getInstance().themeId;
				obj.levelId = UserData.getInstance().levelId;
				CommunicateUtils.getInstance().sendMessage(socket, Command.SUPPLY_BULLETS, obj);
			}
			
			if(FireBulletVO.fireState == FireBulletVO.SKILLBAR_STATE){
				SkillBarManager.getInstance().subBullet(BatteryManager.getInstance().nextBulletData);
			}
			
			BatteryManager.getInstance().nextBulletData = Data.getInstance().bulletVec[0];
			BatteryManager.getInstance().showNextBulletTip();
			startReloading();
		}
		
		private function startReloading():void
		{
			reloadComplete = false;
			reloadTimer = new Timer(reloadSpeed,1);
			reloadTimer.addEventListener(TimerEvent.TIMER, gunReloaded);
			reloadTimer.start();
		}
		
		protected function gunReloaded(event:TimerEvent):void
		{
			reloadComplete = true;
		}
		
		private var firingRad:Number;
		private function onTouch(event:TouchEvent):void
		{
			starlingStage = event.getTouch(stage);
			if(starlingStage == null)	return;
			if(starlingStage.phase == TouchPhase.HOVER || starlingStage.phase == TouchPhase.MOVED){
				rotateBattery();
			}
			if(starlingStage.phase == TouchPhase.BEGAN){
				isFiring = true;
			}else if(starlingStage.phase == TouchPhase.ENDED){
				isFiring = false;
			}
			if(starlingStage.phase == TouchPhase.MOVED){
				isFiring = true;
			}
		}
		
		private function rotateBattery():void
		{
			var dx:Number = starlingStage.globalX - Const.BATTERY_X;
			var dy:Number = starlingStage.globalY - Const.BATTERY_Y;
			firingRad = Math.atan2(dy,dx);
			if(firingRad > 0 && firingRad <= Math.PI * 0.5) firingRad = 0;
			else if(firingRad > Math.PI * 0.5 && firingRad < 2 * Math.PI) firingRad = -Math.PI;
			BatteryManager.getInstance().gunRotate(firingRad);
		}
		
		/**心跳包*/
		private function onHeartBeat():void{
			heartBeat = getTimer();
			socketConnected = true;
			reconnectOrNot = true;
		}
		
		private function onUserLogin(conent:String):void{
			var obj:Object = com.adobe.serialization.json.JSON.decode(content);
			UserData.getInstance().userName = obj.username;
			UserData.getInstance().money = obj.money;
			UserData.getInstance().canPlayTheme = obj.userTheme;
			
			var objConnect:Object = new Object();
			objConnect.username = UserData.getInstance().userName;
			CommunicateUtils.getInstance().sendMessage(socket, Command.CONNECT, objConnect);
		}
		
		private var themeContainer:ThemeContainer;
		private var levelContainer:LevelContainer;
		private var themeLevelBg:Image;
		private function onInitChooseTheme(content:String):void
		{
			if(loginScreen && loginScreen.parent){
				loginScreen.removeFromParent(true);
				loginScreen = null;
			}
			
			var obj:Object = com.adobe.serialization.json.JSON.decode(content);
			
			if(themeLevelBg == null){
				themeLevelBg = new Image(Assets.getTexture("PublicResource_loginBg"));
				LayerUtils.getInstance().baseLayer.addChild(themeLevelBg);
			}
			
			if(themeContainer == null){
				themeContainer = new ThemeContainer(obj as Array);
				LayerUtils.getInstance().gameLayer.addChild(themeContainer);
				themeContainer.x = 200;
				themeContainer.y = 100;
				themeContainer.addEventListener(LevelChooseEvent.THEME_CHOOSE, onThemeChoose);
			}else{
				themeContainer.visible = true;
			}
		}
		
		/**侦听器：主题选择*/
		private function onThemeChoose(event:LevelChooseEvent):void
		{
			var obj:Object = new Object();
			obj.username = UserData.getInstance().userName;
			obj.themeId = event.data;
			CommunicateUtils.getInstance().sendMessage(socket, Command.CHOOSE_THEME, obj);
		}
		
		private function onBackToTheme(event:LevelChooseEvent):void
		{
			levelContainer.removeFromParent(true);
			levelContainer = null;
			themeContainer.visible = true;
		}
		
		/**加载完毕后移除预加载，添加登录界面*/
		private function onLoadComplete(e:starling.events.Event):void
		{	
			removeChild(preload);
			
			loginScreen = new LoginScreen();
			addChild(loginScreen);
			loginScreen.addEventListener(UserEvent.LOGIN, onLogin);
		}
		
		private function onLogin(e:UserEvent):void
		{
			var loginData:Object = {};
			loginData.username = LoginData.getInstance().username;
			loginData.password = LoginData.getInstance().password;
			CommunicateUtils.getInstance().sendMessage(socket, Command.LOGIN, loginData);
		}
	}
}