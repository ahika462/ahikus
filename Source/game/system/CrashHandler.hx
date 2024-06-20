package game.system;

import haxe.CallStack;
import flixel.FlxG;
import openfl.events.UncaughtErrorEvent;
import openfl.Lib;

using StringTools;

class CrashHandler {
	public static function init() {
		#if hl
		hl.Api.setErrorHandler(onHlError);
		#elseif cpp
		untyped __global__.__hxcpp_set_critical_error_handler(onCppError);
		#else
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onUncaughtError);
		#end
	}

	#if hl
	static function onHlError(v:Dynamic) {
		var stack = CallStack.exceptionStack(true);
		var stackString = CallStack.toString(stack);

		var message = '$v\n$stackString';

		logError(message);
		FlxG.stage.window.alert(message, 'Uncaught error');
	}
	#elseif cpp
	static function onCppError(msg:String) {
		var stack = CallStack.exceptionStack(true);
		var stackString = CallStack.toString(stack);

		var message = '$v\n$stackString';

		logError(message);
		FlxG.stage.window.alert(message, 'Uncaught error');
	}
	#else
	static function onUncaughtError(e:UncaughtErrorEvent) {
		var stack = CallStack.exceptionStack(true);
		var stackString = CallStack.toString(stack);

		var message = '${e.error}\n$stackString';

		#if sys
		logError(message);
		#end
		FlxG.stage.window.alert(message, 'Uncaught error');
	}
	#end

	static var usedLibraries = game.system.macros.HaxelibMacro.buildList();

	#if sys
	static function logError(message:String) {
		var report = 'Uncaught exception';

		report += '\n\n$message';

		report += '\n\nUsed libraries';
		report += '\n${[
			for (haxelib in usedLibraries) '  $haxelib'
		].join('\n')}';

		report += '\n\nReported by';
		#if hl
		report += '\n\nHashLink';
		#elseif cpp
		report += '\n\nnHXCPP';
		#else
		report += '\n\nOpenFL';
		#end

		var date = Date.now().toString().replace(' ', '_').replace(':', '\'');
		if (!sys.FileSystem.exists('logs')) sys.FileSystem.createDirectory('logs');
		sys.io.File.saveContent('logs/Error_$date.log', report);
	}
	#end
}