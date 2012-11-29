package model
{
	import utils.Vector2D;

	public class PrizeData
	{
		/**飞行物的唯一主键号*/
		public var primaryKey:uint;
		/**飞行物的在当前关卡中的编号*/
		public var prizeId:uint;
		/**飞行物名称*/
		public var prizeName:String;
		/**飞行物速度*/
		public var speed:Number;
		/**飞行物价格*/
		public var price:uint;
		/**飞行物分数*/
		public var score:uint;
		/**飞行物点数*/
		public var point:uint;
		/**飞行物轨迹类型*/
		public var pathType:uint;
		/**飞行物是否被打了下来
		 * 0：没打下来
		 * 1：打了下来*/
		public var status:uint;
		/**飞行物能量需求*/
		public var energon:String;
		/**是否是关卡的最后一个*/
		public var isLastOne:Boolean = false;
		/**轨迹点*/
		public var pathArr:Array;
		public function PrizeData()
		{
			pathArr = new Array();
		}
		
		public function init(obj:Object):void{
			this.primaryKey = obj.id;
			this.prizeId 	     = obj.prizeId;
			this.prizeName  = obj.prizeName;
			this.speed         = obj.speed;
			this.score          = obj.score;
			this.point          = obj.point;
			this.pathType    = obj.pathType;
			this.status         = obj.status;
			this.energon     = obj.energon;
			this.price        = obj.price;
			
			var arr:Array = obj.pathStr;
			var len:uint = arr.length;
			var i:uint;
			for(i = 0; i < len; i++){
				var p:Vector2D = new Vector2D(arr[i][0], arr[i][1]);
				this.pathArr.push(p);
			}
		}
	}
}