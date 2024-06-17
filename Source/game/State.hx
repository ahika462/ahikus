package game;

import flixel.FlxG;
import game.input.Controls;
import flixel.FlxState;

class State extends FlxState {
	var controls:Controls;

	public function new() {
		super();
		controls = new Controls(FlxG.keys);
	}
}