package model
{
	public class LoginData 
	{
		public var username:String;
		public var password:String;
		public var sign:String;
		public var ip:String;
		private static var _instance:LoginData;
		public function LoginData()
		{
			super();
		}
		
		/**保存登录时的数据,sign,username,password,ip*/
		public static function getInstance():LoginData{
			if(_instance == null)
				_instance = new LoginData();
			return _instance;
		}
	}
}