package game.ui;

import flixel.FlxG;
import haxe.ui.core.Component;
import game.system.Paths;
import haxe.ui.RuntimeComponentBuilder;

class AboutUs extends State {
	var component:Component;

	override function create() {
		component = RuntimeComponentBuilder.fromAsset(Paths.data('aboutus.xml'));
		if (component != null) {
			component.setPosition(100, FlxG.height * 0.8);
			add(component);
		}
	}

	override function update(elapsed:Float) {
		component.y -= 50 * elapsed;

		if (!component.isOnScreen()) FlxG.switchState(game.ui.Menu.new);

		super.update(elapsed);
	}
}