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
	public var keyboardBindings:Map<Control, Array<FlxKey>> = [
		UP     => [W],
		DOWN   => [S],
		LEFT   => [A],
		RIGHT  => [D],
		RELOAD => [E],
		LOSE   => [Q],
		ACCEPT => [SPACE, ENTER, Z],
		BACK   => [ESCAPE, X, BACKSPACE]
	];

	public var gamepadBindings:Map<Control, Array<FlxGamepadInputID>> = [
		UP    => [DPAD_UP],
		DOWN  => [DPAD_DOWN],
		LEFT  => [DPAD_LEFT],
		RIGHT => [DPAD_RIGHT]
	];

	public var keyboard:FlxKeyboard;
	public var gamepad:FlxGamepad;

	public var justPressed:ControlsInput;
	public var pressed:ControlsInput;
	public var justReleased:ControlsInput;

	public function new(?keyboard:FlxKeyboard, ?gamepad:FlxGamepad) {
		this.keyboard = keyboard;
		this.gamepad = gamepad;
		
		justPressed = new ControlsInput(this);
		justPressed.check = (control:Control) -> keyboard.anyJustPressed(keyboardBindings.get(control) ?? []) || gamepad.anyJustPressed(gamepadBindings.get(control) ?? []);

		pressed = new ControlsInput(this);
		pressed.check = (control:Control) -> keyboard.anyPressed(keyboardBindings.get(control) ?? []) || gamepad.anyPressed(gamepadBindings.get(control) ?? []);

		justReleased = new ControlsInput(this);
		justReleased.check = (control:Control) -> keyboard.anyJustReleased(keyboardBindings.get(control) ?? []) || gamepad.anyJustReleased(gamepadBindings.get(control) ?? []);
	}
}