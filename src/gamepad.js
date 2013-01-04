var FLASH_GAME_OBJECT_ID = "swfContent";

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
			//todo - call flash function, browserNotSupported
			console.log("gamepad.js: Broswer not supported");
		} else {
			//todo - call flash function, browserSupported
			console.log("gamepad.js: Broswer IS supported");
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
		document.getElementById(FLASH_GAME_OBJECT_ID).onGamepadConnect(gamepadSupport.gamepads);
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
			document.getElementById(FLASH_GAME_OBJECT_ID).startTicking(); //call as3 function to start calling the tick function
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
				document.getElementById(FLASH_GAME_OBJECT_ID).onGamepadConnect(gamepadSupport.gamepads);
				//tester.updateGamepads(gamepadSupport.gamepads);
			}
		}
	},
	updateDisplay: function (gamepadId) {
		var gamepad = gamepadSupport.gamepads[gamepadId];
		
		//call as3 function to update button states
		document.getElementById(FLASH_GAME_OBJECT_ID).updateButtons(gamepad.buttons, gamepadId); 
		document.getElementById(FLASH_GAME_OBJECT_ID).updateAxes(gamepad.axes, gamepadId);
		
	}
};
