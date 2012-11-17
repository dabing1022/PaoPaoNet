package
{
	/**
	 * 通信命令
	 * @author dabing
	 */
	public class Command
	{
		/**命令长度*/
		public static const COMMANDLENGTH:int = 4;
		/**心跳*/
		public static const HEARTBEAT:String = "1001";
		/**登录*/
		public static const LOGIN:String = "1002";
		/**连接服务器成功*/
		public static const CONNECT:String="1003";
		/**选择主题*/
		public static const CHOOSE_THEME:String = "1004";
		/**选择关卡*/
		public static const CHOOSE_LEVEL:String = "1005";
		/**进入游戏*/
		public static const ENTER_GAME:String = "1006";
		/**补充弹药*/
		public static const SUPPLY_BULLETS:String = "1007";
		/**发射子弹*/
		public static const FIRE_BULLET:String = "1008";
		/**子弹击中飞行物*/
		public static const EFFECTIVE_HIT_PRIZE:String = "1009";
		/**击落道具飞行物*/
		public static const PRIZE_OVER:String = "1010";
		/**击落子弹飞行物*/
		public static const BULLET_OVER:String = "1011";
		/**结束关卡游戏*/
		public static const LEVEL_OVER:String = "1012";
		/**飞行物飞出舞台*/
		public static const PRIZE_FLY_AWAY:String = "1013";
		/**回收子弹个数增加1*/
		public static const RECYECLE_BULLET_NUM_ADD:String = "1014";
		/**子弹兑换金币*/
		public static const BULLET_EXCHANGE_MONEY:String = "1015";
		/**在游戏中进行选择关卡或者重新开始即中断游戏*/
		public static const INTERRUPT_GAME:String = "1016";
		/**关闭浏览器*/
		public static const CLOSE:String ="1017";

	}
}