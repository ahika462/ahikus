import game.system.CrashHandler;
import openfl.Lib;
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
	var initialState:Class<FlxState> = game.play.PlayState;
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
		Lib.current.addChild(instance);
	}

	public function new() {
		var framerate = this.framerate > 0 ? this.framerate : FlxG.stage.window.displayMode.refreshRate;

		super(gameWidth, gameHeight, initialState, framerate, framerate, skipSplash, startFullscreen);
	}
}