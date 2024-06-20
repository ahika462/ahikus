package game.ui.options;

import flixel.FlxG;
import game.input.Controls.Control;
import flixel.group.FlxGroup.FlxTypedGroup;

class Options extends State {
	var options:FlxTypedGroup<ControlCustom>;

	override function create() {
		options = new FlxTypedGroup();
		add(options);

		var constructors = Control.getConstructors();
		for (i in 0...constructors.length) {
			var option = new ControlCustom(100, 200 + i * 50, Control.createByName(constructors[i]));
			options.add(option);
		}
	}

	override function update(elapsed:Float) {
		if (controls.justPressed.BACK) {
			Preferences.flush();
			FlxG.switchState(game.ui.Menu.new);
		}
		
		super.update(elapsed);
	}
}