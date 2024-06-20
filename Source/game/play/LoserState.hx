package game.play;

import flixel.addons.display.FlxBackdrop;
import flixel.FlxObject;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import game.system.Paths;
import flixel.FlxSprite;

class LoserState extends SubState {
	var zoomOut = false;
	var target:FlxObject;

	var bg:FlxBackdrop;

	public function new(target:FlxObject) {
		super();
		this.target = target;
	}

	override function create() {
		bg = new FlxBackdrop(FlxG.bitmap.create(FlxG.width, FlxG.height, 0xFF000000));
		bg.alpha = 0.45;
		add(bg);

		add(target);

		FlxG.camera.follow(target);
		FlxG.camera.zoom = 2;

		FlxG.sound.music.stop();
		FlxG.sound.play(Paths.sound('lose'));
		
		FlxTween.tween(FlxG.camera, {zoom: 1.5}, 0.3, {ease: FlxEase.cubeOut});
		new FlxTimer().start(2, (tmr) -> {
			zoomOut = true;
			FlxG.sound.playMusic(Paths.music('lose'));
		});
	}

	override function update(elapsed:Float) {
		if (zoomOut) {
			var delta = elapsed * 0.03;
			if (FlxG.camera.zoom > 0) FlxG.camera.zoom -= delta;
			if (FlxG.camera.zoom < 0) FlxG.camera.zoom = 0;

			if (bg.alpha < 1) bg.alpha += delta;
			if (bg.alpha > 1) bg.alpha = 1;
		}

		if (controls.justPressed.ACCEPT) {
			zoomOut = false;
			FlxTween.tween(FlxG.camera, {zoom: 1.5}, 1, {ease: FlxEase.cubeOut, onComplete: (twn) -> {
				new FlxTimer().start(1, (tmr) -> {
					FlxG.camera.fade(0xFF000000, 2, () -> FlxG.resetState());
				});
			}});
		}

		super.update(elapsed);
	}
}