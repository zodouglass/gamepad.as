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
		document.getElementById("AS3Gamepadexample").onGamepadConnect(gamepadSupport.gamepads);
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
				document.getElementById("AS3Gamepadexample").onGamepadConnect(gamepadSupport.gamepads);
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


/*

var tester = 
{
	VISIBLE_THRESHOLD: 0.1,
	STICK_OFFSET: 25,
	ANALOGUE_BUTTON_THRESHOLD: .5,
	init: function () {
		tester.updateGamepads();
	},
	showNotSupported: function () {
		document.querySelector('#no-gamepad-support').classList.add('visible');
	},
	updateGamepads: function (gamepads) {
		var els = document.querySelectorAll('#gamepads > :not(.template)');
		for (var i = 0, el; el = els[i]; i++)
		{
			el.parentNode.removeChild(el);
		}
		var padsConnected = false;
		if (gamepads) {
			for (var i in gamepads) 
			{
				var gamepad = gamepads[i];
				if (gamepad) 
				{
					var el = document.createElement('li');
					el.innerHTML = document.querySelector('#gamepads > .template').innerHTML;
					el.id = 'gamepad-' + i;
					el.querySelector('.name').innerHTML = gamepad.id;
					el.querySelector('.index').innerHTML = gamepad.index;
					document.querySelector('#gamepads').appendChild(el);
					var extraButtonId = gamepadSupport.TYPICAL_BUTTON_COUNT;
					while (typeof gamepad.buttons[extraButtonId] != 'undefined') {
						var labelEl = document.createElement('label');
						labelEl.setAttribute('for', 'extra-button-' + extraButtonId);
						labelEl.setAttribute('description', 'Extra button');
						labelEl.setAttribute('access', 'buttons[' + extraButtonId + ']');
						el.querySelector('.extra-inputs').appendChild(labelEl);
						extraButtonId++;
					}
					var extraAxisId = gamepadSupport.TYPICAL_AXIS_COUNT;
					while (typeof gamepad.axes[extraAxisId] != 'undefined') {
						var labelEl = document.createElement('label');
						labelEl.setAttribute('for', 'extra-axis-' + extraAxisId);
						labelEl.setAttribute('description', 'Extra axis');
						labelEl.setAttribute('access', 'axes[' + extraAxisId + ']');
						el.querySelector('.extra-inputs').appendChild(labelEl);
						extraAxisId++;
					}
					padsConnected = true;
				}
			}
		}
		if (padsConnected) {
			document.getElementById("AS3Gamepadexample").onPadsConnected();
			//document.querySelector('#no-gamepads-connected').classList.remove('visible');
		} else {
			console.log("not connected");
			//document.getElementById("AS3Gamepadexample").onPadsNotConnected();
			//document.querySelector('#no-gamepads-connected').classList.add('visible');
		}
	}
};

*/

//MAIN JAVASCRIPT
//console.log("main js", tester);
//tester.init();
//console.log("gamepadSupport init");
//gamepadSupport.init();