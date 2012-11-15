package  
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Zo
	 */
	public class GamepadEvent extends Event 
	{
		
	
		public static var PLAYER_0_BUTTON_0_UP:String = "player_0_button_0_up";
		public static var PLAYER_0_BUTTON_0_DOWN:String = "player_0_button_0_down";
		public static var PLAYER_0_AXIS_ONE_X_CHANGE:String = "player_0_axis_one_x_change";
		public static var PLAYER_0_AXIS_ONE_Y_CHANGE:String = "player_0_axis_one_y_change";
		
		public var gamepadId:int;
		public var value:Number;
	
		public function GamepadEvent(type:String, targetgamepadId:int, newvalue:Number, bubbles:Boolean=false,cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			gamepadId = targetgamepadId;
			value = newvalue;
			
		}
		
	}

}