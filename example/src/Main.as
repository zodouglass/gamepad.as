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
		private var gamepads:gamepad = new gamepad();
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
			gamepads.addEventListener("player_0_button_0_down", playerOneButtonDown );
			gamepads.addEventListener("player_0_button_0_up", playerOneButtonUp );
			
			
			
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