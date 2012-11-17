//此文件为泡泡代码的思考部分
nomalBubble
specialBubble

一般泡泡：红、绿、蓝
tipId
public static const RED_BUBBLE:int = 0;
public static const BLUE_BUBBLE:int = 1;
public static const GREEN_BUBBLE:int = 2;

特殊泡泡：橙、青色
public static const ORANGE_BUBBLE:int = 3;
public static const CYAN_BUBBLE:int = 4;

public static const BUBBLE_FOR_TIP_PRO:String = "BubbleForTip_";


var tipId:int = Math.round(Math.random() * 2);


private var bubbleForTip:MovieClip;
bubbleForTip = ResourceManager.getMovieClip(BUBBLE_FOR_TIP_PRO + tipId);
addChild(bubbleForTip);


---------随机产生道具，并具有运动轨迹--------
1.随机运动
2.propId     
3.MotionTrack 运动轨迹
  LineMotion      -----------------------startPoint/startX/startY
                  ----------------------angle(弧度)
  RandomMotion    ------------------------position/angle
  SinMotion           ------------------angle/range(幅度)

--------------碰撞检测----------------------
1.碰撞检测区域
2.舞台上的每个子弹与舞台上的每个道具进行碰撞检测
采用粗略的检测机制，矩形边界与矩形边界的intersect与否，满足要求

----------------道具出现的位置----------------------
prop ---------最大宽度 140       ----------最大高度 130
x 0-70    y 0~Const.HEIGHT     angle   -60~60        Math.PI / 3
x Const.WIDTH+70   y 0~Const.HEIGHT     angle  120~240     Math.PI * 2 / 3 ~ Math.PI * 4 / 3
x 0~Const.WIDTH   y 0-65                angle  30~150      Math.PI / 6  ~ Math.PI * 5 / 6
x 0~Const.WIDTH   y Const.HEIGHT+65     angle  -150~-30    -Math.PI * 5 / 6 ~ -Math.PI / 6
var px:int = 0-70;
var py:int = Math.random()*Const.HEIGHT;
var angle:Number = Math.random()*
var px:int = Const.WIDTH+70;
var py:int = Math.random()*Const.HEIGHT;

var px:int = Math.random()*Const.WIDTH;
var py:int = 0-65;

var px:int = Math.random()*Const.WIDTH;
var py:int = Const.HEIGHT+65;



------------------------------------------------------------------------------------------
BubbleBoxView             泡泡技能栏格子
--------------colorId:int
--------------num:int
-------numText:TextField
-------frameLine:Shape
addBubbleInBox();
removeBubbleInBox();
update();



BubbleBoxManager
----------

---------------------------------------------------------------------------------------------
PaoPaoLocal 单机网络版

1.游戏数据的存储
所有道具的出现以及道具和泡泡的碰撞检测都在服务端进行
2.用户登录，使用平台帐号和密码，进入游戏后用户信息里面包括了
        用户名  username
        头像    avatar
        昵称    nickname
        金豆数  coins
        所在关卡 currentLevel
        解锁关卡 lockedLevel
        所打下来的道具？？------------------退出游戏必须兑换？/  可以存储起来与帐号绑定
3.关卡配置的详细内容
    道具出现的种类
    地图信息
    扩展：一些特殊的泡泡的出现
    
4.音乐背景和声效的加入
5.正则表达式读取能量块的配置
6.Server--------->轨迹类型---------->Client
7.PrizeView(prizeNo:uint)
prizeNo---->trackType
0-1
0-2
0-3
对角线
直线
圆形
椭圆形
8字形
自定义贝塞尔曲线
心形
trackFactory  轨迹工厂
typeId:uint     subTypeId:uint
(typeId, subTypeId)
TrackFatory.make(typeId, subTypeId);    //return an array with Vector2D elments in
function make-------------->
var returnValue:Array;
switch(typeId){
    case 0:
        returnValue = TrackLine.make(subTypeId);
        break;
    case 1:
        returnValue = TrackC2C.make(subTypeId);
        break;
    case 2:
        returnValue = TrackCircle.make(subTypeId);
        break;
}

TrackProtocal 
TrackLine/TrackC2C/TrackCircle extends TrackProcal
private var _pathArr:Array;
private function make(subTypeId:uint):Array{
    switch(subTypeId){
        case 0:
            _pathArr.push(new Vector2D(100, 100);
            _pathArr.push(new Vector2D(600, 100);
            _pathArr.push(new Vector2D(600, 500);
            _pathArr.push(new Vector2D(100, 500);
            return _pathArr;
            break;
        case 1:
            _pathArr.push(new Vector2D(200, 200);
            _pathArr.push(new Vector2D(700, 300);
            _pathArr.push(new Vector2D(200, 500);
            _pathArr.push(new Vector2D(100, 400);
            return _pathArr;
            break;
        case 2:
            _pathArr.push(new Vector2D(300, 600);
            _pathArr.push(new Vector2D(800, 700);
            _pathArr.push(new Vector2D(10, 530);
            _pathArr.push(new Vector2D(100, 200);
            return _pathArr;
            break;
        default:
            _pathArr.push(new Vector2D(200, 600);
            _pathArr.push(new Vector2D(200, 700);
            _pathArr.push(new Vector2D(102, 530);
            _pathArr.push(new Vector2D(120, 200);
            return _pathArr;
    }
}

public function get pathArr():Array{
    return _pathArr;
}

public function set pathArr(value:Array):void{
    _pathArr = value;
}

---------------------------------------------------------------------------
server-----------t1时刻发送                     |t1
client-----------t2时刻接收到                   |
发射泡泡在客户端的t3时刻                        |
服务端接受到发射命令的时刻在t4时刻              |t4 - timeSynDelta

当发生碰撞的时候 客户端时刻t5 此时服务端时间是 t5 + timeSynDelta     在此时刻，子弹的位置以及飞行物的位置

----------------------------------------Loader/swf/---------------------------------
a/test.html
a/b/c.swf
a/b/d.jpg
------------>如何启动swf决定着相对位置
loader.contentLoaderInfo.addEventListener(Event.INIT, onInit);
function onInit(event:Event):void{
    loader.content.x = 100;
    loader.getChildAt(0).y = 200;
    addChild(loader.content);
}







------------------------------------------------------------------------
背景图
背景音乐



















