package  
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Zo
	 */
	public class GamepadEvent extends Event 
	{
		//PLAYER ZERO
		
		//button zero
		public static var PLAYER_0_BUTTON_0_UP:String = "player_0_button_0_up";
		public static var PLAYER_0_BUTTON_0_DOWN:String = "player_0_button_0_down";
		
		//button one
		public static var PLAYER_0_BUTTON_1_UP:String = "player_0_button_1_up";
		public static var PLAYER_0_BUTTON_1_DOWN:String = "player_0_button_1_down";
		//button two
		public static var PLAYER_0_BUTTON_2_UP:String = "player_0_button_2_up";
		public static var PLAYER_0_BUTTON_2_DOWN:String = "player_0_button_2_down";
		//button three
		public static var PLAYER_0_BUTTON_3_UP:String = "player_0_button_3_up";
		public static var PLAYER_0_BUTTON_3_DOWN:String = "player_0_button_3_down";
		
		//right shoulder
		public static var PLAYER_0_RIGHT_SHOULDER_UP:String = "player_0_right_shoulder_up";
		public static var PLAYER_0_RIGHT_SHOULDER_DOWN:String = "player_0_right_shoulder_down";
		//left shoulder
		public static var PLAYER_0_LEFT_SHOULDER_UP:String = "player_0_left_shoulder_up";
		public static var PLAYER_0_LEFT_SHOULDER_DOWN:String = "player_0_left_shoulder_down";
		
		//right analog trigger
		public static var PLAYER_0_RIGHT_TRIGGER_CHANGE:String = "player_0_right_trigger_change";
		//left analog trigger
		public static var PLAYER_0_LEFT_TRIGGER_CHANGE:String = "player_0_left_trigger_change";
		
		//left top button
		public static var PLAYER_0_LEFT_BUTTON_UP:String = "player_0_left_button_up";
		public static var PLAYER_0_LEFT_BUTTON_DOWN:String = "player_0_left_button_down";
		//right top button
		public static var PLAYER_0_RIGHT_BUTTON_UP:String = "player_0_left_button_up";
		public static var PLAYER_0_RIGHT_BUTTON_DOWN:String = "player_0_right_button_down";
		
		
		
		//axis one
		public static var PLAYER_0_AXIS_ONE_X_CHANGE:String = "player_0_axis_one_x_change";
		public static var PLAYER_0_AXIS_ONE_Y_CHANGE:String = "player_0_axis_one_y_change";
		//axis two
		public static var PLAYER_0_AXIS_TWO_X_CHANGE:String = "player_0_axis_two_x_change";
		public static var PLAYER_0_AXIS_TWO_Y_CHANGE:String = "player_0_axis_two_y_change";
		
		//select
		public static var PLAYER_0_SELECT_DOWN:String = "player_0_select_down";
		public static var PLAYER_0_SELECT_UP:String = "player_0_select_up";
		
		//start
		public static var PLAYER_0_START_DOWN:String = "player_0_start_down";
		public static var PLAYER_0_START_UP:String = "player_0_start_up";
		
		//D-pad
		public static var PLAYER_0_DPAD_TOP_DOWN:String = "player_0_dpad_top_down";
		public static var PLAYER_0_DPAD_TOP_UP:String = "player_0_dpad_top_up";
		public static var PLAYER_0_DPAD_BOTTOM_DOWN:String = "player_0_dpad_bottom_down";
		public static var PLAYER_0_DPAD_BOTTOM_UP:String = "player_0_dpad_bottom_up";
		public static var PLAYER_0_DPAD_LEFT_DOWN:String = "player_0_dpad_left_down";
		public static var PLAYER_0_DPAD_LEFT_UP:String = "player_0_dpad_left_up";
		public static var PLAYER_0_DPAD_RIGHT_DOWN:String = "player_0_dpad_right_down";
		public static var PLAYER_0_DPAD_RIGHT_UP:String = "player_0_dpad_right_up";
		//
		
		/*
		updateButton(buttons[0], gamepadId, 'button-1');
		updateButton(buttons[1], gamepadId, 'button-2');
		updateButton(buttons[2], gamepadId, 'button-3');
		updateButton(buttons[3], gamepadId, 'button-4');
		
		updateButton(buttons[4], gamepadId, 'button-left-shoulder-top');
		updateButton(buttons[6], gamepadId, 'button-left-shoulder-bottom');
		updateButton(buttons[5], gamepadId, 'button-right-shoulder-top');
		updateButton(buttons[7], gamepadId, 'button-right-shoulder-bottom');
		updateButton(buttons[8], gamepadId, 'button-select');
		updateButton(buttons[9], gamepadId, 'button-start');
		updateButton(buttons[10], gamepadId, 'stick-1');
		updateButton(buttons[11], gamepadId, 'stick-2');
		updateButton(buttons[12], gamepadId, 'button-dpad-top');
		updateButton(buttons[13], gamepadId, 'button-dpad-bottom');
		updateButton(buttons[14], gamepadId, 'button-dpad-left');
		updateButton(buttons[15], gamepadId, 'button-dpad-right');
		*/
		
		
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