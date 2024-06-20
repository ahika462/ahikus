package game;

import flixel.FlxG;
import flixel.input.keyboard.FlxKey;
import game.input.Controls.Control;

class Preferences {
	public static var keyboardBindings:Map<Control, FlxKey> = [
		UP     => W,
		DOWN   => S,
		LEFT   => A,
		RIGHT  => D,
		RELOAD => R,
		LOSE   => G,
		ACCEPT => SPACE,
		BACK   => ESCAPE
	];

	public static function flush() {
		FlxG.save.bind('ahikus');
		FlxG.save.data.keyboardBindings = keyboardBindings;
		FlxG.save.flush();
	}

	public static function bind() {
		FlxG.save.bind('ahikus');
		if (FlxG.save.data.keyboardBindinds != null) keyboardBindings = FlxG.save.data.keyboardBindings;
	}
}