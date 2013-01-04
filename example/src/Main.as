package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Zo
	 */
	public class Main extends Sprite 
	{
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//ExternalInterface.call("console.log", "starting gamepads");
			Gamepad.playerOne.addEventListener(GamepadEvent.BUTTON_0_DOWN, playerOneButtonDown );
			Gamepad.playerOne.addEventListener(GamepadEvent.BUTTON_0_UP, playerOneButtonUp );
			
			
			
		}
		
		public function playerOneButtonDown(e:Event):void
		{
			ExternalInterface.call("console.log", "playerOneButtonDown");
		}
		public function playerOneButtonUp(e:Event):void
		{
			ExternalInterface.call("console.log", "playerOneButtonUp");
		}
		
	}
	
}