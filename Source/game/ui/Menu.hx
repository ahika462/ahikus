package game.ui;

import game.system.Data;
import flixel.math.FlxMath;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxCamera;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import game.system.Paths;
import flixel.FlxSprite;

class Menu extends State {
	final buttons = [
		'play',
		'options',
		'about us'
	];
	var curSelection = 0;
	var buttonsGroup:FlxSpriteGroup;

	override function create() {
		FlxG.camera.fade(0xFF000000, 1, true);
		
		var bg = new FlxSprite(Paths.image('menu/bgmenu'));
		bg.screenCenter();
		add(bg);

		var logo = new FlxSprite(20, 20, Paths.image('menu/logo'));
		logo.setGraphicSize(logo.width * 1.6);
		logo.updateHitbox();
		add(logo);

		var randBoob = Data.sexbombs.all[FlxG.random.int(0, Data.sexbombs.all.length - 1)].id;

		var cat = new FlxSprite(FlxG.width * 0.5, FlxG.height, Paths.image('menu/catcreep'));
		cat.setGraphicSize(cat.width * 1.4);
		cat.updateHitbox();
		cat.offset.y -= 45 * cat.scale.y;
		add(cat);

		var booba = new FlxSprite(cat.x, FlxG.height, Paths.image('menu/boobas/$randBoob'));
		booba.setGraphicSize(booba.width * 1.4);
		booba.updateHitbox();
		booba.offset.x -= booba.scale.y * switch(randBoob.toString()) {
			case 'zibidi': 150;
			case 'witch': -50;
			case 'rofos': -50;
			case 'lolartist': 200;
			default: 0;
		}
		booba.offset.y -= booba.scale.y * switch(randBoob.toString()) {
			case 'zibidi': 38;
			case 'witch': 23;
			case 'rofos': 27;
			case 'lolartist': 31;
			case 'hopka': 30;
			default: 0;
		};
		insert(members.indexOf(cat), booba);

		buttonsGroup = new FlxSpriteGroup(logo.getMidpoint().x - 150, logo.y + logo.height + 10);
		add(buttonsGroup);

		for (i in 0...buttons.length) {
			var button = new FlxSprite(0, i * 70);
			button.frames = FlxAtlasFrames.fromSparrow(
				// Paths.image('menu/menu_${buttons[i]}'),
				// Paths.sparrow('menu/menu_${buttons[i]}'));
				Paths.image('menu/menu_${buttons[i]}'),
				Paths.sparrow('menu/menu_${buttons[i]}'));
			button.animation.addByPrefix(buttons[i], buttons[i], 12);
			button.animation.play(buttons[i]);
			button.ID = i;
			buttonsGroup.add(button);
		}

		FlxTween.tween(booba, {y: FlxG.height - booba.height}, 1.5, {ease: FlxEase.cubeOut, startDelay: 0.2});
		FlxTween.tween(cat, {y: FlxG.height - cat.height}, 1.5, {ease: FlxEase.cubeOut});
	}

	override function update(elapsed:Float) {
		if (FlxG.keys.justPressed.ENTER) FlxG.switchState(game.play.PlayState.new);
		
		buttonsGroup.forEach((spr) -> {
			if (FlxMath.inBounds(FlxG.mouse.y, spr.y, spr.y + spr.height)) curSelection = spr.ID;
		});

		var deltaSelection = 0;

		if (controls.justPressed.UP) deltaSelection--;
		if (controls.justPressed.DOWN) deltaSelection++;

		if (deltaSelection != 0) curSelection = FlxMath.wrap(curSelection + deltaSelection, 0, buttonsGroup.length - 1);

		buttonsGroup.forEach((spr) -> {
			spr.alpha = (spr.ID == curSelection) ? 1 : 0.6;
		});

		if (controls.justPressed.ACCEPT || FlxG.mouse.justPressed) {
			switch(buttons[curSelection]) {
				case 'play': FlxG.switchState(game.play.PlayState.new);
				case 'options': FlxG.switchState(game.ui.Options.new);
				case 'about us': FlxG.switchState(game.ui.AboutUs.new);
			}
		}

		super.update(elapsed);
	}
}