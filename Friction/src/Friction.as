package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class Friction extends Sprite
	{
		private var _character:Character = new Character();;
		
		public function Friction()
		{
			//添加角色到舞台
			stage.addChild(_character);
			_character.x = 250;
			_character.y = 175;
			
			//添加时间监听器
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler); 
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		public function keyDownHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.LEFT)
			{
				_character.accelerationX = -0.2;
			}
			else if (event.keyCode == Keyboard.RIGHT)
			{
				_character.accelerationX = 0.2;
			}
			else if (event.keyCode == Keyboard.UP)
			{
				_character.accelerationY = -0.2;
			}
			else if (event.keyCode == Keyboard.DOWN)
			{
				_character.accelerationY = 0.2;
			}
		}
		public function keyUpHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.LEFT 
				|| event.keyCode == Keyboard.RIGHT)
			{
				_character.accelerationX = 0; 
			} 
			else if (event.keyCode == Keyboard.DOWN 
				|| event.keyCode == Keyboard.UP)
			{
				_character.accelerationY = 0; 
			} 
		}
		public function enterFrameHandler(event:Event):void
		{
			//应用加速度
			_character.vx += _character.accelerationX; 
			_character.vy += _character.accelerationY;
			
			//应用摩擦
			_character.vx *= _character.friction; 
			_character.vy *= _character.friction;
			
			
			//限制速度
			if (_character.vx > _character.speedLimit)
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
			
			//Force the velocity to zero
			//after it falls below 0.1
			if (Math.abs(_character.vx) < 0.1)
			{
				_character.vx = 0;
			}
			if (Math.abs(_character.vy) < 0.1)
			{
				_character.vy = 0;
			}
			
			//移动角色 
			_character.x += _character.vx;
			_character.y += _character.vy;
			
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
		} 
	}
}