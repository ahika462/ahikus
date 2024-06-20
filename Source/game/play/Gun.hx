package game.play;

import flixel.math.FlxVelocity;
import flixel.group.FlxGroup.FlxTypedGroup;
import game.system.Paths;
import flixel.math.FlxAngle;
import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;
import game.input.Controls;
import flixel.FlxSprite;

class Gun extends FlxSprite {
	var group:FlxTypedGroup<FlxSprite>;
	var speed = 600.0;

	public function new(x = 0.0, y = 0.0, group:FlxTypedGroup<FlxSprite>, ?simpleGraphic:FlxGraphicAsset) {
		super(x, y, simpleGraphic);
		this.group = group;
	}

	public function fire() {
		var rotation = angle * FlxAngle.TO_RAD;

		var spawnPoint = FlxPoint.get(x + origin.x, y + origin.y);
		/*spawnPoint.x += Math.cos(rotation) * 145;
		spawnPoint.y += Math.sin(rotation) * 91;*/

		var bullet = new FlxSprite(spawnPoint.x, spawnPoint.y, Paths.image('bullet'));
		group.add(bullet);

		var targetPoint = FlxG.mouse.getWorldPosition(camera);
		FlxVelocity.moveTowardsPoint(bullet, targetPoint, speed);
		bullet.angle = FlxAngle.degreesBetweenPoint(bullet, targetPoint);
	}
}