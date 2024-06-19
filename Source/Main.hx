import flixel.system.FlxAssets;
import openfl.display.FPS;
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
	var initialState:Class<FlxState> = game.ui.Menu;
	/**
	 * Game framerate (leave 0 to fit to display refresh rate)
	 */
	var framerate:UInt = 60;
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

		var fps = new FPS(10, 3, 0xFFFFFFFF);
		fps.border = true;
		fps.borderColor = 0xFF000000;
		FlxG.stage.addChild(fps);
	}

	public function new() {
		FlxAssets.FONT_DEFAULT = 'assets/fonts/SillyGames.ttf';

		var framerate = this.framerate > 0 ? this.framerate : FlxG.stage.window.displayMode.refreshRate;

		super(gameWidth, gameHeight, initialState, framerate, framerate, skipSplash, startFullscreen);
	}
}