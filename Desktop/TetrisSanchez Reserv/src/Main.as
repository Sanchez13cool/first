package 
{
	import flash.display.Sprite;
	import flash.events.*;
	
	/**
	 * ...
	 * @author Sanchez)
	 */
	public class Main extends Sprite 
	{ 	
		public var rules:Rules = new Rules();
		public var elements:Elements = new Elements();
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			rules.rules();
			rules.x = 123;
			elements.elements();
			addChild(elements);
			addChild(rules);
			
			trace("Sx");
			stage.focus = stage;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, rules.keyDownListener);
			
		}
		
	}
	
}