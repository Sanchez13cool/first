package 
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	
	
	/**
	 * ...
	 * @author Sanchez)
	 */
	public class Elements extends MovieClip 
	{
		public var informPanel:informationPanel;
		public var rect:Shape;
		
	
		
		public function elements():void 
		{
			
			createSomethin("panel", 0, 700);
			createSomethin("wall", 130, 30);
			createSomethin("wall", 140+Rules.standart*12, 30);
			//createSomethin("setka", 0, 0);
		}
		public function createPanel(xCord:uint, yCord:uint):void {
			informPanel = new informationPanel();
			informPanel.x = xCord;
			informPanel.y = yCord;
			addChild(informPanel);
			informPanel.scoreBox.scoreText.text="йа табло"
		}
		public function createWall(xCord:uint,yCord:uint):void {
			var walll:wall = new wall();
			walll.x = xCord;
			walll.y = yCord;
			addChild(walll);
		}
		
		public function createSomethin(s:String,xCor:uint,yCor:uint):void {
			switch (s) 
			{
				case"setka":
					drawSetka(xCor, yCor);
 					break;
				case"panel":
					createPanel(xCor, yCor);
					break;
				case"wall":
					createWall(xCor, yCor);	
					break;
			default:
				//trace("somethin");
			}
		}
		public function drawSetka(xCord:uint, yCord:uint):void {
			rect = new Shape();
			rect.graphics.lineStyle(1, 0x0000FF, 1);
			rect.graphics.drawRoundRect(0, 0, 28, 28, 2, 2);
			rect.x = xCord * Rules.standart;
			rect.y = yCord * Rules.standart;
			addChild(rect);
			
		}
		
	}

}