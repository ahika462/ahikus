package game.ui;

import flixel.FlxG;
import haxe.ui.core.Component;
import game.system.Paths;
import haxe.ui.RuntimeComponentBuilder;

class AboutUs extends State {
	var component:Component;

	override function create() {
		FlxG.sound.playMusic(Paths.music('credits'));

		component = RuntimeComponentBuilder.fromAsset(Paths.data('aboutus.xml'));
		if (component != null) {
			component.setPosition(100, FlxG.height * 0.8);
			add(component);
		}
	}

	override function update(elapsed:Float) {
		if (component != null) {
			component.y -= 50 * elapsed;
			if (component.y < -component.height) component.y = FlxG.height;
		}

		if (controls.justPressed.BACK) FlxG.switchState(Menu.new);

		super.update(elapsed);
	}
}