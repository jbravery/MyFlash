package
{
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	[SWF(width="550", height="400",backgroundColor="#FFFFFF", frameRate="60")]
	
	public class LoopingMusic extends Sprite
	{
		[Embed(source="../sounds/music.mp3")]
		private var Music:Class;
		
		//为声音创建Sound和SoundChannel对象
		private var _music:Sound = new Music();
		private var _musicChannel:SoundChannel = new SoundChannel;
		
		//设置音量和声道所需要的变量
		private var _volume:Number = 1;
		private var _pan:Number = 0;
		
		public function LoopingMusic()
		{
			_musicChannel = _music.play(30, int.MAX_VALUE);
			
			//修改音量和声道设置
			_volume = 0.5;
			_pan = 0;
			
			//创建SoundTransform对象
			var transform:SoundTransform = new SoundTransform(_volume,_pan);
			
			//将SoundTransform对象赋值给musicChannel的soundTransform属性
			_musicChannel.soundTransform = transform;
		}
	}
}