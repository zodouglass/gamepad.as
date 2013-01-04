package  
{
	import flash.events.Event;
	
	/**
	 * Gamepad events representing xbox 360 like controller
	 * @author Zo
	 */
	public class GamepadEvent extends Event 
	{
		public static var CONNECT:String = "connect";
		
		//button zero - A
		public static var BUTTON_0_UP:String = "button_0_up";
		public static var BUTTON_0_DOWN:String = "button_0_down";
		
		//button one
		public static var BUTTON_1_UP:String = "button_1_up";
		public static var BUTTON_1_DOWN:String = "button_1_down";
		//button two
		public static var BUTTON_2_UP:String = "button_2_up";
		public static var BUTTON_2_DOWN:String = "button_2_down";
		//button three
		public static var BUTTON_3_UP:String = "button_3_up";
		public static var BUTTON_3_DOWN:String = "button_3_down";
		
		//right shoulder
		public static var RIGHT_SHOULDER_UP:String = "right_shoulder_up";
		public static var RIGHT_SHOULDER_DOWN:String = "right_shoulder_down";
		//left shoulder
		public static var LEFT_SHOULDER_UP:String = "left_shoulder_up";
		public static var LEFT_SHOULDER_DOWN:String = "left_shoulder_down";
		
		//right analog trigger
		public static var RIGHT_TRIGGER_CHANGE:String = "right_trigger_change";
		//left analog trigger
		public static var LEFT_TRIGGER_CHANGE:String = "left_trigger_change";
		
		//left top button
		public static var LEFT_BUTTON_UP:String = "left_button_up";
		public static var LEFT_BUTTON_DOWN:String = "left_button_down";
		//right top button
		public static var RIGHT_BUTTON_UP:String = "left_button_up";
		public static var RIGHT_BUTTON_DOWN:String = "right_button_down";
		
		
		
		//axis one
		public static var AXIS_ONE_X_CHANGE:String = "axis_one_x_change";
		public static var AXIS_ONE_Y_CHANGE:String = "axis_one_y_change";
		//axis two
		public static var AXIS_TWO_X_CHANGE:String = "axis_two_x_change";
		public static var AXIS_TWO_Y_CHANGE:String = "axis_two_y_change";
		
		//select
		public static var SELECT_DOWN:String = "select_down";
		public static var SELECT_UP:String = "select_up";
		
		//start
		public static var START_DOWN:String = "start_down";
		public static var START_UP:String = "start_up";
		
		//D-pad
		public static var DPAD_TOP_DOWN:String = "dpad_top_down";
		public static var DPAD_TOP_UP:String = "dpad_top_up";
		public static var DPAD_BOTTOM_DOWN:String = "dpad_bottom_down";
		public static var DPAD_BOTTOM_UP:String = "dpad_bottom_up";
		public static var DPAD_LEFT_DOWN:String = "dpad_left_down";
		public static var DPAD_LEFT_UP:String = "dpad_left_up";
		public static var DPAD_RIGHT_DOWN:String = "dpad_right_down";
		public static var DPAD_RIGHT_UP:String = "dpad_right_up";
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