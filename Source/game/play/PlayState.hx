package game.play;

import flixel.FlxObject;
import flixel.tweens.FlxTween;
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
	var gameCamera:FlxCamera;
	var hudCamera:FlxCamera;

	var bg:FlxBackdrop;
	var playerGroup:FlxSpriteGroup;
	var player:FlxSprite;
	var gun:Gun;

	var bulletsGroup:FlxTypedGroup<FlxSprite>;
	var bullets(default, set):Int = 10;
	var bulletsindicator:FlxText;

	var cam:FlxCamera;

	var playerPoint:FlxObject;

	var sexies:FlxTypedGroup<Sexy>;

	function set_bullets(v) {
		bulletsindicator.text = "BULLETS: " + v;
		return bullets = v;
	}
	override function create() {
		gameCamera = new FlxCamera();
		FlxG.cameras.reset(gameCamera);

		hudCamera = new FlxCamera();
		hudCamera.bgColor = 0x00000000;
		FlxG.cameras.add(hudCamera, false);

		bg = new FlxBackdrop(Paths.image('bg'));
		bg.screenCenter();
		add(bg);

		FlxG.sound.playMusic(Paths.music('gun_battle'));

		playerGroup = new FlxSpriteGroup();
		add(playerGroup);

		player = new FlxSprite(Paths.image('cat'));

		bulletsGroup = new FlxTypedGroup();
		add(bulletsGroup);

		gun = new Gun(bulletsGroup, Paths.image('gun'));
		gun.origin.set(47, 87);

		playerGroup.add(player);
		playerGroup.screenCenter();

		playerGroup.add(gun);
	
		playerPoint = new FlxObject();

		sexies = new FlxTypedGroup();
		add(sexies);

		var sexy = new Sexy(playerGroup);
		sexies.add(sexy);
		bulletsindicator = new FlxText(0, 650, 0, "BULLETS: "+ bullets, 12);
		bulletsindicator.setFormat(32, FlxColor.BLACK, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		bulletsindicator.cameras = [hudCamera];
		add(bulletsindicator);

		FlxG.camera.follow(playerPoint);
	}

	override function update(elapsed:Float) {
		var speed = 500.0;
		
		var movePoint = FlxPoint.get();

		if (controls.pressed.UP) movePoint.y -= speed;
		if (controls.pressed.DOWN) movePoint.y += speed;
		
		if (controls.pressed.LEFT) movePoint.x -= speed;
		if (controls.pressed.RIGHT) movePoint.x += speed;

		move(movePoint, speed);

		if (playerGroup.velocity.x > 0) player.flipX = false;
		if (playerGroup.velocity.x < 0) player.flipX = true;

		player.updateHitbox();
		if (player.flipX) player.offset.x += 32;

		playerPoint.setPosition(player.getMidpoint().x, player.getMidpoint().y);

		gun.angle = FlxAngle.degreesBetweenMouse(playerPoint);

		gun.flipY = !FlxMath.inBounds(gun.angle, -90, 90);

		gun.origin.set(47, 87);
		gun.offset.set(-0.5 * (gun.width - gun.frameWidth), -0.5 * (gun.height - gun.frameHeight) - 6);
		if (gun.flipY) {
			gun.origin.y = gun.height - gun.origin.y;
			gun.offset.set(gun.offset.x - 24, gun.offset.y - 14);
		}

		if (FlxG.mouse.justPressed && bullets > 0) {
			bullets --;
			FlxG.sound.play(Paths.sound('cumshot'));
			gun.fire();
		}

		if (controls.justPressed.RELOAD){
			FlxG.sound.play(Paths.sound('reload'));
			trace('anus work');
			bullets = 10;
		}

		if (controls.justPressed.LOSE) lose();

		super.update(elapsed);

		sexies.forEachAlive((sexy) -> {
			for (bullet in bulletsGroup.members) {
				if (FlxG.overlap(sexy, bullet)) {
					sexy.kill();
					bullet.kill();

					var emitter = new FlxEmitter(sexy.getMidpoint().x, sexy.getMidpoint().y);
					emitter.start(false, 0.01);
					emitter.acceleration.set(-100, 200, 100, 400, -200, 300, 200, 500);
					emitter.makeParticles(2, 2, 0xFFFF0000);
					add(emitter);
				}
			}
		});
	}

	function lose() {
		openSubState(new LoserState(playerGroup));
	}

	function move(target:FlxPoint, speed:Float) {
		var a = FlxAngle.angleBetweenPoint(playerGroup, target.addPoint(playerGroup.getPosition()));
		playerGroup.velocity.x = FlxMath.fastCos(a) * speed;
		playerGroup.velocity.y = FlxMath.fastSin(a) * speed;
	}
}