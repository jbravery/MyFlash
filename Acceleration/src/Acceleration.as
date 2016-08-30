package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
    [SWF(width="550",height="400",backgroundColor="#FFFFFF",frameRate="60"]
	
	public class Acceleration extends Sprite
	{
		private var _character:Character=new Character();
		
		public function Acceleration()
		{
			//将角色添加到舞台上
			stage.addChild(_character);
			_character.x=250;
			_character.y=175;
			
			//添加事件监听器
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyUpHandler);
			stage.addEventListener(Event.ENTER_FRAME,enterFrameHandler);
		}
		public function keyDownHandler(event:KeyboardEvent):void
		{
			if(event.keyCode==Keyboard.LEFT)
			{
			_character.accelerationX=-0.2;
			}
			else if(event.keyCode==Keyboard.RIGHT)
			{
			_character.accelerationX=0.2;
			}
			else if(event.keyCode==Keyboard.UP)
			{
			_character.accelerationY=-0.2;
			}
			else if(event.keyCode==Keyboard.DOWN)
			{
			_character.accelerationY=0.2;
			}
		}
		public function keyUpHandler(event:KeyboardEvent):void
		{
			if(event.keyCode==Keyboard.LEFT ||event.keyCode==Keyboard.RIGHT)
			{
				_character.accelerationX=0;
				_character.vx=0;
			}
			else if(event.keyCode==Keyboard.UP ||event.keyCode==Keyboard.DOWN)
			{
				_character.accelerationY=0;
				_character.vy=0;
			}
		}
		public function enterFrameHandler(event:Event):void
		{
			//应用加速度
			_character.vx+=_character.accelerationX;
			_character.vy+=_character.accelerationY;
			
			//限制速度
			if(_character.vx>_character.speedLimit)
			{
			    _character.vx = _character.speedLimit;
			}
			if (_character.vx < -_character.speedLimit)
			{
				_character.vx = -_character.speedLimit;
			}
			if (_character.vy > _character.speedLimit)
			{
				_character.vy = _character.speedLimit;
			} 
			if (_character.vy < -_character.speedLimit)
			{
				_character.vy = -_character.speedLimit;
			}
			
			//移动角色
			_character.x+=_character.vx;
			_character.y+=_character.vy;
				
			//检测舞台边界
			if (_character.x < 0)
			{
				_character.x = 0;
			}
			if (_character.y < 0)
			{
				_character.y = 0;
			}
			if (_character.x + _character.width > stage.stageWidth)
			{
				_character.x = stage.stageWidth - _character.width;
			}
			if (_character.y + _character.height > stage.stageHeight)
			{
				_character.y = stage.stageHeight - _character.height;
			}
			//打印结果
			trace("_character.vx:"+_character.vx);
			trace("_character.x:"+_character.x);
			trace("----------")
		}
	}
}