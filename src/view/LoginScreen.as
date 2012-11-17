package view
{
	import events.LoginEvent;
	
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import model.LoginData;
	
	import org.osmf.logging.Log;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;

	/**登录界面*/
	public class LoginScreen extends Sprite
	{
		private var _bg:Quad;
		private var _userNameForDisplay:starling.text.TextField;
		private var _userNameForInput:flash.text.TextField;
		private var _passWordForDisplay:starling.text.TextField;
		private var _passWordForInput:flash.text.TextField;
		private var _loginButton:Button;
		private var _loginBtnTexture:Texture;
		public function LoginScreen()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			init();
		}
		
		private function init():void{
			//add bg
			_bg = new Quad(Const.WIDTH, Const.HEIGHT, 0xffffff, true);
			addChild(_bg);
			
			//add userNameForDisplay
			_userNameForDisplay = new starling.text.TextField(100, 20, "账号：");
			addChild(_userNameForDisplay);
			_userNameForDisplay.x = 300;
			_userNameForDisplay.y = 250;
			//add userNameForInput
			_userNameForInput = new flash.text.TextField();
			Starling.current.nativeOverlay.addChild(_userNameForInput);
			with(_userNameForInput){
				x = 380;
				y = 250;
				width = 100;
				height = 20;
				border = true;
				type = TextFieldType.INPUT;
			}
			
			//add passWordForDisplay
			_passWordForDisplay = new starling.text.TextField(100, 20, "密码：");
			addChild(_passWordForDisplay);
			_passWordForDisplay.x = 300;
			_passWordForDisplay.y = 280;
			//add passWordForInput
			_passWordForInput = new flash.text.TextField();
			Starling.current.nativeOverlay.addChild(_passWordForInput);
			with(_passWordForInput){
				x = 380;
				y = 280;
				width = 100;
				height = 20;
				border = true;
				type = TextFieldType.INPUT;
				displayAsPassword = true;
			}
			
			//add login button
			addLoginBtn();
			
			_loginButton.addEventListener(Event.TRIGGERED, onLogin);
		}
		
		private function onLogin(e:Event):void
		{
			LoginData.getInstance().username = _userNameForInput.text;
			LoginData.getInstance().password = _passWordForInput.text;
			dispatchEvent(new LoginEvent(LoginEvent.LOGIN, false, LoginData.getInstance()));
		}
		
		private function addLoginBtn():void{
			_loginBtnTexture = Assets.getAtlas().getTexture("loginBtnBg");
			_loginButton = new Button(_loginBtnTexture, "登录");
			with(_loginButton){
				fontSize = 14;
				fontColor = 0x000000;
				x = 380;
				y = 310;
			}
			addChild(_loginButton);
		}
		
		override public function removeFromParent(dispose:Boolean=false):void{
			Starling.current.nativeOverlay.removeChildren();
			_userNameForInput = null;
			_passWordForInput = null;
			super.removeFromParent();
		}
	}
}