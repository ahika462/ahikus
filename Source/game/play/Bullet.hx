package game.play;

import game.system.Paths;
import flixel.addons.weapon.FlxBullet;

class Bullet extends FlxBullet {
	public function new() {
		super();
		loadGraphic(Paths.image('bullet'));
	}
}