package game.play;

import flixel.FlxCamera;
import flixel.addons.display.FlxBackdrop;
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
import flixel.util.FlxColor;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;
import flixel.text.FlxText;
import flixel.FlxG;

class PlayState extends State {
	var bg:FlxBackdrop;
	var playerGroup:FlxSpriteGroup;
	var player:FlxSprite;
	var gun:FlxSprite;
	var weapon:FlxTypedWeapon<Bullet>;
	var bullets(default, set):Int = 10;
	var bulletsindicator:FlxText;
	var cam:FlxCamera;

	var sexies:FlxTypedGroup<Sexy>;

	function set_bullets(v) {
		bulletsindicator.text = "BULLETS: " + v;
		return bullets = v;
	}
	override function create() {
		bg = new FlxBackdrop(Paths.image('bg'));
		bg.screenCenter();
		add(bg);
		playerGroup = new FlxSpriteGroup();
		add(playerGroup);
		player = new FlxSprite(Paths.image('cat'));

		gun = new FlxSprite(Paths.image('gun'));
		gun.origin.subtract(15);

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
			bulletsindicator = new FlxText(0, 650, 0, "BULLETS: "+ bullets, 12);
			bulletsindicator.setFormat("VCR OSD Mono", 32, FlxColor.BLACK, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			add(bulletsindicator);
			


			super.create();
	}

	override function update(elapsed:Float) {

		var sourcePoint = player.getPosition().add(player.origin.x / 2, player.origin.y / 2);
		var destinationPoint = sourcePoint.copyTo();

		var speed = 500;
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

		if (FlxG.mouse.justPressed && bullets > 0) {
			bullets --;
			FlxG.sound.play(Paths.sound('cumshot'));
			trace(weapon.fireAtMouse());
		}

		if (controls.justPressed.RELOAD){
			FlxG.sound.play(Paths.sound('reload'));
			trace('anus work');
			bullets = 10;
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