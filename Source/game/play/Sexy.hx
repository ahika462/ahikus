package game.play;

import flixel.math.FlxVelocity;
import game.system.Paths;
import flixel.FlxSprite;

class Sexy extends FlxSprite {
	public var target:FlxSprite;

	public function new(x = 0, y = 0, target:FlxSprite) {
		super(x, y, Paths.image('sexbomba'));
		this.target = target;
	}

	override function update(elapsed:Float) {
		var distance = getMidpoint().distanceTo(target.getMidpoint());

		if (distance > 30)
			FlxVelocity.moveTowardsPoint(this, target.getMidpoint(), 150);
		else
			velocity.set();

		if (velocity.x > 0) flipX = false;
		if (velocity.x < 0) flipX = true;
		
		super.update(elapsed);
	}
}