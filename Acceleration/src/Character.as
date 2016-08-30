package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class Character extends Sprite
	{
		//嵌入图片
		[Embed(source="../images/character.png")]
		private var CharacterImage:Class;
		
		//私有属性
		private var _character:DisplayObject=new CharacterImage;
		
		//公有属性
		public var vx:Number=0;
		public var vy:Number=0;
		public var accelerationX:Number=0;
		public var accelerationY:Number=0;
		public var speedLimit:Number=5;
		public var friction:Number=0.96;
		public var bounce:Number=-0.7;
		public var gravity:Number=0.3;
		public var isOnGround:Boolean=undefined;
		public var jumpForce:Number=-10;
		
		public function Character()
		{
			//在当前类中显示图片
			this.addChild(_character);
		}
	}
}