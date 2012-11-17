Li
Mihoutao
var li:Li = new Li();
var mihoutao:Mihoutao = new Mihoutao();

timer = new Timer(800, 2);
timer2 = new Timer(4000, 1);
li.addEventListener(TimerEvent.TIMER, twinkle);
li.addEventListener(TimerEvent.TIMER_COMPLETE, onTwinkeFinished);
li.addEventListener(TimerEvent.TIMER, dispear);
private function twinkle(e:TimerEvent):void{
	li.visible = !li.visible;
}

private function onTwinkeFinished(e:TimerEvent):void{
	li.visible = true;
	timer2.start();
}

private function dispear(e:TimerEvent):void{
	li.parent.removeChild(li);
	li.dispose();
}


fixed:
1.���Ͻ�ͼ�� ����ɫ��ʾ
2.������ 1--�ر�---
3.DIY
4.��������
5.���Ĵ��� �ͷ���




���ϣ�
Hi,

I am just playing about with a side scrolling shooter and am working on the motion paths of the enemies. I can get them to travel in a wave motion from Right to Left using COSINE, and I can get them to track towards the player ship based on its position on the screen.

But how would I go about doing a more complex motion path? One of the things I wanted to do was have an enemy appear on the right of the screen, travel straight across for a short distance, then do a complete circle back in roughly in the middle of the screen, and finish by heading toward the player ship.

Any tips would be much appreciated 













ThemeUnit
LevelUnit
ThemeContainer
LevelContainer
LevelBgFactory
ThemeBgFactory
IUnit
LevelManager
ThemeManager

interface IUnit
Theme
---------------------------
Theme 
public var themeId:uint;
public var levelNum:uint;
�ؿ��Ŀ������ֻ�����Ƿ���ס�ͻ�ɫ��͸�����ǲ��Ҳ�����
--------------------------------------------------------------------------------------
LevelBgFactory
private var bg:Image;
private var _themeId:uint;
private var _levelId:uint;
private var _bgName:String;
bgName:String;             2_3---------->����2���ؿ�3
public static function makeLevelBg(themeId:uint, levelId:uint):Image{
    _themeId = themeId;
    _levelId = levelId;
    _bgName = _themeId + "_" + _levelId + ".png";
    bg = new Image();
    .....from _bgName;
    return bg;
}

-----------------------------------------------------------------------------------
ThemeBgFactory
private var themeBg:Image;
public static function makeThemeBg(bgId:uint):Image{
    switch(bgId){
        case 0:
        case 1:
        case 2:
        default:
            bg = new Image(0);
    }
    return themeBg;
    
}
-----------------------------------------------------------------------------------------
ThemeUnit
private var lockImg:Image;
private var _themeName:String;
private var _theme:Theme;
lockImg = new Image();
.....to make a lockImg
addChild(lockImg);
addChild(grayMask);
lockImg.visible = false;
grayMask.visible = false;
public function setPlay(canPlay:Boolean):void{
    if(canPlay){//����
        lockImg.visible = true;
        grayMask.visible = true;
        if(this.hasEventListener(MouseEvent.CLICK)){
            return;
        }
        this.addEventListener(MouseEvent.CLICK, onChooseTheme);
    }else{//����
        if(this.hasEventListener(MouseEvent.CLICK)){
            this.removeEventListener(MosueEvent.CLICK, onChooseTheme);
        }
        lockImg.visible = false;
        grayMask.visible = false;
    }
}

private function onChooseTheme(event:MouseEvent):void{
    dispatchEventWith(LevelEvent.CHOOSE_THEME, true, theme);
}

-----------------------------------------------------------------------------------------
ThemeContainer
private var themeNum:uint;//�������
private var curTheme:uint;//��ǰ���� canPlay������
private var themeVector:Vector.<ThemeUnit> = new Vector.<ThemeUnit>();
var i:uint;
for(i = 0; i < themeNum;i++){
    //��������λ
    var themeUnit:ThemeUnit = new ThemeUnit(i);
    themeUnit.x = 100 + 40 * i;
    themeUnit.y = 100;
    addChild(themeUnit);

}

for(i = 0; i < curTheme; i++){
    themeVector[i].setPlay(true);
}

----------------------------------------------------------------------------------------
LevelManager
private static var _instance:LevelManager;
private var themeContainer:ThemeContainer;
private var levelContainer:LevelContainer;
public static function getInstance():LevelManager{
    if(_instance == null){
        _instance = new LevelManager();
    }
    return _instance;
}
public function start():void{
    themeContainer = new ThemeContainer();
    LayerUtils.getInstance().gameLayer.addChild(themeContainer);
    themeContainer.addEventListener(LevelEvent.CHOOSE_THEME, onChooseTheme);
}
private function onChooseTheme(event:LevelEvent):void{
    themeContainer.visible = false;
    var theme:Theme = event.data;
    levelContainer = new LevelContainer(theme);
    addChild(levelContainer);
}
-----------------------------------------------------------------------------------------
LevelUnit
levelId
private var _levelBg:Image;
private var lockImg:Image;
private var _levelName:String;
private var _levelId:uint;
private var _themeId:uint;
lockImg = new Image();
.....to make a lockImg
addChild(lockImg);
addChild(grayMask);
lockImg.visible = false;
grayMask.visible = false;
public function LevelUnit(themeId, levelId):void{
    _themeId = themeId;
    _levelId = levelId;
    _levelBg = LevelBgFactory.makeLevelBg(_themeId, _levelId);
}
public function setPlay(canPlay:Boolean):void{
    if(canPlay){//����
        this.addEventListener(MouseEvent.CLICK, onChooseLevel);
        lockImg.visible = true;
        grayMask.visible = true;
    }else{//����
        if(this.hasEventListener(MouseEvent.CLICK)){
            this.removeEventListener(MosueEvent.CLICK, onChooseLevel);
        }
        lockImg.visible = false;
        grayMask.visible = false;
    }
}
------------------------------------------------------------------------------------------
LevelContainer
public var levelNum:uint;
public var curLevel:uint;
public var levelVec:Vector.<LevelUnit> = new Vector.<LevelUnit>();
private var theme:Theme;
public function LevelContainer(theme:Theme):void{
    this.theme = theme;
}
var i:uint;
for(i = 0;i < theme.levelNum;i++){
    //��������λ
    var levelUnit:LevelUnit = new LevelUnit(theme.themeId, i);
    levelUnit.x = 100;
    levelUnit.y = 100 + 40 * i;
    addChild(levelUnit);
}
for(i = 0;i < curLevel;i++){
    levelVec[i].setPlay(true);
}


BulletData
public var bulletId:uint;
public var speed:Number;
public var price:Number;

bulletVec:Vector.<BulletData>
