package view.Login
{
	import events.UserEvent;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	/**
	 * 登录界面
	 * 包括登录面板(帐号密码输入登录)
	 * 注册按钮
	 */
	public class LoginScreen extends Sprite
	{
		private var loginBg:Image;
		/**登录面板*/
		private var loginPanel:LoginPanel;
		/**注册按钮*/
		private var registBtn:Button;
		public function LoginScreen():void
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			init();
		}
		
		private function init():void{
			loginBg = new Image(Assets.getTexture("PublicResource_loginBg"));
			addChild(loginBg);
			
			loginPanel = new LoginPanel();
			addChild(loginPanel);
			loginPanel.x = Const.WIDTH - loginPanel.width >> 1;
			loginPanel.y = Const.HEIGHT - loginPanel.height >> 1;
			
			registBtn = new Button(Assets.getPublicAtlas().getTexture("registBtnNomal"), "", Assets.getPublicAtlas().getTexture("registBtnDown"));
			addChild(registBtn);
			registBtn.x = 730;
			registBtn.y = 16;
			registBtn.addEventListener(Event.TRIGGERED, onRegist);
		}
		
		private function onRegist(event:Event):void
		{
			dispatchEvent(new UserEvent(UserEvent.REGIST));
		}
	}
}