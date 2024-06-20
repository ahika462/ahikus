package game.ui;

import flixel.group.FlxSpriteGroup;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import game.system.Paths;
import flixel.FlxSprite;

class Intro extends State {
	override function create() {
		Preferences.bind();
		
		new FlxTimer().start(1, (tmr) -> {
			var teamLogo = new FlxSprite(Paths.image('team-icon'));
			teamLogo.screenCenter();
			teamLogo.alpha = 0;
			add(teamLogo);
	
			var alphaTween:FlxTween;
	
			teamLogo.scale.set(0.8, 0.8);
			alphaTween = FlxTween.tween(teamLogo, {alpha: 1}, 3);
			FlxTween.tween(teamLogo.scale, {x: 1, y: 1}, 3);
			new FlxTimer().start(2, (tmr) -> {
				alphaTween.cancel();
				alphaTween = FlxTween.tween(teamLogo, {alpha: 0}, 1, {onComplete: (twn) -> {
					new FlxTimer().start(1, (tmr) -> {
						FlxG.switchState(Menu.new);
					});
				}});
			});
		});
	}
}