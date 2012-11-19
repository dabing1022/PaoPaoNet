package utils{
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundTransform;
    import flash.media.SoundMixer;

    public class SoundManager{
        private var soundArr:Array;
        private var soundChannelsArr:Array;
        /**soundMute:是否已经静音*/
        private var soundMute:Boolean = false;
        /**soundTrackChannel:用来存储某时刻的唯一声道*/
        private var soundTrackChannel:SoundChannel = new SoundChannel();
        private var tempSound:Sound;
        private var tempSoundTransform:SoundTransform = new SoundTransform();
        private var muteSoundTransform:SoundTransform = new SoundTransform();
        private static var instance:SoundManager;
        public function SoundManager():void{
            soundArr = new Array();
            soundChannelsArr = new Array();

            init();
        }

        public static function getInstance():SoundManager{
            if(instance == null){
                instance = new SoundManager();
            }
            return instance;
        }

        private function init():void{
            addSound("bgm",Assets.getSound("Resource1_bgm"));
			addSound("shoot",Assets.getSound("Resource1_shoot"));
			addSound("mute",Assets.getSound("Resource1_mute"));
			addSound("hurt",Assets.getSound("Resource1_hurt"));
			addSound("dispear",Assets.getSound("Resource1_dispear"));
        }

        /**
         *@param soundName  声音名字
         *@param sound      声音
         */
        private function addSound(soundName:String, sound:Sound):void{
            soundArr[soundName] = sound;           
        }

        /**
         *@param      soundName          声音名字
         *@param      isSoundTrack       声音是否为声道,当为声道时和其他声音区别对待。
         *@param      loops              循环次数
         *@param      offset             应开始回放的初始位置（以毫秒为单位）
         *@param      volume             音量
         * 一次播放一个声道
         */
        public function playSound(soundName:String,isSoundTrack:Boolean,loops:int = 1,offset:Number = 0,volume:Number = 1):void{
            tempSound = soundArr[soundName];
            tempSoundTransform.volume = volume;
            if(isSoundTrack){
                if(soundTrackChannel != null){
                    soundTrackChannel.stop();
                }
                soundTrackChannel = tempSound.play(offset,loops);
                soundTrackChannel.soundTransform = tempSoundTransform;
            }else{
                //非声道声音
                soundChannelsArr[soundName] = tempSound.play(offset,loops);
                soundChannelsArr[soundName].soundTransform = tempSoundTransform;
            }
        }

        public function stopSound(soundName:String,isSoundTrack:Boolean):void{
            if(isSoundTrack){
                soundTrackChannel.stop();
            }else{
                soundChannelsArr[soundName].stop();
            }
        }

        public function muteSound():void{
            if(soundMute){
                soundMute = false;
                muteSoundTransform.volume = 1;
                SoundMixer.soundTransform = muteSoundTransform;
            }else{
                soundMute = true;
                muteSoundTransform.volume = 0;
                SoundMixer.soundTransform = muteSoundTransform;
            }
        }
    }
}
