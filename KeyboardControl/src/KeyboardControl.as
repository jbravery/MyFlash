package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	
	[SWF(width="550",height="400",backgroundColor="#FFFFFF",frameRate="60")]
	
	public class KeyboardControl extends Sprite
	{
		//创建游戏角色对象
		public var characterURL:URLRequest=new URLRequest("../images/character.png");
		public var characterImage:Loader=new Loader();
		public var character:Sprite=new Sprite();
		
		//创建并初始化VX和VY变量
		public var vx:int=0;
		public var vy:int=0;
		
		public function KeyboardControl()
		{
		    //加载图片并把角色添加到舞台上
			characterImage.load(characterURL);
			character.addChild(characterImage);
			stage.addChild(character);
			character.x=225;
			character.y=150;
			
			//添加事件监听器
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler); 
			stage.addEventListener(Event.ENTER_FRAME,enterFrameHandler);
		}
		public function keyDownHandler(event:KeyboardEvent):void
		{
		    if(event.keyCode==Keyboard.LEFT)
			{
			vx=-5
			}
			else if(event.keyCode==Keyboard.RIGHT)
			{
				vx = 5;
			}
			else if (event.keyCode == Keyboard.UP)
			{
				vy = -5;
			}
			else if (event.keyCode == Keyboard.DOWN)
			{
				vy = 5;
			}
		}
		public function keyUpHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.LEFT 
				|| event.keyCode == Keyboard.RIGHT)
			{
				vx = 0;
			} 
			else if (event.keyCode == Keyboard.DOWN 
				|| event.keyCode == Keyboard.UP)
			{
				vy = 0;
			} 
		}
		public function enterFrameHandler(event:Event):void
		{
			//Move the player 
			character.x += vx; 
			character.y += vy;
			
			//屏幕环绕
			if(character.x+character.width<0)
			{
				character.x=550;
			}
			if(character.y+character.height<0)
			{
				character.y=400;
			}
			if(character.x>stage.stageWidth)
			{
			character.x=0-character.width;
			}
			if(character.y>stage.stageHeight)
			{
			character.y=0-character.height;	
			}
		} 
	}
}