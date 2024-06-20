import haxe.ui.backend.flixel.CursorHelper;
import haxe.ui.Toolkit;
import game.system.Paths;
import openfl.Assets;
import game.system.Data;
import flixel.system.FlxAssets;
import game.ui.FPSCounter;
import game.system.CrashHandler;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxGame;

class Main extends FlxGame {
	/**
	 * Game dimensions width (leave 0 to fit to window)
	 */
	var gameWidth:Int = 0;
	/**
	 * Game dimensions height (leave 0 to fit to window)
	 */
	var gameHeight:Int = 0;
	/**
	 * Game initial state (leave null to `flixel.FlxState`)
	 */
	var initialState:Class<FlxState> = game.ui.Intro;
	/**
	 * Game framerate (leave 0 to fit to display refresh rate)
	 */
	var framerate:UInt = 0;
	/**
	 * Whether the HaxeFlixel intro should be skipped
	 */
	var skipSplash:Bool = false;
	/**
	 * Whether to run the game in full screen mode
	 */
	var startFullscreen:Bool = false;

	public static var instance:Main;

	static function main() {
		CrashHandler.init();

		instance = new Main();
		FlxG.stage.addChild(instance);

		var fps = new FPSCounter(0, 0, 0xFFFFFFFF);
		FlxG.stage.addChild(fps);
	}

	public function new() {
		FlxAssets.FONT_DEFAULT = 'assets/fonts/SillyGames.ttf';

		Data.load(Assets.getText(Paths.data('data.cdb')));

		initHaxeUI();

		var framerate = this.framerate > 0 ? this.framerate : #if desktop FlxG.stage.window.displayMode.refreshRate #else 60 #end;

		super(gameWidth, gameHeight, initialState, framerate, framerate, skipSplash, startFullscreen);
	}

	function initHaxeUI() {
		Toolkit.init();

		for (name in [
			'default',
			'cross',
			'eraser',
			'grabbing',
			'hourglass',
			'pointer',
			'text',
			'text-vertical',
			'zoom-in',
			'zoom-out',
			'crosshair',
			'cell',
			'scroll'
		]) CursorHelper.registerCursor(name, Paths.image('cursor'));
	}
}