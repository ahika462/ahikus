package game.ui;

import haxe.ui.components.Switch;
import flixel.FlxSprite;
import game.system.Paths;
import haxe.ui.RuntimeComponentBuilder;
import haxe.ui.core.Component;

class Options extends State {
	var component:Component;

	override function create() {
		component = RuntimeComponentBuilder.fromAsset(Paths.data('options.xml'));
		if (component != null) {
			component.setPosition(100, 100);
			add(component);

			component.antialiasing = false;
			for (child in component.findComponents()) child.antialiasing = false;
		}
	}

	override function destroy() {
		FlxSprite.defaultAntialiasing = component.findComponent('antialiasing', Switch).selected;
		super.destroy();
	}
}