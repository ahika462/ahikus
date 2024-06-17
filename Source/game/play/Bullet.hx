package game.play;

import flixel.addons.weapon.FlxBullet;

class Bullet extends FlxBullet {
	public function new() {
		super();
		makeGraphic(10, 10);
	}
}