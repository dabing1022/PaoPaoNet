package{
	import flash.geom.Rectangle;

    /**
     * 定义常用的常量
     */
     public class Const{
        /**舞台的宽和高*/
        public static const WIDTH:uint = 900;
        public static const HEIGHT:uint = 580;
        /**射击泡泡的枪管长度*/
        public static const GUN_LEN:uint = 100;
        /**包裹坐标位置*/
        public static const BAG_POS_X:uint = 614;
        public static const BAG_POS_Y:uint = 510;
        /**炮台的坐标*/
        public static const BATTERY_X:uint = 410;
        public static const BATTERY_Y:uint = 555;
        /**提示下一个泡泡为何物的提示泡泡的坐标*/
        public static const BUBBLE_FOR_TIP_X:uint = 434;
        public static const BUBBLE_FOR_TIP_Y:uint = 560;
        public static const BUBBLE_TYPES_NUM:uint = 6;

        /**泡泡技能条的坐标*/
        public static const SKILL_BAR_X:uint = 0;
        public static const SKILL_BAR_Y:uint = 517;
        /**泡泡技能条的3个特殊泡泡的全局舞台坐标,用来TweenMax的运动路径终点*/
        public static const SKILL_BAR_BUBBLE1_X:uint = 42;
        public static const SKILL_BAR_BUBBLE1_Y:uint = 529;
        public static const SKILL_BAR_BUBBLE2_X:uint = 120;
        public static const SKILL_BAR_BUBBLE2_Y:uint = 529;
        public static const SKILL_BAR_BUBBLE3_X:uint = 202;
        public static const SKILL_BAR_BUBBLE3_Y:uint = 529;
		
		/**回收盒子坐标*/
		public static const RECYCLE_BAR1_X:uint = 10;
		public static const RECYCLE_BAR1_Y:uint = 200;
		public static const RECYCLE_BAR2_X:uint = 880;
		public static const RECYCLE_BAR2_Y:uint = 200;

     }
}
