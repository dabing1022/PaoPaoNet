package view.Login
{
	import events.UserEvent;
	
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import model.LoginData;
	
	import org.osmf.media.DefaultMediaFactory;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class LoginPanel extends Sprite
	{
		private var bg:Image;
		private var accountFontImg:Image;
		private var passwordFontImg:Image;
		private var inputAccountTextBg:Image;
		private var inputCodeTextBg:Image;
		private var loginBtn:Button;
		
		private var accountInput:flash.text.TextField;
		private var passwordInput:flash.text.TextField;
		private var accountInputTF:TextFormat;
		public function LoginPanel()
		{
			super();
			
			bg = new Image(Assets.getTexture("PublicResource_loginPanelBg"));
			addChild(bg);
			
			accountFontImg = new Image(Assets.getPublicAtlas().getTexture("accountFont"));
			addChild(accountFontImg);
			accountFontImg.x = 46;
			accountFontImg.y = 94;
			
			passwordFontImg = new Image(Assets.getPublicAtlas().getTexture("codeFont"));
			addChild(passwordFontImg);
			passwordFontImg.x = 46;
			passwordFontImg.y = 154;
			
			inputAccountTextBg = new Image(Assets.getPublicAtlas().getTexture("inputTextBg"));
			addChild(inputAccountTextBg);
			inputAccountTextBg.x = 122;
			inputAccountTextBg.y = 90;
			
			inputCodeTextBg = new Image(Assets.getPublicAtlas().getTexture("inputTextBg"));
			addChild(inputCodeTextBg);
			inputCodeTextBg.x = 122;
			inputCodeTextBg.y = 150;
			
			accountInput = new flash.text.TextField();
			Starling.current.nativeOverlay.addChild(accountInput);
			accountInputTF = new TextFormat("_serif", 25, 0xcccc33, true);
			with(accountInput){
				x = (Const.WIDTH - this.width) * 0.5 + 134;
				y = (Const.HEIGHT - this.height) * 0.5 + 100;
				width = 220;
				height = 30;
				type = TextFieldType.INPUT;
			}
			accountInput.defaultTextFormat = accountInputTF;
			
			passwordInput = new flash.text.TextField();
			Starling.current.nativeOverlay.addChild(passwordInput);
			with(passwordInput){
				x = (Const.WIDTH - this.width) * 0.5 + 134;
				y =  (Const.HEIGHT - this.height) * 0.5 + 164;
				width = 220;
				height = 30;
				type = TextFieldType.INPUT;
				displayAsPassword = true;
			}
			passwordInput.defaultTextFormat = accountInputTF;
			
			loginBtn = new Button(Assets.getPublicAtlas().getTexture("loginBtnNomal"), "", Assets.getPublicAtlas().getTexture("loginBtnDown"));
			addChild(loginBtn);
			loginBtn.x = 162;
			loginBtn.y = 222;
			loginBtn.addEventListener(Event.TRIGGERED, onLoginConfirm);
			
			Starling.current.nativeStage.focus = accountInput;
		}
		
		private function onLoginConfirm(event:Event):void
		{
			LoginData.getInstance().username = accountInput.text;
			LoginData.getInstance().password = passwordInput.text;
			dispatchEvent(new UserEvent(UserEvent.LOGIN, true, LoginData.getInstance()));
		}
		
		override public function dispose():void{
			Starling.current.nativeOverlay.removeChildren();
			accountInput = null;
			passwordInput = null;
			super.dispose();
		}
	}
}