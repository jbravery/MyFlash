package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	public class LevelOne extends Sprite
	{
		//声明变量用来保存游戏对象
		private var _character:Character;
		private var _background:Background;
		private var _gameOver:GameOver;
		private var _monster1:Monster;
		private var _monster2:Monster;
		private var _star:Star;
		private var _levelWinner:String;
		
		//定时器
    	private var _monsterTimer:Timer;
		private var _gameOverTimer:Timer;
		
		//一个用来储存stage引用的变量。stage引用是从应用类传递进来的
		private var _stage:Object;
		
		public function LevelOne(stage:Object)
		{
	        _stage=stage;
			this.addEventListener(Event.ADDED_TO_STAGE,addedToStageHandler);
		}
		private function addedToStageHandler(event:Event):void
		{
		   startGame();
		   this.removeEventListener(Event.ADDED_TO_STAGE,addedToStageHandler);
		}
		private function startGame():void
		{
			//创建游戏对象
			_character=new Character();
			_star=new Star();
			_background=new Background();
			_monster1=new Monster();
			_monster2=new Monster();
			_gameOver=new GameOver();
			
			//游戏对象添加到舞台
			addGameObjectToLevel(_background,0,0);
			addGameObjectToLevel(_monster1,400,150);
			addGameObjectToLevel(_monster2,150,150);
			addGameObjectToLevel(_character,250,300);
			addGameObjectToLevel(_star,250,300)
			_star.visible=false;
			addGameObjectToLevel(_gameOver,140,130)
			
			//初始化怪物定时器
			_monsterTimer=new Timer(1000);
			_monsterTimer.addEventListener(TimerEvent.TIMER,monsterTimerHandler);
			_monsterTimer.start();
			
			//事件监听器
			_stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
			_stage.addEventListener(KeyboardEvent.KEY_UP,keyUpHandler);
			this.addEventListener(Event.ENTER_FRAME,enterFrameHandler);
		}
		private function enterFrameHandler(event:Event):void
		{
			//移动游戏角色并检测它的舞台边界
			_character.x+=_character.vx;
			_character.y+=_character.vy;
			checkStageBoundaries(_character);
			
			//移动怪物并检查他们的舞台边界
			if(_monster1.visible)
			{
				_monster1.x+=_monster1.vx;
				_monster2.y+=_monster2.vy;
				checkStageBoundaries(_monster1);
			}
			if(_monster2.visible)
			{
				_monster2.x+=_monster2.vx;
				_monster2.y+=_monster2.vy;
				checkStageBoundaries(_monster2);
			}
			//如果发射了星星，移动并检查它的舞台边界，以及与怪物之间是否发生碰撞
			if(_star.launched)
			{
				//如果星星被发射，使其变成可见
				_star.visible=true;
				
				//移动星星
				_star.y-=3;
				_star.rotation+=5;
				
				//检查星星 的舞台边界
				checkStageBoundaries(_star);
				
				//检查星星与怪物之间是否发生碰撞
				starVsMonsterCollision(_star,_monster1);
				starVsMonsterCollision(_star,_monster2);
			}
			else
			{
			_star.visible=false;
			}
			//角色和怪物之间的碰撞检测
			characterVsMonsterCollision(_character,_monster1);
			characterVsMonsterCollision(_character,_monster2);	
			}
		    private function characterVsMonsterCollision(character:Character,monster:Monster):void
			{
				if(monster.visible&&character.hitTestObject(monster))
				{
					character.timesHit++;
					checkGameOver();
				}
		}
			private function starVsMonsterCollision(star:Star,monster:Monster):void
			{
				if(monster.visible&&star.hitTestObject(monster))
				{
					//调用怪物的openMouth方法，让它张开嘴巴
					monster.openMouth();
					
					//使星星失效
					star.launched=false;
					
					//将怪物的timesHit变量加1
					monster.timesHit++;
					
					//怪物已经被击中3次了吗？
					if(monster.timesHit==3)
					{
						//调用killMonster方法
						killMonster(monster);
						
						//检测游戏是否结束
						checkGameOver();
					}
				}
			}
			private function killMonster(monster:Monster):void
			{
				//将怪物变为不可见
				monster.visible=false;
					
				//创建一个新的爆炸对象并添加到舞台上
				var explosion:Explosion=new Explosion();
				this.addChild(explosion);
				
				//将爆炸对象定位到怪物的正中心
				explosion.x=monster.x -21;
				explosion.y=monster.y -18;
				
				//调用爆炸效果的explode方法
				explosion.explode();
			}
			private function checkGameOver():void
			{
				if(_monster1.timesHit==3 && _monster2.timesHit==3)
				{
					_levelWinner="character"
					_gameOverTimer=new Timer(2000);
					_gameOverTimer.addEventListener(TimerEvent.TIMER,gameOverTimerHandler);
					_gameOverTimer.removeEventListener(TimerEvent.TIMER,monsterTimerHandler);
					this.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
				}
				if(_character.timesHit==1)
				{
					_levelWinner="monster"
					_character.alpha=0.5;
					_gameOverTimer=new Timer(2000);
					_gameOverTimer.addEventListener(TimerEvent.TIMER,gameOverTimerHandler);
					_gameOverTimer.start();
					_monsterTimer.removeEventListener(TimerEvent.TIMER,monsterTimerHandler);
					this.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
				}
			}
			private function checkStageBoundaries(gameObject:Sprite):void
			{
				if(gameObject.x<50)
				{
					gameObject.x=50;
				}
				if(gameObject.y<50)
				{
				gameObject.y=50;
				}
				if(gameObject.x+gameObject.width>_stage.stageWidth-50)
				{
					gameObject.x=_stage.stageWidth-gameObject.width-50;
				}
				if(gameObject.y+gameObject.height>_stage.stageHeight-50)
				{
					gameObject.y=_stage.stageHeight-gameObject.height-50;
				}
			}
			private function checkStarStageBoundaries(star:Star):void
			{
				if(star.y<50)
				{
					star.launched=false;
				}
			}
			private function monsterTimerHandler(event:TimerEvent):void
			{
				changeMonsterDirection(_monster1);
				changeMonsterDirection(_monster2);
			}
			private function changeMonsterDirection(monster:Monster):void
			{
				var randomNumber:int=Math.ceil(Math.random()*4);
				if(randomNumber==1)
				{
					//向右
					monster.vx=1;
					monster.vy=0;
				}
				else if(randomNumber==2)
				{
					//向左
					monster.vx=-1;
					monster.vy=0;
				}
				else if(randomNumber==3)
				{
					//向上
					monster.vx=0;
					monster.vy=-1;
				}
				else
				{
					//向下
					monster.vx=0;
					monster.vy=1;
				}
			}
			private function gameOverTimerHandler(event:TimerEvent):void
			{
				if(_levelWinner=="character")
				{
					if(_gameOverTimer.currentCount==1)
					{
					_gameOver.levelComplete.visible=true;
					}
					if(_gameOverTimer.currentCount==2)
					{
					_gameOverTimer.reset();
					_gameOverTimer.removeEventListener(TimerEvent.TIMER,gameOverTimerHandler);
					dispatchEvent(new Event("levelOneComplete",true));
					}
				}
				if(_levelWinner=="monsters")
				{
					_gameOver.youLost.visible=true;
					_gameOverTimer.removeEventListener(TimerEvent.TIMER,gameOverTimerHandler);
				}
			}
			private function keyDownHandler(event:KeyboardEvent):void
			{
				if(event.keyCode==Keyboard.LEFT)
					{
						_character.vx=-5;
					}
				else if(event.keyCode==Keyboard.RIGHT)
				{
					_character.vx=5;
				}
				else if(event.keyCode==Keyboard.UP)
				{
					_character.vy=-5;
				}
				else if(event.keyCode==Keyboard.DOWN)
				{
					_character.vy=5;
				}
				if(event.keyCode==Keyboard.SPACE)
				{
					if(!_star.launched)
					{
						_star.x=_character.x+_character.width/2;
						_star.y=_character.y+_character.width/2;
						_star.launched=true;
					}
				}
			}
			private function keyUpHandler(event:KeyboardEvent):void
			{
				if(event.keyCode==Keyboard.LEFT||event.keyCode==Keyboard.RIGHT)
				{
					_character.vx=0
				}
				else if(event.keyCode==Keyboard.DOWN||event.keyCode==Keyboard.UP)
				{
					_character.vy=0;
				}
			}
			private function addGameObjectToLevel(gameObject:Sprite,xPos:int,yPos:int):void
			{
				this.addChild(gameObject);
				gameObject.x=xPos;
				gameObject.y=yPos;
			}
	}
}