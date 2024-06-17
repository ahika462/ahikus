package game.input;

import game.input.Controls.Control;

@:build(game.input.ControlsMacro.build())
class ControlsInput {
	final controls:Controls;

	public function new(controls:Controls) {
		this.controls = controls;
	}

	public dynamic function check(control:Control):Bool {
		return false;
	}
}