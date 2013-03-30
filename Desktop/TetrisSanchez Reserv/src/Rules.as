package
{
	import flash.display.*;
	import flash.utils.Timer;
	import flash.events.*;
	
	/**
	 * ...
	 * @author Sanchez)
	 */
	public class Rules extends MovieClip
	{
		private var globalArrayXy:Array = new Array();
		private var yArray:Array = new Array();
		private var k:int; //y
		private var m:int; //x
		public var rect:Shape;
		public var cub:cube;
		public var element:Elements = new Elements();
		public var gameShape:Array = new Array();
		public var nextShape:Array = new Array();
		public var timerMoveDown:Timer;
		public var timerDelay:uint;
		public static const standart:uint = 32; //standart rect alpha=0;
		public var shapeWidth:uint;
		public var maxXChildren:uint;
		public var line:Array = new Array();
		public var timerEnabled:Boolean;
		public var nowShape:uint;
		public var mcShape:McShapes = new McShapes();
		
		//public var 
		
		////////////////////////////constructor/////////////////////////////////////
		public function rules():void
		{
			yArray.length = 22;
			globalArrayXy.length = 12;
			line.length = 22;
			for (var i:int = 0; i < globalArrayXy.length; i++)
			{
				
				for (var j:int = 0; j < yArray.length; j++)
				{
					yArray[j] = 0;
						//trace(j);
				}
				
				globalArrayXy[i] = [yArray];
			}
		
			
			for (k = 0; k < globalArrayXy.length; k++)
			{
				for (m = 0; m < yArray.length; m++)
				{
					element.createSomethin("setka", k, m);
						//trace(k + "y - x" + m);
					
				}
			}
			
			addChild(element);
			
			timerDelay = 300;
			timerMoveDown = new Timer(timerDelay);
			timerEnabled = true;
			timerMoveDown.start();
			//addEventListener(MouseEvent.CLICK, startStopListener);
			timerMoveDown.addEventListener(TimerEvent.TIMER, moveShapeDown);
		}
		
		public function keyDownListener(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				//left
				case 65: 
					moveShape(-Rules.standart);
					break;
				//left
				case 37: 
					moveShape(-Rules.standart);
					break;
				
				//right
				case 68: 
					moveShape(Rules.standart);
					break;
				//right
				case 39: 
					moveShape(Rules.standart);
					break;
				case 32: 
					rotateShape();
					break;
				default:
					trace("default");
					return;
			}
		}
		////////////////////////////////////////////////////ВРАЩЕНИЕ//////////////////////////////////////////////////
		public function rotateShape():void
		{
			//timerMoveDown.removeEventListener(TimerEvent.TIMER, moveShapeDown);
		
			//timerMoveDown.stop();
			trace("поворот");
			trace("numChildren= "+mcShape.numChildren);
			trace("gameshape= "+gameShape);
		
			if(mcShape){   
			gameShape = [[0, 0, 0, 0], [ 1 , 1, 1, 1], [0, 0, 0, 0], [0, 0, 0, 0]];
			createRotateShape(gameShape);
			
			trace("numChildrenAfter= "+mcShape.numChildren);
			trace("gameshape= " + gameShape);
			trace("вращение закончилось");
			//timerMoveDown.addEventListener(TimerEvent.TIMER, moveShapeDown);
		}
		
		

		//												ДВИГАЕМ
		public function moveShape(xCord:int):void
		{
			
			mcShape.x += xCord;
			//trace(mcShape.x);
			
			if (mcShape.x < 0)
			{
				mcShape.x = 0;
			}
			else if (mcShape.x > Rules.standart * 7)
			{
				for (k = 0; k < gameShape.length; k++)
				{
					for (m = 0; m < gameShape[k].length; m++)
					{
						
						if (gameShape[k][m] == 1)
						{
							if (mcShape.x / Rules.standart + m > 11)
							{
								//timerMoveDown.stop();
								mcShape.x = (11 - m) * Rules.standart;
								return;
							}
							
						}
					}
				}
				
			}
			////////////////////////////////////////////// БОКОВОЕ СТОЛКНОВЕНИЕ////////////////////////////////////////////////////// x m  ....y k
			else if (mcShape)
			{
				for (k = 0; k < gameShape.length; k++)
				{
					for (m = 0; m < gameShape[k].length; m++)
					{
						
						if (gameShape[k][m] == 1)
						{
							if (globalArrayXy[mcShape.x / Rules.standart + m][mcShape.y / Rules.standart + k] == 1)
							{
								mcShape.x -= xCord;
								return;
							}
							
						}
					}
				}
			}
		
		}
		
		//////////////////////////////////          ПАДАЕТ 			////////////////////////////////	
		public function moveShapeDown(t:TimerEvent):void
		{
			var coordX:int = mcShape.x / Rules.standart;
			var coordY:int = mcShape.y / Rules.standart;
			var flagMove:Boolean = true;
			
			for (k = 0; k < gameShape.length; k++)
			{
				for (m = 0; m < gameShape[k].length; m++)
				{
					
					if (gameShape[k][m] == 1)
					{
						////////////////////////////////	ГРАНИЦА НИЗ			/////////////////
							if (coordY + k == 21)
							{
								
								//timerMoveDown.stop();
								flagMove = false
								removeChild(mcShape);
								addToGlobalArray(coordX, coordY);
								//McShape.createGameShape();
								return;
							}
							////////////////////////////////	ПАДЕНИЕ НА ФИГУРУ	/////////////////
							
							else if (globalArrayXy[coordX + m][coordY + k + 1] == 1)
							{
								trace("215");
								flagMove = false
								removeChild(mcShape);
								addToGlobalArray(coordX, coordY);
								//createGameShape();
								return;
							}
						
						
					}
				}
			}
			if (flagMove)
			{
				mcShape.y += Rules.standart;
			}
		
		}
		
		
		
		///////////////////////////////////////////////////////////СОЗДАНИЕ GLOBALARRAYXY///////////////////////////////////////////////////////////////////////
		public function addToGlobalArray(xC:int, yC:int):void
		{
			for (k = 0; k < gameShape.length; k++)
			{
				for (m = 0; m < gameShape[k].length; m++)
				{
					
					if (gameShape[k][m] == 1)
					{
						//trace(xC+m, yC+k);
						globalArrayXy[xC + m][yC + k] = 1;
						createCub(xC + m, yC + k);
						
					}
				}
			}
			CheckLineGlobalArray(globalArrayXy);
		}
		
		
		public function createCub(xCord:int, yCord:int):void
		{
			cub = new cube();
			cub.y = yCord * Rules.standart;
			cub.x = xCord * Rules.standart;
			addChild(cub);
		}
		//////////////////////////////////////////////////////// СТИРАНИЕ ЛИНИИ///////////////////xm   yk////////////////////////////////////////
		public function CheckLineGlobalArray(arr:Array):Array
		{
			var yy:uint = yArray.length;
			var xx:uint;
			
			for (k = 0; k < line.length; k++)
			{
				line[k] = 0;
			}
			for (xx = 0; xx < 12; xx++)
			{
				for (yy = 0; yy < 22; yy++)
				{
					if (globalArrayXy[xx][yy] == 1)
					{
						line[yy] = line[yy] + 1;
						trace(xx, yy);
						for (var l:uint = 0; l <= line.length; l++)
						{
							if (line[l] == 12)
							{
								trace("строка " + l + "заполнена!");
								for (var o:uint = 0; o < 12; o++)
								{
									for (var t:uint = 0; t < 22; t++)
									{
										
											//yArray.splice(0, l);
											//globalArrayXy.splice(0, 12);
											//globalArrayXy[o].splice(0, 12);
										
									}
								}
							}
						}
					}
				}
			}
			trace("line" + line);
			return globalArrayXy;
		}
		
		/*public function startStopListener(e:MouseEvent):void
		{
			trace(timerEnabled);
			if (timerEnabled == true)
			{
				timerMoveDown.stop();
				timerEnabled = false;
				return;
			}
			else if (timerEnabled == false)
			{
				timerMoveDown.start();
				timerEnabled = true;
				return;
			}
		
		}*/
		
		
		
		
		
		////////////////////////////////////////////////////////////ROTATE////////////////////////////////////////////////////////////////////
		public function createRotateShape(gShape:Array):void {
			
			trace("ss" + gShape);
			while (mcShape.numChildren > 0) {
				mcShape.removeChildAt(0);
			}
			
			for (k = 0; k < gShape.length; k++)
			{
				for (m = 0; m < gShape[k].length; m++)
				{
					if (gShape[k][m] == 1)
					{
						cub = new cube();
						cub.y = k * Rules.standart;
						cub.x = m * Rules.standart;
						mcShape.addChild(cub);
						
					}
				}
			}
			trace(mcShape.numChildren);
		}
		

	
	}

}