package game.play;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.weapon.FlxWeapon.FlxWeaponSpeedMode;
import flixel.util.helpers.FlxBounds;
import flixel.addons.weapon.FlxWeapon.FlxWeaponFireFrom;
import flixel.addons.weapon.FlxWeapon.FlxTypedWeapon;
import flixel.effects.particles.FlxEmitter;
import flixel.math.FlxMath;
import flixel.math.FlxAngle;
import game.system.Paths;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;
import flixel.text.FlxText;
import flixel.FlxG;

class PlayState extends State {
	var playerGroup:FlxSpriteGroup;
	var player:FlxSprite;
	var gun:FlxSprite;
	var weapon:FlxTypedWeapon<Bullet>;

	var sexies:FlxTypedGroup<Sexy>;

	override function create() {
		playerGroup = new FlxSpriteGroup();
		add(playerGroup);

		player = new FlxSprite(Paths.image('cat'));

		gun = new FlxSprite(Paths.image('gun'));
		// gun.origin.subtract(25);

		playerGroup.add(player);
		playerGroup.screenCenter();

		playerGroup.add(gun);

		weapon = new FlxTypedWeapon('gun', (_) -> new Bullet(),
			FlxWeaponFireFrom.PARENT(player, new FlxBounds<FlxPoint>(
				FlxPoint.get(player.width * 0.5, player.height * 0.5),
				FlxPoint.get(player.width * 0.5, player.height * 0.5))),
			FlxWeaponSpeedMode.SPEED(new FlxBounds<Float>(500, 500)));
		weapon.rotateBulletTowardsTarget = true;

		sexies = new FlxTypedGroup();
		add(sexies);

		var sexy = new Sexy(playerGroup);
		sexies.add(sexy);
		
		super.create();
	}

	override function update(elapsed:Float) {
		var sourcePoint = player.getPosition().add(player.origin.x / 2, player.origin.y / 2);
		var destinationPoint = sourcePoint.copyTo();

		var speed = 300;

		if (controls.pressed.UP) destinationPoint.y -= speed;
		if (controls.pressed.DOWN) destinationPoint.y += speed;
		
		if (controls.pressed.LEFT) destinationPoint.x -= speed;
		if (controls.pressed.RIGHT) destinationPoint.x += speed;

		if (sourcePoint.distanceTo(destinationPoint) > 0)
			FlxVelocity.moveTowardsPoint(playerGroup, destinationPoint, speed);
		else
			playerGroup.velocity.set();

		if (playerGroup.velocity.x > 0) player.flipX = false;
		if (playerGroup.velocity.x < 0) player.flipX = true;

		/*var viewAngle = FlxAngle.degreesBetweenMouse(gun);
		gun.angle = FlxMath.lerp(gun.angle, viewAngle, 0.16);*/

		gun.angle = FlxAngle.degreesBetweenMouse(gun);

		gun.flipY = !FlxMath.inBounds(gun.angle, -90, 90);

		if (FlxG.mouse.justPressed) {
			FlxG.sound.play(Paths.sound('cumshot'));
			trace(weapon.fireAtMouse());
		}

		super.update(elapsed);

		weapon.group.forEachAlive((bullet) -> bullet.update(elapsed));

		sexies.forEachAlive((sexy) -> {
			for (bullet in weapon.group) {
				if (FlxG.overlap(sexy, bullet)) {
					sexy.kill();
					bullet.kill();
				}
			}
		});
	}

	override function draw() {
		super.draw();
		weapon.group.forEachAlive((bullet) -> bullet.draw());
	}
}