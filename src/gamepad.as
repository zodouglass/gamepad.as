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
 * Embedded Javascript AS3 Gamepad API
 * @author Zo
 * 
 */
public class gamepad extends EventDispatcher
{	
	private var timer:Timer = new Timer(100);
	
	//diction of button arrays sorted by controler id
	private var playerButtons:Dictionary = new Dictionary();
	private var playerAxes:Dictionary = new Dictionary();
 
	public function gamepad():void 
	{
		if ( ExternalInterface.available )
		{
			ExternalInterface.call("console.log", "gamepad constructor" );
			ExternalInterface.addCallback("updateButtons", updateButtons );
			ExternalInterface.addCallback("updateAxes", updateAxes );
			ExternalInterface.addCallback("onGamepadConnect", onGamepadConnect );
			ExternalInterface.addCallback("startTicking", startTicking );
			
			//use embedded js
			//var gamepadResult:String = ExternalInterface.call(JS.gamepadjs);
			
			timer.addEventListener(TimerEvent.TIMER, tick); 
			
			//call js functions, not embedded
			ExternalInterface.call("tester.init");
			ExternalInterface.call("gamepadSupport.init");
			
		}
		else
			trace("Gamepad API can only run in a browser");
	}
	
	public function startTicking():void
	{
		ExternalInterface.call("console.log", "start gamepad" );
		timer.start();
	}
	
	public function tick(e:Event=null):void
	{
		//ExternalInterface.call("console.log", "as ticing" );
		if ( ExternalInterface.available )
			ExternalInterface.call("gamepadSupport.tick");
			//var gamepadtick:String = ExternalInterface.call(JS.tick);
	}
	
	public function onGamepadConnect(gamepads:Array):void
	{
		
		ExternalInterface.call("console.log", "gamepad onGamepadConnect " + gamepads);
		
	}
	public function updateAxes(axes:Array, gamepadId:String ):void
	{
		//trace(axes);
		ExternalInterface.call("console.log", gamepadId + "Axes: " + axes );
		//ExternalInterface.call("console.log", "updateAxes");
		
		for ( var i:int = 0; i < axes.length; i++ )
		{
			if ( playerAxes[gamepadId] ==  null )
				playerAxes[gamepadId] = new Array();
		
			var oldValue:Number = playerAxes[gamepadId][i];
			var newValue:Number = axes[i];
			
			//ExternalInterface.call("console.log", "player_" + gamepadId +"_axis_" + i + "_change"  );
			if (!isNaN(oldValue) && oldValue != newValue ) //button has changed
			{
				
				
				switch( i ) {
					case 0:
							//this.dispatchEvent(new Event("player_" + gamepadId +"_axis_" + i + "_change") );
						this.dispatchEvent(new GamepadEvent(GamepadEvent.PLAYER_0_AXIS_ONE_X_CHANGE, int(gamepadId), newValue));
						break;
					case 1:
						this.dispatchEvent(new GamepadEvent(GamepadEvent.PLAYER_0_AXIS_ONE_Y_CHANGE, int(gamepadId), newValue));
						break;
				}
			
				
				//dispatchButtonEvent(i, oldValue, newValue );
				//this.dispatchEvent(new Event("player" + id +"_button" + index) );
				//save the current button state
				
			}
			playerAxes[gamepadId][i] = newValue;
		}
		
	}
	
	public function updateButtons(buttons:Array, gamepadId:Number ):void
	{
		//trace(buttons);
		//ExternalInterface.call("console.log", "updateButtons");
		ExternalInterface.call("console.log",gamepadId + "Buttons: " +   buttons  );
		//go through each button and compare it to the current button state.
		
		for ( var i:int = 0; i < buttons.length; i++ )
		{
			if ( playerButtons[gamepadId] ==  null )
				playerButtons[gamepadId] = new Array();
		
			var oldValue:Number = playerButtons[gamepadId][i];
			var newValue:Number = buttons[i];
			
			
			if (!isNaN(oldValue) && oldValue != newValue ) //button has changed
			{
				
				//determine if it turned on or off
				//dispatch corrent event
				//TODO
				switch( i ) {
					case 0:
						//ExternalInterface.call("console.log",gamepadId + "ButtonZERO" + i + " CHANGED " +   oldValue + ", " + newValue  );
						if ( newValue == 0 ) //up
						{
							ExternalInterface.call("console.log","player_" + gamepadId +"_button_" + i + "_up"  );
							this.dispatchEvent(new Event("player_" + gamepadId +"_button_" + i + "_up") );
						}
						else //down
						{
							this.dispatchEvent(new Event("player_" + gamepadId +"_button_" + i + "_down") );
							ExternalInterface.call("console.log","player_" + gamepadId +"_button_" + i + "_down" );
						}
						break;
				}
				
				//dispatchButtonEvent(i, oldValue, newValue );
				//this.dispatchEvent(new Event("player" + id +"_button" + index) );
				//save the current button state
				
			}
			playerButtons[gamepadId][i] = newValue;
		}
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
		//updateAxis(gamepad.axes[0], gamepadId, 'stick-1-axis-x', 'stick-1', true);
		//updateAxis(gamepad.axes[1], gamepadId, 'stick-1-axis-y', 'stick-1', false);
		//updateAxis(gamepad.axes[2], gamepadId, 'stick-2-axis-x', 'stick-2', true);
		//updateAxis(gamepad.axes[3], gamepadId, 'stick-2-axis-y', 'stick-2', false);
	}
	
	protected function updateButton(index:int, id:Number):void
	{
		
	}
	
	
	
	
	
 
}
 
}//end gamepad as

/******************************************
 * 				JAVASCRIPT
 *****************************************/
class JS {
	
	static public var tick:XML =
	<script>
	<![CDATA[
	function() 
	{
		var gamepadSupport = 
{
	TYPICAL_BUTTON_COUNT: 16,
	TYPICAL_AXIS_COUNT: 4,
	ticking: false,
	gamepads: [],
	prevRawGamepadTypes: [],
	prevTimestamps: [],
	init: function () {
		console.log("gamepadSupport.init");
		var gamepadSupportAvailable = !! navigator.webkitGetGamepads || !! navigator.webkitGamepads || (navigator.userAgent.indexOf('Firefox/') != -1);
		if (!gamepadSupportAvailable) {
			tester.showNotSupported();
		} else {
			window.addEventListener('MozGamepadConnected', gamepadSupport.onGamepadConnect, false);
			window.addEventListener('MozGamepadDisconnected', gamepadSupport.onGamepadDisconnect, false);
			if ( !! navigator.webkitGamepads || !! navigator.webkitGetGamepads) {
				gamepadSupport.startPolling();
				
			}
		}
	},
	onGamepadConnect: function (event) {
		console.log("js onGamepadConnect");
		gamepadSupport.gamepads.push(event.gamepad);
		//tester.updateGamepads(gamepadSupport.gamepads);
		document.getElementById("AS3Gamepadexample").onGamepadConnect();
		gamepadSupport.startPolling();
	},
	onGamepadDisconnect: function (event) {
		for (var i in gamepadSupport.gamepads) {
			if (gamepadSupport.gamepads[i].index == event.gamepad.index) {
				gamepadSupport.gamepads.splice(i, 1);
				break;
			}
		}
		if(gamepadSupport.gamepads.length == 0) {
			gamepadSupport.stopPolling();
		}
		//tester.updateGamepads(gamepadSupport.gamepads);
	},
	startPolling: function () {
		console.log("js startPolling");
		if (!gamepadSupport.ticking) {
			gamepadSupport.ticking = true;
			document.getElementById("AS3Gamepadexample").startTicking(); //call as3 function to start calling the tick function
		}
	},
	stopPolling: function () {
		gamepadSupport.ticking = false;
	},
	tick: function () {
		gamepadSupport.pollStatus();
		//gamepadSupport.scheduleNextTick();
	},
	scheduleNextTick: function () {
		if (gamepadSupport.ticking) {
			if (window.requestAnimationFrame) {
				window.requestAnimationFrame(gamepadSupport.tick);
			} else if (window.mozRequestAnimationFrame) {
				window.mozRequestAnimationFrame(gamepadSupport.tick);
			} else if (window.webkitRequestAnimationFrame) {
				window.webkitRequestAnimationFrame(gamepadSupport.tick);
			}
		}
	},
	pollStatus: function () {
		gamepadSupport.pollGamepads();
		for (var i in gamepadSupport.gamepads) {
			var gamepad = gamepadSupport.gamepads[i];
			if (gamepad.timestamp && (gamepad.timestamp == gamepadSupport.prevTimestamps[i])) {
				continue;
			}
			gamepadSupport.prevTimestamps[i] = gamepad.timestamp;
			gamepadSupport.updateDisplay(i);
		}
	},
	pollGamepads: function () {
		console.log("pollGamepads");
		var rawGamepads = (navigator.webkitGetGamepads && navigator.webkitGetGamepads()) || navigator.webkitGamepads;
		if (rawGamepads) {
			gamepadSupport.gamepads = [];
			var gamepadsChanged = false;
			for (var i = 0; i < rawGamepads.length; i++) {
				if (typeof rawGamepads[i] != gamepadSupport.prevRawGamepadTypes[i]) {
					gamepadsChanged = true;
					gamepadSupport.prevRawGamepadTypes[i] = typeof rawGamepads[i];
				}
				if(rawGamepads[i]) {
					gamepadSupport.gamepads.push(rawGamepads[i]);
				}
			}
			if(gamepadsChanged) {
				document.getElementById("AS3Gamepadexample").onGamepadConnect();
				//tester.updateGamepads(gamepadSupport.gamepads);
			}
		}
	},
	updateDisplay: function (gamepadId) {
		var gamepad = gamepadSupport.gamepads[gamepadId];
		
		//call as3 function to update button states
		document.getElementById("AS3Gamepadexample").updateButtons(gamepad.buttons, gamepadId); 
		document.getElementById("AS3Gamepadexample").updateAxes(gamepad.axes, gamepadId);
		
		/*tester.updateButton(gamepad.buttons[0], gamepadId, 'button-1');
		tester.updateButton(gamepad.buttons[1], gamepadId, 'button-2');
		tester.updateButton(gamepad.buttons[2], gamepadId, 'button-3');
		tester.updateButton(gamepad.buttons[3], gamepadId, 'button-4');
		tester.updateButton(gamepad.buttons[4], gamepadId, 'button-left-shoulder-top');
		tester.updateButton(gamepad.buttons[6], gamepadId, 'button-left-shoulder-bottom');
		tester.updateButton(gamepad.buttons[5], gamepadId, 'button-right-shoulder-top');
		tester.updateButton(gamepad.buttons[7], gamepadId, 'button-right-shoulder-bottom');
		tester.updateButton(gamepad.buttons[8], gamepadId, 'button-select');
		tester.updateButton(gamepad.buttons[9], gamepadId, 'button-start');
		tester.updateButton(gamepad.buttons[10], gamepadId, 'stick-1');
		tester.updateButton(gamepad.buttons[11], gamepadId, 'stick-2');
		tester.updateButton(gamepad.buttons[12], gamepadId, 'button-dpad-top');
		tester.updateButton(gamepad.buttons[13], gamepadId, 'button-dpad-bottom');
		tester.updateButton(gamepad.buttons[14], gamepadId, 'button-dpad-left');
		tester.updateButton(gamepad.buttons[15], gamepadId, 'button-dpad-right');
		tester.updateAxis(gamepad.axes[0], gamepadId, 'stick-1-axis-x', 'stick-1', true);
		tester.updateAxis(gamepad.axes[1], gamepadId, 'stick-1-axis-y', 'stick-1', false);
		tester.updateAxis(gamepad.axes[2], gamepadId, 'stick-2-axis-x', 'stick-2', true);
		tester.updateAxis(gamepad.axes[3], gamepadId, 'stick-2-axis-y', 'stick-2', false);
		
		var extraButtonId = gamepadSupport.TYPICAL_BUTTON_COUNT;
		while (typeof gamepad.buttons[extraButtonId] != 'undefined') {
			tester.updateButton(gamepad.buttons[extraButtonId], gamepadId, 'extra-button-' + extraButtonId);
			extraButtonId++;
		}
		var extraAxisId = gamepadSupport.TYPICAL_AXIS_COUNT;
		while (typeof gamepad.axes[extraAxisId] != 'undefined') {
			tester.updateAxis(gamepad.axes[extraAxisId], gamepadId, 'extra-axis-' + extraAxisId);
			extraAxisId++;
		}
		*/
	}
};
	}
	]]>
	</script>;
}
