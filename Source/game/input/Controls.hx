package game.input;

import flixel.input.gamepad.FlxGamepad;
import flixel.input.keyboard.FlxKeyboard;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;

enum Control {
	UP;
	DOWN;
	LEFT;
	RIGHT;
	RELOAD;
	LOSE;
	ACCEPT;
	BACK;
}

class Controls {
	public var keyboardBindings(get, never):Map<Control, FlxKey>;
	inline function get_keyboardBindings() return Preferences.keyboardBindings;

	public var keyboard:FlxKeyboard;

	public var justPressed:ControlsInput;
	public var pressed:ControlsInput;
	public var justReleased:ControlsInput;

	public function new(?keyboard:FlxKeyboard) {
		this.keyboard = keyboard;
		
		justPressed = new ControlsInput(this);
		justPressed.check = (control:Control) -> keyboard.anyJustPressed(getKeyboardBinding(control));

		pressed = new ControlsInput(this);
		pressed.check = (control:Control) -> keyboard.anyPressed(getKeyboardBinding(control));

		justReleased = new ControlsInput(this);
		justReleased.check = (control:Control) -> keyboard.anyJustReleased(getKeyboardBinding(control));
	}

	function getKeyboardBinding(control:Control):Array<FlxKey> {
		if (keyboardBindings.exists(control)) return [keyboardBindings[control]];
		else return [];
	}
}