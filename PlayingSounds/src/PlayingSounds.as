package
{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.ui.Keyboard;
	
	[SWF(width="550",height="400",background="#FFFFFF",frameRate="60"]
	
	public class PlayingSounds extends Sprite
	{
		//嵌入声音
		[Embed(source="../sounds/bounce.mp3")]
		private var Bounce:Class;
		
		//创建声音对象以及声道对象
		private var _bounce:Sound = new Bounce();
		private var _bounceChannel:SoundChannel = new SoundChannel();
		
		public function PlayingSounds()
		{
		     stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);	
		}
		public function keyDownHandler(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.SPACE)
			{
				//用来播放弹跳声音的声道
				_bounceChannel = _bounce.play();
			}
		}
	}
}