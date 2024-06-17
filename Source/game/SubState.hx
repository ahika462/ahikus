package game;

import flixel.FlxG;
import game.input.Controls;
import flixel.FlxSubState;

class SubState extends FlxSubState {
	var controls:Controls;

	public function new() {
		super();
		controls = new Controls(FlxG.keys);
	}
}