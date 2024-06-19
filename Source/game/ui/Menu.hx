package game.ui;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import game.system.Paths;
import flixel.FlxSprite;

class Menu extends State {
	override function create(){
		var bg = new FlxSprite(Paths.image('bgmenu'));
		bg.screenCenter();
		add(bg);

		var logo = new FlxSprite(20, 20, Paths.image('logo'));
		logo.setGraphicSize(logo.width * 1.6);
		logo.updateHitbox();
		add(logo);

		var cat = new FlxSprite(FlxG.width * 0.4, 700, Paths.image('catcreep'));
		cat.setGraphicSize(cat.width * 1.4);
		cat.updateHitbox();
		cat.offset.y -= 45 * cat.scale.y;
		add(cat);

		FlxTween.tween(cat, {y: FlxG.height - cat.height}, 1.5, {ease: FlxEase.cubeOut});
	}

	override function update(elapsed:Float) {
		if (FlxG.keys.justPressed.ENTER) FlxG.switchState(game.play.PlayState.new);

		super.update(elapsed);
	}
}