package 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
 
/**
 * AS3 JS Gamepad wrapper class
 * 
 * Usage:
	 * Gamepad.init();
	 * Gamepad.playerOne.addEventListener(GamepadEvent.START_DOWN, onStartPress );
 * @author Zo
 * 
 */
public class Gamepad
{	
	//how often we poll javascript to get the gamepad states
	private static var timer:Timer = new Timer(100);
	
	//diction of button arrays sorted by controler id
	private static var playerButtons:Dictionary = new Dictionary();
	private static var playerAxes:Dictionary = new Dictionary();
	
	public static var playerOne:EventDispatcher = new EventDispatcher();
	public static var playerTwo:EventDispatcher = new EventDispatcher();
	public static var playerThree:EventDispatcher = new EventDispatcher();
	public static var playerFour:EventDispatcher = new EventDispatcher();
	
	protected static var initilized:Boolean = false;
	
	
	public function Gamepad():void 
	{
		throw new Error("Dont create a new Gamepad object.  Add event listeners to static public variables playerOne, playerTwo, etc., after calling Gamepad.init();")
	}
	
	public static function init():void
	{
		if ( ExternalInterface.available  && !initilized)
		{
			ExternalInterface.call("console.log", "gamepad constructor" );
			ExternalInterface.addCallback("updateButtons", updateButtons );
			ExternalInterface.addCallback("updateAxes", updateAxes );
			ExternalInterface.addCallback("onGamepadConnect", onGamepadConnect );
			ExternalInterface.addCallback("startTicking", startTicking );
			
			timer.addEventListener(TimerEvent.TIMER, tick); 
			
			//call js functions, not embedded
			ExternalInterface.call("gamepadSupport.init");
			
			initilized = true;
			
		}
		else
			trace("Gamepad API can only run in a browser");
	}
 
	
	protected static function startTicking():void
	{
		ExternalInterface.call("console.log", "start gamepad" );
		timer.start();
	}
	
	protected static function tick(e:Event=null):void
	{
		//ExternalInterface.call("console.log", "as ticing" );
		if ( ExternalInterface.available )
			ExternalInterface.call("gamepadSupport.tick");
			//var gamepadtick:String = ExternalInterface.call(JS.tick);
	}
	
	protected static function onGamepadConnect(gamepads:Array):void
	{
		ExternalInterface.call("console.log", "gamepad.as onGamepadConnect " + gamepads);
		
		playerOne.dispatchEvent(new GamepadEvent(GamepadEvent.CONNECT, 0, 1 ));
	}
	protected static function updateAxes(axes:Array, gamepadId:String ):void
	{
		for ( var i:int = 0; i < axes.length; i++ )
		{
			if ( playerAxes[gamepadId] ==  null )
				playerAxes[gamepadId] = new Array();
		
			var oldValue:Number = playerAxes[gamepadId][i];
			var newValue:Number = axes[i];
			
			//check if the axis has changed
			if (!isNaN(oldValue) && oldValue != newValue ) 
				axisChange(i, Number(gamepadId), newValue);
				
			//save the current axis state
			playerAxes[gamepadId][i] = newValue;
		}
		
	}
	
	protected static function axisChange(i:int, gamepadId:Number, newValue:Number):void
	{
		//ExternalInterface.call("console.log", "axisChange " + gamepadId + " " + newValue );
		switch( i ) {
			case 0:
				dispatchGamepadEvent(GamepadEvent.AXIS_ONE_X_CHANGE, int(gamepadId), newValue);
				break;
			case 1:
				dispatchGamepadEvent(GamepadEvent.AXIS_ONE_Y_CHANGE, int(gamepadId), newValue);
				break;
			case 2:
				dispatchGamepadEvent(GamepadEvent.AXIS_TWO_X_CHANGE, int(gamepadId), newValue);
				break;
			case 3:
				dispatchGamepadEvent(GamepadEvent.AXIS_TWO_Y_CHANGE, int(gamepadId), newValue);
				break;
		}
	}
	
	protected static function updateButtons(buttons:Array, gamepadId:Number ):void
	{
		//ExternalInterface.call("console.log",gamepadId + "Buttons: " +   buttons  );
		//go through each button and compare it to the current button state
		for ( var i:int = 0; i < buttons.length; i++ )
		{
			if ( playerButtons[gamepadId] ==  null )
				playerButtons[gamepadId] = new Array();
		
			var oldValue:Number = playerButtons[gamepadId][i];
			var newValue:Number = buttons[i];
			
			//check if the button has changed
			if (!isNaN(oldValue) && oldValue != newValue ) 
				buttonChange(i, gamepadId, newValue );
				
			//save the current button state
			playerButtons[gamepadId][i] = newValue;
		}
		
	}
	
	protected static function buttonChange(i:int, gamepadId:uint, newValue:Number ):void
	{
		//ExternalInterface.call("console.log", "buttonChange " + gamepadId + " " + newValue );
		//determine which button has changed
		switch( i ) {
			case 0:
			case 1:
			case 2:
			case 3:
			default:
				if ( newValue == 0 ) //up
					dispatchGamepadEvent("button_" + i + "_up", gamepadId, newValue );
				else //down
					dispatchGamepadEvent("button_" + i + "_down", gamepadId, newValue );
				break;
			//left bumper	
			case 4:
				if ( newValue == 0 )
					dispatchGamepadEvent(GamepadEvent.LEFT_BUTTON_UP, int(gamepadId), newValue);
				else
					dispatchGamepadEvent(GamepadEvent.LEFT_BUTTON_DOWN, int(gamepadId), newValue);
				break;
			//right bumper
			case 5:
				if ( newValue == 0 ) 
					dispatchGamepadEvent(GamepadEvent.RIGHT_BUTTON_UP, int(gamepadId), newValue);
				else
					dispatchGamepadEvent(GamepadEvent.RIGHT_BUTTON_DOWN, int(gamepadId), newValue);
				break;
			//left trigger
			case 6:
				dispatchGamepadEvent(GamepadEvent.LEFT_TRIGGER_CHANGE, int(gamepadId), newValue);
				break;
			//right trigger
			case 7:
				dispatchGamepadEvent(GamepadEvent.RIGHT_TRIGGER_CHANGE, int(gamepadId), newValue);
				break;
			
			//select
			case 8:
				if ( newValue == 0 )
					dispatchGamepadEvent(GamepadEvent.SELECT_UP, int(gamepadId), newValue);
				else
					dispatchGamepadEvent(GamepadEvent.SELECT_DOWN, int(gamepadId), newValue);
				break;
			//start
			case 9:
				if ( newValue == 0 )
					dispatchGamepadEvent(GamepadEvent.START_UP, int(gamepadId), newValue);
				else
					dispatchGamepadEvent(GamepadEvent.START_DOWN, int(gamepadId), newValue);
				break;
				
			//dpad-top
			case 12:
				if ( newValue == 0 )
					dispatchGamepadEvent(GamepadEvent.DPAD_TOP_UP, int(gamepadId), newValue);
				else
					dispatchGamepadEvent(GamepadEvent.DPAD_TOP_DOWN, int(gamepadId), newValue);
				break;
			//dpad-bottom
			case 13:
				if ( newValue == 0 )
					dispatchGamepadEvent(GamepadEvent.DPAD_BOTTOM_UP, int(gamepadId), newValue);
				else
					dispatchGamepadEvent(GamepadEvent.DPAD_BOTTOM_DOWN, int(gamepadId), newValue);
				break;
				break;
			//dpad left
			case 14:
				if ( newValue == 0 )
					dispatchGamepadEvent(GamepadEvent.DPAD_LEFT_UP, int(gamepadId), newValue);
				else
					dispatchGamepadEvent(GamepadEvent.DPAD_LEFT_DOWN, int(gamepadId), newValue);
				break;
				break;
			//dpad right
			case 15:
				if ( newValue == 0 )
					dispatchGamepadEvent(GamepadEvent.DPAD_RIGHT_UP, int(gamepadId), newValue);
				else
					dispatchGamepadEvent(GamepadEvent.DPAD_RIGHT_DOWN, int(gamepadId), newValue);
				break;
				break;
		}
	}
	
	protected static function dispatchGamepadEvent(name:String, gamepadId:uint, value:Number):void
	{
		switch( gamepadId )
		{
			case 0:
				playerOne.dispatchEvent(new GamepadEvent(name, gamepadId, value ));
				break;
			case 1:
				playerTwo.dispatchEvent(new GamepadEvent(name, gamepadId, value ));
				break;
			case 2:
				playerThree.dispatchEvent(new GamepadEvent(name, gamepadId, value ));
				break;
			case 3:
				playerFour.dispatchEvent(new GamepadEvent(name, gamepadId, value ));
				break;
			default:
				playerOne.dispatchEvent(new GamepadEvent(name, gamepadId, value ));
				break;
		}
	}
}//end class
 
}//end package