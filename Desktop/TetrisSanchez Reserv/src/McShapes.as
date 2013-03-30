package 
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Sanchez)
	 */
	public class  McShapes extends MovieClip
	{
		private var globalArrayXy:Array = new Array();
		private var yArray:Array = new Array();
		private var k:int; //y
		private var m:int; //x
		public var cub:cube;
		public var element:Elements = new Elements();
		public var gameShape:Array = new Array();
		public var nextShape:Array = new Array();
		public var mcShape:McShapes;
		public var timerMoveDown:Timer;
		public var timerDelay:uint;
		public static const standart:uint = 32; //standart rect alpha=0;
		public var shapeWidth:uint;
		public var maxXChildren:uint;
		public var line:Array = new Array();
		public var timerEnabled:Boolean;
		public var nowShape:uint;
		
		
		
		
		public function mcShapes():void {
			createNextShape();
			createGameShape();
		}
		
	
	// СОЗДАНИЕ МУВИКА
		public function createShape(xCord:uint, yCord:uint, nShape:Array):void
		{
			mcShape = new McShapes();
			mcShape.x = xCord * Rules.standart;
			mcShape.y = yCord * Rules.standart;
			for (k = 0; k < nShape.length; k++)
			{
				for (m = 0; m < nShape[k].length; m++)
				{
					if (nShape[k][m] == 1)
					{
						cub = new cube();
						cub.y = k * Rules.standart;
						cub.x = m * Rules.standart;
						mcShape.addChild(cub);
					}
				}
			}
			addChild(mcShape);
			trace("now shape"+nowShape);
		
		}
		public function createCub(xCord:int, yCord:int):void
		{
			cub = new cube();
			cub.y = yCord * Rules.standart;
			cub.x = xCord * Rules.standart;
			addChild(cub);
		}
		public function createGameShape():void
		{
			gameShape = new Array();
			gameShape = nextShape;
			createShape(5, 0, gameShape);
			createNextShape();
		}
		public function createNextShape():void
		{
			//var r:uint = Math.round(Math.random() * 7);
			var r:uint = 00;
			switch (r)
			{
				case 0: 
					// LINE ====
					nextShape = [[1], [1], [1], [1]];
					nowShape = 0;
					break;
				case 00:
					//line rotate
					nextShape = [[0, 0, 1, 0], [0, 0, 1, 0], [0, 0, 1, 0], [0, 0, 1, 0]];
					nowShape=01;
				case 1: 
					//RECTANGLE []
					nextShape = [[1, 1], [1, 1]];
					nowShape = 1;
					break;
				
				case 2: 
					// L
					nextShape = [[0, 0, 1], [1, 1, 1], [0, 0, 0]];
					nowShape = 2;
					break;
				
				case 3: 
					// T
					nextShape = [[0, 1, 0], [1, 1, 1], [0, 0, 0]];
					nowShape = 3;
					break;
				
				case 4: 
					// Z
					nextShape = [[1, 1, 0], [0, 1, 1], [0, 0, 0]];
					nowShape = 4;
					break;
				case 5: 
					// S
					nextShape = [[0, 1, 1], [1, 1, 0], [0, 0, 0]];
					nowShape = 5;
					break;
				// Г
				case 6: 
					nextShape = [[1, 0, 0], [1, 1, 1], [0, 0, 0]];
					nowShape = 6;
					shapeWidth = 3
					break;
				case 7: 
					// +
					nextShape = [[0, 1, 0], [1, 1, 1], [0, 1, 0]];
					nowShape = 7
					break;
				
				default: 
					trace("i'm a bug!!");
					nextShape = [[0, 1, 0], [0, 1, 0], [0, 1, 0], [1, 1, 1]];
					break;
			
			}
		
		}
	}
}